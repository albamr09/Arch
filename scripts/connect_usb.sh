#!/bin/bash

# Crear directorio temporal y montar usb
# - $1: dispositivo a montar
# - $2: directorio
# - $3: usuario

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

mkdir $DIRECTORIO && sudo mount /dev/$DISPOSITIVO $DIRECTORIO -o uid=$USUARIO
