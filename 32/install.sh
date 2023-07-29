#!/bin/bash

.  config.sh
.  utils.sh

############################################################################
## INSTALLATION SCRIPT
############################################################################

### First step is to partition our disk

partitioning_helper(){
  echo " + Partitioning disk $1"

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

partitioning(){

  echo "----------------------------------------------"
  echo "--------------- Partitioning -----------------"
  echo "----------------------------------------------"


  if [ -z "$INSTALLATION_DISK" ]; then
        error_msg "\$INSTALLATION_DISK does not have a valid value"
  fi

  partprobe -d -s $INSTALLATION_DISK &> /dev/zero && success_msg "Disk check was successful" || error_msg "$INSLLATION_DISK does not exist"
  
  partitioning_helper $INSTALLATION_DISK
}

### Second step after partitions are defined is to format them

format_partitions(){
  
  echo "----------------------------------------------"
  echo "----------- Formatting partitions ------------"
  echo "----------------------------------------------"


  mkfs.fat -F32 "$INSTALLATION_DISK"2 && success_msg "Successfully formatted EFI partition" || error_msg "Error while formatting EFI partition"
  
  if [ $USB -eq 1 ]; then
      mkfs.ext4 -O "^has_journal" "$INSTALLATION_DISK"4 && success_msg "Successfully formatted "$INSTALLATION_DISK"4" || error_msg "Error formatting "$INSTALLATION_DISK"4" 
  else
      mkfs.ext4 "$INSTALLATION_DISK"4 && success_msg "Formateo exitoso" || error_msg "Fallo en el formateo"
  fi

  mkswap "$INSTALLATION_DISK"3 && success_msg "Formateo exitoso de swap" || error_msg "Fallo en el formateo de swap"
}

### Execute steps
#1
partitioning()