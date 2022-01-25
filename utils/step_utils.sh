#! /bin/bash

function start_step() {
    if [ -f "$DATA_DIR/step$step" ]; then
        skip=1
        echo "skipping step $step"
        return 0
    fi
    
    echo "starting step $step..."
}

function finish_step() {
    touch "$DATA_DIR"/step"$step"
    echo "step $step finished"
}



function step() {
    local cmd=$1
    
    if [ -z "$cmd" ]; then
        echo "missing command for step $step"
        exit 1
    fi
    
    local skip=0
    start_step "$step"
    
    if [ "$skip" = "1" ]; then
        step=$((step+1))
        return 0
    fi
    
    $cmd
    cmd_status=$?
    if ! [ $cmd_status -eq 0  ]; then
        exit $cmd_status
    fi
    
    finish_step "$step"
    step=$((step+1))
}

function noop() {
    echo "noop"
}