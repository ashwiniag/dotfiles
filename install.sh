#!/bin/bash

# Exit on error
set -e

echo "Bootstrapping your Mac... 🛠"

# Setup SSH
#mkdir -p ~/.ssh
#cp -n ~/dotfiles/ssh/id_rsa ~/.ssh/id_rsa
#cp -n ~/dotfiles/ssh/id_rsa.pub ~/.ssh/id_rsa.pub
#chmod 600 ~/.ssh/id_rsa
#chmod 644 ~/.ssh/id_rsa.pub
#eval "$(ssh-agent -s)"
#ssh-add ~/.ssh/id_rsa

# Test SSH
echo "Testing SSH connection to GitHub..."
if ssh -T git@github.com 2>&1 | grep -q "successfully authenticated"; then
  echo "✅ SSH authentication to GitHub successful."
else
  echo "❌ SSH authentication failed. Make sure your SSH key is added to GitHub."
fi

# Install Brew & packages
if ! command -v brew &> /dev/null; then
  echo "🍺 Installing Homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
else
  echo "✅ Homebrew already installed"
fi

echo "📦 Installing packages via Homebrew..."
if [ -f "./macos/brew.sh" ]; then
  source ./macos/brew.sh
else
  echo "⚠️ brew.sh not found. Skipping Homebrew package installation."
fi

# Symlink Git config
echo "🔧 Setting up Git configs..."
ln -sf ~/dotfiles/git/.gitconfig ~/.gitconfig
ln -sf ~/dotfiles/git/.gitignore_global ~/.gitignore_global


#if command -v stow &> /dev/null; then
#  echo "📁 Using stow to manage dotfiles..."
#  stow git
#else
#  echo "⚠️  stow not found. Install it via Homebrew if you want to manage symlinks."
#fi

echo "Done! ✨ Restart your terminal."