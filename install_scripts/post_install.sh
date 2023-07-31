#!/bin/bash

. utils.sh
. config.sh

connect_network(){
    
    title_msg "Setting up network connection"

    nmcli device wifi
    nmcli --ask device wifi connect
}

configure_services(){
    
    title_msg "Configuring services"
    systemctl enable lightdm.service

    execute sudo systemctl enable suspend@$USER
    # Battery notifcation service
    execute systemctl --user enable check-battery-user.timer
    execute systemctl --user start check-battery-user.service
    execute sudo systemctl daemon-reload
}

cleanup() {

    title_msg "Removing installation files"
    execute cd / && sudo rm -r $INSTALL_FOLDER
}

connect_network
configure_services
cleanup
