local agda = require('agda')
local function map(mode, lhs, rhs, opts)
  local options = {noremap = true}
  if opts then options = vim.tbl_extend('force', options, opts) end
  vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

map('', '<leader>al', '<cmd>lua require(\'agda\').load()<cr>')
map('', '<leader>ah', '<cmd>lua require(\'agda\').context()<cr>')
map('', '<leader>ac', '<cmd>lua require(\'agda\').case()<cr>')
map('', '<leader>ar', '<cmd>lua require(\'agda\').refine()<cr>')
map('', '<leader>aa', '<cmd>lua require(\'agda\').auto()<cr>')
map('', '<leader>aj', '<cmd>lua require(\'agda\').forward()<cr>')
map('', '<leader>ak', '<cmd>lua require(\'agda\').back()<cr>')
