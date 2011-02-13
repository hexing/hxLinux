#!/bin/sh

PAC_DB=/var/lib/pacman
PAC_FS=/tmp/pacmanDB.fs
MNT=/tmp/plv

mkdir -p $MNT &&\
	truncate $PAC_FS --size 168M &&\
	mkfs.reiserfs -f $PAC_FS &&\
	mount -t reiserfs $PAC_FS $MNT -o loop &&\
	cp -a $PAC_DB/* $MNT &&\
	umount $MNT

#/etc/fstab
#/tmp/pacmanDB.fs /var/lib/pacman reiserfs defaults,loop 0 9
#EXT4_MOUNT='defaults, async, noatime, nodiratime, data=writeback, barrier=0'
#关闭ext4日志:tune2fs ^has_journal /dev/sdXX
#REISERFS_MOUNT='default, async, noatime, nodiratime, data=writeback#, notail'
