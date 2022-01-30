#! /bin/bash

function start_baker_binaries() {
    sudo systemctl start tezos-{baker,endorser,accuser}
    wait 10
    sudo systemctl is-active --quiet tezos-{baker,endorser,accuser}
}