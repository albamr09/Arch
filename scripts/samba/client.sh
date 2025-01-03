#!/bin/bash

sudo pacman -Sy cifs-utils

sudo mkdir /root/sambashare

# Make sure network on virtual box is configure as Bridge
sudo mount -t cifs //<host_ip>/sambashare /mnt/sambashare -o username=alba