map = require'utils'.map

-- Commands
map('', '<leader>cf', ':echo expand("%:p")<CR>')

-- Tabs
map('', '<leader>H', ':-tabmove<CR>')
map('', '<leader>L', ':+tabmove<CR>')
map('', '<leader>h', 'gT')
map('', '<leader>l', 'gt')
map('', '<leader>td', ':tab split<CR>')

-- Yank
map('', '<leader>yy', '"+y')
map('', '<leader>p', '"+p')
map('v', '<leader>d', '"_dP')
map('v', '<leader>y', '"+y')

-- Goyo
map('', '<leader>go', ':Goyo<CR>')

-- NO CHEATING
map('', '<Up>', '<Nop>')
map('', '<Down>', '<Nop>')
map('', '<Left>', '<Nop>')
map('', '<Right>', '<Nop>')
map('i', '<Up>', '<Nop>')
map('i', '<Down>', '<Nop>')
map('i', '<Left>', '<Nop>')
map('i', '<Right>', '<Nop>')
