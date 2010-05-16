#!/bin/sh

DIRS="/usr/{bin,lib,share,share/{man,doc,applications}} /etc"
changMode()
{
	eval chmod $1 $DIRS
	eval ls -ld $DIRS
}

if [[ '-y' == $1 ]]; then
	changMode o+w
elif [[ '-n' == $1 ]]; then
	changMode o-w
else
	echo -e 'Miss the option:-y or -n?'
fi
