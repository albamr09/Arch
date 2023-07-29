#!/bin/bash

. ../utils.sh
. ../config.sh

config_system() {

    title_msg "Configuring language"
    echo "$LANG $CODEC" >> /etc/locale.gen
    locale-gen &> /dev/zero && log "Configuring language"
    echo "LANG=$LANG" > /etc/locale.conf

    title_msg "Configuring keyboard"
    echo "KEYMAP=$KEYMAP" > /etc/vconsole.conf

    title_msg "Configuring user"
    if [ -z "$USER" ]; then
        error_msg "Invalid \$USER"
    else
        echo $USER > /etc/hostname
        echo "127.0.0.1	localhost" >> /etc/hosts
        echo "::1	localhost" >> /etc/hosts
        echo "127.0.1.1	$USER.localdomain    $USER" >> /etc/hosts
    fi

    title_msg "Configuring time"
    ln -sf /usr/share/zoneinfo/$TIMEZONE /etc/localtime  && log "Configuring timezone"
    hwclock --systohc
}

config_image(){

    title_msg "Configuring linux image"

    sed -i "s/HOOKS=\(.*\)/HOOKS=$HOOKS_MKINITCPIO/g" /etc/mkinitcpio.conf &> /dev/zero && log "Configuring mkinitcpio"
    
    title_msg "Rebuilding linux image"

    mkinitcpio -p linux && log "Rebuilt linux image"
}

config_grub () {
    
    title_msg "Configuring GRUB"

    pacman -S grub parted --noconfirm && log "Installing GRUB"
    partprobe -d -s $GRUB_PARTITION &> /dev/zero && log "Checking GRUB partition"

    title_msg "Configuring BIOS Legacy"

    grub-install --target=$TARGET_GRUB_LEGACY --boot-directory="$BOOT_DIRECTORY" \ 
        $GRUB_PARTITION &> /dev/zero && log "Installing BIOS Legacy"

    title_msg "Configuring EFI"

    if [ $USB -eq 1 ]; then
        grub-install --target=$TARGET_GRUB_EFI --efi-directory="$BOOT_DIRECTORY" --boot-directory="$BOOT_DIRECTORY" \ 
            --removable $GRUB_PARTITION &> /dev/zero && log "Installing EFI with USB"
    else
        grub-install --target=$TARGET_GRUB_EFI --efi-directory="$BOOT_DIRECTORY" --boot-directory="$BOOT_DIRECTORY" \ 
            $GRUB_PARTITION &> /dev/zero && log "Installing EFI"
    fi

    title_msg "Generating GRUB configuration file"
    grub-mkconfig -o "$GRUB_CONF_DIR" &> /dev/zero && log "Generating GRUB config file"
}


## Execute every step
update_pacman_keys
# config_system
# config_image
config_grub