#!/bin/sh

#三天后大下午5点执行
#at 5pm + 3 days /bin/ls
#两星期后点上午7点执行
#at 7am + 2 weeks /bin/ls
#明天点19:30执行
#at 19:30 tomorrow /bin/ls
#1999年点最后一天的最后一分钟执行
#at 23:59 12/21/1999 echo 'bye bye 1999.'

#dig www.baidu.com #查询DNS的时间

find /etc/ -type f -iname '*pacnew' -or -name '*~'
find /opt/hxLinux -type f -name '*~'


lsmod | grep '[i]pv6'


NEED_PKG=(
pdnsd #varnish
p7zip
)
for i in ${NEED_PKG[@]}; do
	pacman -Q $i 1>/dev/null
done


INGNORE_PKG=(
xterm xorg-twm avahi
lvm2 vbetool
)
for i in ${INGNORE_PKG[@]}; do
	pacman -Q $i 2>/dev/null
done


pacman -Qdt


for i in $(find ~/ -name '.recently-used.xbel*' -or -name '.lesshst'); do

	echo $i
done


#du -sh ~/.opera/vps

#reiserfs mount参数: -o defaults,async,noatime,nodiratime,notail,data=writeback
#ext4 mount参数: -o defaults,async,noatime,nodiratime,notail,data=writeback barrier=0
#关闭ext4日志:tune2fs -O^has_journal /dev/sdXX
