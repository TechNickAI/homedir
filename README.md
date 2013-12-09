# Overview
These are for common files in my home directory. Adds bash, vim and other functionality.

# Install
```
    cd ~
    git clone https://github.com/gorillamania/homedir.git
    cd homedir

    # Update the submodules (vim plugins)
    git submodule init
    git submodule update

    # Makes all the symlinks to homedir
    bassh setup.sh

```

or as a one-liner:

`curl "https://raw.github.com/gorillamania/homedir/master/install.sh" | bash`

# Auto update
Once installed, homedir will check when you log in (but not more than once per hour) for a new version. If found, it will ask you if you want to update. To disable this functionality, run:

`touch ~/homedir/.homedir_no_update`

