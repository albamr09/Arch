
# Frameworks

. ../config/config.sh


#Utilities

mensaje_fallo(){
  echo " - $1"; exit
}

mensaje_exito(){
  echo " + $1"
}

#Actualizacion mirrors

actualizacion_mirrors(){

  echo "----------------------------------------------"
  echo "---------- Actualizacion de mirrors ----------"
  echo "----------------------------------------------"

  pacman -Sy &> /dev/zero && mensaje_exito "Actualizacion terminada sin errores" || mensaje_fallo "Ha habido algun error durante la actualizacion"
}

# Actualizacion de keys

actualizacion_keys(){

  echo "----------------------------------------------"
  echo "----------- Actualizacion de keys ------------"
  echo "----------------------------------------------"

  for i in {1..3}
  do
    pacman-key --refresh-keys --keyserver $KEYSERVER &> /dev/zero && mensaje_exito "Refresco terminado correctamente" || mensaje_fallo "Ha habido algun error durante el refresco"
    pacman-key --init &> /dev/zero && mensaje_exito "Inicializacion realizada correctamente" || mensaje_fallo "Ha habido algun error durante la inicializacion"
    pacman-key --populate $ARQUITECTURA &> /dev/zero && mensaje_exito "Repopulacion terminada correctamente" || mensaje_fallo "Ha habido algun error durante la repopulacion"
  done

}
