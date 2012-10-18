#!/bin/bash

# Verbose
set -x

# Abort on error
set -e

cd ~
for file in .vimrc .vim .selected_editor .profile .hushlogin ; do
  if [ -h $file ] ; then 
    # File is already a symbolic link
    continue
  fi
  if [ [ -d $file ] || [ -f $file ] ] ; then 
    rm -rf $file.b4homedir   
    mv $file $file.b4homedir
  fi
  ln -s homedir/$file
done
