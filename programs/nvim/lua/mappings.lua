local function map(mode, lhs, rhs, opts)
  local options = {noremap = true}
  if opts then options = vim.tbl_extend('force', options, opts) end
  vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

-- Todo
-- map('', '<leader>to', 'ITODO(jonathan):<ESC>:execute "normal \<Plug>kommentary_line_default"<CR>f:a<Space>')

-- Tabs
map('', '<leader>H', ':-tabmove<CR>')
map('', '<leader>L', ':+tabmove<CR>')
map('', '<leader>h', 'gT')
map('', '<leader>l', 'gt')
map('', '<leader>td', ':tab split')

-- Yank
map('', '<leader>yy', '"+y')
map('', '<leader>p', '"+p')
map('v', '<leader>d', '"_dP')
map('v', '<leader>y', '"+y')

-- Goyo
map('', '<leader>go', ':Goyo<CR>')

-- Auto Completion
map('i', '<expr><TAB>', 'v:lua.tab_complete()')
map('s', '<expr><TAB>', 'v:lua.tab_complete()')
map('i', '<expr><S-TAB>', 'v:lua.s_tab_complete()')
map('s', '<expr><S-TAB>', 'v:lua.s_tab_complete()')

-- Arrow Keys
map('', '<S-Up>', ':m-2<CR>')
map('i', '<S-Down>', ':m+<CR>')
map('', '<S-Up>', '<Esc>:m-2<CR>')
map('i', '<S-Down>', '<Esc>:m+<CR>')

map('', '<Up>', '<Nop>')
map('', '<Down>', '<Nop>')
map('', '<Left>', '<Nop>')
map('', '<Right>', '<Nop>')
map('i', '<Up>', '<Nop>')
map('i', '<Down>', '<Nop>')
map('i', '<Left>', '<Nop>')
map('i', '<Right>', '<Nop>')
