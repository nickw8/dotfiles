alias k=kubectl
alias kx=kubectx
alias kc="kubectl config use-context"

alias ls="eza --color=always --long --git --no-filesize --icons=always --no-time --no-user --no-permissions"
alias ll="eza --all --grid --group-directories-first --color=always --long --git --no-filesize --icons=always --no-time --no-user --no-permissions"
alias l='eza -blF'
alias la='eza -gla'

alias cat='bat -p'

alias gpat='git push && git push --tags'

alias bump='cz bump --yes'

# Now managed by Mise
# alias tf='terraform'
# alias tfp='terraform plan -var-file envs/$(tfw?).tfvars'
# alias tfa='terraform apply -var-file envs/$(tfw?).tfvars'
# alias tfw='terraform workspace'
# alias 'tfw?'='terraform workspace show'
# alias tfws='terraform workspace select'

alias vi='nvim'
