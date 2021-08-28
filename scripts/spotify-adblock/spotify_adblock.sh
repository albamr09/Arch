#!/usr/bin/bash

yay -S make rust
git clone https://github.com/abba23/spotify-adblock.git
cd spotify-adblock
make
sudo make install
cd ..
rm -r spotify-adblock

# Usage
# Modify spotify desktop file and add:
# Exec=env LD_PRELOAD=/usr/local/lib/spotify-adblock.so spotify %U
