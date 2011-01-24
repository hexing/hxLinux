#!/bin/sh

#dig www.baidu.com #查询DNS的时间

find /etc/ -type f -iname '*pacnew' -or -name '*~'
find /opt/hxLinux -type f -name '*~'


INGNORE_PKG=(
xterm xorg-twm
avahi
)

for i in ${INGNORE_PKG[@]}; do
	pacman -Q $i 2>/dev/null
done

pacman -Qdt


for i in $(ls ~/.recently-used.xbel*); do
	echo $i
done
