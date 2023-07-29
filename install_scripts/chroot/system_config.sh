#!/bin/bash

. ../utils.sh
. ../config.sh

config_system() {

    title_msg "Configuring language"
    echo "$LANG $CODEC" >> /etc/locale.gen )
    execute locale-gen
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
    execute ln -sf /usr/share/zoneinfo/$TIMEZONE /etc/localtime
    execute hwclock --systohc
}

config_image(){

    title_msg "Configuring linux image"

    sed -i "s/HOOKS=\(.*\)/HOOKS=$HOOKS_MKINITCPIO/g" /etc/mkinitcpio.conf
    
    title_msg "Rebuilding linux image"

    execute mkinitcpio -p linux
}

config_grub () {
    
    title_msg "Configuring GRUB"

    execute pacman -S grub parted --noconfirm
    execute partprobe -d -s $GRUB_PARTITION

    title_msg "Configuring BIOS Legacy"

    execute grub-install --target=$TARGET_GRUB_LEGACY --boot-directory="$BOOT_DIRECTORY" $GRUB_PARTITION

    title_msg "Configuring EFI"

    if [ $USB -eq 1 ]; then
        execute grub-install --target=$TARGET_GRUB_EFI --efi-directory="$BOOT_DIRECTORY" --boot-directory="$BOOT_DIRECTORY" --removable $GRUB_PARTITION
    else
        execute grub-install --target=$TARGET_GRUB_EFI --efi-directory="$BOOT_DIRECTORY" --boot-directory="$BOOT_DIRECTORY" $GRUB_PARTITION
    fi

    title_msg "Generating GRUB configuration file"
    execute grub-mkconfig -o "$GRUB_CONF_DIR"
}

generate_fstab(){

  title_msg "Generating fstab"

  execute pacman -S arch-install-scripts --noconfirm
  execute $(genfstab -U / > /etc/fstab)
  execute pacman -R arch-install-scripts --noconfirm

}

#Internet
config_network() {
    
    title_msg "Configuring network"

    execute systemctl enable NetworkManager
}

config_users(){

    title_msg "Configuring root user"

    passwd
    while [ $? != 0 ]; do
        passwd
    done

    title_msg "Adding root to sudo"

    execute pacman -S sudo --noconfirm
    sed -i '82 s/^##*//' /etc/sudoers

    title_msg "Adding user"

    execute useradd -m -G wheel -s /bin/bash $USER
    passwd $USER
    while [ $? != 0 ]; do
        passwd $USER
    done
    execute chmod -R 770 /home/$USER
    sudo sed -i "s/^# %wheel ALL=(ALL:ALL) ALL/%wheel ALL=(ALL:ALL) ALL/g" /etc/sudoers
}


## Execute every step
update_pacman_keys
config_system
config_image
config_grub
generate_fstab
config_network
config_users
config_usb
