lua <<EOF
-- Bubbles config for lualine
-- Author: lokesh-krishna
-- MIT license, see LICENSE for more details.

-- stylua: ignore
local colors = {
  bg_c   = '#152638',
  bg_b   = '#24293c',
  blue   = '#51afef',
  cyan   = '#7fdbca',
  black  = '#011627',
  white  = '#ffffff',
  red    = '#ef5350',
  violet = '#c792ea',
  grey   = '#575656',
  yellow = '#ECBE7B',
  orange = '#FF8800',
  magenta = '#c678dd',
  green  = '#98be65',
}

local bubbles_theme = {
  normal = {
    a = { fg = colors.black, bg = colors.violet },
    b = { fg = colors.white, bg = colors.bg_b },
    c = { fg = colors.black, bg = colors.bg_c },
  },

  insert = { a = { fg = colors.black, bg = colors.blue } },
  visual = { a = { fg = colors.black, bg = colors.cyan } },
  replace = { a = { fg = colors.black, bg = colors.red } },

  inactive = {
    a = { fg = colors.white, bg = colors.black },
    b = { fg = colors.white, bg = colors.black },
    c = { fg = colors.black, bg = colors.black },
  },
}

require('lualine').setup {
  options = {
    theme = bubbles_theme,
    component_separators = '|',
    section_separators = { left = '', right = '' },
  },
  sections = {
    lualine_a = {
      { 'mode', separator = { left = '' }, right_padding = 2 },
    },
  lualine_b = { 
    { 'filename', 
      color = { fg = colors.green },
      file_status = true, 
      shorting_target = 40 },
    {'branch',
      icon = '',
      color = { fg = colors.magenta, gui = 'bold' },
      }, { 'filesize', color = { fg = colors.yellow }} ,
  },
    lualine_c = { 'fileformat'},
    lualine_x = {},
    lualine_y = { 
      {'o:encoding', -- option component same as &encoding in viml
        fmt = string.upper, -- I'm not sure why it's upper case either ;)
        color = { fg = colors.blue }
      }, 
    { 'filetype', colored = true, icon_only = false }, 
      { 'progress', color = { fg = colors.orange } } },
    lualine_z = {
      { 'location', separator = { right = '' }, left_padding = 2 },
    },
  },
  inactive_sections = {
    lualine_a = { 'filename' },
    lualine_b = {},
    lualine_c = {},
    lualine_x = {},
    lualine_y = {},
    lualine_z = { 'location' },
  },
  tabline = {},
  extensions = {},
}
EOF
