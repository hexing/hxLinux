#!/bin/sh


CF_FG_Y='\e[33m'
CF_FG_R='\e[30;41m'
CF_UNDERLINE='\e[36;4m'
CF_RESET='\e[0m'


afterUninstall()
{
	if [[ 'links' == $1 ]]; then
		LST=`find ~ /home -type d -iname '.links'`
		for i in $LST; do
			rm -ir $i
		done
	fi
}


ARR=(
vi
links
#fdisk
xf86-video-vesa xorg-docs xorg-fonts-100dpi xorg-fonts-75dpi xorg-twm xterm
)
#CNT=${#ARR[@]}

for i in ${ARR[@]}
do
	pacman -Q $i &>/dev/null
	(( 0 != $? )) && continue

	echo -e "Would you like to ${CF_FG_Y}U${CF_RESET}ninstall ${CF_FG_R}$i${CF_RESET}?(${CF_UNDERLINE}y/n${CF_RESET})"
	read yn
	[[ 'n' == $yn || 'no' == $yn ]] && continue
	
	pacman -Rns $i && afterUninstall $i
done
