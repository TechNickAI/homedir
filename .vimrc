" Overall
set bg=dark
syntax on
set title
set nocompatible

" spacing, indenting
set list listchars=tab:▷⋅,trail:⋅,nbsp:⋅
set shiftwidth=2
set tabstop=4
set expandtab
set autoindent
set smartindent

"search
set incsearch
set smartcase

augroup filetypedetect
    au! BufRead,BufNewFile *.pp     setfiletype puppet
    au! BufRead,BufNewFile *httpd*.conf     setfiletype apache
    au! BufRead,BufNewFile *inc     setfiletype php
augroup END

" Nick wrote: Uncomment these lines to do syntax checking when you save
augroup Programming
" clear auto commands for this group
autocmd!
autocmd BufWritePost *.php !php -d display_errors=on -l <afile>
autocmd BufWritePost *.inc !php -d display_errors=on -l <afile>
autocmd BufWritePost *httpd*.conf !/etc/rc.d/init.d/httpd configtest
autocmd BufWritePost *.bash !bash -n <afile>
autocmd BufWritePost *.sh !bash -n <afile>
autocmd BufWritePost *.pl !perl -c <afile>
autocmd BufWritePost *.perl !perl -c <afile>
autocmd BufWritePost *.xml !xmllint --noout <afile>
autocmd BufWritePost *.rdf !xmllint --noout <afile>
autocmd BufWritePost *.xsl !xmllint --noout <afile>
" get csstidy from http://csstidy.sourceforge.net/
autocmd BufWritePost *.css !test -f ~/src/csstidy/csslint.php && php ~/csstidy/csslint.php <afile>
" get jslint from http://javascriptlint.com/
autocmd BufWritePost *.js !test -f ~/src/jslint/jsl && ~/src/jslint/jsl -conf ~/.jsl.conf -nologo -nosummary -process <afile>
"autocmd BufWritePost *.js !test -f /usr/local/bin/gjslint && /usr/local/bin/gjslint <afile>
autocmd BufWritePost *.rb !ruby -c <afile>
autocmd BufWritePost *.pp !puppet --parseonly <afile>
autocmd BufWritePost *.erb !erb -x -T '-' <afile> | ruby -c 
autocmd BufWritePost *.py !pyflakes <afile>
augroup en

" enable filetype detection:
filetype on

" my common spelling mistakes ;)
abbreviate wierd weird
abbreviate restaraunt restaurant
