#!/bin/bash

#### Check to see if we have a new version, if so, offer to install it.
#### Assumptions:
# The repo is hosted on github, and public
# curl is installed

# Change the working directory to the scripts working directory
cd "$(dirname "$0")"

# Is auto update disabled?
if [ -f ./.homedir_no_update ] ; then
    exit
fi

# Has it been run in the last x minutes?
last_update=./.homedir_last_update
if [ "`test -f $last_update && find $last_update -mtime -60`" != "" ] ; then
    exit
fi

# Abort on error
set -e

# Pull the repository from git and put sed/awk to work. Kind of a hack, but it works.
repo=`git remote -v | head -1 | awk '{print $2}' | awk -F ':' '{print $2}' | sed 's/\.git$//'`

local_version=`cat VERSION`
remote_version=`curl --max-time 3 --silent https://raw.github.com/$repo/master/VERSION`
# If the curl worked, touch the last update file so we don't check again for a while
if [ $? -eq 0 ] ; then
    touch $last_update
fi

if [ "$local_version" == "$remote_version" ] ; then
    exit
fi

echo "The remote version of $repo is $remote_version, yours is $local_version. Update? (yes/no)"
read -e update
if [ "$update" == "yes" ] ; then
    git pull
    ./setup.sh
else
    echo "Skipping update for now."
    echo "If you want to disable this check, then run 'touch $PWD/.homedir_no_update'"
fi
