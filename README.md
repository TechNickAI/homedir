# Overview

These are for common files in my home directory.

## Install

```bash
    cd ~
    git clone https://github.com/TechNickAI/homedir.git
    cd homedir

    # Update the submodules (vim plugins)
    git submodule init
    git submodule update

    # Makes all the symlinks to homedir
    bash setup.sh

```

or as a one-liner:

`curl "https://raw.githubusercontent.com/TechNickAI/homedir/master/install.sh" | bash`
