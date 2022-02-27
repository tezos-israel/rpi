- apply os 64bit using imager to sd card
- remount sd card
- run `./add-to-rpi.sh`
- run `./setup-rpi.sh`
- unmount sd card
- insert sd card to rpi and turn it on
- run `sudo apt install tmux git jq rename`
- run `sudo halt`
- remove sd card and mount to computer

```
umount /dev/mmcblk0p1 && umount /dev/mmcblk0p2
sudo dd if=/dev/mmcblk0 of=$HOME/tezos-rpi.img bs=32M
sudo ./pishrink.sh -z $HOME/tezos-rpi.img
```
