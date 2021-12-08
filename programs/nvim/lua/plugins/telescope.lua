require'telescope'.setup({
  defaults = {
    prompt_prefix = "🔍 ",
    selection_caret = "👉 ",
    layout_strategy = "flex",
  };
})

require('telescope').load_extension('fzf')

local function map(mode, lhs, rhs, opts)
  local options = {noremap = true}
  if opts then options = vim.tbl_extend('force', options, opts) end
  vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

map('', '<leader>ff', '<cmd>lua require(\'telescope.builtin\').find_files()<cr>')
map('', '<leader>fh', '<cmd>lua require(\'telescope.builtin\').find_files({ hidden = true })<cr>')
map('', '<leader>fg', '<cmd>lua require(\'telescope.builtin\').live_grep()<cr>')
map('', '<leader>fq', '<cmd>lua require(\'telescope.builtin\').quickfix()<cr>')
map('', '<leader>gtb', '<cmd>lua require(\'telescope.builtin\').git_branches()<cr>')
