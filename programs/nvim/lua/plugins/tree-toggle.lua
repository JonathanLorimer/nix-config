local map = require 'utils'.map
require 'nvim-tree'.setup {
  update_cwd = true,
  update_focused_file = {
    enable = true,
    update_cwd = true
  },
  hijack_cursor = true,
}

map('', '<leader>tt', ':lua require"nvim-tree".toggle()<CR>', { silent = true, noremap = true })
map('', '<leader>tr', ':NvimTreeRefresh<CR>')
