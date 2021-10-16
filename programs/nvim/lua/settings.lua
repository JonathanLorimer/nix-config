require'nvim-web-devicons'.setup { default = true; }
require'colorizer'.setup ({ '*'; }, { css = true; })
require'telescope'.setup({
  defaults = {
    prompt_prefix = "🔍 ",
    selection_caret = "👉 ",
    layout_strategy = "flex",
  };
})
require'kommentary.config'.configure_language("default", {
  prefer_single_line_comments = true,
  use_consistent_indentation = true,
  ignore_whitespace = true
})

local cmd = vim.cmd
local set = vim.opt
local g = vim.g

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
set.scrolloff = 8
set.backspace = {"indent","eol","start" }
set.nu = true
set.rnu = true

-- Lsp
set.updatetime=800

-- Completion
set.inccommand = "nosplit"
set.completeopt = { "menuone","noinsert","noselect" }
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

cmd [[
  filetype plugin indent on

  fun! TrimWhitespace()
    let l:save = winsaveview()
    keeppatterns %s/\s\+$//e
    call winrestview(l:save)
  endfun

  autocmd BufEnter * lua require'completion'.on_attach()

  augroup BASE_GROUP
    autocmd!
    autocmd BufWritePre * :call TrimWhitespace()
    autocmd TextYankPost * silent! lua vim.highlight.on_yank { higroup='IncSearch', timeout=200 }
    autocmd FileType haskell setlocal commentstring=--\ %s

    au BufNewFile,BufRead *.ts setlocal filetype=typescript
    au BufNewFile,BufRead *.tsx setlocal filetype=typescript.tsx
  augroup END
]]

