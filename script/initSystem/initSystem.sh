#!/bin/sh

DIR_HX_SCRIPT=../
DIR_HX_FUNCTION="$DIR_HX_SCRIPT/utility/functions"
. "$DIR_HX_FUNCTION/confirm.sh" || exit

ask()
{
	MSG='Would you like to '
	MSG="$MSG\e[7m$*"
	MSG="$MSG\e[0m? (y/n)"
	confirm $MSG
}

sed_awk_app()
{
	[[ -f $F_TARGET ]] && cp $F_TARGET $F_TARGET~
	echo $TAG_BEG >> $F_TARGET
	echo "\"\e[A\": history-search-backward" >> $F_TARGET
	echo "\"\e[B\": history-search-forward" >> $F_TARGET
	echo $TAG_END >> $F_TARGET
}

sed_awk_del()
{
	echo 'delete'
}

#[[ -l /bin/sh ]] && ln -fs /bin/dash /bin/sh
