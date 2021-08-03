#!/bin/bash

#Frameworks

.  ../config/config.sh
.  ../utils/utilities.sh

# Copiar dotfiles

sudo cp -r $DIR_DOTFILES/.??* /home/$USUARIO &> /dev/zero && mensaje_exito "Se han copiado los ficheros de configuracion para $USUARIO" || mensaje_fallo "Fallo durante la copia de los ficheros de configuracion en $USUARIO"

# Cambiar owner y permisos

sudo chown -R $USUARIO /home/$USUARIO/.??* && sudo chmod -R 665 /home/$USUARIO/.??* &> /dev/zero && mensaje_exito "Se han cambiado los permisos para $USUARIO" || mensaje_fallo "Fallo durante el cambio de permisos en $USUARIO"
sudo chown -R $USUARIO /home/$USUARIO/* && sudo chmod -R 665 /home/$USUARIO/??* &> /dev/zero && mensaje_exito "Se han cambiado los permisos para $USUARIO" || mensaje_fallo "Fallo durante el cambio de permisos en $USUARIO"
chmod 775 /home/$USUARIO/.xsession &> /dev/zero && mensaje_exito "Se han cambiado los permisos para $USUARIO de xsession" || mensaje_fallo "Fallo durante el cambio de permisos en $USUARIO se xsession"