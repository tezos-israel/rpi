#!/bin/bash

# strict mode - based on http://redsymbol.net/articles/unofficial-bash-strict-mode/
set -euo pipefail
IFS=$'\n\t'

proto=$1
SCRIPT_DIR=$(dirname "$0")
DATA_DIR=$(readlink -f "./out")

source "$SCRIPT_DIR"/../utils/baker_details.sh

session="tezos-$proto"

tmux new-session -d -s "$session"

tmux send-key "tezos-baker-$proto run with local node /home/$USER/.tezos-node $BAKER" C-m
tmux split-window -h

tmux send-key "tezos-accuser-$proto run" C-m
tmux split-window -v

tmux send-key "tezos-endorser-$proto run" C-m

tmux attach-session -t "$session"
