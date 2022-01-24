#!/bin/bash

function step4_cmd() {
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
}