#!/usr/bin/env bash

if [ ! "$(pgrep -l tmux)" ]; then # check if there's no tmux process
  tmux new-session -d
  echo "ressurecting tmux..."
  tmux run-shell "~/.config/tmux/plugins/tmux-resurrect/scripts/restore.sh"
fi
tmux a
