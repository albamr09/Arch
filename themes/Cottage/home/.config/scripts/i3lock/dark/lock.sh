#!/usr/bin/env bash

#---------------
# i3lock-color
#---------------


B='#292d3e' # center background
C='#33374c' # center background verif
T='#d8d8c7' # center text
D='#292d3e' # default ring
I='#6fa065' # indicator
W='#bf616a' # wrong ring + indicator
V='#dfe5c9' # verif ring

FONT="Iosevka Nerd Font"

i3lock \
    -c 2E3440 \
    --insidever-color=$C \
    --ringver-color=$V \
    \
    --insidewrong-color=$C \
    --ringwrong-color=$W \
    \
    --ring-color=$D \
    --line-color=$T \
    --separator-color=$D \
    \
    --inside-color=$B \
    --verif-color=$T \
    --wrong-color=$T \
    --time-color=$T \
    --date-color=$T \
    --layout-color=$T \
    --keyhl-color=$I \
    --bshl-color=$I \
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
    --radius=300 \
    -n

sleep 1
exit
