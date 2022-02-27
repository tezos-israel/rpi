#!/bin/bash

function start_node() {
    echo "starting node"
    sudo systemctl enable tezos-node
    sudo systemctl start tezos-node
    
    echo "sleeping until node is ready"
    sleep 20
    
    /opt/tezos/tezos-client bootstrapped
}