# Overview
These are for common files in my home directory. Adds bash, vim and other functionality.

## Install
```
    cd ~
    git clone https://github.com/gorillamania/homedir.git
    cd homedir

    # Update the submodules (vim plugins)
    git submodule init
    git submodule update

    # Makes all the symlinks to homedir
    bash setup.sh

```

or as a one-liner:

`curl "https://raw.githubusercontent.com/gorillamania/homedir/master/install.sh" | bash`
