#!/bin/bash

. ../utils.sh
. ../config.sh

connect_network(){
    
    title_msg "Setting up network connection"

    nmcli device wifi
    nmcli --ask device wifi connect 
}