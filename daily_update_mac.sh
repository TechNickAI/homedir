#!/bin/zsh

source ~/.zshrc

#############################################################
# Daily System Update Script for macOS
#
# To schedule daily at 10am, add to crontab:
# 0 10 * * * $HOME/homedir/daily_update_mac.sh >> $HOME/daily_update.log 2>&1
#############################################################

# Function to check if running on AC power
is_on_power() {
    local power_status=$(pmset -g ps | grep -o "AC Power")
    if [[ -n "$power_status" ]]; then
        echo "Debug: Running on AC power"
        return 0
    else
        echo "Debug: Running on battery"
        return 1
    fi
}

echo "🚀 Starting daily system updates..."

# Exit if not on power
if ! is_on_power; then
    echo "\n⚠️ Not connected to power - skipping updates to save battery"
    exit 1
fi

################################################################
# SYSTEM UPDATES
################################################################

echo "\n📦 Updating Homebrew..."
brew update
brew upgrade
brew cleanup

################################################################
# Node/Javascript
################################################################

echo "\n📦 Updating pnpm..."
pnpm self-update

echo "\n📦 Updating global npm packages..."
npm update -g

# Optional: Update Oh My Zsh if you use it
if [ -d "$HOME/.oh-my-zsh" ]; then
    echo "\n🛠 Updating Oh My Zsh..."
    omz update
fi

################################################################
# Python
################################################################

pip3 install -U pip3 --break-system-packages
echo "\n✨ Daily update completed!"
