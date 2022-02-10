#!/bin/bash
set -euo pipefail
IFS=$'\n\t'

SCRIPT_DIR=$(dirname "$0")
DATA_DIR=$(readlink -f "./out")


source "$SCRIPT_DIR"/utils/utils.sh
source "$SCRIPT_DIR"/utils/step_utils.sh
source "$SCRIPT_DIR"/utils/download_tezos.sh

source "$SCRIPT_DIR"/steps/1-update-machine.sh
source "$SCRIPT_DIR"/steps/2-check-deps.sh
source "$SCRIPT_DIR"/steps/3-install-tezos.sh
source "$SCRIPT_DIR"/steps/4-setup-services.sh
source "$SCRIPT_DIR"/steps/5-import-snapshot.sh
source "$SCRIPT_DIR"/steps/6-start-node.sh
source "$SCRIPT_DIR"/steps/register-baker.sh
source "$SCRIPT_DIR"/steps/7-start_baker_binaries.sh

mkdir -p "$DATA_DIR"

source "$SCRIPT_DIR"/utils/baker_details.sh

step=0


num_step update_machine restart_machine

num_step check_deps

num_step install_tezos

num_step create_tezos_services

num_step import_snapshot

num_step start_node


echo "Please import your baker"
echo "To import a ledger baker, run ./import_ledger_baker.sh"
echo "To import a tesnet baker, run ./create_test_baker.sh ADDRESS"

echo "press [Enter] to continue..."
read -r

num_step register_baker

num_step start_baker_binaries


## ledger specifc
# apply_udev "$DATA_DIR"

# echo "Please connect ledger and open the baking app, press [Enter] to continue..."
# read -r

# import_baker


