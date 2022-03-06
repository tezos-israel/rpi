#!/bin/bash

MAINNET_TZKT_API=https://api.tzkt.io/
TESTNET_TZKT_API=https://api.hangzhou2net.tzkt.io/

function get_protocol() {
    TZKT_API=$TESTNET_TZKT_API
    if [ "$NETWORK" == "mainnet" ]; then
        TZKT_API=$MAINNET_TZKT_API
    fi
    
    curl -s "$TZKT_API"v1/protocols/current | jq .hash | cut -c 2-9  -
}


function create_service_files(){
    DATA_DIR=$1
    user=$2
    baker=$3
    
    proto=$(get_protocol "$DATA_DIR")
    
    if [ -z "$proto" ]; then
        echo "protocol is missing"
        exit 1
    fi
    
    SERVICES_DIR="$DATA_DIR/services"
    TEMPLATES_DIR="$SCRIPT_DIR"/services
    
    mkdir -p "$SERVICES_DIR"
    
    services_templates=$(find "$TEMPLATES_DIR"/*.template -printf "%f\n")
    
    for f in $services_templates
    do
        sed "s/\$USER/$user/g" "$TEMPLATES_DIR/$f" | sed "s/\$BAKER_ALIAS/$baker/g" | sed "s/\$PROTO/$proto/g" > "$SERVICES_DIR/${f/\.template/""}"
    done
}


function create_tezos_services() {
    echo "creating files"
    create_service_files "$DATA_DIR" "$user" "$baker"
    
    echo "moving files to system"
    # move services to system dir
    sudo mv "$DATA_DIR"/services/* /etc/systemd/system/
    
    sudo systemctl daemon-reload
}
