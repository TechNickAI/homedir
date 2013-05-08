# vim:set syntax=sh:

# Hard drives and memory are cheap. Keep 10,000 lines of history and
export HISTSIZE=10000
# don't limit the size of the history file.
unset HISTFILESIZE
# ignore dupes in bash
export HISTCONTROL=ignoreboth


# http://www.gnu.org/software/bash/manual/html_node/Bash-History-Builtins.html#Bash-History-Builtins
# We are going to store each session as a separate file, with the IP addr
bash_hist=$HOME/.history_bash
sship=`echo $SSH_CLIENT | awk '{print $1}'`
test -d $bash_hist || mkdir $bash_hist
export HISTFILE=$bash_hist/hist-$sship-`date +%Y-%m-%d-%H-%M-%S`.hist

# Clean up files based on $MAX_DAYS
MAX_DAYS=180
if [ "$MAX_DAYS" != "" ] ; then
    find $bash_hist -mtime +$MAX_DAYS | xargs rm -rf
fi

# Read in history from the previous history files, up until we hit HISTSIZE
histtemp=`mktemp /tmp/hist.XXXXXXXX`
touch $histtemp
for file in `ls -1tr $bash_hist`; do
    cat $bash_hist/$file >> $histtemp
done
history -r $histtemp
rm $histtemp

# Always use vim
export SVN_EDITOR=`which vim`
export EDITOR=`which vim`

# Auto update
~/homedir/update.sh

## Bash prompt
source ~/homedir/.bash_prompt

# Colors for ls
export LSCOLORS=gxfxbEaEBxxEhEhBaDaCaD
export CLICOLOR=1

# some useful git aliases
alias gg='git log --oneline --abbrev-commit --all --graph --decorate --color'
alias gw='git diff --color-words'
alias gb='git diff --word-diff'

export PIP_DOWNLOAD_CACHE=~/.pip-download-cache

test -f ~/.extra_profile && source ~/.extra_profile

### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"

if [ -f /usr/local/bin/virtualenvwrapper.sh ] ; then
# Virtual env wrapper for python
export WORKON_HOME=~/.virtualenvs
. /usr/local/bin/virtualenvwrapper.sh
fi

[[ -s /Users/nick/.nvm/nvm.sh ]] && . /Users/nick/.nvm/nvm.sh # This loads NVM

# Ruby env 
test `which rbexnv` && eval "$(rbenv init -)"
