autoload colors && colors

export XDG_CONFIG_HOME="$HOME/.config"
export STARSHIP_CONFIG="$XDG_CONFIG_HOME/starship/starship.toml"

export PATH="/opt/homebrew/opt/openjdk/bin:$PATH"
export CPPFLAGS="-I/opt/homebrew/opt/openjdk/include"

export EDITOR="nvim"
export visual="nvim"

source ~/.config/zsh/aliases.zsh
source ~/.config/zsh/bindings.zsh
source ~/.config/zsh/zoxide.zsh
source ~/.config/zsh/utils.zsh
source ~/.config/zsh/zsh-autosuggestions.zsh
source ~/.config/zsh/completion-for-pnpm.zsh

eval "$(/opt/homebrew/bin/brew shellenv)"
eval "$(starship init zsh)"
eval "$(zoxide init --cmd cd zsh)"
eval "$(fnm env --use-on-cd --shell zsh)"

# Bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
[ -s "/Users/radu/.bun/_bun" ] && source "/Users/radu/.bun/_bun" # completions

# Go
[ -n "$(go env GOBIN)" ] && export PATH="$(go env GOBIN):${PATH}"
[ -n "$(go env GOPATH)" ] && export PATH="$(go env GOPATH)/bin:${PATH}"

