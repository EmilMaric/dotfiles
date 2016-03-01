# Dotfiles

## How it works
```bash
cd path/to/dotfiles
stow bash
stow zsh
...
```

If errors occur, make sure that the file does not exist in the corresponding folder.
For example, if the file ``.bashrc`` exists in ``~/.bashrc``, and you try to run ``stow bash``, 
the command will fail. You need to delete the ``~/.bashrc`` file, and then run ``stow bash``, in order
to get the latest ``.bashrc`` from the dotfiles repo.
