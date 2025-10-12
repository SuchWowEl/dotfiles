#!/bin/bash

# action="notify-send"
action="systemctl"
if [[ "$1" == "poweroff" || "$1" == "reboot"  ]]; then
  action="$action $1"
  dunstify "Commencing $action..."
elif [[ "$1" == "logout" ]]; then
  action="hyprctl dispatch exit"
else
  action=""
  dunstify "Error: no arguments were passed"
fi


terminate_process() {
  local process_name="$1"
  local pid

  pid=$(pidof "$process_name")
  if [[ -n "$pid" ]]; then
    kill "$pid"

    # Wait for the process to terminate
    while kill -0 "$pid" 2>/dev/null; do
      sleep 1
    done
    dunstify "Process $process_name terminated."
  else
    dunstify "Process $process_name not found."
  fi
}

terminating_programs() {
  for process_name in "$@"; do (
    terminate_process "$process_name"
  ) &
  done

  # Wait for all background jobs to finish
  wait
}

if [[ "$action" ]]; then
  # Check for active package managers
  if [[ -f "/var/lib/pacman/db.lck" ]] || pidof yay pacman >/dev/null 2>&1; then
    dunstify "Cannot shutdown: Package manager is currently running or active" "Please wait for package operations to complete"
    exit 1
  fi

  # Check if timeshift backup is running
  if pidof timeshift >/dev/null 2>&1; then
    dunstify "Cannot shutdown: Timeshift backup is currently running" "Please wait for backup to complete"
    exit 1
  fi

  terminating_programs zen-bin spotify steam discord
  # terminate_process tmux
  # TODO: graceful shutdown for tmux
  tmux kill-server
  sleep 1
  eval $action
fi

# systemctl poweroff
