###############################################################################
# Vendor
#
# Activation of other scripts beyond my control.
###############################################################################

# Pulls bash-complete and complete into zsh 
autoload -U +X bashcompinit && bashcompinit
autoload -U +X compinit && compinit
###############################################################################

## AWS ##
# Better AWS completion Plugin
source $HOME/.oh-my-zsh/custom/plugins/fzf-tab-completion/zsh/fzf-zsh-completion.sh 
# only aws command completion 
#zstyle ':completion:*:*:aws' fzf-search-display true
# or for everything
zstyle ':completion:*' fzf-search-display true

# AWS-CLI auto-complete
complete -C '/usr/local/bin/aws_completer' aws
###############################################################################

## Terraform ##
# Terraform auto-complete
complete -o nospace -C /usr/local/bin/terraform terraform
###############################################################################
