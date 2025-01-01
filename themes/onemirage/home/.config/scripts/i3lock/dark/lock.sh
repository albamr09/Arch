#!/usr/bin/env bash

#---------------
# i3lock-color
#---------------


B='#1f2430'     # center background
C='#33374c'     # center background verif
T='#6b98c4'     # center text
D='#ffcc66'     # default ring
DI='#95be6d'    # default inner ring
I='#1f2430'     # indicator
W='#d86d58'     # wrong ring + indicator
V='#95be6d'     # verif ring

FONT="Input Nerd Font"

i3lock \
    -c 2E3440 \
    --insidever-color=$C \
    --ringver-color=$V \
    \
    --insidewrong-color=$C \
    --ringwrong-color=$W \
    \
    --ring-color=$D \
    --line-color=$DI \
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
    --radius=300
    -n

sleep 1
exit
