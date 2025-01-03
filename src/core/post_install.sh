#!/bin/bash

CURR_DIR="$PWD"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd $SCRIPT_DIR

. ./common/utils.sh
. ./common/config.sh

connect_network(){
    
    title_msg "Setting up network connection"

    nmcli device wifi
    nmcli --ask device wifi connect
}

configure_services(){
    
    title_msg "Configuring services"
    systemctl enable lightdm.service
    
}

cleanup() {
    title_msg "Removing installation files"
    execute cd / && sudo rm -r $INSTALL_FOLDER/post_install.sh
}

connect_network
configure_services
cleanup

cd $CURR_DIR