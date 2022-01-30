#!/bin/bash

function check_deps() {
    echo "Checking dependencies... "
    deps=""
    while read -r name
    do
        if ! [  -x "$(command -v "$name")" ] ; then
            deps="$name $deps";
        fi
    done < "$SCRIPT_DIR"/dependencies
    
    if  [ -n "$deps" ] ; then
        printf "\nmissing dependencies, run:\nsudo apt install %s\n" "$deps"
        exit 1
    fi
}
