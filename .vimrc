""" Overall
syntax on
set title
set nocompatible

" Pathogen for auto loading modules
" https://github.com/tpope/vim-pathogen
call pathogen#infect()

" Syntastic settings
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
let g:syntastic_error_symbol='✗'
let g:syntastic_warning_symbol='⚠'
let g:syntastic_auto_loc_list=2
" Syntax checker installations...
" sudo apt-get install pyflakes
" sudo apt-get install tidy
" sudo npm install -g csslint
" Full list here: https://github.com/scrooloose/syntastic/tree/master/syntax_checkers

" Set utf8 as standard encoding and en_US as the standard language
set encoding=utf8
" enable filetype detection
filetype on
filetype plugin on
filetype indent on

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
set expandtab
"set autoindent
"set smartindent

""" search
set incsearch
" respect case, but only if first letter is upper case
set smartcase
" Highlight search results
set hlsearch
set scrolloff=5

" Working with split screen nicely
" Resize Split When the window is resized
au VimResized * :wincmd =

augroup filetypedetect
    au! BufRead,BufNewFile *.pp     setfiletype puppet
    au! BufRead,BufNewFile *httpd*.conf     setfiletype apache
    au! BufRead,BufNewFile *inc     setfiletype php
    au! BufRead,BufNewFile *.json setfiletype javascript
augroup END

" Nick wrote: Uncomment these lines to do syntax checking when you save
"augroup Programming
" clear auto commands for this group
"autocmd!
"autocmd BufWritePost *.php !php -d display_errors=on -l <afile>
"autocmd BufWritePost *.inc !php -d display_errors=on -l <afile>
"autocmd BufWritePost *httpd*.conf !/etc/rc.d/init.d/httpd configtest
"autocmd BufWritePost *.bash !bash -n <afile>
"autocmd BufWritePost *.sh !bash -n <afile>
"autocmd BufWritePost *.pl !perl -c <afile>
"autocmd BufWritePost *.perl !perl -c <afile>
"autocmd BufWritePost *.xml !xmllint --noout <afile>
"autocmd BufWritePost *.rdf !xmllint --noout <afile>
"autocmd BufWritePost *.xsl !xmllint --noout <afile>
"" get csstidy from http://csstidy.sourceforge.net/
"autocmd BufWritePost *.css !test -f ~/src/csstidy/csslint.php && php ~/csstidy/csslint.php <afile>
" get jslint from http://javascriptlint.com/
autocmd BufWritePost *.js !test -f ~/src/jslint/jsl && ~/src/jslint/jsl -conf ~/.jsl.conf -nologo -nosummary -process <afile>
"autocmd BufWritePost *.rb !ruby -c <afile>
"autocmd BufWritePost *.pp !puppet --parseonly <afile>
"autocmd BufWritePost *.erb !erb -x -T '-' <afile> | ruby -c 
autocmd BufWritePost *.py !pyflakes <afile>
"augroup en


" my common spelling mistakes ;)
abbreviate wierd weird
abbreviate restaraunt restaurant
