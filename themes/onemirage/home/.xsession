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
