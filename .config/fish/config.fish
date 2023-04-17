source ~/.iterm2_shell_integration.fish

# Sets
set fish_greeting ""
set -gx EDITOR nvim

# Aliases
alias .. 'cd ..'
alias ... 'cd ../..'
alias .... 'cd ../../..'
alias vim nvim
alias v vim

# NVM
function __check_rvm --on-variable PWD --description 'Do nvm stuff'
    status --is-command-substitution; and return

    if test -f .nvmrc; and test -r .nvmrc;
        nvm use
    else
    end
end

if status is-interactive
    # Commands to run in interactive sessions can go here
    export PNPM_HOME="/Users/radu/Library/pnpm"
    export PATH="$HOME/.cargo/bin:$PATH"
    export PATH="$PNPM_HOME:$PATH"
end
