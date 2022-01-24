#!/usr/bin/env bash

function get_protocol() {
    DATA_DIR=$1
    
    BINARIES_DIR="$DATA_DIR/binaries"
    
    cd "$BINARIES_DIR" || exit 1
    
    bk_binaries=$(find . -type f -iname "tezos-baker-*" | sort)
    
    if [ -z "$bk_binaries" ]; then
        echo "baking binary not found"
        exit 1
    fi
    
    proto=$(echo "$bk_binaries" | sed -En "s/.\/tezos-baker-(.*)/\1/p" | tail -1)
    
    echo "$proto"
}

function start_step() {
    step=$1
    
    if [ -f "$DATA_DIR/step$step" ]; then
        skip=1
        echo "skipping step $step"
        return 0
    fi
    
    echo "starting step $step..."
}

function finish_step() {
    step=$1
    touch "$DATA_DIR"/step"$step"
    echo "step $step finished"
}



function step() {
    local step=$1
    local cmd=$2
    
    if [ -z "$cmd" ]; then
        echo "missing command for step $step"
        exit 1
    fi
    
    local skip=0
    start_step "$step"
    
    if [ "$skip" = "1" ]; then
        return 0
    fi
    
    $cmd
    
    finish_step "$step"
}
