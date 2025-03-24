# 🛠️ Dotfiles

Automates minimal, modular, setup for macOS with:

- Terminal and CLI tools (iterm2,git, zsh, tmux, neovim, etc.)
- Cloud tooling (awscli, gcloud, kubectl, terraform)
- Custom scripts (`set_aws_context`, `set_gcp_context`)
- Dotfile symlinking via GNU Stow
- Shell enhancements (Oh My Zsh, plugins, powerlevel10k)
- Custom configuration (auto detection of AWS profiles, git configurations, aliases etc)

---

## ⚡️ Quick Start

```bash
git clone git@github.com:ashwiniag/dotfiles.git ~/dotfiles
cd ~/dotfiles
./install.sh
```

After setup run
```bash
source ~/.zshrc
```
Then
```bash
p10k configure
```