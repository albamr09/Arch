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
    echo "--------------- Instalar yay -----------------"
    echo "----------------------------------------------"
    
    chmod +x ../utils/yaourt.sh
    su $USUARIO "../utils/yaourt.sh" 

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
        
        su $USUARIO $(yay -S $paquete)
    done
}

configurar_i3_bar(){
    # Permite mostrar informacion de uso de cpu, ram, almacenamiento, etc
    pip3 install psutil
}

instalar_ohmyzsh(){
    sh -c "$(wget -O- https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
    #rm install.sh
}

copiar_accesos_directos(){
    sudo cp ../surf.desktop /usr/share/applications/
}

establecer_predeterminados(){
    #Surf
    xdg-settings set default-web-browser surf.desktop
    #Zsh
    chsh -s /bin/zsh
}

copiar_dotfiles(){

  echo "----------------------------------------------"
  echo " + Copiar dotfiles"
  echo "----------------------------------------------"

  cp -r ../dotfiles/.??* ~ &> /dev/zero && mensaje_exito "Se han copiado los ficheros de configuracion para root" || mensaje_fallo "Fallo durante la copia de los ficheros de configuracion en root"
  su $USUARIO $(cp -r ../dotfiles/.??* /home/$USUARIO) &> /dev/zero && mensaje_exito "Se han copiado los ficheros de configuracion para $USUARIO" || mensaje_fallo "Fallo durante la copia de los ficheros de configuracion en $USUARIO"
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
instalar_ohmyzsh
copiar_accesos_directos
establecer_predeterminados
copiar_dotfiles
