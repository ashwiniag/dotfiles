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
#echo "🔧 Setting up Git configs..."
#ln -sf ~/dotfiles/git/.gitconfig ~/.gitconfig
#ln -sf ~/dotfiles/git/.gitignore_global ~/.gitignore_global


if [ ! -d "$HOME/.oh-my-zsh" ]; then
 echo "🌀 Installing Oh My Zsh + Plugins..."
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
else
  echo "✅ Oh My Zsh already installed."
fi

# Clone Plugins (if not already)
ZSH_CUSTOM=${ZSH_CUSTOM:-~/.oh-my-zsh/custom}

install_plugin() {
  local name=$1
  local url=$2
  local dest="$ZSH_CUSTOM/plugins/$name"
  if [ ! -d "$dest" ]; then
    echo "📥 Installing plugin: $name"
    git clone "$url" "$dest"
  else
    echo "✅ Plugin $name already installed."
  fi
}

install_theme() {
  local name=$1
  local url=$2
  local dest="$ZSH_CUSTOM/themes/$name"
  if [ ! -d "$dest" ]; then
    echo "🎨 Installing theme: $name"
    git clone --depth=1 "$url" "$dest"
  else
    echo "✅ Theme $name already installed."
  fi
}

install_plugin zsh-autosuggestions https://github.com/zsh-users/zsh-autosuggestions
install_plugin zsh-syntax-highlighting https://github.com/zsh-users/zsh-syntax-highlighting
install_plugin zsh-completions https://github.com/zsh-users/zsh-completions
install_theme powerlevel10k https://github.com/romkatv/powerlevel10k.git

if command -v stow &> /dev/null; then
  echo "📁 Using stow to manage dotfiles..."
  echo "🔧 Setting up Git configs..."
  stow git
  if [ -f "$HOME/.zshrc" ] && [ ! -L "$HOME/.zshrc" ]; then
    echo "⚠️  Removing existing ~/.zshrc to avoid stow conflict..."
    mv ~/.zshrc ~/.zshrc.backup.$(date +%s)
  fi
  stow zsh
else
  echo "⚠️  stow not found. Install it via Homebrew if you want to manage symlinks."
fi

echo "✅ Done! Restart the terminal or run the following to apply changes:"
echo ""
echo "  source ~/.zshrc"
echo "  exec zsh"
echo ""

echo "Once you restart terminal run the following to apply changes:"
echo ""
echo "  p10k configure"
echo ""
