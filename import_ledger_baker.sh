#!/bin/bash
set -euo pipefail
IFS=$'\n\t'


source ./utils/step_utils.sh

DATA_DIR=./out

function apply_udev() {
    FILENAME=$DATA_DIR/add_udev_rules.sh
    wget -O "$FILENAME" https://raw.githubusercontent.com/LedgerHQ/udev-rules/master/add_udev_rules.sh
    chmod +x "$FILENAME"
    sudo $FILENAME
    
    sudo reboot
}

function import_baker() {
    import_cmd=$(tezos-client list connected ledgers | grep ed25519 | sed "s/ledger_$USER/$baker/g")
    
    $import_cmd
}

function setup_ledger_to_baker() {
    tezos-client setup ledger to bake for "$baker"
}

baker=$1

step apply_udev "udev"
step import_baker "import baker"
step setup_ledger_to_baker "setup ledger to baker"



