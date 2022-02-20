#!/bin/bash
set -euo pipefail
IFS=$'\n\t'

MOUNT_PATH=${MOUNT_PATH:-"/media/$USER"}
BOOT=${BOOT:-"$MOUNT_PATH/boot"}
ROOT=${ROOT:-"$MOUNT_PATH/rootfs"}
SSH_PUB_KEY=${SSH_PUB_KEY:-"$HOME/.ssh/id_rsa.pub"}
COUNTRY_CODE=${COUNTRY_CODE:-"IL"}

touch "$BOOT"/ssh

cat > "$BOOT"/wpa_supplicant.conf <<EOF

country=$COUNTRY_CODE
ctrl_interface=DIR=/var/run/wpa_supplicant GROUP=netdev
update_config=1

network={
  ssid="$WIFI_SSID"
  scan_ssid=1
  psk="$WIFI_PASSWORD"
}

EOF

SSH="$ROOT/home/pi/.ssh"
mkdir -p "$SSH"
cp "$SSH_PUB_KEY" "$SSH"/authorized_keys
sudo chown 1000:1000 "$SSH/authorized_keys"
sudo chmod 600 "$SSH/authorized_keys"