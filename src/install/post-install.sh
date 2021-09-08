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
    nmcli --ask device wifi connect 
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
    
    su $USUARIO "$DIR_USER_SCRIPTS/$PKG_MANAGER" 

}

instalar_paquetes_AUR(){
    
    echo "----------------------------------------------"
    echo "---------- Instalar paquetes AUR -------------"
    echo "----------------------------------------------"

    su $USUARIO "$DIR_USER_SCRIPTS/$PKG_INSTALL" 
}

configurar_i3_bar(){

    echo "----------------------------------------------"
    echo "------------ Configurar i3-bar ---------------"
    echo "----------------------------------------------"

    # Permite mostrar informacion de uso de cpu, ram, almacenamiento, etc
    pip3 install psutil
}

configurar_ranger(){

    echo "----------------------------------------------"
    echo "------------ Configurar ranger ---------------"
    echo "----------------------------------------------"
    
    ranger --copy-config=all
}

configurar_servicios(){

		echo "---------------------------------------------------"
		echo "-------- Copiar y configurar servicios ------------"
		echo "---------------------------------------------------"

		sudo cp $DIR_SERVICES/* /etc/systemd/system &> /dev/zero && mensaje_exito "Se han copiado los servicios" || mensaje_fallo "Fallo durante la copia de servicios"
		sudo systemctl enable suspend@$USUARIO &> /dev/zero && mensaje_exito "Se han activado los servicios" || mensaje_fallo "Fallo durante la activación de los servicios"
		#Actualizar
		sudo systemctl daemon-reload
}

instalar_ohmyzsh(){
    
  echo "----------------------------------------------"
  echo " + Intalar oh-my-zsh"
  echo "----------------------------------------------"

  sh -c "$(wget -O- https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
  #rm install.sh
}

establecer_predeterminados(){

  echo "----------------------------------------------"
  echo " + Establecer programas predeterminados"
  echo "----------------------------------------------"

  #Surf
  xdg-settings set default-web-browser org.qutebrowser.qutebrowser.desktop
  #Zsh
  chsh -s /bin/zsh
  #Usuario
  su $USUARIO "$DIR_USER_SCRIPTS/$CHANGE_DEFAULTS" 
}

configurar_nvim(){

    echo "----------------------------------------------"
    echo "------------- Configurar nvim ----------------"
    echo "----------------------------------------------"

    su $USUARIO "$DIR_USER_SCRIPTS/$CONFIG_NVIM"
}

copiar_dotfiles(){

  echo "----------------------------------------------"
  echo " + Copiar dotfiles"
  echo "----------------------------------------------"

  cp -r $DIR_DOTFILES/.??* ~ &> /dev/zero && mensaje_exito "Se han copiado los ficheros de configuracion para root" || mensaje_fallo "Fallo durante la copia de los ficheros de configuracion en root"
  cp $DIR_RESOURCES/etc/* /etc &> /dev/zero && mensaje_exito "Se ha copiado directorio etc" || mensaje_fallo "Fallo durante la copia del directorio etc"

  # Copia usuario
  chmod +x $DIR_USER_SCRIPTS"/"$COPY_DOTFILES
  su $USUARIO "$DIR_USER_SCRIPTS/$COPY_DOTFILES" 

  # Tras copia de dotfiles de nvim configurar nvim
  configurar_nvim
}

copiar_fonts(){

    echo "----------------------------------------------"
    echo " + Copiar fuentes"
    echo "----------------------------------------------"

    cp -r $DIR_FONTS/* $HOST_DIR_FONTS &> /dev/zero && mensaje_exito "Se han copiado las fuentes" || mensaje_fallo "Fallo durante la copia de las fuentes"
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
