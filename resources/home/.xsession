
# CAMBIAR FONDO

cambiar_fondo(){
	#nitrogen --random --set-zoom-fill &

	# Obtener el numero de monitores (decrementar en uno)
	((NUM_MONITORS=$(echo `xrandr --listmonitors` | sed -E 's/.* ([0-9]) .*/\1/')-1))

	# Recorrer las pantallas y establecer fondo de pantalla
	for screen in $(eval echo "{0..$NUM_MONITORS}")
	do
		nitrogen --head="$screen" --random --set-zoom-fill
	done
}

bucle_infinito(){
	while true; do
		cambiar_fondo
		sleep 1800
	done
}

bucle_infinito &

# IDIOMAR DE TECLADO A ESPAÑOL

setxkbmap es

# RESOLUCION DE PANTALLA

#xrandr --newmode "1256x900_60.00"   92.75  1256 1328 1456 1656  900 903 913 934 -hsync +vsync
#xrandr --addmode Virtual-1 1256x900_60.00
#xrandr --output Virtual-1 --mode 1256x900_60.00
