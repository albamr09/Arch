
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
 
lua << EOF
require'lualine'.setup{
  options = { theme  = {{ (datasource "variables").nvim.lualine_theme }} },
}
EOF

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
require('telescope').load_extension('dap')
EOF

" -------------- ] Markdown Preview [ ----------------

" Echo the url when the command is executed
let g:mkdp_echo_preview_url = 1

" -------------- ] Latex Preview [ ----------------
 
let g:vimtex_view_general_viewer = 'zathura'

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
local servers = { 'tsserver', 'pyright', 'clangd', 'cmake' }
require("nvim-lsp-installer").setup {
  ensure_installed = servers
}
for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup {
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
vim.api.nvim_set_hl(0, 'DapBreakpoint', { ctermbg=0, fg='#292d3e', bg='#dd92b8' })
vim.api.nvim_set_hl(0, 'DapStopped', { ctermbg=0, fg='#292d3e', bg='#939ede' })
vim.api.nvim_set_hl(0, 'DapLogPoint', { ctermbg=0, fg='#292d3e', bg='#d5dd92' })

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
