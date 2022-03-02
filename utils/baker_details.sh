#!/bin/bash

details_file="$DATA_DIR"/baker_details

if [ -f "$details_file" ]; then
    # shellcheck source=/dev/null
    source "$details_file"
fi

DEFAULT_NETWORK=hangzhounet

if [[ -z ${user+x} ]]; then
    echo "What's is the user name that runs tezos (default: $USER)?"
    read -r user
    user=${user:-$USER}
fi

if [[ -z ${baker+x} ]]; then
    echo "What's is your baker alias (default: baker)?"
    read -r baker
    baker=${baker:-"baker"}
fi

if [[ -z ${NETWORK+x} ]]; then
    echo "What's is the network (default: $DEFAULT_NETWORK)?"
    read -r NETWORK
    NETWORK=${NETWORK:-"$DEFAULT_NETWORK"}
fi

cat > "$details_file" << EOF
baker=$baker
user=$user
NETWORK=$NETWORK
EOF