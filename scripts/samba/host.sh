#!/bin/bash

yay -S samba

mkdir -p ~/sambashare
sudo cp smb.conf /etc/samba/smb.conf
sudo chown -R alba:alba ~/sambashare
sudo chmod -R 755 ~/sambashare

sudo smbpasswd -a alba
sudo smbpasswd -e alba

sudo systemctl enable smb
sudo systemctl restart smb