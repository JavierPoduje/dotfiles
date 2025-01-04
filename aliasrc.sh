#   - Vi
alias v="/opt/homebrew/bin/nvim"
alias vfind="fd path ~ --type f --hidden --exclude .git | fzf | xargs nvim"
#   - GIT
alias gch="git checkout"
alias gcp="git cherry-pick"
alias gs="git stash"
alias gsp="git stash pop"
alias gp="git pull"
alias gP="git push"
alias dotfiles="/usr/bin/git --git-dir=$HOME/.dotfiles --work-tree=$HOME"

gtheirs() {
  git checkout --theirs $1 && git add $1;
}
gours() {
  git checkout --ours $1 && git add $1;
}

#   - Navigation
alias to-utils="cd ~/Documents/.utils/"

# Navigation
#   - personal
alias to-asanapp="cd ~/Documents/projects/asanapp/"
alias to-config="cd ~/.config/"

# Personal
alias to-vim="cd ~/.config/nvim/"
alias to-tmux="cd ~/.config/tmux/"
alias to-projects="cd ~/Documents/projects"
alias templ="/Users/puje/go/bin/templ"
alias air="/Users/puje/go/bin/air"
