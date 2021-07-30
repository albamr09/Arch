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
    
    chmod +x ../utils/pkg-manager.sh
    su $USUARIO "../utils/pkg-manager.sh" 

}

instalar_paquetes_AUR(){
    
    echo "----------------------------------------------"
    echo "---------- Instalar paquetes AUR -------------"
    echo "----------------------------------------------"

    chmod +x ../utils/pkg-install.sh
    su $USUARIO "../utils/pkg-install.sh" 
}

configurar_i3_bar(){
    # Permite mostrar informacion de uso de cpu, ram, almacenamiento, etc
    pip3 install psutil
}

instalar_ohmyzsh(){
    
  echo "----------------------------------------------"
  echo " + Intalar oh-my-zsh"
  echo "----------------------------------------------"

  sh -c "$(wget -O- https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
  #rm install.sh
}

copiar_accesos_directos(){

  echo "----------------------------------------------"
  echo " + Crear accesos directos"
  echo "----------------------------------------------"

  cp ../config-files/*.desktop /usr/share/applications/ &> /dev/zero && mensaje_exito "Se han copiado los accesos directos" || mensaje_fallo "Fallo durante la copia de los accesos directos"
}

establecer_predeterminados(){

  echo "----------------------------------------------"
  echo " + Establecer programas predeterminados"
  echo "----------------------------------------------"

  #Surf
  xdg-settings set default-web-browser surf.desktop
  #Zsh
  chsh -s /bin/zsh
}

copiar_dotfiles(){

  echo "----------------------------------------------"
  echo " + Copiar dotfiles"
  echo "----------------------------------------------"

  cp -r ../config-files/dotfiles/.??* ~ &> /dev/zero && mensaje_exito "Se han copiado los ficheros de configuracion para root" || mensaje_fallo "Fallo durante la copia de los ficheros de configuracion en root"
  
  # Copia usuario
  chmod +x ../utils/copy-dotfiles.sh
  su $USUARIO "../utils/copy-dotfiles.sh" 
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
copiar_dotfiles
establecer_predeterminados