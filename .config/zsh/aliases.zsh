# tippity top
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."

alias vim="nvim"
alias v="nvim"

alias ls="exa"
alias ll="exa -lah"

alias s="source ~/.zshrc"

# Git
alias ga="git add"
alias gb="git branch"
alias gc="git commit -S"
alias gch="git checkout"
alias gd="git diff"
alias gl="git log"
alias gp="git push origin"
alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'

function mkcd {
    mkdir -- "$1" &&
    cd -- "$1"
}
