#!/bin/bash
set -euo pipefail
IFS=$'\n\t'


source ./utils/utils.sh
source ./utils/step_utils.sh

DATA_DIR=./out

. ./utils/baker_details.sh

function add_user_to_root() {
    echo "adding user to root"
    
    sudo adduser "$BAKING_USER" root
}


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
    
    ledger_output=$(/opt/tezos/tezos-client list connected ledgers)
    
    if [ -z "$ledger_output" ]; then
        echo "missing ledger output, please check your ledger and run again"
        exit 1
    fi
    
    
    ledger_uri=$(echo "$ledger_output" | grep ed25519 | sed 's/.*\(ledger:.*\)"/\1/')
    
    if [ -z "$ledger_uri" ]; then
        echo "missing ledger uri, please check your ledger and run again"
        exit 1
    fi
    
    /opt/tezos/tezos-client import secret key "$BAKER" "$ledger_uri"
}

function setup_ledger_to_baker() {
    echo "approve ledger for baking:"
    /opt/tezos/tezos-client setup ledger to bake for "$BAKER"
}

step apply_udev "udev"
step add_user_to_root "add user to root" restart_machine
step import_baker "import baker"
step setup_ledger_to_baker "setup ledger to baker"



