set bg=dark
syntax on
set title
set nocompatible

" php helpfuls
" let php_sql_query = 1
let php_baselib = 1
let php_htmlInStrings = 1
let php_noShortTags = 1
let php_parent_error_close = 1
let php_parent_error_open = 1
let php_folding = 1

" some common helpful settings 
set shiftwidth=2

"do an incremental search
set incsearch

" Correct indentation after opening a phpdocblock and automatic * on every line
set formatoptions=qroct

" Wrap visual selectiosn with chars
":vnoremap ( "zdi^V(<C-R>z)<ESC>
":vnoremap { "zdi^V{<C-R>z}<ESC>
":vnoremap [ "zdi^V[<C-R>z]<ESC>
":vnoremap ' "zdi'<C-R>z'<ESC>
":vnoremap " "zdi^V"<C-R>z^V"<ESC>

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

set tabstop=4
set expandtab

" enable filetype detection:
filetype on

" make searches case-insensitive, unless they contain upper-case letters:
set ignorecase
set smartcase

" my common spelling mistakes ;)
abbreviate wierd weird
abbreviate restaraunt restaurant


"set ls=2            " allways show status line
"set ruler           " show the cursor position all the time

"au BufNewFile,BufRead  *.pls    set syntax=dosini



if &term == "xterm-color"
  fixdel
endif

" Enable folding by fold markers
" this causes vi problems set foldmethod=marker 

" Correct indentation after opening a phpdocblock and automatic * on every
" line
set formatoptions=qroct



" The completion dictionary is provided by Rasmus:
" http://lerdorf.com/funclist.txt
set dictionary-=~/phpfunclist.txt dictionary+=~/phpfunclist.txt
" Use the dictionary completion
set complete-=k complete+=k

" {{{ Autocompletion using the TAB key

" This function determines, wether we are on the start of the line text (then tab indents) or
" if we want to try autocompletion
function InsertTabWrapper()
    let col = col('.') - 1
   if !col || getline('.')[col - 1] !~ '\k'
        return "\<tab>"
    else
        return "\<c-p>"
    endif
endfunction

" Remap the tab key to select action with InsertTabWrapper
inoremap <tab> <c-r>=InsertTabWrapper()<cr>

" }}} Autocompletion using the TAB key

" {{{ Mappings for autogeneration of PHP code

" There are 2 versions available of the code templates, one for the case, that
" the close character mapping is disabled and one for the case it is enabled.

" {{{ With close char mapping activated (currently active)

" require, require_once
map! =req /**<CR> *  <CR>*  <CR>*  <CR>* @since  <CR>*/<CR><LEFT>require '<RIGHT>;<LEFT><Left>
map! =roq /**<CR> *  <CR>*  <CR>*  <CR>* @since  <CR>*/<CR><LEFT>require_once '<RIGHT>;<LEFT><Left>

" include, include_once
map! =inc /**<CR> *  <CR>*  <CR>*  <CR>* @since  <CR>*/<CR><LEFT>include '<RIGHT>;<Left><Left>
map! =ioc /**<CR> *  <CR>*  <CR>*  <CR>* @since  <CR>*/<CR><LEFT>include_once '<Right>;<Left><Left>

