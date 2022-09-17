
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
    "scss",
    "cpp",
    "python",
    "java",
    "c",
    "rust",
    "bash",
    "latex",
    "make",
    "dockerfile",
    "cmake",
    "r",
    "typescript",
    "tsx",
    "ruby",
    "kotlin",
    "c_sharp"
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

" Vimwiki working directory
let g:vimwiki_list = [{
    \ 'path': '~/Documentos/GitRepos/NoteWorld/VimWiki',
    \ 'template_path': '$HOME/.config/vimwiki/templates',
    \ 'template_default': 'default',
    \ 'template_ext': '.html'}]

" Code highlight
let wiki_settings={
\ 'nested_syntaxes': {
\ 'js':'javascript',
\ 'py': 'python',
\ 'm': 'octave',
\ 'sh': 'bash',
\ 'java': 'java',
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
  buf_set_keymap('n', '<leader>gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', '<leader>gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', '<leader>K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', '<leader>gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', '<leader>gr', "<cmd>lua require'telescope.builtin'.lsp_references()<CR>", opts)
  -- buf_set_keymap('n', '<leader>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  -- buf_set_keymap('n', '<leader>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  -- buf_set_keymap('n', '<leader>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  -- buf_set_keymap('n', '<leader>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  -- buf_set_keymap('n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  -- buf_set_keymap('n', '<leader><CR>', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  -- buf_set_keymap('v', '<leader><CR>', '<cmd>lua vim.lsp.buf.range_code_action()<CR>', opts)
  -- buf_set_keymap('n', '<leader>e', '<cmd>lua vim.diagnostic.open_float()<cr>', opts)
  -- buf_set_keymap('n', '<leader>ovr', '<cmd>Telescope lsp_document_symbols<cr>', opts)
  -- buf_set_keymap('n', ']d', '<cmd>lua vim.diagnostic.goto_next{severity = { min = vim.diagnostic.severity.HINT, max = vim.diagnostic.severity.WARN }}<CR>', opts)
  -- buf_set_keymap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev{severity = { min = vim.diagnostic.severity.HINT, max = vim.diagnostic.severity.WARN }}<CR>', opts)
  -- buf_set_keymap('n', ']e', '<cmd>lua vim.diagnostic.goto_next{severity = { min = vim.diagnostic.severity.ERROR }}<CR>', opts)
  -- buf_set_keymap('n', '[e', '<cmd>lua vim.diagnostic.goto_prev{severity = { min = vim.diagnostic.severity.ERROR }}<CR>', opts)
  -- buf_set_keymap('n', '<leader>q', '<cmd>lua vim.diagnostic.setloclist()<CR>', opts)


end

-- Use a loop to conveniently install and call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches
local servers = { 'tsserver', 'pyright', 'clangd', 'cmake' }
require("nvim-lsp-installer").setup {
  ensure_installed = servers
}

for _, server in ipairs(servers) do
  nvim_lsp[server].setup {
    on_attach = on_attach,
    flags = {
      debounce_text_changes = 150,
    }
  }
end
EOF

" -------------- ] Floating Term [ ----------------

let g:floaterm_title=''
let g:floaterm_autoinsert=1
let g:floaterm_width=0.7
let g:floaterm_height=0.7
let g:floaterm_wintitle=0
let g:floaterm_autoclose=2
let g:floaterm_borderchars = "─│─│╭╮╯╰"

" Set floaterm window's background to black
" hi Floaterm guibg=black
" Set floating window border line color to cyan, and background to orange
hi FloatermBorder guifg=white

" -------------- ] CPP Linting [ ----------------

let g:syntastic_cpp_checkers = ['cpplint']
let g:syntastic_c_checkers = ['cpplint']
let g:syntastic_cpp_cpplint_exec = 'cpplint'
" The following two lines are optional. Configure it to your liking!
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

" --------------- ] Debugger [  --------------- 

lua << EOF
-- CPP/C/Rust config
local dap = require('dap')
dap.adapters.lldb = {
  type = 'executable',
  command = '/usr/bin/lldb-vscode', -- install lldb an locate lldb-vscode, it might not be the same
  name = 'lldb'
}

local dap = require('dap')
dap.configurations.cpp = {
  {
    name = 'Launch',
    type = 'lldb',
    request = 'launch',
    program = function()
      return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
    end,
    cwd = '${workspaceFolder}',
    stopOnEntry = false,
    args = {},
  },
}

dap.configurations.c = dap.configurations.cpp
dap.configurations.rust = dap.configurations.cpp

-- Python
local dap = require('dap')
dap.adapters.python = {
  type = 'executable';
  command = '/home/alba/.virtualenvs/debugpy/bin/python';
  args = { '-m', 'debugpy.adapter' };
}
local dap = require('dap')
dap.configurations.python = {
  {
    type = 'python'; -- the type here established the link to the adapter definition: `dap.adapters.python`
    request = 'launch';
    name = "Launch file";
    program = "${file}"; -- This configuration will launch the current file if used.
    pythonPath = function()
      local cwd = vim.fn.getcwd()
      if vim.fn.executable(cwd .. '/venv/bin/python') == 1 then
        return cwd .. '/venv/bin/python'
      elseif vim.fn.executable(cwd .. '/.venv/bin/python') == 1 then
        return cwd .. '/.venv/bin/python'
      else
        return '/usr/bin/python'
      end
    end;
  },
}

-- Highlight colors
vim.highlight.create('DapBreakpoint', { ctermbg=0, guifg='#7a5e6f', guibg='#dd92b8' }, false)
vim.highlight.create('DapStopped', { ctermbg=0, guifg='#3b5cb1', guibg='#939ede' }, false)
vim.highlight.create('DapLogPoint', { ctermbg=0, guifg='#7a735e', guibg='#d5dd92' }, false)

-- Cutomize breakpoints
vim.fn.sign_define('DapBreakpoint', {text='🚩', texthl='', linehl='DapBreakpoint', numhl=''})
vim.fn.sign_define('DapBreakpointCondition', {text='❔', texthl='DapBreakpoint', linehl='', numhl=''})
vim.fn.sign_define('DapBreakpointRejected', {text='✖️', texthl='DapBreakpoint', linehl='', numhl=''})
vim.fn.sign_define('DapLogPoint', { text='📜', texthl='', linehl='DapLogPoint', numhl= '' })
vim.fn.sign_define('DapStopped', { text='👁️', txthl='', linehl='DapStopped', numhl='' })
EOF

" --------------- ] Debugger UI [  --------------- 

lua << EOF
require("dapui").setup({
  icons = { expanded = "▾", collapsed = "▸", current_frame = "▸" },
  expand_lines = vim.fn.has("nvim-0.7"),
  layouts = {
    {
      elements = {
        "breakpoints",
        "stacks",
      },
      size = 40, -- 40 columns
      position = "left",
    },
    {
      elements = {
        "scopes",
        "console",
      },
      size = 0.25, -- 25% of total lines
      position = "bottom",
    },
  },
  floating = {
    max_height = nil, -- These can be integers or a float between 0 and 1.
    max_width = nil, -- Floats will be treated as percentage of your screen.
    border = "single", -- Border style. Can be "single", "double" or "rounded"
    mappings = {
      close = { "q", "<Esc>" },
    },
  },
  windows = { indent = 1 },
  render = {
    max_type_length = nil, -- Can be integer or nil.
    max_value_lines = 100, -- Can be integer or nil.
  }
})
EOF

" --------------- ] Debugger Virtual Text [  --------------- 

lua << EOF
require("nvim-dap-virtual-text").setup {
    enabled = true,                        -- enable this plugin (the default)
    enabled_commands = true,               -- create commands DapVirtualTextEnable, DapVirtualTextDisable, DapVirtualTextToggle, (DapVirtualTextForceRefresh for refreshing when debug adapter did not notify its termination)
    highlight_changed_variables = true,    -- highlight changed values with NvimDapVirtualTextChanged, else always NvimDapVirtualText
    highlight_new_as_changed = false,      -- highlight new variables in the same way as changed variables (if highlight_changed_variables)
    show_stop_reason = true,               -- show stop reason when stopped for exceptions
    commented = false,                     -- prefix virtual text with comment string
    only_first_definition = true,          -- only show virtual text at first definition (if there are multiple)
    all_references = false,                -- show virtual text on all all references of the variable (not only definitions)
    filter_references_pattern = '<module', -- filter references (not definitions) pattern when all_references is activated (Lua gmatch pattern, default filters out Python modules)
    -- experimental features:
    virt_text_pos = 'eol',                 -- position of virtual text, see `:h nvim_buf_set_extmark()`
    all_frames = false,                    -- show virtual text for all stack frames not only current. Only works for debugpy on my machine.
    virt_lines = false,                    -- show virtual lines instead of virtual text (will flicker!)
    virt_text_win_col = nil                -- position the virtual text at a fixed window column (starting from the first text column) ,
                                           -- e.g. 80 to position at column 80, see `:h nvim_buf_set_extmark()`
}
EOF