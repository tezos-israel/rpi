#!/usr/bin/env bash

function get_repo_latest_release() {
    curl --silent "https://api.github.com/repos/$1/releases/latest" | jq ".tag_name" | tr -d "\"" | cut -c 2-
}

function get_arch() {
    arch=$(dpkg --print-architecture)

    if [ "$arch" == "arm64" ]; then
        echo "-arm64"
    fi

    echo ""
}

function download_latest() {
    DATA_DIR="$1"
    arch_suffix="$2"

    github_repo="serokell/tezos-packaging"
    latest="$(get_repo_latest_release $github_repo)"
    
    

    wget -O "$BINARIES_TAR" "https://github.com/$github_repo/releases/download/v$latest/binaries-$latest$arch_suffix.tar.gz"
}



function download_tezos() {
    echo "downloading tezos"

    DATA_DIR="$1"
    BINARIES_TAR="$DATA_DIR/binaries.tar.gz"
    BINARIES_DIR="$DATA_DIR/binaries"

    arch_suffix=$(get_arch)

    download_latest "$DATA_DIR" "$arch_suffix"
    
    echo "extracting tezos"
    mkdir -p "$BINARIES_DIR"
    tar -xvf "$BINARIES_TAR" -C "$BINARIES_DIR"

    cd "$BINARIES_DIR" || exit 1
    if [ -n "$arch_suffix" ]; then
        echo "normalizing names"
        rename 's/-arm64//' ./*
    fi

    chmod +x ./*
}
