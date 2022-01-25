#!/bin/bash
# strict mode - based on http://redsymbol.net/articles/unofficial-bash-strict-mode/
set -euo pipefail
IFS=$'\n\t'

TESTNET_URL=https://d1u3sv5wkszf4p.cloudfront.net/hangzhounet-rolling-tezos
# MAINNET_URL=https://mainnet.xtz-shots.io/rolling

SNAPSHOT_URL=$TESTNET_URL

SNAPSHOT_PATH="$DATA_DIR"/snapshot.rolling

printf "\ndownloading latest snapshot\n"
wget $SNAPSHOT_URL -O "$SNAPSHOT_PATH"

printf "\nstopping node\n"
sudo systemctl stop tezos-node

printf "\nclearing data\n"
rm -rf "$HOME"/.tezos-node/{context,store,lock} || true

printf "\nimporting snapshot\n"
tezos-node snapshot import "$SNAPSHOT_PATH"
