# zplug setup
export ZPLUG_HOME=/usr/local/opt/zplug
source $ZPLUG_HOME/init.zsh

# Packages
zplug 'zplug/zplug', hook-build:'zplug --self-manage'
zplug "mafredri/zsh-async", from:github
zplug "sindresorhus/pure", use:pure.zsh, from:github, as:theme

# Install plugins if there are plugins that have not been installed
if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi

# Then, source plugins and add commands to $PATH
zplug load --verbose

# User configuration
if [[ "$(uname)" == "Darwin" ]]; then
    platform="macOS"
else
    platform="unknown"
fi

# Key-bindings
bindkey -v					                # Vi-mode
bindkey -v '^?' backward-delete-char 		# Change the backspace key to delete all characters
bindkey '^_' undo 				            # Use ESC to unexpand tab-completion

# Spaceship bindings
SPACESHIP_VI_MODE_SHOW=false

# --files: List files that would be searched but do not search
# --no-ignore: Do not respect .gitignore, etc...
# --hidden: Search hidden files and folders
# --follow: Follow symlinks
export FZF_DEFAULT_COMMAND='rg --files --hidden --follow'

# aliases
alias vim=nvim

# LS-colours
export CLICOLOR=1
export LSCOLORS=ExFxBxDxCxegedabagacad

# History settings for zsh
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt appendhistory

# Load FZF keybindings
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
