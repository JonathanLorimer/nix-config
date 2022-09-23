vim.o.termguicolors = true
vim.cmd [[
  hi LineNr ctermbg=NONE guibg=NONE
  syntax enable
  colorscheme zenwritten
  hi ColorColumn guifg=NONE guibg=#262626
]]

vim.g.zenwritten = {
  darkness = "stark"
}

