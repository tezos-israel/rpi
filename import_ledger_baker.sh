#!/bin/bash
set -euo pipefail
IFS=$'\n\t'


source ./utils/utils.sh
source ./utils/step_utils.sh

DATA_DIR=./out

function apply_udev() {
    echo "downloading udev"
    FILENAME=$DATA_DIR/add_udev_rules.sh
    wget -O "$FILENAME" https://raw.githubusercontent.com/LedgerHQ/udev-rules/master/add_udev_rules.sh
    chmod +x "$FILENAME"

    echo "applying udev rules"
    sudo $FILENAME   
}

function import_baker() {
    echo "importing ledger public key - please approve in ledger"
    ledger_uri=$(tezos-client list connected ledgers | grep ed25519 | sed 's/.*\(ledger:.*\)"/\1/')
    tezos-client import secret key baker "$ledger_uri"
}

function setup_ledger_to_baker() {
    echo "approve ledger for baking:"
    tezos-client setup ledger to bake for "$baker"
}

baker=$1

step apply_udev "udev" restart_machine
step import_baker "import baker"
step setup_ledger_to_baker "setup ledger to baker"



