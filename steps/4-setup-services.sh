#!/bin/bash

function step4_cmd() {
    create_service_files "$DATA_DIR" "$user" "$baker" "$proto"
    
    # move services to system dir
    sudo mv "$DATA_DIR"/services/* /etc/systemd/system/
    
    sudo systemctl daemon-reload
}