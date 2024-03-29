local set = vim.opt
local g = vim.g
local w = vim.wo
local o = vim.o

g.mapleader = " "

-- Plugin config
g.CoolTotalMatches = 1

-- Disable distribution plugins
g.loaded_gzip = 1
g.loaded_tar = 1
g.loaded_tarPlugin = 1
g.loaded_zip = 1
g.loaded_zipPlugin = 1
g.loaded_getscript = 1
g.loaded_getscriptPlugin = 1
g.loaded_vimball = 1
g.loaded_vimballPlugin = 1
g.loaded_matchit = 1
g.loaded_2html_plugin = 1
g.loaded_logiPat = 1
g.loaded_rrhelper = 1
g.loaded_netrw = 1
g.loaded_netrwPlugin = 1
g.loaded_netrwSettings = 1
g.loaded_netrwFileHandlers = 1

-- GUI
set.guifont = "PragmataProMonoLiga Nerd Font"

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
set.smartindent = false
set.autoindent = false

-- Search
set.hlsearch = true
set.incsearch = true
set.inccommand = "nosplit"

-- General
w.wrap = false
set.scrolloff = 8
set.backspace = { "indent", "eol", "start" }
set.nu = true
set.rnu = true

-- Lsp
set.updatetime = 800

-- Completion
set.inccommand = "nosplit"
set.completeopt = { "menu", "menuone", "noselect" }
set.shortmess = vim.o.shortmess .. "c"

-- don't let plugins map leader bindings
g.no_plugin_maps = 1

-- Agda
g.cornelis_use_global_binary = 1
