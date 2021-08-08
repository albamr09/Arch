call plug#begin('~/.vim/plugged')
" Autocomplete
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" Temas
Plug 'gruvbox-community/gruvbox'
Plug 'dracula/vim'

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
Plug 'tpope/vim-fugitive'

" Busqueda de ficheros
Plug 'ctrlpvim/ctrlp.vim'
call plug#end()



" --------------- ] Tema [  --------------- 

if (has("termguicolors"))
 set termguicolors
endif
syntax enable
colorscheme gruvbox

" --------------- ] Config neovim [  --------------- 

set background=dark
set tabstop=2
set smartindent
set nu
set smartcase
set softtabstop=0 noexpandtab
set shiftwidth=2
set encoding=UTF-8

" --------------- ] Autocomplete [  --------------- 

let g:coc_global_extensions = [
\ 'coc-snippets',
\ 'coc-pairs',
\ 'coc-prettier',
\ 'coc-python',
\ 'coc-clangd',
\ 'coc-java',
\ 'coc-json',
\	'coc-css', 
\ 'coc-html', 
\ 'coc-tsserver',
\ 'coc-emmet',
\ 'coc-eslint'
\]


" --------------- ] File Explorer [  --------------- 

let g:NERDTreeShowHidden = 1
let g:NERDTreeMinimalUI = 1
let g:NERDTreeIgnore = []
let g:NERDTreeStatusline = ''
" Automaticaly close nvim if NERDTree is only thing left open
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
" Toggle
nnoremap <silent> <C-b> :NERDTreeToggle<CR>

" -------------- ] Integrated Terminal [ ----------------

" open new split panes to right and below
set splitright
set splitbelow
" turn terminal to normal mode with escape
tnoremap <Esc> <C-\><C-n>
" start terminal in insert mode
au BufEnter * if &buftype == 'terminal' | :startinsert | endif
" open terminal on ctrl+n
function! OpenTerminal()
  split term://bash
  resize 10
endfunction
nnoremap <c-n> :call OpenTerminal()<CR>

" -------------- ] Switching between panels [ ----------------

" use alt+hjkl to move between split/vsplit panels
tnoremap <A-h> <C-\><C-n><C-w>h
tnoremap <A-j> <C-\><C-n><C-w>j
tnoremap <A-k> <C-\><C-n><C-w>k
tnoremap <A-l> <C-\><C-n><C-w>l
nnoremap <A-h> <C-w>h
nnoremap <A-j> <C-w>j
nnoremap <A-k> <C-w>k
nnoremap <A-l> <C-w>l


" -------------- ] Cambiar tamaño splits [ ----------------

nnoremap <Left> :vertical resize +5 <CR>
nnoremap <Right> :vertical resize -5 <CR>
nnoremap <Down> :resize +5 <CR>
nnoremap <Up> :resize -5 <CR>



" -------------- ] Airline configuracion [ -----------------
 
let g:airline_powerline_fonts = 1

" -------------- ] Documentacion en hover [ ----------------

nnoremap <silent> K :call CocAction('doHover')<CR>


" -------------- ] Linea identacion [ ----------------

" No mostrar en ciertos tipos de buffers y archivos
let g:indentLine_fileTypeExclude = ['text', 'sh', 'help', 'terminal']
let g:indentLine_bufNameExclude = ['NERD_tree.*', 'term:.*']
