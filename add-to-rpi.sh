#!/bin/bash
set -euo pipefail
IFS=$'\n\t'

MOUNT_PATH=${MOUNT_PATH:-"/media/$USER"}
BOOT=${BOOT:-"$MOUNT_PATH/boot"}
ROOT=${ROOT:-"$MOUNT_PATH/rootfs"}

cd "$ROOT/home/pi"
git clone https://github.com/tezos-israel/rpi.git setup-rpi