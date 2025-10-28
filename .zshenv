# ~/.zshenv - sourced by ALL zsh shells (interactive and non-interactive)
# This ensures virtualenvwrapper is available in Cursor's terminal

# Only set up virtualenvwrapper if workon command is not already available
if ! command -v workon >/dev/null 2>&1; then
    export WORKON_HOME="$HOME/.virtualenvs"
    export VIRTUALENVWRAPPER_PYTHON="/opt/homebrew/Cellar/virtualenvwrapper/6.1.1/libexec/bin/python"

    # Source virtualenvwrapper if it exists
    if [[ -f "/opt/homebrew/bin/virtualenvwrapper.sh" ]]; then
        source /opt/homebrew/bin/virtualenvwrapper.sh
    fi
fi
