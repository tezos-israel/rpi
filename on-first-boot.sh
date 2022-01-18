#!/bin/bash
set -euo pipefail
IFS=$'\n\t'

source ./utils/utils.sh
source ./utils/download_tezos.sh
source ./utils/create_services.sh

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

if [ ! -d "$DATA_DIR/binaries" ]; then
    download_tezos "$DATA_DIR"
fi

## configure tezos

proto=$(get_protocol $DATA_DIR)

if [ -z "$proto" ]; then
    echo "protocol is missing"
    exit 1
fi

echo "What's is the user name that runs tezos (default: $USER)"
read -r user
user=${user:-$USER}

echo "What's is your baker alias (default: baker)"
read -r baker
baker=${baker:-"baker"}

create_service_files $DATA_DIR "$user" "$baker" "$proto"

# 6. fetch and apply udev rules

# 7.
