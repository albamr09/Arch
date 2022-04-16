
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

" ------------------ ] Tree Sitter [ --------------------

lua <<EOF
require'nvim-treesitter.configs'.setup {
  highlight = {
    enable = true,
    disable = {},
  },
  indent = {
    enable = false,
    disable = {},
  },
  ensure_installed = {
    "javascript",
    "json",
    "html",
    "scss"
  },
}
EOF

" -------------- ] Integrated Terminal [ ----------------

" open new split panes to right and below
set splitright
set splitbelow

" -------------- ] Lualine [ -----------------
 
source ~/.config/nvim/plugins/lualine/themes/bubbles.vim

" -------------- ] Linea identacion [ ----------------

" No mostrar en ciertos tipos de buffers y archivos
" Avoid conceallevel problem (e.g. not showing links)
let g:indentLine_fileTypeExclude = ['text', 'sh', 'help', 'terminal', 'json', 'vimwiki', 'markdown', 'tex']
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

" -------------- ] Telescope: fuzzy search [ ----------------
lua <<EOF
require'telescope'.setup{
  defaults = {
    file_ignore_patterns = { 'node_modules' }
  }
}
EOF

" -------------- ] Markdown Preview [ ----------------

" Echo the url when the command is executed
let g:mkdp_echo_preview_url = 1

" -------------- ] Vimwiki [ ----------------

" Vimwiki working directory, and template
let g:vimwiki_list = [{
    \ 'path': '~/Desktop/VimWiki',
    \ 'template_path': '$HOME/.config/vimwiki/templates',
    \ 'template_default': 'default',
    \ 'template_ext': '.html'}]

" Code highlight
let wiki_settings={
\ 'nested_syntaxes': {
\ 'js':'javascript',
\ 'py':'python',
\ }}

" Relative path on links
let g:vimwiki_auto_chdir = 1

" Allow for autocompletion in vimwiki

" disable table mappings
let g:vimwiki_key_mappings = {
            \ 'all_maps': 1,
            \ 'global': 1,
            \ 'headers': 1,
            \ 'text_objs': 1,
            \ 'table_format': 1,
            \ 'table_mappings': 0,
            \ 'lists': 1,
            \ 'links': 1,
            \ 'html': 1,
            \ 'mouse': 0,
            \ }
augroup VimwikiRemaps
    autocmd!
    " unmap tab in insert mode
    autocmd Filetype vimwiki silent! iunmap <buffer> <Tab>
    " remap table tab mappings to M-n M-p
    autocmd Filetype vimwiki inoremap <silent><expr><buffer> <M-n> vimwiki#tbl#kbd_tab()
    autocmd Filetype vimwiki inoremap <silent><expr><buffer> <M-p> vimwiki#tbl#kbd_shift_tab()
    " on enter if completion is open, complete first element otherwise use
    " default vimwiki mapping
    autocmd Filetype vimwiki inoremap <silent><expr><buffer> <cr> pumvisible() ? coc#_select_confirm()
                              \: "<C-]><Esc>:VimwikiReturn 1 5<CR>"
augroup end

" Filetype vimwiki only in wiki directory
let g:vimwiki_global_ext = 0

" -------------- ] Latex Preview [ ----------------
 
let g:vimtex_view_general_viewer = 'zathura'
let g:vimtex_view_general_options_latexmk = '-reuse-instance'

" -------------- ] LSP [ ----------------

lua << EOF
local nvim_lsp = require('lspconfig')

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  -- Enable completion triggered by <c-x><c-o>
  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  local opts = { noremap=true, silent=true }

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)

end

-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches
local servers = { 'tsserver' }
for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup {
    on_attach = on_attach,
    flags = {
      debounce_text_changes = 150,
    }
  }
end
EOF
