#!/bin/sh

DIR_BACKUP=/opt/hxLinux

LIST=('/etc/{hosts,resolv.conf,pacman.d/mirrorlist}')
for i in ${LIST[@]}; do
	eval ls $i
done
