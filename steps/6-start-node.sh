#!/bin/bash

function start_node() {
    sudo systemctl enable tezos-node
    sudo systemctl start tezos-node
    
    sleep 20
    
    tezos-client bootstrapped
}