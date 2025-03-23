# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Path to your oh-my-zsh installation
export ZSH="$HOME/.oh-my-zsh"

# Theme
ZSH_THEME="powerlevel10k/powerlevel10k"

# Plugins
plugins=(
  git
  docker
  zsh-autosuggestions
  zsh-syntax-highlighting
)

source $ZSH/oh-my-zsh.sh

# User configuration
aws-profiles() {
    cat ~/.aws/credentials | grep '\[' | grep -v '#' | tr -d '[' | tr -d ']'
  }

  set-aws-profile() {
    local aws_profile=$1
    set -x
    export AWS_PROFILE=${aws_profile}
    set +x
  }

  set-aws-keys() {
    local aws_profile=$1
    profile_data=$(cat ~/.aws/credentials | grep "\[$aws_profile\]" -A4)
    AWS_ACCESS_KEY_ID="$(echo $profile_data | grep aws_access_key_id | cut -f2 -d'=' | tr -d ' ')"
    AWS_SECRET_ACCESS_KEY="$(echo $profile_data | grep aws_secret_access_key | cut -f2 -d'=' | tr -d ' ')"
    set -x
    export AWS_ACCESS_KEY_ID=$AWS_ACCESS_KEY_ID
    export AWS_SECRET_ACCESS_KEY=$AWS_SECRET_ACCESS_KEY
    set +x
  }

# Aliases
alias ll='ls -la'
alias gs='git status'
alias gc='git commit'
alias gl='git pull'
alias gp='git push'

# Better `ls`
# alias ls='exa --icons'

# Load p10k config
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# FZF config
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Export PATH (customize as needed)
export PATH="/opt/homebrew/bin:$PATH"

# History
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt HIST_IGNORE_ALL_DUPS

# Prompt speed
zstyle ':omz:update' mode disabled

# Go environment
export GOPATH="$HOME/go"
export GOBIN="$GOPATH/bin"
export PATH="$PATH:$GOBIN"
