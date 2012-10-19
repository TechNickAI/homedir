# Overview
These are for common files in my home directory. Adds bash, vim and other functionality.

# Install
```
    cd ~
    git clone git@github.com:gorillamania/homedir.git
    cd homedir

    # Update the submodules (vim plugins)
    git submodule -q foreach git pull -q origin maste
    # Makes all the symlinks to homedir
    sh install.sh

```

# Auto update
Once installed, homedir will check when you log in (but not more than once per hour) for a new
version. If found, it will ask you if you want to update. To disable this functionality, run touch
`~/homedir/.homedir_no_update`

