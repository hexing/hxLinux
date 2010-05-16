#!/bin/sh

. ./Functions


ARR_PACMAN=(
alsa-utils alsa-oss
)

ARR_YAOURT=(
)


checkArgv $* || exit
	
optionType $@
TYPE=$?
if (( 1 == $TYPE )); then
	for i in ${ARR_PACMAN[@]}; do
		install $i
	done

	for i in ${ARR_YAOURT[@]}; do
		install $i yaourt
	done

	#amixer set Master 90% unmute
	#amixer set PCM 85% unmute

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
