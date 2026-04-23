#!/bin/zsh 

autoload colors && colors
XDG_CONFIG_HOME="$HOME/.config"

colorize ()
{
    echo "$fg[red]$1$reset_color"
}

create_symlink ()
{
    local name="$1"
    local target_dir="${2:-$XDG_CONFIG_HOME}"
    local src="$PWD/$name"
    local target="$target_dir/$name"
    local display_name="$(colorize ${(U)name})"

    if [[ ! -L "$target" ]]; then
        echo "🔗 Creating symlink for ${display_name}..."
        ln -s "$src" "$target" || echo "❌ Failed to create symlink for ${(U)name}"
    else
        echo "‼️ Symlink for ${display_name} already exists, skipping..."
    fi
}

echo "🏠 Creating $(colorize "XDG_CONFIG_HOME") if it does not exists ..."
mkdir -p $XDG_CONFIG_HOME

echo "🍺 Installing $(colorize "HOMEBREW")..."
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

echo "🛠️ Installing applications from $(colorize "BREWFILE")..."
brew bundle

echo "⏳Sourcing profile..."
source $HOME/.zprofile

echo "🥟 Installing $(colorize "BUN")..."
curl -fsSL https://bun.sh/install | bash

create_symlink ".zshrc" "$HOME"
create_symlink "zsh"
create_symlink "ghostty"
create_symlink "nvim"
create_symlink "bat"
create_symlink "starship"
create_symlink "lazygit"
create_symlink "btop"
create_symlink "aerospace"
create_symlink "k9s"

source "$HOME/.zshrc"
