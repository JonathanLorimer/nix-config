vim.o.termguicolors = true
vim.cmd [[
  hi LineNr ctermbg=NONE guibg=NONE
  syntax enable
  colorscheme nord
]]

local set = vim.opt
local g = vim.g

set.t_Co = 256
set.nowshowmode = true

