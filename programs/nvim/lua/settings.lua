local cmd = vim.cmd
local set = vim.opt
local g = vim.g
local w = vim.wo

-- Rulers
set.hidden = true
set.pumheight = 10
set.ruler = true
set.cursorline = true
set.colorcolumn = "121"

-- Tabs
set.expandtab = true
set.tabstop = 2
set.softtabstop = 2
set.shiftwidth = 2
set.smarttab = true
set.smartindent = true
set.autoindent = true

-- Search
set.hlsearch = true
set.incsearch = true
set.inccommand = "nosplit"

-- General
w.wrap = false
set.scrolloff = 8
set.backspace = {"indent","eol","start" }
set.nu = true
set.rnu = true

-- Lsp
set.updatetime=800

-- Completion
set.inccommand = "nosplit"
set.completeopt = { "menu", "menuone","noselect" }
set.shortmess = vim.o.shortmess .. "c"

-- don't let plugins map leader bindings
g.no_plugin_maps = 1

-- Haskell Rules
g.haskell_indent_do = 3
g.haskell_indent_if = 3
g.haskell_indent_in = 1
g.haskell_indent_let = 4
g.haskell_indent_case = 2
g.haskell_indent_where = 6

-- Agda
g.cornelis_use_global_binary = 1

cmd [[
  filetype plugin indent on

  fun! TrimWhitespace()
    let l:save = winsaveview()
    keeppatterns %s/\s\+$//e
    call winrestview(l:save)
  endfun

  augroup BASE_GROUP
    autocmd!
    autocmd BufWritePre * :call TrimWhitespace()
    autocmd TextYankPost * silent! lua vim.highlight.on_yank { higroup='IncSearch', timeout=200 }
    autocmd FileType haskell setlocal commentstring=--\ %s

    au BufNewFile,BufRead *.ts setlocal filetype=typescript
    au BufNewFile,BufRead *.tsx setlocal filetype=typescript.tsx
  augroup END

  au BufEnter,BufRead,BufNewFile *.agda call AgdaFiletype()
  function! AgdaFiletype()
      nnoremap <buffer> <leader>a :CornelisLoad<CR>
      nnoremap <buffer> <leader>r :CornelisRefine<CR>
      nnoremap <buffer> <leader>d :CornelisAuto<CR>
      nnoremap <buffer> <leader>c :CornelisMakeCase<CR>
      nnoremap <buffer> <leader>t :CornelisTypeContext<CR>
      nnoremap <buffer> <leader>s :CornelisSolve<CR>
      nnoremap <buffer> <leader>j :CornelisNextGoal<CR>
      nnoremap <buffer> <leader>k :CornelisPrevGoal<CR>
      nnoremap <buffer> <leader>n :CornelisNormalize<CR>
  endfunction
]]

