#!/usr/bin/env bash
# Waybar module for toggling sunsetr using presets

STATE_FILE="${XDG_RUNTIME_DIR:-/tmp}/sunsetr-preset-state"

# Check if sunsetr is running
is_running() {
    pgrep -x sunsetr > /dev/null
}

# Get current preset state
get_state() {
    if [ -f "$STATE_FILE" ]; then
        cat "$STATE_FILE"
    else
        echo "default"
    fi
}

# Set preset state
set_state() {
    echo "$1" > "$STATE_FILE"
}

# Toggle between default and disabled presets
toggle() {
    # Make sure sunsetr is running
    if ! is_running; then
        sunsetr &
        sleep 0.5
    fi

    current=$(get_state)

    if [ "$current" = "default" ]; then
        # Switch to disabled preset
        sunsetr preset disabled
        set_state "disabled"
    else
        # Switch to default preset
        sunsetr preset default
        set_state "default"
    fi
}

# Get status for waybar
status() {
    if ! is_running; then
        # Sunsetr not running
        echo '{"text": "󰖔", "tooltip": "Sunsetr: Not running", "class": "disabled"}'
        set_state "default"
        return
    fi

    current=$(get_state)

    if [ "$current" = "default" ]; then
        # Blue light filter is active
        echo '{"text": "󰖔", "tooltip": "Sunsetr: Active (filtering blue light)", "class": "active"}'
    else
        # Blue light filter is disabled
        echo '{"text": "󰖔", "tooltip": "Sunsetr: Disabled (no filtering)", "class": "disabled"}'
    fi
}

case "$1" in
    toggle)
        toggle
        ;;
    status|*)
        status
        ;;
esac
