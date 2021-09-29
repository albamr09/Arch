
"---------------------------------------------------------------------------------------
" _____ ______   ________  ________  ________  ___  ________   ________  ________      
"|\   _ \  _   \|\   __  \|\   __  \|\   __  \|\  \|\   ___  \|\   ____\|\   ____\     
"\ \  \\\__\ \  \ \  \|\  \ \  \|\  \ \  \|\  \ \  \ \  \\ \  \ \  \___|\ \  \___|_    
" \ \  \\|__| \  \ \   __  \ \   ____\ \   ____\ \  \ \  \\ \  \ \  \  __\ \_____  \   
"  \ \  \    \ \  \ \  \ \  \ \  \___|\ \  \___|\ \  \ \  \\ \  \ \  \|\  \|____|\  \  
"   \ \__\    \ \__\ \__\ \__\ \__\    \ \__\    \ \__\ \__\\ \__\ \_______\____\_\  \ 
"    \|__|     \|__|\|__|\|__|\|__|     \|__|     \|__|\|__| \|__|\|_______|\_________\
"                                                                          \|_________|
"---------------------------------------------------------------------------------------

" --------------- ] File Explorer [  --------------- 

" Toggle
nnoremap <silent> <C-b> :call NERDTreeToggleAndRefresh()<CR>

" Toggle and refresh
function NERDTreeToggleAndRefresh()
  :NERDTreeToggle
  if g:NERDTree.IsOpen()
    :NERDTreeRefreshRoot
  endif
endfunction

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

" -------------- ] Documentacion en hover [ ----------------

nnoremap <silent> K :call CocAction('doHover')<CR>

" -------------- ] File search [ ----------------

" Search files in popup window
nnoremap <silent> <leader>f :<C-U>Leaderf file<CR>
" Search vim help files
nnoremap <silent> <leader>h :<C-U>Leaderf help --popup<CR>

" --------------- ] Tab Navigation [  --------------- 

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

" Close buffer
nnoremap <silent>    <A-c> :BufferClose<CR>

" -------------- ] Markdown Preview [ ----------------

" Open preview
nmap <C-s> <Plug>MarkdownPreview        

" -------------- ] Toggle spell check [ ----------------

nnoremap <silent> <F11> :set spell!<cr>
inoremap <silent> <F11> <C-O>:set spell!<cr>