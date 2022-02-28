#!/usr/bin/env bash

function restart_machine() {
    echo "Press [Enter] key to reboot..."
    read -r
    
    sudo reboot
}

function is_in_activation {
    activation=$(sudo systemctl is-active "$1")
    if [ -z "$activation" ]; then
        true;
    else
        false;
    fi
    
    return $?;
}

function wait_until_is_active {
    while ! is_in_activation "$1"; do
        sleep 1
    done
}

