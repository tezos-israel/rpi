#!/bin/bash
set -euo pipefail
IFS=$'\n\t'

DEBUG=${DEBUG:-""}

if [[ -n $DEBUG ]]; then
    set -x
fi

SCRIPT_DIR=$(dirname "$0")
DATA_DIR=$(readlink -f "./out")

source ./utils/baker_details.sh

source "$SCRIPT_DIR"/steps/4-setup-services.sh

proto=${1:-""}

create_tezos_services "$proto"