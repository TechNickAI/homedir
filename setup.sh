#!/bin/bash
#### Script to set up symlinks from ~/ to ~/homedir,
#### elegantly dealing with ones that may already be there, and backing up the existing.

# Abort on error
set -e

cd ~
for file in .vimrc .vim .selected_editor .profile .hushlogin .jshintrc ; do
  if [ -h $file ] ; then
    # File is already a symbolic link
    echo "Symlink for $file is already there"
    continue
  fi
  if [ -d $file -o -f $file ] ; then 
    echo "Backing up existing $file to $file.b4homedir"
    rm -rf $file.b4homedir
    mv $file $file.b4homedir
  fi
  echo "Creating symlink for $file"
  ln -s homedir/$file
done

set +e

function checkExe(){
    loc=`which $1`
    if [ "$?" != "0" ] ; then
        echo
        echo "$1 NOT found, install with '$2'"
    else
        echo -n "."
    fi
}
echo "Checking for programs required for syntax checking (handy for vim syntastic)"
checkExe jshint "sudo npm install jshint -g"
checkExe pyflakes "sudo apt-get install pyflakes"
checkExe xmllint "sudo apt-get install libxml2-utils"
checkExe tidy "sudo apt-get install tidy"
checkExe csslint "sudo npm install csslint -g"
checkExe js-yaml "sudo npm install js-yaml -g"

echo Done
