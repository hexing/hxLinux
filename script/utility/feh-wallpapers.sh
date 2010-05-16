#!/bin/sh

DIR_WALLPAPERS='/usr/share/lxde/wallpapers'
[ ! -d "$DIR_WALLPAPERS" ] && exit
#FEH=`which feh`
#[ 0 -ne $? ] && exit
FEH=/usr/bin/feh
[ ! -x "$FEH" ] && exit

find $DIR_WALLPAPERS -type f -iname '*.jpg' -o -iname '*.png' | shuf -n 1 | xargs feh --bg-scale &

#feh --bg-scale "$(find /usr/share/lxde/wallpapers -name * | shuf -n 1)"

#F_WP=`ls $DIR_WALLPAPERS | shuf -n 1`
#F_WP=$DIR_WALLPAPERS/$F_WP
#$FEH --bg-scale $F_WP
