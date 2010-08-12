#!/bin/sh

[ 0 -eq $# ] && echo -e "which directory is to be initialized?" && exit 1

DIR_HOME=$1
[ ! -d $DIR_HOME ] && echo -e "$DIR_HOME is not a directory!" && exit 2

HX_LINUX=/opt/hxLinux
HX_SCRIPT=$HX_LINUX/script
HX_INITSYSTEM=$HX_SCRIPT/initSystem

HX_HOME="$HX_LINUX/root"
F_LIST=(
.ssh/id_rsa
.ssh/id_rsa.pub
)

for i in ${F_LIST[@]}; do
	if [ ! -e $HX_HOME/$i ]; then
		echo -e "\e[31;4m$HX_HOME/$i does not exist! Would you like to continue?(Y/n)\e[0m"
		read answer
		[ -z $answer ] || [ 'y' == $answer ] || [ 'Y' == $answer ] && continue
		exit 3
	fi

	DIR_TO=$DIR_HOME/$(dirname $i)
	[ -e $DIR_TO ] && [ ! -d $DIR_TO ] && echo -e "\e[31;4m$DIR_TO exist! And $DIR_TO is not a directory.\e[0m" && exit 4
	[ ! -e $DIR_TO ] && (mkdir -p $DIR_TO || (echo -e "\e[31;4mCan't mkdir $DIR_TO.\e[0m" && exit 5))

	ln -is $HX_HOME/$i $DIR_HOME/$i
	if [ 0 -ne $? ]; then
		echo -e "\e[31;4mCan't ln $HX_HOME/$i! Would you like to continue?(Y/n)\e[0m"
		read answer
		[ -z $answer ] || [ 'y' == $answer ] || [ 'Y' == $answer ] && continue
		exit 6
	fi
done

sh $HX_INITSYSTEM/initUsrLocalSbin.sh || exit 7
sh $HX_INITSYSTEM/initHome.sh $DIR_HOME || exit 8

echo -e "Success to compelete."
