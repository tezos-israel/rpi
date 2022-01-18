#!/bin/bash

function apply_udev() {
    DATA_DIR=$1
    FILENAME=$DATA_DIR/add_udev_rules.sh
    wget -O "$FILENAME" https://raw.githubusercontent.com/LedgerHQ/udev-rules/master/add_udev_rules.sh
    chmod +x "$FILENAME"
    # sudo $FILENAME
}