#!/bin/bash
set -euo pipefail
IFS=$'\n\t'

source ./download_tezos.sh

## requires:
## rename, wget, curl

DATA_DIR="out"

mkdir -p "$DATA_DIR"

if [ ! -f "$DATA_DIR/step1" ]; then
    # 1. update machine
    sudo apt update
    sudo apt full-upgrade -y
    
    touch "$DATA_DIR/step1"
    
    echo "Press [Enter] key to reboot..."
    read -r
    
    pause
    # sudo reboot
fi

download_tezos $DATA_DIR

## configure tezos


# 5. create services


# 6. fetch and apply udev rules

# 7.
