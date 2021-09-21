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

" Markdownpreview
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install'  }

call plug#end()


" --------------- ] Tema [  --------------- 

if (has("termguicolors"))
 set termguicolors
endif
syntax enable
colorscheme night-owl

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

" Git status
let g:NERDTreeGitStatusUseNerdFonts = 1

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


" -------------- ] Git update time [ ----------------

set updatetime=100

" -------------- ] Smooth Scroll [ ----------------

lua <<EOF
require'neoscroll'.setup {
    mappings = {'<C-u>', '<C-d>', '<C-f>',
                '<C-y>', '<C-e>', 'zt', 'zz', 'zb'}
}
EOF

" -------------- ] File search [ ----------------

"" Map leader to ,
let mapleader=','

" Disable default mapping
let g:Lf_ShortcutF = ''
let g:Lf_ShortcutB = ''

" Do not use cache file
let g:Lf_UseCache = 0
" Refresh each time we call leaderf
let g:Lf_UseMemoryCache = 0

" popup mode
let g:Lf_WindowPosition = 'popup'
let g:Lf_PreviewInPopup = 1

" Search files in popup window
nnoremap <silent> <leader>f :<C-U>Leaderf file<CR>
" Search vim help files
nnoremap <silent> <leader>h :<C-U>Leaderf help --popup<CR>

" Ignore certain files and directories when searching files
let g:Lf_WildIgnore = {
  \ 'dir': ['.git', '__pycache__', '.DS_Store'],
  \ 'file': ['*.exe', '*.dll', '*.so', '*.o', '*.pyc', '*.jpg', '*.png',
  \ '*.gif', '*.svg', '*.ico', '*.db', '*.tgz', '*.tar.gz', '*.gz',
  \ '*.zip', '*.bin', '*.pptx', '*.xlsx', '*.docx', '*.pdf', '*.tmp',
  \ '*.wmv', '*.mkv', '*.mp4', '*.rmvb', '*.ttf', '*.ttc', '*.otf',
  \ '*.mp3', '*.aac']
  \}

" -------------- ] Tabs navigation [ ----------------

" Move to previous/next
nnoremap <silent>    <A-,> :BufferPrevious<CR>
nnoremap <silent>    <A-.> :BufferNext<CR>
" Re-order to previous/next
nnoremap <silent>    <A-<> :BufferMovePrevious<CR>
nnoremap <silent>    <A->> :BufferMoveNext<CR>
" Goto buffer in position...
nnoremap <silent>    <A-1> :BufferGoto 1<CR>
nnoremap <silent>    <A-2> :BufferGoto 2<CR>
nnoremap <silent>    <A-3> :BufferGoto 3<CR>
nnoremap <silent>    <A-4> :BufferGoto 4<CR>
nnoremap <silent>    <A-5> :BufferGoto 5<CR>
nnoremap <silent>    <A-6> :BufferGoto 6<CR>
nnoremap <silent>    <A-7> :BufferGoto 7<CR>
nnoremap <silent>    <A-8> :BufferGoto 8<CR>
nnoremap <silent>    <A-9> :BufferLast<CR>
" Pin/unpin buffer
nnoremap <silent>    <A-p> :BufferPin<CR>
" Close buffer
nnoremap <silent>    <A-c> :BufferClose<CR>
" Wipeout buffer
"                          :BufferWipeout<CR>
" Close commands
"                          :BufferCloseAllButCurrent<CR>
"                          :BufferCloseAllButPinned<CR>
"                          :BufferCloseBuffersLeft<CR>
"                          :BufferCloseBuffersRight<CR>
" Magic buffer-picking mode
nnoremap <silent> <C-s>    :BufferPick<CR>
" Sort automatically by...
nnoremap <silent> <Space>bb :BufferOrderByBufferNumber<CR>
nnoremap <silent> <Space>bd :BufferOrderByDirectory<CR>
nnoremap <silent> <Space>bl :BufferOrderByLanguage<CR>
nnoremap <silent> <Space>bw :BufferOrderByWindowNumber<CR>

" Other:
" :BarbarEnable - enables barbar (enabled by default)
" :BarbarDisable - very bad command, should never be used
