
change_wallpaper(){
	((NUM_MONITORS=$(echo `xrandr --listmonitors` | sed -E 's/.* ([0-9]) .*/\1/')-1))

	for screen in $(eval echo "{0..$NUM_MONITORS}")
	do
		nitrogen --head="$screen" --random --set-zoom-fill
	done
}

forever_loop(){
	while true; do
		change_wallpaper
		sleep 1800
	done
}

forever_loop &
setxkbmap es

#xrandr --newmode "1256x900_60.00"   92.75  1256 1328 1456 1656  900 903 913 934 -hsync +vsync
#xrandr --addmode Virtual-1 1256x900_60.00
#xrandr --output Virtual-1 --mode 1256x900_60.00
