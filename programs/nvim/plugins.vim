call plug#begin('~/.local/share/nvim/plugged')

" General
Plug 'plasticboy/vim-markdown'
Plug 'rhysd/conflict-marker.vim'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'airblade/vim-rooter'
Plug 'francoiscabrol/ranger.vim'
Plug 'rbgrouleff/bclose.vim' "Peer dependency of ranger
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'scrooloose/syntastic'
Plug 'arcticicestudio/nord-vim'
Plug 'hardselius/warlock'
Plug 'liuchengxu/vim-which-key'
Plug 'majutsushi/tagbar'

" Git
Plug 'tpope/vim-fugitive'
Plug 'mhinz/vim-signify'
Plug 'tpope/vim-rhubarb'
Plug 'junegunn/gv.vim'

" LSP
Plug 'neoclide/coc.nvim', {'do': 'yarn install --frozen-lockfile'}
let g:coc_global_extensions = ['coc-tslint-plugin', 'coc-tsserver', 'coc-emmet', 'coc-css', 'coc-html', 'coc-json', 'coc-yank', 'coc-prettier']

" Nix
Plug 'LnL7/vim-nix'

" Haskell
Plug 'neovimhaskell/haskell-vim'
Plug 'alx741/yesod.vim'
let g:yesod_handlers_directories = ['src']

" TS
Plug 'leafgarland/typescript-vim'
Plug 'ianks/vim-tsx'

" uolorizer
Plug 'norcalli/nvim-colorizer.lua'

call plug#end()
