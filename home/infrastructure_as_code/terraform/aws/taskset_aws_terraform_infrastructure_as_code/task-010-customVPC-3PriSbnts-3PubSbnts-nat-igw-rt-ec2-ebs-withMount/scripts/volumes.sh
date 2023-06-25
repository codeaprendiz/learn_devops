#!/bin/bash

set -ex

# this will refresh the lvm state that we installed using init.cfg
vgchange -ay


# it will check wether we already have a file system or not. If not then we will create. If it has then it will not format it.
DEVICE_FS=`blkid -o value -s TYPE ${DEVICE} || echo ""`
if [ "`echo -n $DEVICE_FS`" == "" ] ; then
  # wait for the device to be attached
  DEVICENAME=`echo "${DEVICE}" | awk -F '/' '{print $3}'`
  DEVICEEXISTS=''
  while [[ -z $DEVICEEXISTS ]]; do
    echo "checking $DEVICENAME"
    DEVICEEXISTS=`lsblk |grep "$DEVICENAME" |wc -l`
    if [[ $DEVICEEXISTS != "1" ]]; then
      sleep 15
    fi
  done
  pvcreate ${DEVICE}
  vgcreate data ${DEVICE}
  lvcreate --name volume1 -l 100%FREE data
  mkfs.ext4 /dev/data/volume1
fi
mkdir -p /data
echo '/dev/data/volume1 /data ext4 defaults 0 0' >> /etc/fstab
mount /data

# install docker
curl https://get.docker.com | bash
