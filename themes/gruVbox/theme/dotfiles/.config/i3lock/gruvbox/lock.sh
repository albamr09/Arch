#!/usr/bin/env bash

#---------------
# i3lock-color
#---------------


B='#282828' # center background
C='#3c3836' # center background verif
T='#ffe19b' # center text
D='#d3869b' # default ring
I='#b3e060' # indicator
W='#fc7d6f' # wrong ring + indicator
V='#fabd2f' # verif ring

FONT="Iosevka Nerd Font"

i3lock \
    -c 458588 \
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
