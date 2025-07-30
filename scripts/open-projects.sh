#!/bin/bash

projects_folder="$HOME/Documents/projects"

selected_path=$(
  find "$projects_folder" -type d \
    -name ".git" -prune \
  | sed "s|^$(echo "$projects_folder" | sed 's/\./\\./g')/||" | sed 's/\/.git//' \
  | fzf
)

if [ -n "$selected_path" ]; then
  selected_project_path="$projects_folder/$selected_path"

  if tmux has-session 2>/dev/null; then
    tmux rename-window "cli"
    tmux send-keys -t "cli" "cd $selected_project_path" Enter

    tmux new-window -n "code"
    tmux send-keys -t "code" "cd $selected_project_path && nvim" Enter
  fi
fi
