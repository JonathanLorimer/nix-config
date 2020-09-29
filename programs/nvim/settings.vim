let mapleader = "\<Space>"

set hidden
set nowrap
set pumheight=10
set ruler
set cursorline

" Ranger
let g:ranger_replace_netrw = 1 "open ranger when vim open a directory
let g:ranger_map_keys = 0

" Highlight 81st column
highlight ColorColumn ctermbg=red
call matchadd('ColorColumn', '\%81v', 100)

" Tab Stuff
set expandtab
set tabstop=2
set softtabstop=2
set shiftwidth=2
set smarttab
set smartindent
set autoindent

" Search
set inccommand=nosplit

"General
set number
set rnu
autocmd BufWritePre * %s/\s\+$//e
set nocompatible
set backspace=indent,eol,start
filetype plugin indent on

" Plugins

" FZF
let g:fzf_colors =
  \ { 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Comment'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'border':  ['fg', 'Ignore'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment'] }

let g:fzf_action = { 'ctrl-t': 'tab-split' }

" Don't let plugins map leader bindings
let g:no_plugin_maps = 1

" Signify
let g:signify_sign_add               = '+'
let g:signify_sign_delete            = '_'
let g:signify_sign_delete_first_line = '‾'
let g:signify_sign_change            = '~'

let g:signify_sign_show_count = 0
let g:signify_sign_show_text = 1


" FZF
let g:fzg_buffers_jump = 1
let g:fzf_tags_command = 'ctags -R'

" Haskell

let g:haskell_indent_do = 3
let g:haskell_indent_if = 3
let g:haskell_indent_in = 1
let g:haskell_indent_let = 4
let g:haskell_indent_case = 2
let g:haskell_indent_where = 6
let g:yesod_handlers_directories = ['src']

autocmd FileType haskell setlocal commentstring=--\ %s

"Javascript/Typescript
au BufNewFile,BufRead *.ts setlocal filetype=typescript
au BufNewFile,BufRead *.tsx setlocal filetype=typescript.tsx

