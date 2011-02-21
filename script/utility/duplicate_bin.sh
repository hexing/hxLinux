#!/usr/bin/sh

DIR_BACKUP=/tmp/Duplicate

fDIFF() {
	diff $1 $2 &>/dev/null
	if [ 0 -eq $? ]; then
		echo $1 == $2
	else
		echo $1 != $2
	fi
}

for i in $(find /bin -type f); do
	bf=$(basename $i)
	ub=/usr/bin/$bf
	ulb=/usr/local/bin/$bf

	if [ -e $ub ]; then
		fDIFF $i $ub
		if [ -e $ulb ]; then
			fDIFF $i $ulb
			fDIFF $ub $ulb
		fi
	elif [ -e $ulb ]; then
		fDIFF $i $ulb
	fi
done
