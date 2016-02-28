# Set the terminal to use vim-like commands
set -o vi

# Enables iTerm2 shell integration, which integrates iTerm2 with the unix 
# shell so that it can keep track of your command history, current working
# directory, host name, and more, even over SSH.
source $HOME/.iterm2_shell_integration.`basename $SHELL`

# Enable colour support for `ls`
if [ "$TERM" != "dumb" ]; then
    [ -e "$HOME/.dircolors" ] && export DIR_COLORS="$HOME/.dircolors"
    [ -e "$DIR_COLORS" ] || DIR_COLORS=""
    eval "`dircolors -b $DIR_COLORS`"
fi

# Enable pyenv shims and autocompletion
if which pyenv > /dev/null; then eval "$pyenv init -)"; fi

# Colourize the output of grep
export GREP_COLOR='1;37;41'
export GREP_OPTIONS='--color=auto'
