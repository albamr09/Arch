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

    execute sudo cp $DIR_SERVICES/* /etc/systemd/system
    execute sudo systemctl enable suspend@$USER
    # Battery notifcation service
    execute su -c "systemctl --user enable check-battery-user.timer" $USER
    execute su -c "systemctl --user start check-battery-user.service" $USER
    execute sudo systemctl daemon-reload
}

cleanup() {

    title_msg "Removing installation files"
    execute cd / && rm -r $INSTALL_FOLDER
}

connect_network
configure_services
cleanup