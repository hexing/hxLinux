#!/bin/sh

find /etc/ -type f -iname '*pacnew' -or -name '*~'
find /opt/hxLinux -type f -name '*~'

INGNORE_PKG=(
xterm
xorg-twm
)

for i in ${INGNORE_PKG[@]}; do
	pacman -Q $i 2>/dev/null
done
