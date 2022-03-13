#!/bin/bash
# strict mode - based on http://redsymbol.net/articles/unofficial-bash-strict-mode/
set -euo pipefail
IFS=$'\n\t'

if ! [  -f /opt/tezos/tezos-node ] ; then
    echo "tezos-node was not found"
    exit 1
fi

DATA_DIR=${1:-$DATA_DIR}

SNAPSHOT_URL=https://$NETWORK.xtz-shots.io/rolling

SNAPSHOT_PATH="$DATA_DIR"/snapshot.rolling

if [ ! -f "$SNAPSHOT_PATH" ] || [ "$(find "$SNAPSHOT_PATH" -mmin +60)" ] || [ "${FORCE_DOWNLOAD_SNAPSHOT+0}" == "1" ]; then
    printf "\ndownloading latest snapshot\n"
    wget "$SNAPSHOT_URL" -O "$SNAPSHOT_PATH"
fi

printf "\nstopping node\n"
sudo systemctl stop tezos-node

printf "\nclearing data\n"
rm -rf "$HOME"/.tezos-node/{context,store,lock} || true

printf "\nimporting snapshot\n"
/opt/tezos/tezos-node snapshot import "$SNAPSHOT_PATH"
