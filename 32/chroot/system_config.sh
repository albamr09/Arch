#!/bin/bash

.  ../utils.sh
.  ../config.sh

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
    ln -sf /usr/share/zoneinfo/$ZONA_HORARIA /etc/localtime  && mensaje_exito "Configuracion de hora finalizada" || mensaje_fallo "Ha habido algun error durante la configuracion horaria"
    hwclock --systohc
}