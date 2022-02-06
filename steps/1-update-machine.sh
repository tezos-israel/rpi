#!/bin/bash

function update_machine() {
    sudo apt update
    sudo apt full-upgrade -y
    
    touch "$DATA_DIR/step1"
    
    echo "rerun $0 after reboot"
    restart_machine
}

