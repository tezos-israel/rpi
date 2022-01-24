#!/bin/bash


function step1_cmd() {
    # 1. update machine
    sudo apt update
    sudo apt install curl jq
    sudo apt full-upgrade -y
    
    touch "$DATA_DIR/step1"
    
    echo "Press [Enter] key to reboot..., rerun $0 after reboot"
    read -r
    
    sudo reboot
}

