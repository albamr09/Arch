#!/bin/bash

# Crear directorio temporal y montar usb
# - $1: dispositivo a montar
# - $2: directorio
# - $3: usuario
# - $4: montar nfts

NFTS=$4
DISPOSITIVO=$1
DIRECTORIO=$2
USUARIO=$3

if [ -z "$1" ]
  then
    DISPOSITIVO="sdc1"
fi

if [ -z "$2" ]
  then
    DIRECTORIO="/tmp/SANDISK"
fi

if [ -z "$3" ]
  then
	USUARIO="alba"
fi

if [ -z "$4" ]
  then
	mkdir -p $DIRECTORIO && sudo mount /dev/$DISPOSITIVO $DIRECTORIO -o uid=$USUARIO
else
	mkdir -p $DIRECTORIO && sudo mount -t ntfs-3g /dev/$DISPOSITIVO $DIRECTORIO
fi
