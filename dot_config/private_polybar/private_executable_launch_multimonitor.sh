#!/usr/bin/env bash
(
  flock 200
  killall -q polybar

  attempt=1
  while pgrep -u $UID -x polybar >/dev/null; do
          attempt=$(($attempt+1))
          ## Re-kill polybar every 6 attempts
          if [ $attempt -gt 6 ]; then
                  echo "Polybar didn't die in time, trying to kill it again"
                  attempt=1
                  killall -q polybar
          fi
          sleep 0.5;
  done

  outputs=$(xrandr --query | grep " connected" | cut -d" " -f1)
  tray_output=eDP1

  for m in $outputs; do
    if [[ "$m" =~ ^(HDMI2|DP2-1|DP2-2)$ ]]; then
      tray_output=$m
    fi
  done

  for m in $outputs; do
    export MONITOR=$m
    export TRAY_POSITION=none
    if [[ $m == "$tray_output" ]]; then
      TRAY_POSITION=right
    fi

    polybar --reload main </dev/null >/var/tmp/polybar-"$m".log 2>&1 200>&- &
    disown
  done
) 200>/var/tmp/polybar-launch.lock
