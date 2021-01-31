source $HOME/.config/nixpkgs/programs/nvim/theme.vim
source $HOME/.config/nixpkgs/programs/nvim/settings.vim
source $HOME/.config/nixpkgs/programs/nvim/mappings.vim

if (has("nvim-0.5.0"))
:luafile $HOME/.config/nixpkgs/programs/nvim/lsp.lua
endif

