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
    local step=$2
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
    cmd_status=$?
    if ! [ $cmd_status -eq 0  ]; then
        exit $cmd_status
    fi
    
    finish_step "$step"

    local after_finish_cmd=${3:-""}
    if [ -n "$after_finish_cmd" ]; then
        $after_finish_cmd
    fi
}

function inc_step() {
    step=$((step+1))
}

function num_step() {
    inc_step
    
    step "$1" "$step" "${2:-""}"
}

function noop() {
    echo "noop"
}