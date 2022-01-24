#!/usr/bin/env bash

github_repo="serokell/tezos-packaging"

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

function download() {
    DATA_DIR="$1"
    arch_suffix="$2"
    version="$3"

    
    wget -O "$BINARIES_TAR" "https://github.com/$github_repo/releases/download/v$version/binaries-$version$arch_suffix.tar.gz"
}




function download_tezos() {
    echo "downloading tezos"

    DATA_DIR="$1"
    BINARIES_TAR="$DATA_DIR/binaries.tar.gz"
    BINARIES_DIR="$DATA_DIR/binaries"

    arch_suffix=$(get_arch)

    version="$2"

    if [ -z "$version" ] || [ "$version" = "latest" ]; then
        version="$(get_repo_latest_release $github_repo)"
    fi

    download "$DATA_DIR" "$arch_suffix" "$version"
    
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
