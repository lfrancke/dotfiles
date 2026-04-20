#!/usr/bin/env bash
# Waybar module for toggling sunsetr via presets

is_running() {
    pgrep -x sunsetr > /dev/null
}

# Read currently active preset (empty string = base config)
active_preset() {
    sunsetr preset active 2>/dev/null | grep -oP 'Active preset:\s*\K\S+' || echo ""
}

toggle() {
    if ! is_running; then
        nohup sunsetr > /dev/null 2>&1 & disown
        sleep 0.5
    fi

    if [ "$(active_preset)" = "disabled" ]; then
        sunsetr preset default
    else
        sunsetr preset disabled
    fi
}

status() {
    if ! is_running; then
        echo '{"text": "󰖔", "tooltip": "Sunsetr: Not running", "class": "disabled"}'
        return
    fi

    if [ "$(active_preset)" = "disabled" ]; then
        echo '{"text": "󰖔", "tooltip": "Sunsetr: Disabled (no filtering)", "class": "disabled"}'
    else
        echo '{"text": "󰖔", "tooltip": "Sunsetr: Active (filtering blue light)", "class": "active"}'
    fi
}

case "$1" in
    toggle) toggle ;;
    status|*) status ;;
esac
