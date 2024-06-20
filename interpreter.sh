#!/bin/zsh

set -e

source virtualenvwrapper.sh

if [[ ! -d "$WORKON_HOME/interpreter" ]]; then
    echo "Virtual environment 'interpreter' not found. Creating..."
    mkvirtualenv interpreter

    echo "Virtual environment 'interpreter' created successfully."
    echo "Installing open-interpreter via pip"
    pip install open-interpreter
else
    echo "Virtual environment 'interpreter' already exists."
fi
