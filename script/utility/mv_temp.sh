#!/bin/sh

#set -x
[[ 0 -eq $# ]] && echo '0 == $#' && exit
[[ 1 -ne $# ]] && echo '1 != $#' && exit

SRC=$1
BN=`basename "$SRC"`

TEMP=/tmp
echo "cp -Rp $SRC $TEMP ......"
cp -Rp "$SRC" "$TEMP" && echo 'Success'
if [[ 0 -ne $? ]];then
	echo "Error occured when cp $SRC $TEMP"
	exit
fi

MV_TEMP="$TEMP"/"$BN"
#DEST=/mnt/sda12/bios
DEST=/mnt/sda10/bios06
echo "mv $MV_TEMP $DEST ......"
mv "$MV_TEMP" "$DEST" && echo 'Success'
if [[ 0 -ne $? ]];then
	echo "Error occured when mv $MV_TEMP $DES"
	exit
fi

echo "rm -fr $SRC ......"
rm -fr "$SRC" && echo 'Success' || echo "Error occured when rm $SRC"
#set +x
