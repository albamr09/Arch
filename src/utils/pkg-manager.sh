
#!/bin/bash

#--------------------------------------------------------
#----------------------  YAOURT  ------------------------
#--------------------------------------------------------

# Dependencias yaourt

#sudo pacman -S --needed base-devel git wget yajl


# package-query

#cd /tmp
#git clone https://aur.archlinux.org/package-query.git
#cd package-query/
#makepkg -si && cd /tmp/

# yaourt

#git clone https://aur.archlinux.org/yaourt.git
#cd yaourt/
#makepkg -si

#--------------------------------------------------------
#------------------------  YAY  -------------------------
#--------------------------------------------------------

# Dependencias yay

sudo pacman -S --needed base-devel git

# Instalar yay
cd /tmp 
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si
