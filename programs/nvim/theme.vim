if (has("termguicolors"))
	set termguicolors
  hi LineNr ctermbg=NONE guibg=NONE
endif

syntax enable
set t_Co=256
set noshowmode
highlight ColorColumn ctermbg=red
call matchadd('ColorColumn', '\%81v', 120)

"Color Theme
colorscheme nord

"Airline Theme
let g:airline_theme='nord_minimal'
" let g:airline_theme='nord'

" Enable extensions
let g:airline_extensions = ['branch', 'hunks']

" Do not draw separators for empty sections (only for the active window) >
let g:airline_skip_empty_sections = 1
let g:airline#extensions#tabline#enabled = 1

" Smartly uniquify buffers names with similar filename, suppressing common parts of paths.
let g:airline#extensions#tabline#formatter = 'unique_tail'

" Custom setup that removes filetype/whitespace from default vim airline bar
let g:airline#extensions#default#layout = [['a', 'b', 'c'], ['x', 'z', 'warning', 'error']]

" Customize vim airline per filetype
let g:airline_filetype_overrides = {
  \ 'list': [ '%y', '%l/%L'],
  \ }

" Enable powerline fonts
let g:airline_powerline_fonts = 1

" Enable caching of syntax highlighting groups
let g:airline_highlighting_cache = 1

" Define custom airline symbols
if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif

" unicode symbols
let g:airline_left_sep = '»'
let g:airline_right_sep = '«'
let g:airline_symbols.branch = '⎇'

" airline symbols
let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''
let g:airline_symbols.branch = ''

" Sections
function! AirlineInit()
  let g:airline_section_a = airline#section#create(['mode'])
  let g:airline_section_b = airline#section#create(['branch'])
  let g:airline_section_c = airline#section#create(['hunks'])
  let g:airline_section_x = airline#section#create(['%f'])
  let g:airline_section_z = airline#section#create(['linenr'])
endfunction
autocmd User AirlineAfterInit call AirlineInit()

"Airline Theme
" let g:airline_theme='nord'
" let g:airline_powerline_fonts = 1
" let g:airline#extensions#tabline#enabled = 1
" let g:airline#parts#ffenc#skip_expected_string='utf-8[unix]'
" let g:airline_section_z = '%3p%% %3l/%L:%3v'

" Custom Highlighting
hi SignifySignAdd guifg=#99c794
hi SignifySignDelete guifg=#ec5f67
hi SignifySignChange guifg=#c594c5

"FZF Theme
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

let $FZF_DEFAULT_OPTS = '--layout=reverse --info=inline'
let $FZF_DEFAULT_COMMAND="rg --files --hidden"
