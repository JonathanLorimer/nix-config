
" Navigation
nnoremap <leader>rt :RangerTab<CR>
nnoremap <leader>rf :RangerEdit<CR>
nnoremap <leader>rv :RangerVSplit<CR>
nnoremap <leader>rh :RangerSplit<CR>

nnoremap <leader>ff :Files<CR>
nnoremap <leader>fb :Buffers<CR>
nnoremap <leader>fr :Rg<CR>

" Git
"
nnoremap <leader>gj <plug>(signify-next-hunk)
nnoremap <leader>gk <plug>(signify-prev-hunk)
nnoremap <leader>gb :Gblame<CR>

" Misc
nnoremap <leader>t ITODO(jonathan):<ESC>:Commentary<CR>f:a<Space>
nnoremap <leader>H :-tabmove<CR>
nnoremap <leader>L :+tabmove<CR>
nnoremap <leader>h gT
nnoremap <leader>l gt

nnoremap <leader>w :retab<CR>

nnoremap <leader>yy "+y
nnoremap <leader>p "+p
vnoremap <leader>d "_dP
vnoremap <leader>y  "+y

au filetype haskell nnoremap <silent> <leader>p :let a='{-# LANGUAGE  #-}'\|put! = a <cr> l11 <Insert>

" Auto Completion
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"


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
