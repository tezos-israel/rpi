#!/usr/bin/env bash

function restart_machine() {
    echo "Press [Enter] key to reboot..."
    read -r
    
    sudo reboot
}



function wait_until_is_active {
    while true; do
        if [ "$(systemctl is-active "$1")" == "active" ]; then
            break
        fi
        
        sleep 1
    done
}

