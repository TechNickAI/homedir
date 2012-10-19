cd ~
git clone git@github.com:gorillamania/homedir.git
cd homedir

echo
echo "Updating the submodules (vim plugins)"
git submodule init
git submodule update

echo
echo "Setup all the symlinks to homedir (setup.sh)"
sh setup.sh
