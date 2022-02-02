#!/bin/bash

function step3_cmd(){
    if [ ! -d "$DATA_DIR/binaries" ]; then
        version="latest"
        download_tezos "$DATA_DIR" "$version"
    fi
    
    # move_binaries_to_path
    sudo mkdir -p /opt/tezos
    sudo cp "$DATA_DIR"/binaries/* /opt/tezos
    
    echo "export PATH=\"\$PATH:/opt/tezos\"" >> "$HOME"/.bashrc
    export PATH=$PATH:/opt/tezos
    
    # download zcash params
    wget -O "$DATA_DIR"/fetch-zcash-params.sh https://raw.githubusercontent.com/zcash/zcash/master/zcutil/fetch-params.sh
    chmod +x "$DATA_DIR"/fetch-zcash-params.sh
    "$DATA_DIR"/fetch-zcash-params.sh
    
    tezos-node config --network hangzhounet --rpc-addr "[::]:8732" init
}