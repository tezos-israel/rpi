#!/bin/bash

function update_machine() {
    sudo apt update
    sudo apt full-upgrade -y
    
    touch "$DATA_DIR/step1"
    
    echo "Press [Enter] key to reboot..., rerun $0 after reboot"
    read -r
    
    sudo reboot
}

