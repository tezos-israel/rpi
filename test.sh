#!/bin/bash
set -euo pipefail
IFS=$'\n\t'

DATA_DIR=$(readlink -f "./out")

mkdir -p "$DATA_DIR"

source ./utils/utils.sh
source ./steps/step1.sh

step1