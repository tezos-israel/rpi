#!/bin/bash
set -euo pipefail
IFS=$'\n\t'

DEBUG=${DEBUG:-""}

if [[ -n $DEBUG ]]; then
    set -x
fi

SCRIPT_DIR=$(dirname "$0")
DATA_DIR=$(readlink -f "./out")

source "$SCRIPT_DIR"/utils/download_tezos.sh

version=${1:-"latest"}
download_tezos "$DATA_DIR" "$version"

# move_binaries_to_path
sudo mkdir -p /opt/tezos
sudo cp "$DATA_DIR"/binaries/* /opt/tezos

sudo systemctl reload-or-restart tezos-node.service