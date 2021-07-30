#!/bin/bash

#Frameworks

.  ../config/config.sh
.  ./utilities.sh

# Instalar paquetes

paquetes=($(echo $PAQUETES_AUR | tr ";" "\n"))

#Print the split string
for paquete in "${paquetes[@]}"
do
    echo "----------------------------------------------"
    echo " + Instalando $paquete"
    echo "----------------------------------------------"
        
    yay -S $paquete &> /dev/zero && mensaje_exito "Se ha instalado $paquete" || mensaje_fallo "Fallo durante la instalacion de $paquete"
done