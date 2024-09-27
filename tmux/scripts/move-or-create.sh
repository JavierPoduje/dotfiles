#!/bin/bash

# This script switches to an existing tmux session or creates a new one based on the provided argument.
#
# Arguments:
#   $1: The target session number (1, 2, 3, or 4).
#
# The script counts the current number of tmux sessions and:
# - Switches to session 1 if $1 is 1.
# - Switches to or creates session 2 if $1 is 2.
# - Switches to or creates session 3 if $1 is 3.
# - Switches to or creates session 4 if $1 is 4.

NUMBER_OF_SESSIONS=$(tmux list-sessions | wc -l | xargs)

if [ $1 = 1 ]; then
    tmux switch -t "1"
elif [ $1 = 2 ]; then
    if tmux has-session -t 2 2>/dev/null; then
        tmux switch -t 2
    else
        tmux new -s 2 -d; tmux switch -t 2
    fi
elif [ $1 = 3 ]; then
    if tmux has-session -t 3 2>/dev/null; then
        tmux switch -t 3
    else
        tmux new -s 3 -d; tmux switch -t 3
    fi
elif [ $1 = 4 ]; then
    if tmux has-session -t 4 2>/dev/null; then
        tmux switch -t 4
    else
        tmux new -s 4 -d; tmux switch -t 4
    fi
fi
