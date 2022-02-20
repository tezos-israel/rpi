## How to use

- enable boot from usb: https://www.tomshardware.com/how-to/boot-raspberry-pi-4-usb#how-to-boot-raspberry-pi-4-400-from-usb-xa0

- burn image to hdd (using imager)

- run `wget -O - https://raw.githubusercontent.com/tezos-israel/rpi/main/setup-rpi-before-boot.sh | bash`

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
