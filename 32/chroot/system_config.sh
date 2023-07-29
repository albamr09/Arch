#!/bin/bash

ls
echo $PWD

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


## Execute every step
config_system
# config_image