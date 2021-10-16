require'nvim-tree'.setup {
  hijack_cursor = true,
  update_focused_file = {
    enable = true,
  },
}

local function map(mode, lhs, rhs, opts)
  local options = {noremap = true}
  if opts then options = vim.tbl_extend('force', options, opts) end
  vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

map('', '<leader>tt', ':NvimTreeToggle<CR>')
map('', '<leader>tr', ':NvimTreeRefresh<CR>')

