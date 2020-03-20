###############################################################################
# Envars
#
# Things that are only used by Zsh should not be exported.
###############################################################################

## Oh My ZSH ##
export ZSH="/Users/nweight/.oh-my-zsh"
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