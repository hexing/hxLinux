#!/bin/sh

pgrep 'gnome-session' || exit 0
PAGER=`ls /opt/hxLinux/home/wallpapers/* | shuf -n 1`
gconftool-2  -s /desktop/gnome/background/picture_filename\
	-t string "$PAGER" -s /desktop/gnome/background/picture_options zoom

#DIR_WALLPAPERS='/usr/share/lxde/wallpapers'
#[ ! -d "$DIR_WALLPAPERS" ] && exit
##FEH=`which feh`
##[ 0 -ne $? ] && exit
#FEH=/usr/bin/feh
#[ ! -x "$FEH" ] && exit
#
#find $DIR_WALLPAPERS -type f -iname '*.jpg' -o -iname '*.png' | shuf -n 1 | xargs feh --bg-scale &
#
##feh --bg-scale "$(find /usr/share/lxde/wallpapers -name * | shuf -n 1)"
#
##F_WP=`ls $DIR_WALLPAPERS | shuf -n 1`
##F_WP=$DIR_WALLPAPERS/$F_WP
##$FEH --bg-scale $F_WP
#
#while true;
#do
#	feh --bg-scale "$(find ~/.wallpaper -name *.jpg | shuf -n 1)"
#	sleep 15m
#done
