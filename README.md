# Dotfiles
*Note: My dotfiles and setup is tailored for OS X*

## Background
For me, managing all of my dotfiles across my different computers used to be a difficult and time-consuming task. Using [GNU Stow](https://www.gnu.org/software/stow/), I can now manage all of my dotfiles in a centralized directory. A centralized directory offers the convenience of:
* organizing my dotfiles into seperate directories, based on their function
* version-controlling my dotfiles on GitHub

For example, I have all my `vim` related dotfiles stored in a directory aptly named `vim`. This directory contains anything `vim` related, so that includes files like `.vimrc`, the `.vim` directory, etc. I have similar directories for `zsh`, `bash`, `tmux`, etc. Version-controlling is easily achieved by initializing the centralized dotfiles directory as a git repository, and pushing/pulling your changes via GitHub. This is very easy to do, as all of your dotfiles are now contained within one main directory.

## Quick & Easy Setup
If you just want to use my setup, then just follow this setup. **BE CAREFUL** though, as if you perform these commands, your existing dotfiles will get overwritten with the ones in this repository. You can have `stow` prevent overriding files by running the commands below without the `-R` option (ex. `stow -vt ~/ bash`). 

If you dont care about this, then here is the quick and simple way to get my setup:
```bash
cd path/to/dotfiles_repo
stow -vRt ~/ bash
stow -vRt ~/ zsh
...
```

You can repeat the `stow` command for any number of packages you want. Additionally, if you would like for `stow` to install the package under a different directory other than the home directory, then just replace the `~/` directory with the directory of your choice.

## Setting up your own stow-based dotfiles repository
Managing your own dotfiles using `stow` is also very easy:

1. Create a new directory to hold your dotfiles. I created one by doing `mkdir ~/git/dotfiles`.
2. Create a directory for each of the different dotfile types you plan on storing. For example, I plan to store and manage my
`vim`, `bash`, and `tmux` dotfiles using stow, so I'll do `mkdir ~/git/dotfiles/vim ~/git/dotfiles/bash ~/git/dotfiles/tmux`. `stow` refers to each of these directories as a `package`. So `~/git/dotfiles/vim` is really a `stow` package for your `vim` dotfiles.
3. Move all your dotfiles to the new directories that they belong in. For example, I'll be moving my `.bashrc`, `.bash_profile`, and `.profile` files into `~/git/dotfiles/bash/`, and move my `.vimrc` and `.vim` directory into `~/git/dotfiles/vim/`.
4. The next step involves using the magic of `stow`. **MAKE SURE** you are in your root dotfiles directory, which for me is `~/git/dotfiles`. You should be able to see all of your packages by running `ls`. We'll use the `vim` package for this example. When you execute `stow`, what it will do is create symlinks to all the files and directories stored in the `vim` package in a pre-defined directory. In my `vim` package I have a `vimrc` file and a `.vim` directory containing a bunch of `vim` related files. Executing `stow -vRt ~/ vim` will create symlinks to `.vimrc` and `.vim` in the `~/` directory. The `VIM` editor can now reference my `vim` dotfiles, since it reads from `~/.vimrc`, which points to my dotfiles directory. I can also edit `~/.vimrc` as I normally would and have the changes appear in `~/git/dotfiles/vim`.
5. After stowing all your packages, initialize your dotfiles repository as a git repository. For example, I will do `git init ~/git/dotfiles`. Create a repository on GitHub, or whatever hosting service you prefer, and set up yoru local dotfiles repository to point to the remote GitHub repository. Then commit and push your changes.
6. Now you can clone your GitHub dotfiles repository on your other computers. After cloning, just perform `stow -vRt <target_dir> <package>` on all your packages to bring over your dotfiles. **BE CAREFUL** as this will override any of your local dotfiles, so make sure you copy and save them to a safe location if you are at all worried about losing your old copies. Any time you make any dotfile changes on any of your computers, just commit and push, and then pull these changes on your other computers and re`stow` the package. Very simple!

## ToDo
* Find a brew cask alternative for:
  * Microsoft OneNote
  * Todoist
* Convert cron jobs to launchd scripts

## References
1. http://brandon.invergo.net/news/2012-05-26-using-gnu-stow-to-manage-your-dotfiles.html?round=two

