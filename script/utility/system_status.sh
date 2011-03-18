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

#0Black 1Blue 2Green 3Cyan青色 4Red 5Carmine洋红色 6Yellow 7White


tput setaf 6
find /etc/ -iname '*.pacnew' -or -name '*~' -or -iname '*.bak'
find /opt/hxLinux/ -name '*~' -or -iname '*.bak'


tput setaf 1
tput setab 7
tput rev
lsmod | grep '[i]pv6'


tput sgr0
tput setaf 2
NEED_PKG=(
	aufs2 squashfs-tools
	pdnsd #varnish west-chamber
	p7zip sqlite3 wget aria2
	#openbox lxde pekwm icewm dwm jwm pwm compiz Tint2
	gpicview feh viewnior mirage gthumb #gpicview
	zathura epdfview apvlv xpdf mupdf
)
for i in ${NEED_PKG[@]}; do
	pacman -Q $i 1>/dev/null
done


tput sgr0
tput setaf 5
INGNORE_PKG=(
	xterm xorg-twm avahi epiphany
	lvm2 vbetool
)
for i in ${INGNORE_PKG[@]}; do
	pacman -Q $i 2>/dev/null
done


tput sgr0
tput smul
tput setaf 4
pacman -Qdt


tput sgr0
tput setaf 3
for i in $(find ~/ -name '.recently-used.xbel*' -or -name '.lesshst' -or -name '.netrwhist'); do
	echo $i
done


tput sgr0
tput dim
for i in $(ls /proc/sys/vm/dirty_*); do
	cat $i
done
tput sgr0


#du -sh ~/.opera/vps

#reiserfs mount参数: -o defaults,async,noatime,nodiratime,notail,data=writeback
#ext4 mount参数: -o defaults,async,noatime,nodiratime,notail,data=writeback barrier=0
#关闭ext4日志:tune2fs -O^has_journal /dev/sdXX
