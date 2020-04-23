# dotfiles

I love me some dotfiles testing. Got this strategy from [this](https://medium.com/toutsbrasil/how-to-manage-your-dotfiles-with-git-f7aeed8adf8b) cool article.

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

I added some other aliases for the most common actions. **NOTE** you only have to `git.dot add` new files, modified or deleted files will be picked up with `git.dot commit -am`

```shell
alias gda='git.dot add -f'
alias gds='git.dot status'
alias gdl='git.dot pull'
alias gdp='git.dot push'
alias gdc='git.dot commit -am'
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
