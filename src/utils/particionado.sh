#!/bin/bash

realizar_particionado(){
  echo " + Particionamiento del disco $1"

  sed -e 's/\s*\([\+0-9a-zA-Z]*\).*/\1/' << EOF | gdisk $DISCO_INSTALACION
  o     # Borrar tabla de particiones
  Y     # Confirmar borrado
  n     # Nueva particion
  1     # Particion numero 1
        # Default - empezar al principio del disco 
  +10M  # 10M de BIOS
  ef02  #Tipo de particion BIOS Boot Partition
  n     # Nueva particion
  2     # Particion numero 2
        # Default - empezar al principio del disco
  +250M # 250M de EFI
  ef00  #Tipo de particion EFI
  n     # Nueva particion
  3     # Particion numero 3
        # Default - empezar al principio del disco
  +2G   # 2G de swap
  8200  #Tipo de particion swap
  n     # Nueva particion
  4     # Particion numero 4
        # Default - empezar al principio del disco
        # Default - ocupar el resto del disco
        # Default - tipo de particion Linux file system
  p # Print resultado
  w # Guardar
  Y # Confirmar resultado
  q # Salir
EOF
}

