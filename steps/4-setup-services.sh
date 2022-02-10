#!/bin/bash

function get_protocol() {
    DATA_DIR=$1
    
    BINARIES_DIR="$DATA_DIR/binaries"
    
    cd "$BINARIES_DIR" || exit 1
    
    bk_binaries=$(find . -type f -iname "tezos-baker-*" | sort)
    
    if [ -z "$bk_binaries" ]; then
        echo "baking binary not found"
        exit 1
    fi
    
    proto=$(echo "$bk_binaries" | sed -En "s/.\/tezos-baker-(.*)/\1/p" | tail -1)
    
    echo "$proto"
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
