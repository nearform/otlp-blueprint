#!/bin/bash
set -eu
set -o pipefail

repo_dir_name=$(dirname "$(cd "$(dirname "${BASH_SOURCE[0]}")" &> /dev/null && pwd)")

# echo "cd ${repo_dir_name}/Code/server && npm i && npm start"
tmux kill-server
tmux new-session -d -s app
tmux split-window -h
tmux send -t app:0.0 "cd ${repo_dir_name}/Code/server && npm i && npm start" C-m
tmux send -t app:0.1 "cd ${repo_dir_name}/Code/client && npm i && npm start" C-m
tmux -2 attach-session -d
