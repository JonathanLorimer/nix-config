source $HOME/.config/nixpkgs/programs/nvim/theme.vim
if (has("nvim-0.5.0"))
:luafile $HOME/.config/nixpkgs/programs/nvim/lsp.lua
:luafile $HOME/.config/nixpkgs/programs/nvim/settings.lua
endif
source $HOME/.config/nixpkgs/programs/nvim/settings.vim
source $HOME/.config/nixpkgs/programs/nvim/mappings.vim
