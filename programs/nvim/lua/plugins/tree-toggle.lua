local map = require'utils'.map
require'nvim-tree'.setup {
  hijack_cursor = true,
  update_focused_file = {
    enable = true,
  },
}

map('', '<leader>tt', ':lua require"nvim-tree".toggle()<CR>', {silent = true, noremap = true})
map('', '<leader>tr', ':NvimTreeRefresh<CR>')

