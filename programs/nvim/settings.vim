let mapleader = "\<Space>"

set hidden
set nowrap
set pumheight=10
set ruler
set cursorline

" Highlight 81st column
set colorcolumn=121

" Tab Stuff
set expandtab
set tabstop=2
set softtabstop=2
set shiftwidth=2
set smarttab
set smartindent
set autoindent

" Search
set hlsearch
set incsearch
set inccommand=nosplit

"General
set scrolloff=8
set nocompatible
set backspace=indent,eol,start
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

" Lsp
set updatetime=800

" Completion
set inccommand=nosplit
set completeopt=menuone,noinsert,noselect
set shortmess+=c

" Don't let plugins map leader bindings
let g:no_plugin_maps = 1

" Signify
let g:signify_sign_add               = '+'
let g:signify_sign_delete            = '_'
let g:signify_sign_delete_first_line = '‾'
let g:signify_sign_change            = '~'

let g:signify_sign_show_count = 0
let g:signify_sign_show_text = 1

" Haskell
let g:haskell_indent_do = 3
let g:haskell_indent_if = 3
let g:haskell_indent_in = 1
let g:haskell_indent_let = 4
let g:haskell_indent_case = 2
let g:haskell_indent_where = 6

" Tagbar
let g:tagbar_type_haskell = {
    \ 'ctagsbin'    : 'hasktags',
    \ 'ctagsargs'   : '-x -c -o-',
    \ 'kinds'       : [
        \  'm:modules:0:1',
        \  'd:data:0:1',
        \  'd_gadt:data gadt:0:1',
        \  'nt:newtype:0:1',
        \  'c:classes:0:1',
        \  'i:instances:0:1',
        \  'cons:constructors:0:1',
        \  'c_gadt:constructor gadt:0:1',
        \  'c_a:constructor accessors:1:1',
        \  't:type names:0:1',
        \  'pt:pattern types:0:1',
        \  'pi:pattern implementations:0:1',
        \  'ft:function types:0:1',
        \  'fi:function implementations:0:1',
        \  'o:others:0:1'
    \ ],
    \ 'sro'          : '.',
    \ 'kind2scope'   : {
        \ 'm'        : 'module',
        \ 'd'        : 'data',
        \ 'd_gadt'   : 'd_gadt',
        \ 'c_gadt'   : 'c_gadt',
        \ 'nt'       : 'newtype',
        \ 'cons'     : 'cons',
        \ 'c_a'      : 'accessor',
        \ 'c'        : 'class',
        \ 'i'        : 'instance'
    \ },
    \ 'scope2kind'   : {
        \ 'module'   : 'm',
        \ 'data'     : 'd',
        \ 'newtype'  : 'nt',
        \ 'cons'     : 'c_a',
        \ 'd_gadt'   : 'c_gadt',
        \ 'class'    : 'ft',
        \ 'instance' : 'ft'
    \ }
\ }

