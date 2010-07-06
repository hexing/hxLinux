#!/bin/sh

HX_LINUX=/opt/hxLinux


DIR_TO=/usr/local/sbin
HX_HOME="$HX_LINUX/script/utility"
F_LIST=(
getip.sh
canShutdown.sh
shutdown.sh
deliverIP.sh
reboot.sh
)

for i in ${F_LIST[@]}; do
	if [ ! -e $HX_HOME/$i ]; then
		echo -e "\e[31;4m$HX_HOME/$i does not exist! Would you like to continue?(Y/n)\e[0m"
		read answer
		[ -z $answer ] || [ 'y' == $answer ] || [ 'Y' == $answer ] && continue
		exit 1
	fi

	DIR=$(dirname $i)
	[ -e $DIR ] && [ ! -d $DIR ] && echo -e "\e[31;4m$DIR exist! And $DIR is not a directory.\e[0m" && exit 2
	[ ! -e $DIR ] && (mkdir -p $DIR || (echo -e "\e[31;4mCan't mkdir $DIR.\e[0m" && exit 2))

	ln -is $HX_HOME/$i $DIR_TO/$i
	if [ 0 -ne $? ]; then
		echo -e "\e[31;4mCan't ln $HX_HOME/$i! Would you like to continue?(Y/n)\e[0m"
		read answer
		[ -z $answer ] || [ 'y' == $answer ] || [ 'Y' == $answer ] && continue
		exit 1
	fi
done
