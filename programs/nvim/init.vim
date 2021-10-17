let mapleader = " "
set nowrap
:luafile $HOME/.config/nixpkgs/programs/nvim/lua/theme.lua
:luafile $HOME/.config/nixpkgs/programs/nvim/lua/lsp.lua
:luafile $HOME/.config/nixpkgs/programs/nvim/lua/settings.lua
:luafile $HOME/.config/nixpkgs/programs/nvim/lua/mappings.lua
:luafile $HOME/.config/nixpkgs/programs/nvim/lua/plugins.lua
:luafile $HOME/.config/nixpkgs/programs/nvim/lua/plugins/galaxyline.lua
:luafile $HOME/.config/nixpkgs/programs/nvim/lua/plugins/telescope.lua
:luafile $HOME/.config/nixpkgs/programs/nvim/lua/plugins/tree-toggle.lua
:luafile $HOME/.config/nixpkgs/programs/nvim/lua/plugins/nvim-cmp.lua

let g:signify_priority               = 1
let g:signify_sign_add               = '+'
let g:signify_sign_delete            = '_'
let g:signify_sign_delete_first_line = '‾'
let g:signify_sign_change            = '~'

let g:signify_sign_show_count = 0
let g:signify_sign_show_text = 1

hi SignifySignAdd guifg=#99c794
hi SignifySignDelete guifg=#ec5f67
hi SignifySignChange guifg=#c594c5
hi TelescopeMultiSelection guifg=#EBCB8B " multisections

nnoremap <leader>gj <plug>(signify-next-hunk)
nnoremap <leader>gk <plug>(signify-prev-hunk)
nnoremap <leader>gb :Gblame<CR>
