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

    grub-install --target=$TARGET_GRUB_LEGACY --boot-directory="$BOOT_DIRECTORY" $GRUB_PARTITION &> /dev/zero && log "Installing BIOS Legacy"

    title_msg "Configuring EFI"

    if [ $USB -eq 1 ]; then
        grub-install --target=$TARGET_GRUB_EFI --efi-directory="$BOOT_DIRECTORY" --boot-directory="$BOOT_DIRECTORY" --removable $GRUB_PARTITION &> /dev/zero && log "Installing EFI with USB"
    else
        grub-install --target=$TARGET_GRUB_EFI --efi-directory="$BOOT_DIRECTORY" --boot-directory="$BOOT_DIRECTORY" $GRUB_PARTITION &> /dev/zero && log "Installing EFI"
    fi

    title_msg "Generating GRUB configuration file"
    grub-mkconfig -o "$GRUB_CONF_DIR" &> /dev/zero && log "Generating GRUB config file"
}

generate_fstab(){

  title_msg "Generating fstab"

  pacman -S arch-install-scripts --noconfirm
  $(genfstab -U / > /etc/fstab) &> /dev/zero && log "Generating fstab"
  pacman -R arch-install-scripts --noconfirm

}

#Internet
config_network() {
    
    title_msg "Configuring network"

    systemctl enable NetworkManager &> /dev/zero && log "Network configuraiton"
}

config_users(){

    title_msg "Configuring root user"

    passwd
    while [ $? != 0 ]; do
        passwd
    done

    title_msg "Adding root to sudo"

    pacman -S sudo --noconfirm
    sed -i '82 s/^##*//' /etc/sudoers && log "Adding root to group"

    title_msg "Adding user"

    useradd -m -G wheel -s /bin/bash $USER &> /dev/zero && log "Creating $USER user"
    passwd $USER
    while [ $? != 0 ]; do
        passwd $USER
    done
    chmod -R 770 /home/$USER &> /dev/zero && log "Configuring permissions for $USER"
    sudo sed -i "s/^# %wheel ALL=(ALL:ALL) ALL/%wheel ALL=(ALL:ALL) ALL/g" /etc/sudoers &> /dev/zero && log "Adding $USER to sudoers"
}


## Execute every step
update_pacman_keys
# config_system
# config_image
# config_grub
# generate_fstab
# config_network
config_users