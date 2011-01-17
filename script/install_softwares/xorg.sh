#!/bin/sh

. ./Functions


ARR_PACMAN=(
xorg
fonts
hal mesa numlockx
xf86-video-ati ati-dri
xf86-input-evdev
)

ARR_YAOURT=(
)

IGNORE='xterm|xorg-twm|xorg-docs'
LIST=$(pacman -Sg xorg | grep -Pv "$IGNORE" | grep -Po '\s.+')

checkArgv $* || exit
	
optionType $@
TYPE=$?
if [ 1 -eq $TYPE ] ; then
	for i in ${ARR_PACMAN[@]}; do
		if [ 'xorg' == $i ]; then
			$PACMAN -S $LIST
		else
			install $i
			if [ 0 -eq $? ]; then
				[ 'hal' == $i ] && echo -e "Please append \e[32;1m@hal\e[0m to \e[34;1m/etc/rc.conf daemon\e[0m."
				[ 'numlockx' == $i ] && echo -e "Please append \e[32;1mnumlock &\e[0m to \e[34;1m~/.xinitrc\e[0m."
			fi
		fi
	done

	for i in ${ARR_YAOURT[@]}; do
		install $i yaourt
	done

elif [ 2 -eq $TYPE ]; then
	for i in ${ARR_PACMAN[@]}; do
		uninstall $i
	done

	for i in ${ARR_YAOURT[@]}; do
		uninstall $i yaourt
	done

else
	exit 99
fi
