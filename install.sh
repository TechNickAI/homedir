cd ~
git clone https://github.com/TechNickAI/homedir.git
cd homedir

echo
echo "Updating the submodules (vim plugins)"
git submodule init
git submodule update

echo
echo "Setup all the symlinks to homedir (setup.sh)"
bash setup.sh
