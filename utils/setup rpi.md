- enable boot from usb
- burn image to hdd
- add the following files to boot:
  - ssh (empty file, no extensions)
  - wpa_supplicant:

```
country=COUNTRY_CODE
ctrl_interface=DIR=/var/run/wpa_supplicant GROUP=netdev
update_config=1

network={
  ssid="WIFI_SSID"
  scan_ssid=1
  psk="WIFI_PASSWORD"
}
```

- copy your ssh public key from (e.g. ~/.ssh/id_rsa.pub) to /root/home/pi/authorized_keys
- `sudo chown 1000:1000 /root/home/pi/authorized_keys`
- `sudo chmod 600 /root/home/pi/authorized_keys`

- unmount and disconnect hd

- connect hd to rpi
- start hd

- should be able to ssh into rpi (after 1 minute)
- git clone THIS_REPO
- cd THIS_REPO
- ./on-first-boot.sh
