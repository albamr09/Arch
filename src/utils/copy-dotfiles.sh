#!/bin/bash

#Frameworks

.  ../config/config.sh
.  ../utils/utilities.sh

# Copiar dotfiles

sudo cp -r $DIR_DOTFILES/.??* /home/$USUARIO &> /dev/zero && mensaje_exito "Se han copiado los ficheros de configuracion para $USUARIO" || mensaje_fallo "Fallo durante la copia de los ficheros de configuracion en $USUARIO"