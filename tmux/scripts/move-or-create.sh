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

# TODO: Cosider the case in which we're moving to a non-existen session. eg:
# current sessions: 1, 2, 3
# remove session 2, leaving: 1, 3
# go-to session 2.
# current behavior: there are two sessions, so it tries to move to session 2, but it doesn't exist.
# expected behaviour: create session 2 and move to it.

NUMBER_OF_SESSIONS=$(tmux list-sessions | wc -l | xargs)

if [ $1 = 1 ]; then
  tmux switch -t "1"
elif [ $1 = 2 ] && [ $NUMBER_OF_SESSIONS -lt 2 ]; then
  tmux new -s 2 -d; tmux switch -t 2
elif [ $1 = 2 ] && [ $NUMBER_OF_SESSIONS -ge 2 ]; then
  tmux switch -t 2
elif [ $1 = 3 ] && [ $NUMBER_OF_SESSIONS -lt 3 ]; then
  tmux new -s 3 -d; tmux switch -t 3
elif [ $1 = 3 ] && [ $NUMBER_OF_SESSIONS -ge 3 ]; then
  tmux switch -t 3
elif [ $1 = 4 ] && [ $NUMBER_OF_SESSIONS -lt 4 ]; then
  tmux new -s 4 -d; tmux switch -t 4
elif [ $1 = 4 ] && [ $NUMBER_OF_SESSIONS -ge 4 ]; then
  tmux switch -t 4
fi
