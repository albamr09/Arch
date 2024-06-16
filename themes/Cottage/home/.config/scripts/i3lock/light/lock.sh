#!/bin/sh

# Seleccionar de forma aleatoria
#BACKGROUND=$(find $HOME/Wallpapers -type f | shuf -n 1)
#BACKGROUND="$HOME/Wallpapers/w12.jpg"
FONT="VictorMono"
BG_COLOR="d8d8c7"
FG_COLOR="292d3e"
RIGHT_COLOR="6fa065"
WRONG_COLOR="bf616a"

i3lock --nofork \
    --ignore-empty-password \
    \
    --indicator \
    --bar-indicator \
    --bar-base-width 10 \
		--bar-pos y+h \
    --bar-direction 1 \
    --bar-color=$FG_COLOR \
    --ringver-color=$RIGHT_COLOR \
    --ringwrong-color=$WRONG_COLOR \
    --bshl-color=5e81ac \
    --keyhl-color=a3be8c \
		--bar-step 15 \
		--redraw-thread \
    \
    --clock \
    --time-color=$FG_COLOR \
    --time-str="%I:%M %p" \
    --time-font=$FONT \
    --time-size=50 \
    --time-pos x+50:y+h-400 \
		--time-align 1 \
    \
    --date-color=$FG_COLOR \
    --date-str="%A, %m %Y" \
    --date-font=$FONT \
    --date-size=50 \
    --date-pos tx:ty+60 \
		--date-align 1 \
    \
    --verif-font=$FONT \
    --verif-size=100 \
    --verif-text="Verifying..." \
		--verif-color $FG_COLOR \
    --wrong-font=$FONT \
    --wrong-size=100 \
    --wrong-text="Wrong!" \
		--wrong-color $FG_COLOR \
		--modif-pos -50:-50 \
    \
    -n \
		-c $BG_COLOR \
		#--image $BACKGROUND
