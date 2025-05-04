#!/bin/bash

# Select last line from battery info
BATTINFO=`acpi -b | sed  /"Unknown"/d | tail -n 1`
# Extract number value of remaning battery
PERCENTAGE=$(echo "$BATTINFO" | grep -oP 'Discharging, \K[0-9]+')
 
if [[ `echo $BATTINFO | grep Discharging` && $PERCENTAGE -lt 15 ]] ; then
  PRINTINFO="Discharging "$PERCENTAGE"%"
  /usr/bin/notify-send -u critical "battery" "$PRINTINFO"
elif [[ (`echo $BATTINFO | grep Charging` || `echo $BATTINFO | grep Full`) && $PERCENTAGE -gt 95 ]] ; then
  /usr/bin/notify-send -u normal "battery" "Fully charged!"
fi
