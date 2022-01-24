#!/bin/bash
set -euo pipefail
IFS=$'\n\t'

SCRIPT_DIR=$(dirname "$0")
DATA_DIR=$(readlink -f "./out")


source "$SCRIPT_DIR"/utils/utils.sh
source "$SCRIPT_DIR"/utils/download_tezos.sh
source "$SCRIPT_DIR"/utils/create_services.sh
source "$SCRIPT_DIR"/utils/udev.sh

source "$SCRIPT_DIR"/steps/step1.sh
source "$SCRIPT_DIR"/steps/step2.sh
source "$SCRIPT_DIR"/steps/step3.sh
source "$SCRIPT_DIR"/steps/step4.sh
source "$SCRIPT_DIR"/steps/step5.sh
source "$SCRIPT_DIR"/steps/step6.sh

mkdir -p "$DATA_DIR"

step "1" step1_cmd
step "2" step2_cmd
step "3" step3_cmd
step "4" step4_cmd
step "5" step5_cmd
step "6" step6_cmd



## ledger specifc
# apply_udev "$DATA_DIR"

# echo "Please connect ledger and open the baking app, press [Enter] to continue..."
# read -r

# import_baker


