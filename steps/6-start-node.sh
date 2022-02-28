#!/bin/bash

function start_node() {
    echo "starting node"
    sudo systemctl enable tezos-node
    sudo systemctl start tezos-node
    
    echo "sleeping until node is ready"
    wait_until_is_active "tezos-node.service"
    
    /opt/tezos/tezos-client bootstrapped
}