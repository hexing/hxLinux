[ 0 -eq $# ] && echo -e "which directory is to be initialized?" && exit 1

DIR_HOME=$1
[ ! -d $DIR_HOME ] && echo -e "$DIR_HOME is not a directory!" && exit 2

HX_LINUX=/opt/hxLinux

HX_HOME="$HX_LINUX/home"
F_LIST=(
.bash_profile
.bashrc
.config/.aurvote
.config/fcitx/config
.config/fcitx/sp.dat
#.config/openbox
.fonts
.gitconfig
.inputrc
.opera/bookmarks.adr
.opera/keyboard
.rtorrent.rc
.themes
.vim
.xinitrc
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
	[ ! -e $DIR_TO ] && (mkdir -p $DIR_TO && chmod a=rwx $DIR_TO || (echo -e "\e[31;4mCan't mkdir $DIR_TO.\e[0m" && exit 5))

	ln -is $HX_HOME/$i $DIR_HOME/$i
	if [ 0 -ne $? ]; then
		echo -e "\e[31;4mCan't ln $HX_HOME/$i! Would you like to continue?(Y/n)\e[0m"
		read answer
		[ -z $answer ] || [ 'y' == $answer ] || [ 'Y' == $answer ] && continue
		exit 6
	fi
done

echo -e "Success to compelete."
