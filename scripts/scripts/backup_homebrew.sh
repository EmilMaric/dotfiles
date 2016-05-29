#!/bin/bash

# Saves all the homebrew taps, formulas, and casks, and generates a script
# that is used to backup all of these homebrew components. The script can be
# run to restore homebrew in case you get a new computer and want to transfer
# over all of your taps, formulas, and casks.

brew_command=/usr/local/bin/brew
brew_cask_command="$brew_command cask"

echo '#!/bin/bash'
echo ''
echo '# AUTO-GENERATED FILE'
echo '# Run this file to restore homebrew'
echo ''
echo 'brew_command=/usr/local/bin/brew'
echo 'brew_cask_command="$brew_command cask"'
echo ''
echo 'failed_items=""'
echo ''
echo 'function install_package() {'
echo '    echo EXECUTING: brew install $1 $2'
echo '    $brew_command install $1 $2'
echo '    [ $? -ne 0 ] && $failed_items="$failed_items $1"  # package failed to install.'
echo '}'
echo ''
echo 'function install_cask_package() {'
echo '    echo EXECUTING: brew cask install $1'
echo '    $brew_cask_command install $1'
echo '    [ $? -ne 0 ] && $failed_items="$failed_items $1"  # package failed to install.'
echo '}'
echo ''

echo '# Taps'
$brew_command tap | while read tap; do echo "$brew_command tap $tap"; done
echo ''

echo '# Formulas'
$brew_command list | while read item;
do
    echo "install_package $item '$($brew_command info $item | /usr/bin/grep 'Built from source' | /usr/bin/sed 's/^[ \t]*Built from source on [-0-9]* at [:0-9]*\( with: \)*//g; s/\,/ /g')'"
done
echo ''

echo '# Casks'
$brew_cask_command list | while read item;
do
    echo "install_cask_package $item"
done
echo ''

echo '[ ! -z $failed_items ] && echo The following items failed to install: && echo $failed_items'
