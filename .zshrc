# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="/Users/nick/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="robbyrussell"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in ~/.oh-my-zsh/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to automatically update without prompting.
# DISABLE_UPDATE_PROMPT="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS=true

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git)

source $ZSH/oh-my-zsh.sh

#### Startup scripts
# NVM
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm

# Python Virtual env
if [ -f /usr/local/bin/virtualenvwrapper.sh ] ; then
    export WORKON_HOME=~/.virtualenvs
    . /usr/local/bin/virtualenvwrapper.sh
fi

#### Environment variables
# Always use vim
export SVN_EDITOR=`which vim`
export EDITOR=`which vim`

#Go
export GOPATH=~/src/go
test -d $GOPATH || mkdir -p $GOPATH
export GOPRIVATE='github.com/tantralabs/*,github.com/heartrithm/*'

# Path
export PATH=$PATH:$GOPATH/bin

#### Aliases
alias ip='dig +short myip.opendns.com @resolver1.opendns.com'
alias localip="ipconfig getifaddr en0"

#### Functions
function commit_link(){
    ## Grab the latest commit from the current repo and open it on github.com

    # hash
    hash=`git log -n 1 --format="%H"`

    # repo owner/name
    repo=`git remote -v | grep github.com | head -1 | awk -F ':' '{print $2}' | perl -p -e 's/\.git.+//'`
    url="https://github.com/$repo/commit/$hash"
    echo $url
    open $url
}

function wifi_redirect(){
    # When you have connected to a wifi portal, sometimes it can be hard to trigger the TOS captive portal
    # Do an http fetch and capture where it is trying to redirect you, and open that url
    test_url="http://down.com/"
    tmpfile="/tmp/wifi_redirect_headers.txt"
    echo "Fetching headers for $test_url"
    curl -D $tmpfile $test_url > /dev/null
    location_header=`grep Location: $tmpfile`
    location_url=`echo $location_header | sed 's/Location://' | sed 's/[[:space:]]//g'`
    echo Found $location_url
    if [ "`echo $location_url | grep down.com`" ] ; then
        echo "Already connected"
        location_url="https://ismyinternetworking.com/"
    fi
    open $location_url
}


# Include local machine specific setup
test -f ~/.extra_zshrc && source ~/.extra_zshrc
