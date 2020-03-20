if [[ $ostype = 'Darwin' ]]; then

    # print "Doing MacOS setup."
    path+=$HOME/homebrew/bin
    
    # Makes sure zsh can run in iterm
    test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

else
    : echo "skipping mac setup"
fi