#!/bin/bash
set -euo pipefail
IFS=$'\n\t'

baker=$1
account=$2

tezos-client activate account "$baker" with "$account.json"
tezos-client register key "$baker" as delegate
