# homedir

My macOS dotfiles. Simple, symlink-based configuration for a productive development environment.

## Install

```bash
cd ~
git clone https://github.com/TechNickAI/homedir.git
cd homedir
git submodule init
git submodule update
bash setup.sh
```

Or as a one-liner:

```bash
curl "https://raw.githubusercontent.com/TechNickAI/homedir/master/install.sh" | bash
```

After installing, run the macOS defaults script:

```bash
~/.macos
```

## What's Included

### Shell Configuration

- **`.my_mac_zshrc`** - macOS-specific zsh config with Homebrew, virtualenv aliases, and utilities
- **`.my_zshrc`** - Cross-platform zsh base config
- **`.zshenv`** - Universal environment setup (virtualenvwrapper, Python paths)
- **`.profile`** - Bash config with history management and git aliases
- **`.bash_prompt`** - Colorized prompt with git status

### Vim

- **`.vimrc`** - Vim configuration with Pathogen plugin manager
- Plugins: Syntastic, CtrlP, indent guides, rainbow parentheses
- 160-char line width with visual guide

### Git

- **`.gitconfig`** - Safe defaults: `pull.ff=only`, rebase on pull, autocorrect
- **`.gitignore`** - Global ignore patterns

### Code Quality

- **`.pre-commit-config.yaml`** - Pre-commit hooks with Ruff for Python
- **`.prettierrc`** - Prettier config (88-char width, consistent with Python)
- **`.jshintrc`** - JavaScript linting

### Command-Line Tools (via Brewfile)

```bash
brew bundle --file=~/homedir/Brewfile
```

| Tool | Purpose |
|------|---------|
| `bat` | Better `cat` with syntax highlighting |
| `btop` | Modern process viewer |
| `delta` | Beautiful git diffs |
| `fzf` | Fuzzy finder for everything |
| `ag` | Fast code search (silver searcher) |
| `ncdu` | Disk usage analyzer |

### macOS Defaults (`.macos`)

Run `~/.macos` to configure:

- Screenshots saved to `~/Desktop/ScreenShots/`
- Key repeat enabled for VS Code (vim j/k navigation)
- Key repeat enabled for Cursor (vim j/k navigation)

### Automation

**Daily Updates** (`daily_update_mac.sh`)

Scheduled via cron to run at 10am:
- Updates Homebrew packages
- Updates npm/pnpm globals
- Skips when on battery

```bash
# Add to crontab
0 10 * * * $HOME/homedir/daily_update_mac.sh >> $HOME/daily_update.log 2>&1
```

**Environment Loading**

Automatically sources `.env` files from:
- `~/dot_env_shared` (team-shared)
- `~/dot_env_local` (local secrets)
- `~/env`, `~/src/env`, `~/.env`

Use `browse_env_vars` to see loaded variables.

### Smart Git Functions

**`commit_link`** - Copy GitHub URL of latest commit to clipboard

**`_smart_git_update`** - Intelligent branch management:
- Detects uncommitted changes (stays on branch)
- Checks for unpushed commits (warns before switching)
- Auto-switches to main if current branch is merged

**`clone-carmenta [name]`** / **`clone-cryptoai [name]`** - Clone project with environment setup

## Customization

### Local Overrides

Create `~/.zshrc.local` for machine-specific settings. This file is gitignored and sourced at the end of `.my_mac_zshrc`:

```bash
# ~/.zshrc.local example
export WORK_API_KEY="secret"
alias deploy="./scripts/deploy-prod.sh"
```

### Adding macOS Defaults

Edit `.macos` to add your preferred system settings. Check [mathiasbynens/dotfiles](https://github.com/mathiasbynens/dotfiles/blob/main/.macos) for inspiration.

## Structure

```text
homedir/
├── .macos              # macOS system preferences
├── .my_mac_zshrc       # macOS shell config
├── .my_zshrc           # Cross-platform shell config
├── .vimrc              # Vim configuration
├── .vim/               # Vim plugins (Pathogen)
├── .gitconfig          # Git configuration
├── .pre-commit-config.yaml
├── .prettierrc
├── Brewfile            # Homebrew packages
├── setup.sh            # Creates symlinks
├── daily_update_mac.sh # Automated updates
└── install.sh          # One-liner installer
```

## License

MIT
