#!/bin/bash

#Frameworks

.  ../config/config.sh
.  ./utilities.sh

# Copiar dotfiles

sudo cp -r ../config/dotfiles/.??* /home/$USUARIO &> /dev/zero && mensaje_exito "Se han copiado los ficheros de configuracion para $USUARIO" || mensaje_fallo "Fallo durante la copia de los ficheros de configuracion en $USUARIO"