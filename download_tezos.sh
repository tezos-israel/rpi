#!/usr/bin/env bash

function get_repo_latest_release() {
    curl --silent "https://api.github.com/repos/$1/releases/latest" | jq ".tag_name" | tr -d "\"" | cut -c 2-
}


function download_latest() {
    DATA_DIR="$1"

    github_repo="serokell/tezos-packaging"
    latest="$(get_repo_latest_release $github_repo)"
    
    wget -O "$DATA_DIR/binaries.tar.gz" "https://github.com/$github_repo/releases/download/v$latest/binaries-$latest-arm64.tar.gz"
}



function download_tezos() {
    echo "downloading tezos"

    DATA_DIR="$1"

    download_latest "$DATA_DIR" 
    
    echo "extracting tezos"
    mkdir -p "$DATA_DIR/binaries"
    tar -xvf binaries.tar.gz -C ./binaries

    echo "normalizing names"
    cd "$DATA_DIR/binaries" || exit 1
    rename 's/-arm64//' ./*
}
