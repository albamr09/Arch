#!/usr/bin/env bash

#---------------
# i3lock-color
#---------------

font="JetBrainsMono"
alpha='dd'
transparent_alpha="00"
semitransparent_alpha="55"
base03='#002b36'
base02='#041424'
base01='#586e75'
base00='#657b83'
base0='#839496'
base1='#93a1a1'
base2='#eee8d5'
base3='#fdf6e3'
yellow='#b58900'
orange='#cb4b16'
red='#dc322f'
magenta='#d33682'
violet='#6c71c4'
blue='#9c9e91'
cyan='#2aa198'
green='#20d06a'

i3lock \
  --insidever-color=$base02$transparent_alpha \
  --insidewrong-color=$base02$transparent_alpha \
  --inside-color=$base02$transparent_alpha \
  --ringver-color=$green$alpha \
  --ringwrong-color=$red$alpha \
  --ring-color=$blue \
	--line-color=$blue$transparent_alpha\
  --keyhl-color=$magenta$alpha \
  --bshl-color=$orange$alpha \
  --separator-color=$base01$alpha \
  --verif-color=$green \
  --wrong-color=$red \
  --layout-color=$blue \
  --date-color=$blue \
  --time-color=$blue \
  --screen 1 \
	--blur 3 \
  --clock \
	--indicator\
	--ind-pos="w/2-r/2:h-r*4"\
  --time-str="%H:%M:%S" \
	--time-pos="w/2:h/2-r*2"\
  --date-str="%a %b %e %Y" \
	--date-pos="tx:ty+80"\
  --verif-text="" \
  --wrong-text="" \
  --noinput="-" \
  --lock-text="Locking" \
  --lockfailed="" \
  --time-font=$font \
  --date-font=$font\
  --layout-font= $font\
  --verif-font=$font\
  --wrong-font=$font\
  --radius=20 \
  --ring-width=5 \
	--date-size=32\
	--date-align=vertical\
	--time-size=94\
	--time-align=vertical\
	--layout-size=20\
	--layout-align=vertical\
	--verif-size=25\
	--wrong-size=25\
	--greeter-size=25\
sleep 1
exit
