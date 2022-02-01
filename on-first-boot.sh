#!/bin/bash
set -euo pipefail
IFS=$'\n\t'

SCRIPT_DIR=$(dirname "$0")
DATA_DIR=$(readlink -f "./out")


source "$SCRIPT_DIR"/utils/utils.sh
source "$SCRIPT_DIR"/utils/step_utils.sh
source "$SCRIPT_DIR"/utils/download_tezos.sh
source "$SCRIPT_DIR"/utils/udev.sh

source "$SCRIPT_DIR"/steps/1-update-machine.sh
source "$SCRIPT_DIR"/steps/2-check-deps.sh
source "$SCRIPT_DIR"/steps/3-install-tezos.sh
source "$SCRIPT_DIR"/steps/4-setup-services.sh
source "$SCRIPT_DIR"/steps/5-import-snapshot.sh
source "$SCRIPT_DIR"/steps/6-start-node.sh
source "$SCRIPT_DIR"/steps/7-start_baker_binaries.sh

mkdir -p "$DATA_DIR"

source "$SCRIPT_DIR"/utils/baker_details.sh

step=1

step update_machine
step check_deps
step step3_cmd
step create_tezos_services
step step5_cmd
step step6_cmd

echo "Please import your baker, press [Enter] to continue..."
read -r

echo "Do you want to register your baker? [y/N]"
read -r register
register=${register:-"N"}

if [ "$register" = "y" ] || [ "$register" = "Y" ]; then
    tezos-client register key "$baker" as delegate
fi

step start_baker_binaries


## ledger specifc
# apply_udev "$DATA_DIR"

# echo "Please connect ledger and open the baking app, press [Enter] to continue..."
# read -r

# import_baker


