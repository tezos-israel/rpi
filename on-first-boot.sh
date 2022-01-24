#!/bin/bash
set -euo pipefail
IFS=$'\n\t'

SCRIPT_DIR=$(dirname "$0")
DATA_DIR=$(readlink -f "./out")


source "$SCRIPT_DIR"/utils/utils.sh
source "$SCRIPT_DIR"/utils/download_tezos.sh
source "$SCRIPT_DIR"/utils/create_services.sh
source "$SCRIPT_DIR"/utils/udev.sh



mkdir -p "$DATA_DIR"

if [ ! -f "$DATA_DIR/step1" ]; then
    # 1. update machine
    sudo apt update
    sudo apt install curl jq
    sudo apt full-upgrade -y
    
    touch "$DATA_DIR/step1"
    
    echo "Press [Enter] key to reboot..., rerun $0 after reboot"
    read -r
    
    sudo reboot
fi


echo "Checking dependencies... "
deps=""
while read -r name
do
    if ! [  -x "$(command -v "$name")" ] ; then
        deps="$name $deps";
    fi
done < "$SCRIPT_DIR"/dependencies

if  [ -n "$deps" ] ; then
    printf "\nmissing dependencies, run:\nsudo apt install %s\n" "$deps"
    exit 1
fi



if [ ! -d "$DATA_DIR/binaries" ]; then
    version="latest"
    download_tezos "$DATA_DIR" "$version"
fi

# move_binaries_to_path
sudo mkdir -p /opt/tezos
sudo cp "$DATA_DIR"/binaries/* /opt/tezos

echo PATH="\$PATH:/opt/tezos" >> "$HOME"/.bashrc
PATH=$PATH:/opt/tezos

# download zcash params
wget -O "$DATA_DIR"/fetch-zcash-params.sh https://raw.githubusercontent.com/zcash/zcash/master/zcutil/fetch-params.sh
chmod +x "$DATA_DIR"/fetch-zcash-params.sh
"$DATA_DIR"/fetch-zcash-params.sh

## configure tezos

proto=$(get_protocol "$DATA_DIR")

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



create_service_files "$DATA_DIR" "$user" "$baker" "$proto"

# move services to system dir
sudo mv "$DATA_DIR"/services/* /etc/systemd/system/

sudo systemctl daemon-reload

tezos-node config --network hangzhounet init

# import snapshot
. "$SCRIPT_DIR"/utils/import_snapshot.sh

# start node service
sudo systemctl enable tezos-node
sudo systemctl start tezos-node
#

## ledger specifc
# apply_udev "$DATA_DIR"

# echo "Please connect ledger and open the baking app, press [Enter] to continue..."
# read -r

# import_baker


