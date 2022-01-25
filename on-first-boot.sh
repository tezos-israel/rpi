#!/bin/bash
set -euo pipefail
IFS=$'\n\t'

SCRIPT_DIR=$(dirname "$0")
DATA_DIR=$(readlink -f "./out")


source "$SCRIPT_DIR"/utils/utils.sh
source "$SCRIPT_DIR"/utils/step_utils.sh
source "$SCRIPT_DIR"/utils/download_tezos.sh
source "$SCRIPT_DIR"/utils/create_services.sh
source "$SCRIPT_DIR"/utils/udev.sh

source "$SCRIPT_DIR"/steps/1-update-machine.sh
source "$SCRIPT_DIR"/steps/2-check-deps.sh
source "$SCRIPT_DIR"/steps/3-install-tezos.sh
source "$SCRIPT_DIR"/steps/4-setup-services.sh
source "$SCRIPT_DIR"/steps/5-import-snapshot.sh
source "$SCRIPT_DIR"/steps/6-start-node.sh

mkdir -p "$DATA_DIR"

step=1
step step1_cmd
step step2_cmd
step step3_cmd
step step4_cmd
step step5_cmd
step step6_cmd



## ledger specifc
# apply_udev "$DATA_DIR"

# echo "Please connect ledger and open the baking app, press [Enter] to continue..."
# read -r

# import_baker


