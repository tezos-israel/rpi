#!/bin/bash

details_file="$DATA_DIR"/baker_details

if [ -f "$details_file" ]; then
    # shellcheck source=/dev/null
    . "$details_file"
fi

if [ -z "$user" ]; then
    echo "What's is the user name that runs tezos (default: $USER)"
    read -r user
    user=${user:-$USER}
fi

if [ -z "$baker" ]; then
    echo "What's is your baker alias (default: baker)"
    read -r baker
    baker=${baker:-"baker"}
fi

cat > "$details_file" << EOF
baker=$baker
user=$user
EOF