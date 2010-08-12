#!/bin/sh

. ./Functions

checkArgv $* || exit

echo -e 'Please to choice:
1 - Original LCD packages
2 - Ubuntu patched packages
3 - ClearType packages'
read nChoice

if [ 1 -eq $nChoice ]; then
	APP_REMOVE=(
			libxft
			cairo
		   )
	APP_PACMAN=(
			libxft-lcd
		   )
	APP_YAOURT=(
			fontconfig-lcd
			cairo-lcd
		   )
elif [ 2 -eq $nChoice ]; then
	APP_REMOVE=(
			libxft
			cairo
			fontconfig
			freetype2
		   )
	APP_YAOURT=(
			freetype2-ubuntu
			fontconfig-ubuntu
			libxft-ubuntu
			cairo-ubuntu
		   )
elif [ 3 -eq $nChoice ]; then
	APP_REMOVE=(
			libxft
			cairo
			freetype2
		   )
	APP_YAOURT=(
			freetype2-cleartype
			libxft-cleartype
			cairo-cleartype
		   )
fi



optionType $@
TYPE=$?
if (( 1 == $TYPE )); then
	for i in ${APP_REMOVE[@]}; do
		pacman -Rd --noconfirm $i
	done

	for i in ${APP_PACMAN[@]}; do
		install $i
	done

	for i in ${APP_YAOURT[@]}; do
		install $i yaourt
	done

elif (( 2 == $TYPE )); then
	for i in ${APP_PACMAN[@]}; do
		pacman -d -R $i
	done

	for i in ${APP_YAOURT[@]}; do
		pacman -d -R $i
	done

	for i in ${APP_REMOVE[@]}; do
		pacman -S --noconfirm $i
	done
else
	exit 99
fi
