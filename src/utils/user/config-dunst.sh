#!/bin/bash

# Eliminar proceso
killall dunst
# Establecer/actualizar fichero de configuracion
dunst -config ~/.config/dunst/dunstrc &