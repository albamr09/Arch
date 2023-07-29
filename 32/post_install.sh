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


	sudo cp $DIR_SERVICES/* /etc/systemd/system &> /dev/zero && log "Copying services configuration files"
	sudo systemctl enable suspend@$USER &> /dev/zero && log "Activating services"
	# Battery notifcation service
    su -c "systemctl --user enable check-battery-user.timer" $USER
    su -c "systemctl --user start check-battery-user.service" $USER
	sudo systemctl daemon-reload
}

cleanup() {

    title_msg "Removing installation files"
        
    cd / && rm -r Arch  &> /dev/zero && log "Removing installation files"
}