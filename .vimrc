" Pathogen for auto loading modules
" https://github.com/tpope/vim-pathogen
call pathogen#infect()

""" Overall
syntax on
filetype plugin indent on
set title
set nocompatible

""" CtrlP for fuzzy file matching
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'

" Syntastic settings
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
let g:syntastic_error_symbol='✗'
let g:syntastic_warning_symbol='⚠'
let g:syntastic_echo_current_error=1


" Syntax checker installations...
" sudo apt-get install pyflakes
" sudo apt-get install tidy
" sudo npm install csslint -g
" sudo npm install jsonlint -g
" Full list here: https://github.com/scrooloose/syntastic/tree/master/syntax_checkers

" Set utf8 as standard encoding and en_US as the standard language
set encoding=utf8

" Optimize for fast connections
set ttyfast
" Set to auto read when a file is changed from the outside
set autoread
" No annoying sound on errors
set noerrorbells
set novisualbell
" Status line
set laststatus=2
set statusline=%F%m%r%h%w\ \ [%l,%v][%p%%]

""" Colors
set bg=dark
"http://ethanschoonover.com/solarized
set t_Co=256
let g:solarized_termcolors=256
colorscheme solarized

""" Settings for tab auto completion of files
set wildmode=longest:full
set wildmenu
" Ignore compiled files
set wildignore=*.pyc

""" spacing, indenting
" Put special characaters in when tabs, leading, or trailing space are found.
set list listchars=tab:▸\ ,trail:⋅,nbsp:⋅
set shiftwidth=4
set tabstop=4
set softtabstop=4
"set autoindent
"set smartindent

""" search
set incsearch
" respect case, but only if first letter is upper case
set smartcase
" Highlight search results
set hlsearch
set scrolloff=5

""" Stop bringing up help when I accidentally hit f1
inoremap <F1> <ESC>
nnoremap <F1> <ESC>
vnoremap <F1> <ESC>

""" Additional syntaxes
au BufRead,BufNewFile *.handlebars,*.hbs set ft=html syntax=handlebars

" Working with split screen nicely
" Resize Split When the window is resized
au VimResized * :wincmd =

" my common spelling mistakes ;)
abbreviate wierd weird
abbreviate restaraunt restaurant
abbreviate garauntee guarantee
set expandtab
