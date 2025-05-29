#!/bin/bash

# Define your folder
projects_folder="$HOME/Documents/projects"

# Capture the result
selected_path=$(ls "$projects_folder" | fzf)

# You can then use 'selected_path' in your script
if [ -n "$selected_path" ]; then
# Construct the full path to the selected project
  selected_project_path="$projects_folder/$selected_path"

  # 1. Open a new tmux window called "cli" in the selected path.
  # Check if a tmux server is running and attached
  if tmux has-session 2>/dev/null; then
    echo "Tmux session detected. Creating new windows."
    # Create a new window named "cli" and send it to the selected directory
    cd "$selected_project_path"
    tmux new-window -n "cli"

    # 2. Open another window called "code" and open neovim in it.
    # Create another new window named "code", change to the directory, and start nvim
    tmux new-window -n "code"
    # open neovim
    tmux send-keys -t "code" "nvim" C-m
  else
    echo "No active tmux session found. Starting a new one."
  fi
fi
