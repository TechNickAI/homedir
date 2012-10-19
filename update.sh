#!/bin/bash

#### Check to see if we have a new version, if so, offer to install it.
#### Assumes that the repo is hosted on github

# Pull the repository from git and put sed/awk to work. Kind of a hack, but it works.
repo=`git remote -v | head -1 | awk '{print $2}' | awk -F ':' '{print $2}' | sed 's/\.git$//'`

local_version=`cat VERSION`
remote_version=`curl --silent https://raw.github.com/$repo/master/VERSION`

if [ "$local_version" != "$remote_version" ] ; then
    echo "The remote version of $repo is $remote_version, yours is $local_version. Update? (yes/no)"
    read confirm
    if [ "$confirm" == "yes" ] ; then
        git pull
        ./install.sh
    fi
fi
