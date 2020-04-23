# dotfiles

I love me some dotfiles testing

## Setup:
First you need to create a bare repo to track your dotfiles
```shell
mkdir $HOME/.dotfiles
git init --bare $HOME/.dotfiles
```
Then create an alias (and add it to your `zsh` or `bash` aliases) so you dont have to keep typing all the git arguments everytime
```shell
alias git.dot='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
```
Set your repo to not show untracked files (or you will see all the files in you $HOME directory)
```shell
git.dot config --local status.showUntrackedFiles no
```

## Usage:
You can now use your alias with normal git commands to manage your dotfiles
```shell
git.dot status
git.dot commit -am "dotfiles are the best"
git.dot push
git.dot pull
```

## Setup on New Computer:
Clone your bare repo
```shell
git clone --bare https://github.com/nickw8/dotfiles.git $HOME/.dotfiles
```
Make sure you have the alias set up on the new computer, then checkout the code
```shell
git.dot checkout
```
