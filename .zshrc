# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

###############################################################################
# .zshrc
###############################################################################

# Two reasons for splitting into files, instead of big unified .zshrc:
#
# 1. Can separate different things for different shells (zsh, bash)
#
# 2. Can have a “reload” util that just re`source`s a subset of the files.
#
# Using perlesque convention that ‘my_*’ vars are globally visible things that
# I have set.
#
# Noticed that archlinux et al do the same type of `source`ing of worker
# scripts in /etc/profile and /etc/profile.d/
###############################################################################

# Set name of the theme to load --- if set to "random", it will
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="powerlevel10k/powerlevel10k"
###############################################################################

# Which plugins would you like to load?
# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
  aws
  battery
  brew
  colorize
  common-aliases
  docker
  docker-compose
  encode64
  extract
  fzf
  git
  git-extras
  gitignore
  golang
  gpg-agent
  history
  iterm2
  osx
  python
  ssh-agent
  sudo
  systemadmin
  terraform
  vscode
  zsh-syntax-highlighting # Slow paste
  zsh-autosuggestions
  zsh-completions
)

export ZSH="$HOME/.oh-my-zsh"
source $ZSH/oh-my-zsh.sh

###############################################################################

# User configuration

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
