#!/bin/bash

function step6_cmd() {
    sudo systemctl enable tezos-node
    sudo systemctl start tezos-node
    
    tezos-client bootstrapped
}