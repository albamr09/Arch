#!/bin/bash

# Virtual environments for python
wd=$(pwd)
mkdir -p /home/$USER/.virtualenvs && cd /home/$USER/.virtualenvs
python -m venv debugpy
/home/$USER/.virtualenvs/debugpy/bin/pip3 install debugpy
cd $wd

curl -fLo /home/$USER/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
nvim -c 'PlugInstall|q|q'
nvim -c 'so ~/.config/nvim/init.vim|q'
nvim -c 'PlugInstall|q|q|q'
pip3 install neovim cpplint pynvim
