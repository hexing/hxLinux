#!/bin/sh

[ 0 -eq $# ] && echo -e "which directory is to be initialized?" && exit 1

DIR_ETC=$1
[ ! -d $DIR_ETC ] && echo -e "$DIR_ETC is not a directory!" && exit 2

HX_LINUX=/opt/hxLinux

HX_ETC="$HX_LINUX/etc"
F_LIST=(
dnsmasq.resolv.conf
hosts
hosts.allow
hx-shrc
inittab
makepkg.conf
pacman.conf
pacman.d/mirrorlist
resolv.conf
vimrc
)

for i in ${F_LIST[@]}; do
	if [ ! -e $HX_ETC/$i ]; then
		echo -e "\e[31;4m$HX_ETC/$i does not exist! Would you like to continue?(Y/n)\e[0m"
		read answer
		[ -z $answer ] || [ 'y' == $answer ] || [ 'Y' == $answer ] && continue
		exit 3
	fi

	DIR_TO=$DIR_ETC/$(dirname $i)
	[ -e $DIR_TO ] && [ ! -d $DIR_TO ] && echo -e "\e[31;4m$DIR_TO exist! And $DIR_TO is not a directory.\e[0m" && exit 4
	[ ! -e $DIR_TO ] && (mkdir -p $DIR_TO && chmod a=rwx $DIR_TO || (echo -e "\e[31;4mCan't mkdir $DIR_TO.\e[0m" && exit 5))

	ln -is $HX_ETC/$i $DIR_ETC/$i
	if [ 0 -ne $? ]; then
		echo -e "\e[31;4mCan't ln $HX_ETC/$i! Would you like to continue?(Y/n)\e[0m"
		read answer
		[ -z $answer ] || [ 'y' == $answer ] || [ 'Y' == $answer ] && continue
		exit 6
	fi
done

echo -e "Success to compelete."
