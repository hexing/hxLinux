#!/bin/sh

if [ 2 -ne $# ] && [ 3 -ne $# ]; then
	echo -e 'USAGE:'
	echo  -e '\thxtar c xxx.tar.xx xxx'
	echo  -e '\thxtar x xxx.tar.xx'
	exit 1
fi

Z_7z()
{
	#set -x
	7zr a -si "$1" -t7z -ms=on -mfb=64 -mx=9 -md=32m -m0=lzma
	#set +x
}

TAR=$(which tar 2>/dev/null) || TAR=`which bsdtar 2>/dev/null` || exit 2
EXT=$2
EXT=${EXT##*.}

#file=/dir1/dir2/dir3/my.file.txt
#我们可以用 ${ } 分别替换获得不同的值：
#${file#*/}：拿掉第一条 / 及其左边的字符串：dir1/dir2/dir3/my.file.txt
#${file##*/}：拿掉最后一条 / 及其左边的字符串：my.file.txt
#${file#*.}：拿掉第一个 .  及其左边的字符串：file.txt
#${file##*.}：拿掉最后一个 .  及其左边的字符串：txt
#${file%/*}：拿掉最后条 / 及其右边的字符串：/dir1/dir2/dir3
#${file%%/*}：拿掉第一条 / 及其右边的字符串：(空值)
#${file%.*}：拿掉最后一个 .  及其右边的字符串：/dir1/dir2/dir3/my.file
#${file%%.*}：拿掉第一个 .  及其右边的字符串：/dir1/dir2/dir3/my

#Extract
if [ 2 -eq $# ]; then
	[ 'x' != $1 ] && exit 3
	F_TAR=$2
#Archive
elif [ 3 -eq $# ]; then
	[ 'c' != $1 ] && exit 4
	F_TAR=$2
	SRC=$3
	EXEC_TAR="$TAR -cf - $SRC"

	if [ -e "$F_TAR" ]; then
		echo -e "$F_TAR has exists!"
		exit 5
	elif [ '7z' == $EXT ]; then
		$EXEC_TAR | Z_7z $F_TAR
	elif [ 'xz' == $EXT ]; then
		$EXEC_TAR | xz -z -7 - $F_TAR
	fi
fi
