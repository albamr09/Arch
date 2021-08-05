#!/bin/bash

# Hacer que haya dos pantallas en lugar de una duplicada
# - LVDS1: monitor portatil
# - VGA1: monitor externo (está conectado por VGA)

xrandr --output LVDS1 --auto --output VGA1 --right-of LVDS1

# Cambiar resolución de monitor
# - VGA1: monitor externo 

xrandr --output VGA1 --mode 1920x1080
