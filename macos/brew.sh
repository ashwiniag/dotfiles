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
install_if_missing tmux
install_if_missing neovim
install_if_missing curl
install_if_missing wget

# Install GUI apps
install_cask_if_missing iterm2

echo "🎉 Done installing brew packages!"
