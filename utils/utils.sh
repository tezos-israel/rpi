#!/usr/bin/env bash

function restart_machine() {
    echo "Press [Enter] key to reboot..."
    read -r
    
    sudo reboot
}