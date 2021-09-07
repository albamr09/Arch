#!/bin/bash

#Frameworks

.  ../utils/utilities.sh
.  ../config/config.sh

# Ejecutar este fichero como root

#Idioma y teclado
config_sistema () {

    echo "----------------------------------------------"
    echo "-------- Configurar idioma y teclado ---------"
    echo "----------------------------------------------"

    # Idioma
    echo "$IDIOMA $CODIFICACION" >> /etc/locale.gen
    locale-gen &> /dev/zero && mensaje_exito "Generacion de idioma finalizada correctamente" || mensaje_fallo "Ha habido algun error durante la generacion"
    echo "LANG=$IDIOMA" > /etc/locale.conf

    # Teclado
    echo "KEYMAP=$KEYMAP" > /etc/vconsole.conf

    #Sistema
    if [ -z "$USUARIO" ]; then
        mensaje_fallo "\$USUARIO no tiene un valor valido"
    else
        echo $USUARIO > /etc/hostname
        echo "127.0.0.1	localhost" >> /etc/hosts
        echo "::1	localhost" >> /etc/hosts
        echo "127.0.1.1	$USUARIO.localdomain    $USUARIO" >> /etc/hosts
    fi

    #Hora
    ln -sf /usr/share/zoneinfo/$ZONA_HORARIA /etc/localtime  && mensaje_exito "Configuracion de hora finalizada" || mensaje_fallo "Ha habido algun error durante la configuracion horaria"
    hwclock --systohc
}


config_imagen(){

    echo "----------------------------------------------"
    echo "---- Configuracion de la imagen de linux -----"
    echo "----------------------------------------------"

    sed -i "s/HOOKS=\(.*\)/HOOKS=$HOOKS_MKINITCPIO/g" /etc/mkinitcpio.conf &> /dev/zero && mensaje_exito "Configuracion de mkinitcpio realizada" || mensaje_fallo "Fallo en la configuracion de mkinitcpio"
    
    echo "----------------------------------------------"
    echo " + Rebuild la imagen"
    echo "----------------------------------------------"

    mkinitcpio -p linux
}

#Grub
config_arranque () {
    
    echo "----------------------------------------------"
    echo "------- Configurar gestor de arranque --------"
    echo "----------------------------------------------"

    pacman -S grub parted && mensaje_exito "GRUB instalado correctamente" || mensaje_fallo "Ha habido un error al instalar GRUB"

    if [ -z "$DISPOSITIVO_GRUB" ]; then
        mensaje_fallo "\$DISPOSITIVO_GRUB no tiene un valor valido"
    fi

    partprobe -d -s $DISPOSITIVO_GRUB &> /dev/zero && mensaje_exito "Comprobacion de dispositivo finalizada con exito" || mensaje_fallo "$DISPOSITIVO_GRUB no existe"

    echo "----------------------------------------------"
    echo " + GRUB LEGACY"
    echo "----------------------------------------------"

    grub-install --target=$TARGET_GRUB_LEGACY --boot-directory="$DIRECTORIO_BOOT" $DISPOSITIVO_GRUB &> /dev/zero && mensaje_exito "Instalacion GRUB Legacy finalizada correctamente" || mensaje_fallo "Fallo en la instalacion de GRUB Legacy"

    echo "----------------------------------------------"
    echo " + GRUB EFI"
    echo "----------------------------------------------"

    if [ $USB -eq 1 ]; then
        grub-install --target=$TARGET_GRUB_EFI --efi-directory="$DIRECTORIO_BOOT" --boot-directory="$DIRECTORIO_BOOT" --removable $DISPOSITIVO_GRUB &> /dev/zero && mensaje_exito "Instalacion GRUB EFI en USB finalizada correctamente" || mensaje_fallo "Fallo en la instalacion de GRUB EFI en USB"
    else
        grub-install --target=$TARGET_GRUB_EFI --efi-directory="$DIRECTORIO_BOOT" --boot-directory="$DIRECTORIO_BOOT" $DISPOSITIVO_GRUB &> /dev/zero && mensaje_exito "Instalacion GRUB EFI finalizada correctamente" || mensaje_fallo "Fallo en la instalacion de GRUB EFI"
    fi

    echo "----------------------------------------------"
    echo " + Generacion del archivo de configuracion de grub"
    echo "----------------------------------------------"

    grub-mkconfig -o "$DIRECTORIO_GRUB_CONF" &> /dev/zero && mensaje_exito "Generacion del archivo de configuracion finalizada" || mensaje_fallo "Fallo durante la generacion del archivo de configuracion"
}

