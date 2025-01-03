#!/bin/bash

# GUEST

# Install ssh
# pamcan -Sy && pamcan -S openssh
# systemctl start sshd
# systemctl enable sshd

# Create password for root
# passwd

# Obtain ip on the guest machine
# ip a

# HOST

# Connect to guest machine
ssh root@192.168.1.130