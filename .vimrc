syntax on
filetype plugin indent on

set backspace=indent,eol,start
set nocompatible              
set expandtab
set tabstop=8
set shiftwidth=2
set nowrap
set textwidth=0 wrapmargin=0 
set autoindent		

set foldmethod=marker

nmap <F7> :tabprevious
nmap <F8> :tabnext

set laststatus=2

" {{{ haskellmode-vim conf
let g:haddock_browser="/usr/bin/chromium"
let g:haddock_indexfiledir="~/"
au BufEnter *.hs compiler ghc
" }}}

" {{{ airline conf
let g:airline_powerline_fonts = 1

if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif

" unicode symbols
let g:airline_left_sep = '»'
let g:airline_left_sep = '▶'
let g:airline_right_sep = '«'
let g:airline_right_sep = '◀'
let g:airline_symbols.linenr = '␊'
let g:airline_symbols.linenr = '␤'
let g:airline_symbols.linenr = '¶'
let g:airline_symbols.branch = '⎇'
let g:airline_symbols.paste = 'ρ'
let g:airline_symbols.paste = 'Þ'
let g:airline_symbols.paste = '∥'
let g:airline_symbols.whitespace = 'Ξ'
" }}} 

" {{{ YCM conf
let g:ycm_path_to_python_interpreter="/usr/bin/python3"
let g:ycm_global_ycm_extra_conf="~/.vim/bundle/YouCompleteMe/.ycm_extra_conf.py"
let g:ycm_confirm_extra_conf=0
let g:ycm_show_diagnostics_ui=0
" }}}

" {{{ Easymotion conf
map <Leader>l <Plug>(easymotion-lineforward)
map <Leader>j <Plug>(easymotion-j)
map <Leader>k <Plug>(easymotion-k)
map <Leader>h <Plug>(easymotion-linebackward)
map <Leader>f <Plug>(easymotion-bd-f)
map <Leader>w <Plug>(easymotion-bd-w)

let g:EasyMotion_startofline = 0 " keep cursor column when JK motion
let g:EasyMotion_smartcase = 1
" }}}

let g:syntastic_c_checkers=['avrgcc']

let g:filetype_pl="prolog"

execute pathogen#infect()

