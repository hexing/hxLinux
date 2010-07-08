#!/bin/sh

[ 1 -eq "$#" ] || exit 1

if [ '--mount' = "$1" ]; then
mount -t xfs /dev/sda1 /mnt/sda1
mount -t xfs /dev/sda2 /mnt/sda2
mount -t xfs /dev/sda6 /mnt/sda6
mount -t xfs /dev/sda7 /mnt/sda7
elif [ '--umount' = "$1" ]; then
umount /mnt/sda1
umount /mnt/sda2
umount /mnt/sda6
umount /mnt/sda7
else
echo '--mount or --umount'
fi
