#! /bin/bash

function register_baker() {
    echo "Do you want to register your baker? please make sure it's not empty [y/N]"
    read -r register
    register=${register:-"N"}
    
    if [ "$register" = "y" ] || [ "$register" = "Y" ]; then
        /opt/tezos/tezos-client register key "$BAKER" as delegate
    fi
}
