#!/bin/bash
set -euo pipefail
IFS=$'\n\t'

baker=$1

apply_udev "$DATA_DIR"

import_cmd=$(tezos-client list connected ledgers | grep ed25519 | sed "s/ledger_$USER/$baker/g")

$import_cmd

tezos-client setup ledger to bake for "$baker"