## How to use

- enable boot from usb: https://www.tomshardware.com/how-to/boot-raspberry-pi-4-usb#how-to-boot-raspberry-pi-4-400-from-usb-xa0

- download image using

```
wget "https://github.com/tezos-israel/rpi/releases/download/v0.0.1/tezos-rpi.img.tar.gz"
tar -xzf ./tezos-rpi.img.tar.gz
```

- burn image to hdd (using imager)

- run

```shell
wget -O - https://raw.githubusercontent.com/tezos-israel/rpi/main/setup-rpi-before-boot.sh | WIFI_SSID=<WIFI_SSID> WIFI_PASSWORD=<WIFI_PASSWORD> bash
```

you can also supply SSH_PUB_KEY, COUNTRY_CODE if needed (more env vars are available in the script)

- dismount hd

- connect hd to rpi
- start rpi

- connect to rpi using ssh

- run

```
cd ./setup-rpi
./on-first-boot.sh
```

- to import baker address:

  - for testnet:
    - download config from faucet: https://teztnets.xyz/hangzhounet-faucet to a json file (name the file `PUBLIC_ADDRESS.json` - something like `tzXXX.json`)
    - run `./create_test_baker.sh tzXXXX`
  - for mainnet: run `./import_ledger_baker.sh`
