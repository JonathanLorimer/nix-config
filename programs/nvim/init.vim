:luafile $HOME/.config/nixpkgs/programs/nvim/theme.lua
:luafile $HOME/.config/nixpkgs/programs/nvim/lsp.lua
:luafile $HOME/.config/nixpkgs/programs/nvim/settings.lua
:luafile $HOME/.config/nixpkgs/programs/nvim/plugins/galaxyline.lua
source $HOME/.config/nixpkgs/programs/nvim/settings.vim
source $HOME/.config/nixpkgs/programs/nvim/mappings.vim


let g:signify_priority = 1
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
