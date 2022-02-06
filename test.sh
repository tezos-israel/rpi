#!/bin/bash
set -euo pipefail
IFS=$'\n\t'


function test_step() {
    echo "stepping $step"
}

DATA_DIR=$(readlink -f "./out")

mkdir -p "$DATA_DIR"

source ./utils/utils.sh
source ./utils/step_utils.sh

step=0

inc_step
step test_step $step
inc_step
step test_step $step
inc_step
step test_step $step
inc_step
step test_step $step


