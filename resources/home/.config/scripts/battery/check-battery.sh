#!/bin/bash

BATTINFO=`acpi -b | sed  /"Unknown"/d`
PRINTINFO=`echo $BATTINFO | cut --fields=3,4 -d " " | awk '{ print substr( $0, 1, length($0)-1 ) }'`

if [[ `echo $BATTINFO | grep Discharging` && `echo $BATTINFO | cut -f 4 -d " " | awk '{ print substr( $0, 1, length($0)-2 ) }'` -lt 15 ]] ; then
       /usr/bin/notify-send -u critical "battery" "$PRINTINFO"
fi
