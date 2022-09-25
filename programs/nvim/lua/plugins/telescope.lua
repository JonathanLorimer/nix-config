local map = require'utils'.map

require'telescope'.setup({
  defaults = {
    prompt_prefix = "🔍 ",
    selection_caret = "👉 ",
    layout_strategy = "flex",
  };
})

require('telescope').load_extension('fzf')

map('', '<leader>fb', '<cmd>lua require(\'telescope.builtin\').buffers()<cr>')
map('', '<leader>ff', '<cmd>lua require(\'telescope.builtin\').find_files()<cr>')
map('', '<leader>fh', '<cmd>lua require(\'telescope.builtin\').find_files({ hidden = true })<cr>')
map('', '<leader>fg', '<cmd>lua require(\'telescope.builtin\').live_grep()<cr>')
map('', '<leader>fq', '<cmd>lua require(\'telescope.builtin\').quickfix()<cr>')
map('', '<leader>gtb', '<cmd>lua require(\'telescope.builtin\').git_branches()<cr>')
