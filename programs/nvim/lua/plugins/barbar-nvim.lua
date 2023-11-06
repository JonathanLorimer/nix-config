local map = require'utils'.map

require'bufferline'.setup {
  animation = false,
  auto_hide = true,
  tabpages = true,
  clickable = false,
  icons = {
    buffer_index = false,
    buffer_number = false,
    filetype = { enabled = true },
    inactive = {separator = {left = '', right = '' }, button = ''},
    active = {separator = {left = '', right = ''}},
    button = '',
    modified = {button = ''},
    pinned = {button = '' },
    separator = { left = '', right = ''},
  },
  sidebar_filetypes = {
    NvimTree = true
  }
}

local opts = { noremap = true, silent = true }
-- Tabs
map('', '<leader>H', '<Cmd>BufferMovePrevious<CR>', opts)
map('', '<leader>L', '<Cmd>BufferMoveNext<CR>', opts)
map('', '<leader>h', '<Cmd>BufferPrevious<CR>', opts)
map('', '<leader>l', '<Cmd>BufferNext<CR>', opts)
map('', '<leader>td', ':tab split<CR>', opts)
