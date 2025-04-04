#!/bin/bash

echo "📦 Installing essential packages with Homebrew..."

echo "🔧 Adding Homebrew to the PATH..."
echo >> ~/.zprofile
echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
eval "$(/opt/homebrew/bin/brew shellenv)"

# Function to install brew formula if not already installed
install_if_missing() {
  if ! brew list "$1" &> /dev/null; then
    echo "📥 Installing $1..."
    brew install "$1"
  else
    echo "✅ $1 is already installed."
  fi
}

# Function to install brew cask if not already installed
install_cask_if_missing() {
  if ! brew list --cask "$1" &> /dev/null; then
    echo "📥 Installing $1 (cask)..."
    brew install --cask "$1"
  else
    echo "✅ $1 (cask) is already installed."
  fi
}

# Install CLI tools
install_if_missing git
install_if_missing gh
install_if_missing stow
install_if_missing zsh
install_if_missing tmux         # terminal multiplexer (window + session mgmt)
install_if_missing neovim
install_if_missing htop
install_if_missing jq           # JSON parsing
install_if_missing ripgrep      # fast search (rg)
install_if_missing fzf          # fuzzy finder for anything (history, files, git branches)
install_if_missing bat          # beautiful cat with syntax highlighting
install_if_missing fd           # better find
install_if_missing lazygit      # terminal Git UI
install_if_missing starship     # cross-shell prompt (alt to Powerlevel10k)
install_if_missing go
install_if_missing terraform
install_if_missing coreutils     # GNU utilities (gutils)
install_if_missing postgresql@15 # for `psql` CLI
install_if_missing aquasecurity/trivy/trivy
install_if_missing tflint
install_if_missing terraform-docs
install_if_missing flux

# Networking tools
install_if_missing mtr
install_if_missing nmap
install_if_missing telnet
install_if_missing ipcalc
install_if_missing httpie
install_if_missing whois
install_if_missing curl
install_if_missing wget

# Cloud CLIs
install_if_missing awscli

# Kubernetes tooling
install_if_missing kubectl
install_if_missing helm
install_if_missing kubectx
install_if_missing kubedns
install_if_missing k9s

# Install GUI apps
install_cask_if_missing iterm2
install_cask_if_missing figtree
install_cask_if_missing docker
install_cask_if_missing flux  # f.lux (for screen temperature control)

echo "🎉 Done installing brew packages!"
