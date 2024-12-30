
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

# Change keyboard

setxkbmap es