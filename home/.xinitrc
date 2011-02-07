#!/bin/sh

#!/bin/sh

#ps -ef | grep -P 'dbus' | grep -v 'grep'
#ps -ef | grep -P '[d]bus'
pgrep 'dbus'
if [ 0 -ne $? ]; then
	if [ 'root' == $USER ]; then
		/etc/rc.d/dbus start
		/etc/rc.d/alsa start
	else
		echo -e 'sudo /etc/rc.d/dbus start'
		exit
	fi
fi
lsmod | grep 'fuse'
if [ 0 -ne $? ]; then
	modprobe fuse
fi


#userresources=$HOME/.Xresources
#usermodmap=$HOME/.Xmodmap
#sysresources=/etc/X11/xinit/.Xresources
#sysmodmap=/etc/X11/xinit/.Xmodmap
#
## merge in defaults and keymaps
#
#if [ -f $sysresources ]; then
#    xrdb -merge $sysresources
#fi
#
#if [ -f "$userresources" ]; then
#    xrdb -merge "$userresources"
#fi
#
#if [ -f "$usermodmap" ]; then
#    xmodmap "$usermodmap"
#fi




export LANG=zh_CN.utf8
export LC_CTYPE=zh_CN.utf8
export LC_ALL=zh_CN.utf8

export XMODIFIERS="@im=fcitx"
export GTK_IM_MODULE=xim
export QT_IM_MODULE=xim
##export XIM=fcitx
##export XIM_PROGRAM=fcitx
##export GTK_IM_MODULE=xim
##export GTK_IM_MODULE=fcitx

fcitx &
numlockx &

#exec startlxde

exec ck-launch-session gnome-session
