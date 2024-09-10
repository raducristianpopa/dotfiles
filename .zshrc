source ~/.config/zsh/aliases.zsh
source ~/.config/zsh/zoxide.zsh
source ~/.config/zsh/utils.zsh
source ~/.config/zsh/zsh-autosuggestions.zsh

eval "$(/opt/homebrew/bin/brew shellenv)"
eval "$(starship init zsh)"
eval "$(zoxide init --cmd cd zsh)"

export NVM_DIR="$HOME/.nvm"
[ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"  # This loads nvm
[ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion

# bun completions
[ -s "/Users/radu/.bun/_bun" ] && source "/Users/radu/.bun/_bun"

export PATH="/opt/homebrew/opt/openjdk/bin:$PATH"
export CPPFLAGS="-I/opt/homebrew/opt/openjdk/include"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

# pnpm
export PNPM_HOME="/Users/radu/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end

#fly
export FLYCTL_INSTALL="/Users/radu/.fly"
export PATH="$FLYCTL_INSTALL/bin:$PATH"
#fly end

# opam configuration
[[ ! -r /Users/radu/.opam/opam-init/init.zsh ]] || source /Users/radu/.opam/opam-init/init.zsh  > /dev/null 2> /dev/null
