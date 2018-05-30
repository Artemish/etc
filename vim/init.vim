syntax on
filetype plugin indent on

set ruler
set hidden
set magic

set backspace=indent,eol,start
set foldmethod=marker

set fileformat=unix
set fileformats=unix,dos
set fileencodings=ucs-bom,latin1,sjis,utf-8,default


set nocompatible              
set expandtab
set tabstop=4
set shiftwidth=4
set nowrap
set textwidth=0 wrapmargin=0 
set autoindent		

au! BufNewFile,BufRead *.hsp setf hsp

nmap <F7> :tabprevious
nmap <F8> :tabnext

set wildmode=longest,list,full
set wildmenu

nnoremap <leader>ev :sp $MYVIMRC<cr>
nnoremap <leader>sv :source $MYVIMRC<cr>
inoremap ` <esc>

" {{{ Syntastic
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*



let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 0
let g:syntastic_check_on_wq = 0

let g:syntastic_python_flake8_args = '--ignore=E501,E221,E261,E203,E241'

let g:syntastic_cpp_checkers=['']
" }}}

let g:ycm_path_to_python_interpreter='/usr/local/bin/python2'
let g:ycm_confirm_extra_conf=0

" {{{ indent-guides
set background=dark
colorscheme default
hi Search ctermfg=black
" }}}

" {{{ Ack plugin
let g:ackprg = 'ag --vimgrep --smart-case'                                                   
cnoreabbrev ag Ack
cnoreabbrev aG Ack
cnoreabbrev Ag Ack
cnoreabbrev AG Ack
" }}}

nnoremap <leader>t :tabn
nnoremap <leader>T :tabp

let g:airline_powerline_fonts = 1
let g:airline_theme='papercolor'

map <Leader> <Plug>(easymotion-prefix)

execute pathogen#infect()
