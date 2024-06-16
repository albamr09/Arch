#!/bin/bash

# Terminate already running bar instances
pgrep -u $UID -x polybar | xargs kill -9

# Launch polybar
if type "xrandr"; then
    if [[ $(xrandr | grep "HDMI1 connected") && $(xrandr | grep "VGA1 connected") ]]; then
        for m in $(xrandr --query | grep " connected" | cut -d" " -f1); do
            if ! [ $m = "LVDS1" ]; then
                MONITOR=$m polybar --reload main &
            fi
        done
    else
        MONITOR=$m polybar --reload main &
    fi
else
	polybar --reload main &
fi

echo "Polybar launched..."

