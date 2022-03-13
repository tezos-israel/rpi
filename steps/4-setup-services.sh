#!/bin/bash

MAINNET_TZKT_API=https://api.tzkt.io/
TESTNET_TZKT_API=https://api.hangzhou2net.tzkt.io/

function get_protocol() {
    TZKT_API=$TESTNET_TZKT_API
    if [ "$NETWORK" == "mainnet" ]; then
        TZKT_API=$MAINNET_TZKT_API
    fi
    protocol_json=$(curl -s "$TZKT_API"v1/protocols/current)
    
    hash=$(echo "$protocol_json" | jq -r '.hash' | cut -c 1-8)
    code=$(echo "$protocol_json" | jq -r '.code' | xargs printf "%03d")
    echo "$code"-"$hash"
}


function create_service_files(){
    proto=$1
    
    SERVICES_DIR="$DATA_DIR/services"
    TEMPLATES_DIR="$SCRIPT_DIR"/services
    
    mkdir -p "$SERVICES_DIR"
    
    services_templates=$(find "$TEMPLATES_DIR"/*.template -printf "%f\n")
    
    for f in $services_templates
    do
        sed "s/\$USER/$BAKING_USER/g" "$TEMPLATES_DIR/$f" | sed "s/\$BAKER_ALIAS/$BAKER/g" | sed "s/\$PROTO/$proto/g" > "$SERVICES_DIR/${f/\.template/""}"
    done
}


function check_binaries() {
    proto=$1
    
    if [ ! -f /opt/tezos/tezos-baker-"$proto" ]; then
        echo "tezos-baker-$proto not found"
        exit 1
    fi
}

function create_tezos_services() {
    proto=${1:-$(get_protocol "$DATA_DIR")}
    
    if [ -z "$proto" ]; then
        echo "protocol is missing"
        exit 1
    fi
    
    check_binaries "$proto"
    
    echo "creating files"
    create_service_files "$proto"
    
    echo "moving files to system"
    # move services to system dir
    sudo mv "$DATA_DIR"/services/* /etc/systemd/system/
    
    sudo systemctl daemon-reload
}
