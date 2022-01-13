#!/usr/bin/env bash

function get_protocol() {
    DATA_DIR=$1
    
    BINARIES_DIR="$DATA_DIR/binaries"
    
    cd "$BINARIES_DIR" || exit
    
    bk_binaries=$(find . -type f -iname "tezos-baker-*" | sort)
    
    if [ -z "$bk_binaries" ]; then
        echo "baking binary not found"
        exit 1
    fi
    
    proto=$(echo "$bk_binaries" | sed -En "s/.\/tezos-baker-(.*)/\1/p" | tail -1)
    
    echo "$proto"
}