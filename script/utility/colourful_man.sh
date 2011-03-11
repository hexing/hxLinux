#!/usr/bin/sh

vman() {
	export PAGER="/bin/sh -c \"unset PAGER;col -b -x | \
		vim -R -c 'set ft=man nomod nolist' -c 'map q :q<CR>' \
		-c 'map <SPACE> <C-D>' -c 'map b <C-U>' \
		-c 'nmap K :Man <C-R>=expand(\\\"<cword>\\\")<CR><CR>' -\""

	#invoke man page
	man $*
	#we muse unset the PAGER, so regular man pager is used afterwards
	unset PAGER
}

vman $*

#另一个办法？
#export LESSTERMCAPmb=$'\E[01;31m'
#export LESSTERMCAPmd=$'\E[01;31m'
#export LESSTERMCAPme=$'\E[0m'
#export LESSTERMCAPse=$'\E[0m'
#export LESSTERMCAPso=$'\E[01;44;33m'
#export LESSTERMCAPue=$'\E[0m'
#export LESSTERMCAPus=$'\E[01;32m'
