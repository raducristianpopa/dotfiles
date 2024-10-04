source ~/.config/zsh/aliases.zsh
source ~/.config/zsh/zoxide.zsh
source ~/.config/zsh/utils.zsh
source ~/.config/zsh/zsh-autosuggestions.zsh
source ~/.config/zsh/completion-for-pnpm.zsh

eval "$(/opt/homebrew/bin/brew shellenv)"
eval "$(starship init zsh)"
eval "$(zoxide init --cmd cd zsh)"
eval "$(fnm env --use-on-cd --shell zsh)"

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
