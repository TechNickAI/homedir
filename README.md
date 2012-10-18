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
	sh install.s

```

