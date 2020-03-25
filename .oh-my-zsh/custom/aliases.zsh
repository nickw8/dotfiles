###############################################################################
# Aliases
#
# My personal aliases to make life happier
###############################################################################

## Clear DNS on Mac
alias cleardns="sudo killall -HUP mDNSResponder"

## Set up alias for managing dotfiles with git
#alias dotfiles='/usr/bin/git --git-dir=/Users/nweight/.dotfiles/ --work-tree=/Users/nweight'
alias git.dot='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'

## Kubernetes
alias k="kubectl"
# Step 2: follow your own preferred way
alias kg='kubectl get'
alias kl='kubectl logs '
alias kx='kubectl exec -i -t'

## Terraform
alias tf="terraform"
alias tfa="terraform apply"
alias tfp="terraform plan"
alias tfw="terraform workspace"
alias mtr="/usr/local/Cellar/mtr/0.93_1/sbin/mtr"

## Colorize cat
alias cat='ccat'

## Edit zsh aliases
alias zsh.aliases='vim ~/.oh-my-zsh/custom/aliases.zsh'
