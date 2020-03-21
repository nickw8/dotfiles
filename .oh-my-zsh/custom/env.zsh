###############################################################################
# Envars
#
# Things that are only used by Zsh should not be exported.
###############################################################################

# Pulls bash-complete and complete into zsh 
autoload -U +X bashcompinit && bashcompinit
autoload -U +X compinit && compinit
###############################################################################

# Makes sure zsh can run in iterm
test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"
###############################################################################

## GO ##
export GOPATH=$HOME/go
export PATH=$PATH:$(go env GOPATH)/bin
###############################################################################

## NVM ##
export NVM_DIR="$HOME/.nvm"
# Load nvm
[ -s "/usr/local/opt/nvm/nvm.sh" ] && . "/usr/local/opt/nvm/nvm.sh"  
# This loads nvm bash_completion
[ -s "/usr/local/opt/nvm/etc/bash_completion" ] && . "/usr/local/opt/nvm/etc/bash_completion"  
###############################################################################

## Istio ##
export PATH="$PATH:/Users/nweight/repos/rotor/istio-1.1.5/bin"
###############################################################################

## Krew ##
export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"
###############################################################################

## Kubernetes ##
# Custom kubenetes script to import kubeconfigs
CUSTOM_KUBE_CONTEXTS="$HOME/.kube/custom-contexts"
mkdir -p "${CUSTOM_KUBE_CONTEXTS}"
OIFS="$IFS"
IFS=$'\n'
for contextFile in `find "${CUSTOM_KUBE_CONTEXTS}" -type f -name "*.yml"`  
do
    export KUBECONFIG="$contextFile:$KUBECONFIG"
done
IFS="$OIFS"
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

## Twilix ##
if [ $TILIX_ID ] || [ $VTE_VERSION ]; then
        source /etc/profile.d/vte.sh
fi
###############################################################################
