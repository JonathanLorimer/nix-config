nnoremap <silent> <leader> :silent WhichKey '<Space>'<CR>
vnoremap <silent> <leader> :silent <c-u> :silent WhichKeyVisual '<Space>'<CR>

" Create map to add keys to
let g:which_key_map =  {}
" Define a separator
let g:which_key_sep = '=>'
let g:which_key_use_floating_win = 0

" Register Vim Which Key
autocmd VimEnter * call which_key#register('<Space>', "g:which_key_map")

" Which Key Colours
highlight default link WhichKey          Operator
highlight default link WhichKeySeperator DiffAdded
highlight default link WhichKeyGroup     Identifier
highlight default link WhichKeyDesc      Function

autocmd! FileType which_key
autocmd  FileType which_key set laststatus=0 noshowmode noruler
  \| autocmd BufLeave <buffer> set laststatus=2 noshowmode ruler

let g:which_key_map['h'] = [ 'gT'   , 'tab left'     ]
let g:which_key_map['l'] = [ 'gt'   , 'tab right'    ]

let g:which_key_map.r = {
      \ 'name': '+ranger',
      \ 't' : [':RangerTab'          , 'new tab'          ],
      \ 'f' : [':RangerEdit'         , 'find'             ],
      \ 'v' : [':RangerVSplit'       , 'vertical split'   ],
      \ 'h' : [':RangerSplit'        , 'horizontal split' ],
      \ }

let g:which_key_map.z = {
      \ 'name': '+fzf',
      \ 't' : [':Tags'    , 'tags'    ],
      \ 'f' : [':Files'   , 'files'   ],
      \ 'b' : [':Buffers' , 'buffers' ],
      \ }

let g:which_key_map.g = {
      \ 'name': '+git',
      \ 'j' : ['<plug>(signify-next-hunk)'    , 'hunk down'  ],
      \ 'k' : ['<plug>(signify-prev-hunk)'    , 'hunk up'    ],
      \ '2' : [':Gdiffsplit<CR>'              , '2 way merge'],
      \ '3' : [':Gdiffsplit!<CR>'             , '3 way merge'],
      \ 'b' : [':Gblame<CR>'                  , 'blame'      ],
      \ }

let g:which_key_map.c = {
      \ 'name': '+Coc',
      \ 'k' : ['<Plug>(coc-diagnostic-prev)'          , 'previous diagnostic'  ],
      \ 'j' : ['<Plug>(coc-diagnostic-next)'          , 'next diagnostic'      ],
      \ 'd' : ['<Plug>(coc-definition)'               , 'goto definition'      ],
      \ 't' : ['<Plug>(coc-type-definition)'          , 'goto type definition' ],
      \ 'i' : ['<Plug>(coc-implementation)'           , 'goto implementation'  ],
      \ 'r' : ['<Plug>(coc-references)'               , 'goto reference'       ],
      \ 'f' : ['Plug>(coc-format-selected)'           , 'format'               ],
      \ }

nnoremap <leader>ch :call <SID>show_documentation()<CR>
let g:which_key_map.c.h = 'show documentation'
" Misc
nnoremap <leader>t ITODO(jonathan):<ESC>:Commentary<CR>f:a<Space>
let g:which_key_map.t = 'todo'

nnoremap <leader>f :Rg<CR>
let g:which_key_map.f = 'ripgrep'

nnoremap <leader>H :-tabmove<CR>
let g:which_key_map.H = 'move tab left'

nnoremap <leader>L :+tabmove<CR>
let g:which_key_map.L = 'move tab right'

nnoremap <leader>w :retab<CR>
let g:which_key_map.w = 'tabs -> spaces'
+
nnoremap <leader>yy "+y
nnoremap <leader>yp "+p
vnoremap <leader>dp "_dP
vnoremap <leader>y  "+y

au filetype haskell nnoremap <silent> <leader>p :let a='{-# LANGUAGE  #-}'\|put! = a <cr> l11 <Insert>
let g:which_key_map.p = 'add pragma'

" Arrow Keys
nnoremap <S-Up> :m-2<CR>
nnoremap <S-Down> :m+<CR>
inoremap <S-Up> <Esc>:m-2<CR>
inoremap <S-Down> <Esc>:m+<CR>

noremap <Up> <Nop>
noremap <Down> <Nop>
noremap <Left> <Nop>
noremap <Right> <Nop>
inoremap <Up> <Nop>
inoremap <Down> <Nop>
inoremap <Left> <Nop>
inoremap <Right> <Nop>

" Coc
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

inoremap <silent><expr> <c-space> coc#refresh()

inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

