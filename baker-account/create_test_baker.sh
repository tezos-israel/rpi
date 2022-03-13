#!/bin/bash
set -euo pipefail
IFS=$'\n\t'

DATA_DIR=$(readlink -f "./out")


. ./utils/baker_details.sh

if [ -z ${1+x} ]; then
    echo "download your testnet account json from https://teztnets.xyz/hangzhounet-faucet"
    exit 1
fi

account=$1

/opt/tezostezos-client activate account "$BAKER" with "./$account.json"
