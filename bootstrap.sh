#!/bin/bash

# Install Oh My Zsh framework for zsh plugins
sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

# Change shell to zsh
chsh -s /usr/local/bin/zsh
