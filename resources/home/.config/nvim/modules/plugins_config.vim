
"---------------------------------------------------------------
" ________  ________  ________   ________ ___  ________     
"|\   ____\|\   __  \|\   ___  \|\  _____\\  \|\   ____\    
"\ \  \___|\ \  \|\  \ \  \\ \  \ \  \__/\ \  \ \  \___|    
" \ \  \    \ \  \\\  \ \  \\ \  \ \   __\\ \  \ \  \  ___  
"  \ \  \____\ \  \\\  \ \  \\ \  \ \  \_| \ \  \ \  \|\  \ 
"   \ \_______\ \_______\ \__\\ \__\ \__\   \ \__\ \_______\
"    \|_______|\|_______|\|__| \|__|\|__|    \|__|\|_______|
"
"---------------------------------------------------------------


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

" Git status
let g:NERDTreeGitStatusUseNerdFonts = 1

" -------------- ] Airline configuracion [ -----------------
 
let g:airline_powerline_fonts = 1

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

" Ignore certain files and directories when searching files
let g:Lf_WildIgnore = {
  \ 'dir': ['.git', '__pycache__', '.DS_Store'],
  \ 'file': ['*.exe', '*.dll', '*.so', '*.o', '*.pyc', '*.jpg', '*.png',
  \ '*.gif', '*.svg', '*.ico', '*.db', '*.tgz', '*.tar.gz', '*.gz',
  \ '*.zip', '*.bin', '*.pptx', '*.xlsx', '*.docx', '*.pdf', '*.tmp',
  \ '*.wmv', '*.mkv', '*.mp4', '*.rmvb', '*.ttf', '*.ttc', '*.otf',
  \ '*.mp3', '*.aac']
  \}

" -------------- ] Markdown Preview [ ----------------

" Echo the url when the command is executed
let g:mkdp_echo_preview_url = 1

" -------------- ] Vimwiki [ ----------------

" Vimwiki working directory
let g:vimwiki_list = [{'path': '~/Desktop/MyNotes'}]
