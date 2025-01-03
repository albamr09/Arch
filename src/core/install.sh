#!/bin/bash

# Directory of the currently running script
CURR_DIR="$PWD"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd $SCRIPT_DIR

. ../common/config.sh
. ../common/utils.sh
. ../common/fs.sh

# Exit immediately if any command fails
set -e

############################################################################
## INSTALLATION SCRIPT
############################################################################

### First step is to partition our disk

partitioning(){

    title_msg "Partitioning"

    if [ -z "$INSTALLATION_DISK" ]; then
        error_msg "\$INSTALLATION_DISK does not have a valid value"
    fi

    execute partprobe -d -s $INSTALLATION_DISK
    execute partition $INSTALLATION_DISK
}

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

installing_firmware(){

    title_msg "Installing firmware"

    execute update_pacman_keys
    execute pacstrap /mnt $FIRMWARE
}

system_configuration(){

    title_msg "System configuration and setup"

    execute mkdir -p $INSTALL_FOLDER && cp -rf $SRC_DIR $INSTALL_FOLDER
    execute 'arch-chroot /mnt /bin/bash -c "cd $CHROOT_INSTALL_FOLDER/ && ./src/core/setup.sh"'
    execute rm -rf $SRC_INSTALL_FOLDER/*
}

finish(){
    title_msg "Finishing installation"
    umount_fs
}


partitioning
format_partitions
mount_fs
installing_firmware
system_configuration
finish

cd $CURR_DIR