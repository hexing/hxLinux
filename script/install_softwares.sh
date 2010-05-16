#!/bin/sh


beforeInstall()
{
	if [[ 'vim' == $1 ]]; then
		rm /usr/bin/{view,rview} 2>/dev/null
	elif [[ 'yaourt' == $1 ]]; then
		cp /etc/pacman.conf /tmp
		echo -e "\n[archlinuxfr]\nServer = http://repo.archlinux.fr/x86_64" >> /etc/pacman.conf
		$PACMAN -Sy
	fi
	return
}

install()
{
	set -v
	$PACMAN -S $1
	set +v
}

afterInstall()
{
	if [[ 'pacman-color' == $1 ]]; then
		F_PM_COLOR=`pacman-color` && F_PACMAN=`which pacman` && mv $F_PACMAN $F_PACMAN.origin && ln -s $F_PM_COLOR $F_PACMAN
	fi
}

CF_FG_Y='\e[36;1m'
CF_FG_R='\e[30;42m'
CF_UNDERLINE='\e[36;4m'
CF_RESET='\e[0m'


ARR_PACMAN=(
vim tmux git
#bash-completion pacman-optimize
abs yaourt aurvote customizepkg
repacman pacman-color
vifm feh
elinks wget rtorrent dnsmasq
#esmtp msmtp nbsmtp ssmtp
ttf-arphic-ukai ttf-arphic-uming ttf-fireflysung ttf-hannom-usong ttf-dejav ttf-bitstream-vera
libgl mesa xorg xf86-video-ati ati-dri
lxde obconf obmenu
)
#CNT=${#ARR_PACMAN[@]}
ARR_YAOURT=(
rankmirrors
opera-static
)

#---------------------------------------------------------------------
#pacman -Syu

PACMAN=`which powerpill 2>/dev/null`
if (( 0 != $? )); then
	echo -e "Would you like to ${CF_FG_Y}I${CF_RESET}nstall ${CF_FG_R}powerpill${CF_RESET} and use it instead of pacman?(${CF_UNDERLINE}y/n${CF_RESET})"
	read yn
	if [[ 'n' != $yn && 'no' != $yn ]]; then
		pacman -S powerpill
		PACMAN=`which powerpill 2>/dev/null`
	fi
fi
[[ -z $PACMAN ]] && PACMAN='pacman'


for i in ${ARR_PACMAN[@]}
do
	pacman -Q $i &>/dev/null
	[[ 0 == $? ]] && echo -e "\e[32;7m$i\e[0m has been installed,contine..." && continue

	echo -e "Would you like to ${CF_FG_Y}I${CF_RESET}nstall ${CF_FG_R}$i${CF_RESET}?(${CF_UNDERLINE}y/n${CF_RESET})"
	read yn
	[[ 'n' == $yn || 'no' == $yn ]] && continue
	
	beforeInstall $i
	(( 0 == $? )) && $PACMAN -S $i && afterInstall $i

	if (( 0 == $? )); then
		echo -e "\e[1m\e[32;4mSuccess to $PACMAN $i.\e[0m"
	else
		echo -e "\e[31;7mFail to $PACMAN $i.\e[0m"
	fi
done


[[ ! -x `which yaourt 2>/dev/null` ]] && exit
for i in ${ARR_YAOURT[@]}
do
	yaourt -Q $i &>/dev/null
	[[ 0 == $? ]] && echo -e "\e[32;7m$i\e[0m has been installed,contine..." && continue

	echo -e "Would you like to ${CF_FG_Y}I${CF_RESET}nstall ${CF_FG_R}$i${CF_RESET}?(${CF_UNDERLINE}y/n${CF_RESET})"
	read yn
	[[ 'n' == $yn || 'no' == $yn ]] && continue
	
	beforeInstall $i
	(( 0 == $? )) && yaourt -S $i && afterInstall $i

	if (( 0 == $? )); then
		echo -e "\e[1m\e[32;4mSuccess to $PACMAN $i.\e[0m"
	else
		echo -e "\e[31;7mFail to $PACMAN $i.\e[0m"
	fi
done
