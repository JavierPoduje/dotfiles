alias air="~/go/bin/air"
alias gP="git push"
alias gch="git checkout"
alias gcp="git cherry-pick"
alias gp="git pull"
alias gs="git stash"
alias gsp="git stash pop"
alias pilla="~/.config/scripts/open-projects.sh"
alias templ="~/go/bin/templ"
alias to-config="cd ~/.config/"
alias to-projects="cd ~/Documents/projects"
alias to-tmux="cd ~/.config/tmux/"
alias to-utils="cd ~/Documents/.utils/"
alias to-vim="cd ~/.config/nvim/"
alias v="/opt/homebrew/bin/nvim"
alias posting="~/.local/bin/posting"
alias mc="~/aistor-binaries/mc"


gtheirs() {
  git checkout --theirs $1 && git add $1;
}
gours() {
  git checkout --ours $1 && git add $1;
}
