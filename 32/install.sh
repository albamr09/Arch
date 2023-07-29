#!/bin/bash

. config.sh
. utils.sh

############################################################################
## INSTALLATION SCRIPT
############################################################################

### First step is to partition our disk

partitioning_helper(){
  sed -e 's/\s*\([\+0-9a-zA-Z]*\).*/\1/' << EOF | gdisk $INSTALLATION_DISK
  o     # Borrar tabla de particiones
  Y     # Confirmar borrado
  n     # Nueva particion
  1     # Particion numero 1
        # Default - empezar al principio del disco 
  +10M  # 10M de BIOS
  ef02  #Tipo de particion BIOS Boot Partition
  n     # Nueva particion
  2     # Particion numero 2
        # Default - empezar al principio del disco
  +250M # 250M de EFI
  ef00  #Tipo de particion EFI
  n     # Nueva particion
  3     # Particion numero 3
        # Default - empezar al principio del disco
  +2G   # 2G de swap
  8200  #Tipo de particion swap
  n     # Nueva particion
  4     # Particion numero 4
        # Default - empezar al principio del disco
        # Default - ocupar el resto del disco
        # Default - tipo de particion Linux file system
  p # Print resultado
  w # Guardar
  Y # Confirmar resultado
  q # Salir
EOF
}

partitioning(){

    title_msg "Partitioning"

    if [ -z "$INSTALLATION_DISK" ]; then
        error_msg "\$INSTALLATION_DISK does not have a valid value"
    fi

    partprobe -d -s $INSTALLATION_DISK &> /dev/zero && log "Disk check"
    
    partitioning_helper $INSTALLATION_DISK && log "Performing partitioning"
}

### Second step after partitions are defined is to format them

format_partitions(){
    
    title_msg "Formatting partitions"

    mkfs.fat -F32 "$INSTALLATION_DISK"2 && log "Formatting EFI partition"
    
    if [ $USB -eq 1 ]; then
        mkfs.ext4 -O "^has_journal" "$INSTALLATION_DISK"4 && log "Formatting "$INSTALLATION_DISK"4"
    else
        mkfs.ext4 "$INSTALLATION_DISK"4 && log "Formatting "$INSTALLATION_DISK"4"
    fi

    mkswap "$INSTALLATION_DISK"3 && log "Formatting swap"
}

# Third step: after partitions are formatted mount them 

mounting_filesystems(){

    title_msg "Mounting filesystems"

    swapon "$INSTALLATION_DISK"3 && log "Activating swap"

    mount "$INSTALLATION_DISK"4 /mnt &> /dev/zero && log "Mounting "$INSTALLATION_DISK"4"

    mkdir "/mnt/$BOOT_DIRECTORY" && mount "$INSTALLATION_DISK"2 "/mnt/$BOOT_DIRECTORY" &> /dev/zero && log "Mounting EFI partition"
}

# Fourth step: install basic linux firmware

installing_firmware(){

    title_msg "Installing firmware"

    update_pacman_keys && log "Updating pacman keys"
    pacstrap /mnt $FIRMWARE && log "Installing firmware"
}

# Fifth step: executing chroot

system_configuration(){

    title_msg "System configuration"

    cp -rf $WORKDIR /mnt
    arch-chroot /mnt ./$INSTALL_FOLDER/chroot/system_config.sh && log "Performing chroot on system config"

#   echo "----------------------------------------------"
#   echo " + Limipeza"
#   echo "----------------------------------------------"

#   # Limipeza de chroot
#   rm -r /mnt/install /mnt/config /mnt/utils &> /dev/zero && mensaje_exito "Se ha eliminado el script chroot" || mensaje_fallo "Fallo durante la eliminacion del script de chroot"
  
#   # Copia de ficheros de configuracion
#   copia_ficheros_config

#   echo "----------------------------------------------"
#   echo " + Fin de la instalacion"
#   echo "----------------------------------------------"

#   swapoff "$DISCO_INSTALACION"3 && mensaje_exito "Se ha desactivado el swap" || mensaje_fallo "Fallo al desactivar el swap"
#   umount "$DISCO_INSTALACION"4 "$DISCO_INSTALACION"2 && mensaje_exito "Se han desmontado las particiones" || mensaje_fallo "Fallo al desmontar las particiones"
}

### Execute steps
# 1
# partitioning
# 2
# format_partitions
# 3
# mounting_filesystems
# 4
# installing_firmware
# 5
system_configuration