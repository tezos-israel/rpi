#! /bin/bash

function start_baker_binaries() {
    sudo systemctl start tezos-{baker,endorser,accuser}
    sleep 10
    sudo systemctl is-active --quiet tezos-{baker,endorser,accuser}
}