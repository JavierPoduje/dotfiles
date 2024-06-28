# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

plugins=(
  git
  zsh-autosuggestions
  zsh-syntax-highlighting
)

# For streaming
#ZSH_AUTOSUGGEST_HISTORY_IGNORE=*

source $ZSH/oh-my-zsh.sh

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

# startship
eval "$(starship init zsh)"

# Load aliases: keep this at the end of the file to override any aliases defined before
[ -f "$HOME/.config/aliasrc.sh" ] && source "$HOME/.config/aliasrc.sh"
[ -f "$HOME/Documents/.utils/Chess/aliasrc.sh" ] && source "$HOME/Documents/.utils/Chess/aliasrc.sh"
[ -f "$HOME/Documents/.utils/Foris/aliasrc.sh" ] && source "$HOME/Documents/.utils/Foris/aliasrc.sh"
