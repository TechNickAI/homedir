#!/bin/bash

#### Check to see if we have a new version, if so, offer to install it.
#### Assumptions:
# The repo is hosted on github, and public
# curl is installed

if [ -f ~/.homedir_no_update ] ; then
    exit
fi

# Abort on error
set -e
cd "$(dirname "$0")"

# Pull the repository from git and put sed/awk to work. Kind of a hack, but it works.
repo=`git remote -v | head -1 | awk '{print $2}' | awk -F ':' '{print $2}' | sed 's/\.git$//'`

local_version=`cat VERSION`
remote_version=`curl --max-time=3--silent https://raw.github.com/$repo/master/VERSION`

if [ "$local_version" != "$remote_version" ] ; then
    echo "The remote version of $repo is $remote_version, yours is $local_version. Update? (yes/no)"
    read -e update
    if [ "$update" == "yes" ] ; then
        git pull
        ./install.sh
    else
        echo "Skipping update for now."
        echo "If you want to disable this check, then run 'touch ~/.homedir_no_update'"
    fi
fi