#Generar fstab
generar_fstab(){

  echo "----------------------------------------------"
  echo "-------------- Generar fstab -----------------"
  echo "----------------------------------------------"

  pacman -S arch-install-scripts
  $(genfstab -U / > /etc/fstab) &> /dev/zero && mensaje_exito "Se ha generado fstab" || mensaje_fallo "Fallo durante la generacion de fstab"
  pacman -R arch-install-scripts

}

#Internet
config_net () {

    echo "----------------------------------------------"
    echo "-------------- Activar internet --------------"
    echo "----------------------------------------------"

    systemctl enable NetworkManager &> /dev/zero && mensaje_exito "Conexion a internet habilitada" || mensaje_fallo "Fallo de habilitacion del gestor de internet"
}

#Nuevo usuario
config_usuarios(){

    echo "----------------------------------------------"
    echo "-------- Definir contrasena para root --------"
    echo "----------------------------------------------"

    # Root

    passwd
    while [ $? != 0 ]; do
        passwd
    done

    # Permitir sudo
    echo "--------------------------------------"
    echo " + Permitir sudo"
    echo "--------------------------------------"

    pacman -S sudo || mensaje_fallo "Fallo al instalar sudo"
    sed -i '82 s/^##*//' /etc/sudoers && mensaje_exito "Se ha habilitado sudo en sudoers" || mensaje_fallo "Fallo al habilitar sudo en el archivo de configuracion"

    # Nuevo usuario con sudo

    echo "--------------------------------------"
    echo " + Creacion de usuario"
    echo "--------------------------------------"

    if [ -z "$USUARIO" ]; then
        mensaje_exito "\$USUARIO no tiene valor, no se creara un usuario"
    elif [ "$USUARIO" != "root" ]; then
        useradd -m $USUARIO &> /dev/zero && mensaje_exito "Se ha creado el usuario: $USUARIO correctamente" || mensaje_fallo "Fallo al crear el usuario"
        passwd $USUARIO
        while [ $? != 0 ]; do
            passwd $USUARIO
        done
        usermod -a -G wheel $USUARIO &> /dev/zero && mensaje_exito "Se ha anadido $USUARIO al grupo wheel (sudo)" || mensaje_fallo "Fallo al anadir $USUARIO al grupo wheel (sudo)"
        chmod -R 770 /home/$USUARIO &> /dev/zero && mensaje_exito "Se han configurado los permisos de $USUARIO" || mensaje_fallo "Fallo al configurar los permisos de $USUARIO"
    fi
    
}

#Configuracion extra para unidad usb
config_usb(){

    echo "----------------------------------------------"
    echo "------------- Configuracion USB --------------"
    echo "----------------------------------------------"

    if [ $USB -eq 1 ]; then
        sed -i "s/^#Storage=.*/Storage=volatile/g" /etc/systemd/journald.conf &> /dev/zero && mensaje_exito "Configuracion de Storage journal realizada" || mensaje_fallo "Fallo en la configuracion de Storage journal"
        sed -i "s/^#RuntimeMaxUse=.*/RuntimeMaxUse=30/g" /etc/systemd/journald.conf &> /dev/zero && mensaje_exito "Configuracion de RuntimeMaxUse journal realizada" || mensaje_fallo "Fallo en la configuracion de RuntimeMaxUse journal"
    fi
}

config_sonido(){

    echo "----------------------------------------------"
    echo "-- Configuracion de herramientas de sonido ---"
    echo "----------------------------------------------"
    
    pacman -S alsa-utils
}



#Idioma y teclado
config_sistema
#Imagen linux
config_imagen
#Grub
config_arranque
#Fstab
generar_fstab
#Internet
config_net
#Nuevo usuario
config_usuarios
#Configuracion para usb
config_usb
#Configuracion de sonido
config_sonido
