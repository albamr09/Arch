#!/bin/bash

. config.sh
. utils.sh

# Exit immediately if any command fails
set -e

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

    execute partprobe -d -s $INSTALLATION_DISK
    execute partitioning_helper $INSTALLATION_DISK
}

### Second step after partitions are defined is to format them

format_partitions(){
    
    title_msg "Formatting partitions"

    execute mkfs.fat -F32 "$INSTALLATION_DISK"2
    
    if [ $USB -eq 1 ]; then
        execute mkfs.ext4 -O "^has_journal" "$INSTALLATION_DISK"4
    else
        execute mkfs.ext4 -F "$INSTALLATION_DISK"4
    fi

    execute mkswap "$INSTALLATION_DISK"3
}

# Third step: after partitions are formatted mount them 

mounting_filesystems(){

    title_msg "Mounting filesystems"

    execute swapon "$INSTALLATION_DISK"3

    execute mount "$INSTALLATION_DISK"4 /mnt

    execute mkdir -p "/mnt/$BOOT_DIRECTORY" && mount "$INSTALLATION_DISK"2 "/mnt/$BOOT_DIRECTORY"
}

# Fourth step: install basic linux firmware

installing_firmware(){

    title_msg "Installing firmware"

    execute update_pacman_keys
    execute pacstrap /mnt $FIRMWARE
}

# Fifth step: executing chroot

system_configuration(){

    title_msg "System configuration and setup"

    execute cp -rf $WORKDIR /mnt
    execute 'arch-chroot /mnt /bin/bash -c "cd $HOST_INSTALL_FOLDER/ && ./setup.sh"'
}

cleanup() {

    title_msg "Finishing installation"

    title_msg "Copying post install script"
    execute cp $INSTALL_FOLDER/post_install.sh /mnt/$INSTALL_FOLDER
    
    execute swapoff "$INSTALLATION_DISK"3
    execute umount "$INSTALLATION_DISK"2 "$INSTALLATION_DISK"4

    title_msg "Installation finished! Remember to execute the post_install script after reboot!"
}

### Execute steps
partitioning
format_partitions
mounting_filesystems
installing_firmware
system_configuration
cleanup