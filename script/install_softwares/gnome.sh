#!/bin/sh

. ./Functions


ARR_PACMAN=(
dbus gamin
gnome
gnome-extra
gnome-system-tools gtk-engine-murrine gtk-engines gtk-aurora-engine gtk-rezlooks-engine
gnome-themes-extras
)

ARR_YAOURT=(
)

IGNORE='gnome-terminal|gnome-keyring|gnome-media|epiphany'
LIST=$(pacman -Sg gnome | grep -Pv "$IGNORE" | grep -Po '\s.+')

ATTACH=
addAttach()
{
	echo  "$LIST" | grep "$1" 1>/dev/null && ATTACH="$ATTACH $2"
}

addAttach epiphany epiphany-extensions

addAttach nautilus nautilus-sendto
addAttach nautilus nautilus-actions
addAttach nautilus nautilus-open-terminal
GNOME="$LIST"


IGNORE="bug-buddy|cheese|dasher|ekiga|empathy|eog|evince|evolution|evolution-exchange|evolution-webcal|file-roller\
|gcalctool|gdm|gedit|gnome-audio|gnome-games|gnome-games-extra-data|gnome-mag|gok|gucharmap|libgail-gnome|nautilus-sendto\
|orca|seahorse|seahorse-plugins|sound-juicer|tomboy|totem|vinagre|vino|zenity"
LIST=$(pacman -Sg gnome-extra | grep -Pv "$IGNORE" | grep -Po '\s.+')
GNOME_EXTRA="$LIST"



checkArgv $* || exit

optionType $@
TYPE=$?
if [ 1 -eq $TYPE ]; then
	for i in ${ARR_PACMAN[@]}; do
		if [ 'gnome' == $i ]; then
			$PACMAN -S $GNOME
		elif [ 'gnome-extra' == $i ]; then
			$PACMAN -S $GNOME_EXTRA
		else
			install $i
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
