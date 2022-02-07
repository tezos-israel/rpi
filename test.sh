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

num_step test_step

num_step test_step

num_step test_step

num_step test_step


