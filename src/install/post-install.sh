#!/bin/bash

#Frameworks

.  ../utils/utilities.sh
.  ../config/config.sh


# Internet

conectar_internet(){
    
    echo "----------------------------------------------"
    echo "-------------- Activar internet --------------"
    echo "----------------------------------------------"

    nmcli device wifi
    nmcli --ask device wifi connect &> /dev/zero && mensaje_exito "Conexion exitosa" || mensaje_fallo "Fallo de conexion: compruebe las credenciales"
}


#Xorg

instalar_display_server(){
    
    echo "----------------------------------------------"
    echo "---------- Instalar display server -----------"
    echo "----------------------------------------------"

    pacman -S xorg-server xorg-apps xorg-xinit
}

#Lightdm

instalar_lightdm(){
    
    echo "----------------------------------------------"
    echo "-------------- Instalar lightdm --------------"
    echo "----------------------------------------------"

    pacman -S lightdm lightdm-gtk-greeter lightdm-gtk-greeter-settings
    systemctl enable lightdm.service
}

# Drivers
instalar_drivers_display(){

    echo "----------------------------------------------"
    echo "--------- Instalar drivers display -----------"
    echo "----------------------------------------------"

    pacman -S $DRIVERS
}

#Tiling window manager
instalar_tiliwing_window_manager(){

    echo "----------------------------------------------"
    echo "--------------- Instalar TWM -----------------"
    echo "----------------------------------------------"

    pacman -S $TWM
    pacman -S sxhkd feh picom rofi imagemagick
}

#Paquetes adicionales
instalar_paquetes(){

    echo "----------------------------------------------"
    echo "------------ Instalar paquetes ---------------"
    echo "----------------------------------------------"

    pacman -S $TERMINAL
    pacman -S $PAQUETES
}

instalar_AUR_manager(){

    echo "----------------------------------------------"
    echo "------------- Instalar yaourt ----------------"
    echo "----------------------------------------------"
    
    chmod +x yaourt.sh
    su $USUARIO "./yaourt.sh" 

}

instalar_paquetes_AUR(){
    
    echo "----------------------------------------------"
    echo "---------- Instalar paquetes AUR -------------"
    echo "----------------------------------------------"

    paquetes=($(echo $PAQUETES_AUR | tr ";" "\n"))

    #Print the split string
    for paquete in "${paquetes[@]}"
    do
        echo "----------------------------------------------"
        echo " + Instalando $paquete"
        echo "----------------------------------------------"
        
        su $USUARIO yaourt $paquete
    done
}

configurar_i3_bar(){

    # Permite mostrar informacion de uso de cpu, ram, almacenamiento, etc
    pip3 install psutil --user
}


#Refresh keys y mirrors

# Actualizacion de keys
#actualizacion_keys
#Actualizacion mirrors
#actualizacion_mirrors


conectar_internet
instalar_display_server
instalar_lightdm
instalar_drivers_display
instalar_tiliwing_window_manager
instalar_paquetes
instalar_AUR_manager
instalar_paquetes_AUR
configurar_i3_bar
