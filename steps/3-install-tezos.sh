#!/bin/bash

function install_tezos(){
    if [ ! -d "$DATA_DIR/binaries" ]; then
        version="latest"
        download_tezos "$DATA_DIR" "$version"
    fi
    
    # move_binaries_to_path
    sudo mkdir -p /opt/tezos
    sudo cp "$DATA_DIR"/binaries/* /opt/tezos
    
    echo "export PATH=\"\$PATH:/opt/tezos\"" >> "$HOME"/.bashrc
    export PATH=$PATH:/opt/tezos
    source "$HOME"/.bashrc
    
    echo "run: source $HOME/.bashrc"
    
    # download zcash params
    wget -O "$DATA_DIR"/fetch-zcash-params.sh https://raw.githubusercontent.com/zcash/zcash/master/zcutil/fetch-params.sh
    chmod +x "$DATA_DIR"/fetch-zcash-params.sh
    "$DATA_DIR"/fetch-zcash-params.sh
    
    tezos-node config --network "$NETWORK" --rpc-addr "localhost:8732" init
    
    tezos-node identity generate
}