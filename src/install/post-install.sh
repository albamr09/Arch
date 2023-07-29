#!/bin/bash

#Frameworks

.  ../utils/utilities.sh
.  ../config/config.sh


# Internet



configurar_servicios(){

		echo "---------------------------------------------------"
		echo "-------- Copiar y configurar servicios ------------"
		echo "---------------------------------------------------"

		sudo cp $DIR_SERVICES/* /etc/systemd/system &> /dev/zero && mensaje_exito "Se han copiado los servicios" || mensaje_fallo "Fallo durante la copia de servicios"
		sudo systemctl enable suspend@$USUARIO &> /dev/zero && mensaje_exito "Se han activado los servicios" || mensaje_fallo "Fallo durante la activación de los servicios"
		# Servicio de notificación de batería
        su -c "systemctl --user enable check-battery-user.timer" $USUARIO
        # Servicio de notificación de batería
        su -c "systemctl --user start check-battery-user.service" $USUARIO
        #Actualizar
		sudo systemctl daemon-reload
}

delete_all(){

    echo "----------------------------------------------"
    echo " + Eliminar ficheros fuente"
    echo "----------------------------------------------"

    cd /
    rm -r Arch  &> /dev/zero && mensaje_exito "Se han eliminado los ficheros fuente" || mensaje_fallo "Fallo durante la eliminacion de los ficheros fuente"
}

#Refresh keys y mirrors

#actualizacion_keys
#actualizacion_mirrors
conectar_internet

# Instalaciones display
instalar_display_server
instalar_lightdm
instalar_drivers_display

# Desktop environment
instalar_tiliwing_window_manager

# Software
instalar_paquetes
instalar_AUR_manager
instalar_paquetes_AUR
instalar_ohmyzsh

# Config
configurar_i3_bar
configurar_ranger
configurar_servicios
establecer_predeterminados

# Copiar dotfiles y demas
copiar_dotfiles
copiar_fonts

# Finalizacion
delete_all
