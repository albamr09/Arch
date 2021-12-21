#!/bin/bash
printf 'script started' | systemd-cat -t check-battery #write to log when script is called
BATTINFO=`acpi -b | sed  /"Unknown"/d`
PRINTINFO=`echo $BATTINFO | cut --fields=3,4 -d " " | awk '{ print substr( $0, 1, length($0)-1 ) }'`
if [[ `echo $BATTINFO | grep Discharging` && `echo $BATTINFO | cut -f 4 -d " " | awk '{ print substr( $0, 1, length($0)-2 ) }'` < 15 ]] ; then
        printf 'condition is true' | systemd-cat -t check-battery #write to log if condition is true
       /usr/bin/notify-send -u critical "battery" "$PRINTINFO"
fi
