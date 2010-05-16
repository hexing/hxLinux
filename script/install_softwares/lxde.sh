#!/bin/sh

. ./Functions


ARR_PACMAN=(
gamin conky
leafpad p7zi xarchiver
lxde lxde-setting-daemon
obconf obmenu obtheme openbox-themes
gnome-control-center gtk-theme-switch gtk-theme-switch2 xcompmgr transset-df
gnome-icon-theme tango-icon-theme gnome-themes gnome-themes-extras
)

ARR_YAOURT=(
lxdm lxmusic lxinput lxshortcut
)


checkArgv $* || exit
	
optionType $@
TYPE=$?
if (( 1 == $TYPE )); then
	for i in ${ARR_PACMAN[@]}; do
		if [[ 'gamin' = $i ]]; then
			uninstall fam
		fi

		if [[ 'lxde' == $i ]]; then
			$PACMAN -S $i
		else
			install $i
		fi
	done

	for i in ${ARR_YAOURT[@]}; do
		install $i yaourt
	done

elif (( 2 == $TYPE )); then
	for i in ${ARR_PACMAN[@]}; do
		uninstall $i
	done

	for i in ${ARR_YAOURT[@]}; do
		uninstall $i yaourt
	done

else
	exit 99
fi
