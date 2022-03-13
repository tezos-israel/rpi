#!/bin/bash

details_file="$DATA_DIR"/baker_details

if [ -f "$details_file" ]; then
    # shellcheck source=/dev/null
    source "$details_file"
fi

DEFAULT_NETWORK=hangzhounet

if [[ -z ${BAKING_USER+x} ]]; then
    echo "What's is the user name that runs tezos (default: $USER)?"
    read -r BAKING_USER
    BAKING_USER=${BAKING_USER:-$USER}
fi

if [[ -z ${BAKER+x} ]]; then
    echo "What's is your baker alias (default: baker)?"
    read -r BAKER
    BAKER=${BAKER:-"baker"}
fi

if [[ -z ${NETWORK+x} ]]; then
    echo "What's is the network (default: $DEFAULT_NETWORK)?"
    read -r NETWORK
    NETWORK=${NETWORK:-"$DEFAULT_NETWORK"}
fi

cat > "$details_file" << EOF
BAKER=$BAKER
BAKING_USER=$BAKING_USER
NETWORK=$NETWORK
EOF