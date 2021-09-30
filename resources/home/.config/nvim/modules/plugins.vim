
"------------------------------------------------------------------------------
" ________  ___       ___  ___  ________  ___  ________   ________      
"|\   __  \|\  \     |\  \|\  \|\   ____\|\  \|\   ___  \|\   ____\     
"\ \  \|\  \ \  \    \ \  \\\  \ \  \___|\ \  \ \  \\ \  \ \  \___|_    
" \ \   ____\ \  \    \ \  \\\  \ \  \  __\ \  \ \  \\ \  \ \_____  \   
"  \ \  \___|\ \  \____\ \  \\\  \ \  \|\  \ \  \ \  \\ \  \|____|\  \  
"   \ \__\    \ \_______\ \_______\ \_______\ \__\ \__\\ \__\____\_\  \ 
"    \|__|     \|_______|\|_______|\|_______|\|__|\|__| \|__|\_________\
"                                                           \|_________|
"
"------------------------------------------------------------------------------


call plug#begin('~/.vim/plugged')
" Autocomplete
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" Temas
Plug 'haishanh/night-owl.vim'

" File explorer
Plug 'scrooloose/nerdtree'
Plug 'ryanoasis/vim-devicons'

" Syntax highlighting
Plug 'leafgarland/typescript-vim'
Plug 'peitalin/vim-jsx-typescript'
Plug 'HerringtonDarkholme/yats.vim'
Plug 'pangloss/vim-javascript'
Plug 'styled-components/vim-styled-components', { 'branch': 'main' }

" Linea estado abajo
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" Linea de identacion
Plug 'Yggdroot/indentLine'

" Github
Plug 'airblade/vim-gitgutter'

" Tab navigation
Plug 'kyazdani42/nvim-web-devicons'
Plug 'romgrk/barbar.nvim'
Plug 'Xuyuanp/nerdtree-git-plugin'

" Scroll
Plug 'karb94/neoscroll.nvim'

" File search
Plug 'Yggdroot/LeaderF', { 'do': ':LeaderfInstallCExtension' }

" Smooth scrolling
Plug 'karb94/neoscroll.nvim'

" Markdown preview
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app & yarn install' }

" Vimwiki
Plug 'vimwiki/vimwiki'

" Latex
Plug 'lervag/vimtex'

call plug#end()
