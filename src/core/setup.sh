#!/bin/bash

CURR_DIR="$PWD"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd $SCRIPT_DIR

. ../common/utils.sh
. ../common/config.sh

config_system() {

    title_msg "Configuring language"
    execute 'echo "$LANG $CODEC" >> /etc/locale.gen'
    execute locale-gen
    execute 'echo "LANG=$LANG" > /etc/locale.conf'

    title_msg "Configuring keyboard"
    execute 'echo "KEYMAP=$KEYMAP" > /etc/vconsole.conf'

    title_msg "Configuring user"
    if [ -z "$USER" ]; then
        error_msg "Invalid \$USER"
    else
        execute 'echo $USER > /etc/hostname'
        execute 'echo "127.0.0.1	localhost" >> /etc/hosts'
        execute 'echo "::1	localhost" >> /etc/hosts'
        execute 'echo "127.0.1.1	$USER.localdomain    $USER" >> /etc/hosts'
    fi

    title_msg "Configuring time"
    execute ln -sf /usr/share/zoneinfo/$TIMEZONE /etc/localtime
    execute hwclock --systohc
}

config_image(){

    title_msg "Configuring linux image"

    execute 'sed -i "s/HOOKS=\(.*\)/HOOKS=$HOOKS_MKINITCPIO/g" /etc/mkinitcpio.conf'
    
    title_msg "Rebuilding linux image"

    execute mkinitcpio -p linux
}

config_grub () {
    
    title_msg "Configuring GRUB"

    execute pacman -S grub parted --noconfirm
    execute partprobe -d -s $GRUB_PARTITION

    title_msg "Configuring BIOS Legacy"

    execute grub-install --target=$TARGET_GRUB_LEGACY --boot-directory="$BOOT_DIRECTORY" $GRUB_PARTITION

    if system_supports_efi; then
    
        title_msg "Configuring EFI"

        local efi_target=$TARGET_GRUB_EFI

        if is_machine_32; then
            efi_target=$TARGET_GRUB_EFI_32
        fi

        if [ $USB -eq 1 ]; then
            execute grub-install --target=$efi_target --efi-directory="$BOOT_DIRECTORY" --boot-directory="$BOOT_DIRECTORY" --removable $GRUB_PARTITION
        else
            execute grub-install --target=$efi_target --efi-directory="$BOOT_DIRECTORY" --boot-directory="$BOOT_DIRECTORY" $GRUB_PARTITION
        fi
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
    execute 'sudo sed -i "s/^# %wheel ALL=(ALL:ALL) ALL/%wheel ALL=(ALL:ALL) ALL/g" /etc/sudoers'

    title_msg "Adding user"

    execute useradd -m -G wheel -s /bin/bash $USER
    passwd $USER
    while [ $? != 0 ]; do
        passwd $USER
    done
    execute chmod -R 770 /home/$USER
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

cd $CURR_DIR