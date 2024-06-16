#!/usr/bin/env bash

#---------------
# i3lock-color
#---------------


B='#282828' # center background
C='#3c3836' # center background verif
T='#ffe19b' # center text
D='#d3869b' # default ring
I='#b3e060' # indicator
K='#b16286' # Key stroke indicator
BS='fabd2f' # Delete key indicator
W='#fc7d6f' # wrong ring + indicator
V='#d79921' # verif ring
alpha="dd"
transparent_alpha="00"

FONT="Iosevka Nerd Font"

i3lock \
    --insidever-color=$C$alpha \
    --ringver-color=$V$alpha \
    \
    --insidewrong-color=$C \
    --ringwrong-color=$W \
    \
    --ring-color=$D$transparent_alpha \
    --line-color=$T$transparent_alpha \
    --separator-color=$D$alpha \
    \
    --inside-color=$B$alpha \
    --verif-color=$T \
    --wrong-color=$T \
    --time-color=$T \
    --date-color=$T \
    --layout-color=$T \
    --keyhl-color=$K$alpha \
    --bshl-color=$BS$alpha \
    \
    --clock \
    --indicator \
    --time-str="%I:%M %p" \
    --date-str="%A, %m %Y" \
    \
    --verif-text="Verifying..." \
    --wrong-text="Nope!" \
    \
    --date-font="$FONT" \
    --time-font="$FONT" \
    --layout-font="$FONT" \
    --verif-font="$FONT" \
    --wrong-font="$FONT" \
    --greeter-font="$FONT" \
    \
    --date-size=20 \
    --date-align=vertical \
    --time-size=20 \
    --time-align=vertical \
    --layout-size=20 \
    --verif-size=30 \
    --wrong-size=30 \
    --greeter-size=30 \
    \
    --radius=200 \
		--blur 1 \
    -n
sleep 1
exit
