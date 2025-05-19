# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.config/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

export EDITOR="nvim"

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

plugins=(
  git
  zsh-autosuggestions
  zsh-syntax-highlighting
)

# For streaming
# ZSH_AUTOSUGGEST_HISTORY_IGNORE=*

source $ZSH/oh-my-zsh.sh

DISABLE_UNTRACKED_FILES_DIRTY="true"

export NVM_DIR="$HOME/.nvm"
  [ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"  # This loads nvm
  [ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/puje/Downloads/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/puje/Downloads/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/puje/Downloads/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/puje/Downloads/google-cloud-sdk/completion.zsh.inc'; fi

# pyenv things
export PYENV_ROOT="$HOME/.pyenv"
command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

# zoxide
eval "$(zoxide init zsh)"

# psql
export PATH="/usr/local/opt/libpq/bin:$PATH"

# p10k
# To customize prompt, run `p10k configure` or edit ~/.config/.p10k.zsh.
[[ ! -f ~/.config/.p10k.zsh ]] || source ~/.config/.p10k.zsh
source /opt/homebrew/share/powerlevel10k/powerlevel10k.zsh-theme
typeset -g POWERLEVEL9K_SHORTEN_STRATEGY=truncate_to_last

# go commands
export GOPATH="$HOME/go"
export PATH=$PATH:$GOPATH/bin

# Load aliases: keep this at the end of the file to override any aliases defined before
[ -f "$HOME/.config/aliasrc.sh" ] && source "$HOME/.config/aliasrc.sh"
[ -f "$HOME/Documents/.utils/Chess/aliasrc.sh" ] && source "$HOME/Documents/.utils/Chess/aliasrc.sh"
[ -f "$HOME/Documents/.utils/Foris/aliasrc.sh" ] && source "$HOME/Documents/.utils/Foris/aliasrc.sh"
