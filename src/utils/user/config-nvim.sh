#!/bin/bash

curl -fLo /home/$USER/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
nvim -c 'so ~/.config/nvim/init.vim|q'
nvim -c 'PlugInstall|q|q|q'
pip3 install neovim cpplint pynvim
