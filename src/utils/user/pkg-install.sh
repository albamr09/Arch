#!/bin/bash

#Frameworks

.  ../config/config.sh

# Instalar paquetes

paquetes=($(echo $PAQUETES_AUR | tr ";" "\n"))

#Print the split string
for paquete in "${paquetes[@]}"
do
    echo "----------------------------------------------"
    echo " + Instalando $paquete"
    echo "----------------------------------------------"
        
    yay -S $paquete --answerdiff None --answerclean None
done
