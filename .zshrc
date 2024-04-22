# Add the following lines to ~/.zshenv:
# . "$HOME/.cargo/env"
# ZDOTDIR=~/.config
#
# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="powerlevel10k/powerlevel10k"

plugins=(
  git
  zsh-autosuggestions
  zsh-syntax-highlighting
)

source $ZSH/oh-my-zsh.sh

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

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

# psql
export PATH="/usr/local/opt/libpq/bin:$PATH"

# Load aliases: keep this at the end of the file to override any aliases defined
[ -f "$HOME/.config/aliasrc.sh" ] && source "$HOME/.config/aliasrc.sh"
[ -f "$HOME/Documents/.utils/Chess/aliasrc.sh" ] && source "$HOME/Documents/.utils/Chess/aliasrc.sh"
[ -f "$HOME/Documents/.utils/Foris/aliasrc.sh" ] && source "$HOME/Documents/.utils/Foris/aliasrc.sh"