" define
map! =def /**<CR> *  <CR>*  <CR>*  <CR>* @since  <CR>* @access public<CR>*/<CR><LEFT>define ('<Right>, '<Right><Right>;<ESC>?',<CR>i

" class
map! =cla /**<CR> *  <CR>*  <CR>*  <CR>* @since  <CR>*/<CR><LEFT>class  {<CR><ESC>?/\*\*<CR>/ \* <CR>$i

" public/private methods
map! =puf /**<CR> *  <CR>*  <CR>*  <CR>* @since  <CR>* @access public<CR>* @param  <CR>* @return void<CR>*/<CR><LEFT>public function  (<Right><CR>{<CR><ESC>?/\*\*<CR>/ \* <CR>$i
map! =prf /**<CR> *  <CR>*  <CR>*  <CR>* @since  <CR>* @access private<CR>* @param  <CR>* @return void<CR>*/<CR><LEFT>private function _ (<Right><CR>{<CR><ESC>?/\*\*<CR>/ \* <CR>$i

" public/private attributes
map! =pua /**<CR> *  <CR>*  <CR>* @var <CR>* @since  <CR>*/<CR><LEFT>public $ = ;<ESC>?/\*\*<CR>/ \* <CR>$i
map! =pra /**<CR> *  <CR>*  <CR>* @var <CR>* @since  <CR>*/<CR><LEFT>private $_ = ;<ESC>?/\*\*<CR>/ \* <CR>$i

" for loop
map! =for for ($i = 0; $i ; $i++<Right> {<Up><Up><ESC>/ ;<CR>i

" foreach loop
map! =foe foreach ($ as $ => $<Right> {<Up><xHome><ESC>/\ as<CR>i

" while loop
map! =whi while ( <Right> {<Up><Up><ESC>/ )<CR>i

" switch statement
map! =swi switch ($<Right> {<CR>case '<Right>:<CR><CR>break;<CR>default:<CR><CR>break;<Up><Up><Up><Up><Up><Up><Up><xHome><ESC>/)<CR>i

" alternative
map! =if if (<Right> {<Down><xEnd> else {<Up><Up><Up><Up><Up><Up><ESC>/)<CR>i

" }}} With close char mapping activated (currently active)

" {{{ With close char mapping de-activated (currently in-active)

" require, require_once
"map! =req /**<CR> *  <CR>*  <CR>*  <CR>* @since  <CR>*/<CR><LEFT>require '';<ESC>hi
"map! =roq /**<CR> *  <CR>*  <CR>*  <CR>* @since  <CR>*/<CR><LEFT>require_once '';<ESC>hi

" include, include_once
"map! =inc /**<CR> *  <CR>*  <CR>*  <CR>* @since  <CR>*/<CR><LEFT>include '';<ESC>hi
"map! =ioc /**<CR> *  <CR>*  <CR>*  <CR>* @since  <CR>*/<CR><LEFT>include_once '';<ESC>hi

" define
"map! =def /**<CR> *  <CR>*  <CR>*  <CR>* @since  <CR>* @access public<CR>*/<CR><LEFT>define ('', '');<ESC>?',<CR>i

" class
"map! =cla /**<CR> *  <CR>*  <CR>*  <CR>* @since  <CR>*/<CR><LEFT>class  {<CR><CR>}<CR><ESC>?/\*\*<CR>/ \* <CR>$i

" public/private methods
"map! =puf /**<CR> *  <CR>*  <CR>*  <CR>* @since  <CR>* @access public<CR>* @param  <CR>* @return void<CR>*/<CR><LEFT>public function  ()<CR>{<CR><CR>}<CR><ESC>?/\*\*<CR>/ \* <CR>$i
"map! =prf /**<CR> *  <CR>*  <CR>*  <CR>* @since  <CR>* @access private<CR>* @param  <CR>* @return void<CR>*/<CR><LEFT>private function _ ()<CR>{<CR><CR>}<CR><ESC>?/\*\*<CR>/ \* <CR>$i

" public/private attributes
"map! =pua /**<CR> *  <CR>*  <CR>* @var <CR>* @since  <CR>*/<CR><LEFT>public $ = ;<ESC>?/\*\*<CR>/ \* <CR>$i
"map! =pra /**<CR> *  <CR>*  <CR>* @var <CR>* @since  <CR>*/<CR><LEFT>private $_ = ;<ESC>?/\*\*<CR>/ \* <CR>$i

" for loop
"map! =for for ($i = 0; $i ; $i++) {<CR><CR>}<Up><Up><ESC>/ ;<CR>i

" foreach loop
"map! =foe foreach ($ as $ => $) {<CR><CR>}<Up>

" while loop
"map! =whi while ( ) {<CR><CR>}<Up><Up><ESC>/ )<CR>i

" switch statement
"map! =swi switch ($) {<CR>case '':<CR><CR>break;<CR>default:<CR><CR>break;<CR>}<Up><Up><Up><Up><Up><Up><Up><ESC>/)<CR>i

" alternative
"map! =if if () {<CR><CR>} else {<CR><CR>}<Up><Up><Up><Up><Up><Up><ESC>/)<CR>i

" }}} With close char mapping de-activated (currently in-active)

" }}} Mappings for autogeneration of PHP code


