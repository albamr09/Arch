#!/usr/bin/env bash

#---------------
# i3lock-color
#---------------

font="JetBrainsMono"
alpha='dd'
transparent_alpha="00"
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
blue='#a4bae1'
cyan='#2aa198'
green='#20d06a'

i3lock \
  --insidever-color=$base02$alpha \
  --insidewrong-color=$base02$alpha \
  --inside-color=$base02$alpha \
  --ringver-color=$green$alpha \
  --ringwrong-color=$red$alpha \
  --ring-color=$blue$transparent_alpha \
  --line-uses-ring \
  --keyhl-color=$magenta$alpha \
  --bshl-color=$orange$alpha \
  --separator-color=$base01$alpha \
  --verif-color=$green \
  --wrong-color=$red \
  --layout-color=$blue \
  --date-color=$blue \
  --time-color=$blue \
  --screen 1 \
  --blur 1 \
  --clock \
	--indicator\
  --time-str="%H:%M:%S" \
  --date-str="%a %b %e %Y" \
  --verif-text="Verifying" \
  --wrong-text="Nope!" \
  --noinput="No Input" \
  --lock-text="Locking" \
  --lockfailed="Lock Failed" \
  --time-font=$font \
  --date-font=$font\
  --layout-font= $font\
  --verif-font=$font\
  --wrong-font=$font\
  --radius=150 \
  --ring-width=10 \
	--date-size=15\
	--date-align=vertical\
	--time-size=20\
	--time-align=vertical\
	--layout-size=20\
	--layout-align=vertical\
	--verif-size=25\
	--wrong-size=25\
	--greeter-size=25\
  -n
sleep 1
exit
