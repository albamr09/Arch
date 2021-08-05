#!/bin/bash

# Crear directorio temporal y montar usb
mkdir /tmp/usbstick/ && sudo mount /dev/sdc1 /tmp/usbstick -o uid=alba
