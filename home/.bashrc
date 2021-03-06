#!/bin/sh

#{{{1 functions
mkDir()
{
	[[ -d "$1" ]] && return 0
	mkdir -p "$1" || echo -e "\e[33m[\e[41;7mERROR\e[0m\e[33m]  \e[4m\e[35;6mCan not mkdir $1!!!\e[0m"
	#mkdir $1 && echo -e "\e[33m[\e[37;41;7mERROR\e[0m\e[33m]  \e[4m\e[35;6mCan not mkdir $1!!!\e[0m"
}


#{{{1 alias
alias ls='ls -AFhp --color=auto --quoting-style=shell'
#alias lx='ls -l -BX' #sort by extension
#alias lz='ls -l -rS' #sort by size
#alias lt='ls -l -rt' #sort by date
#为命令绑定快捷键
#bind -x '"\C-l":ls -l'

alias grep='grep --color=auto -P -Hnu'

alias find_bin='find /{bin,sbin}/ /usr/{bin,sbin,local/{bin,sbin}}/'
alias find_lib='find /lib/ /usr/{lib,local/lib}/'
alias find_pkg='find /var/cache/pacman/pkg/'

HXUTL=/opt/hxLinux/script/utility
HX_SBIN=$HXUTL
alias shutdown="sh $HX_SBIN/shutdown.sh -h +0"
alias reboot="sh $HX_SBIN/reboot.sh"

HX_BIN=$HXUTL
#alias getip="sh $HX_BIN/getip.sh"
alias getip='python /opt/hxLinux/script/utility/getip.py'
alias dict="python $HX_BIN/dict.py"  #|sed -e 's/<em>//g' -e 's/<\/em>//g'

alias du='du -h'
alias df='df -h'
alias cp='cp -ip'
#alias rm='rm -I'
alias rm='rm -i'
alias mv='mv -i'
alias mkdir='mkdir -p'
alias ln='ln -si'
alias tar='tar -lh --suffix=~'
alias echo='echo -e'
alias mount='mount -o defaults,async,noatime,nodiratime'
alias pm='pacman'
alias pmc='pacman-color'
alias pp='powerpill'
alias wget='wget -c'
alias feh='feh --fullscreen --draw-filename'
alias date='date "+%A, %B %d, %Y [%T]"'
alias py='python'
#alias dog='cat'
alias rsync='rsync -zvrbulpgothAX --progress'

alias chown='chown --preserve-root'
alias chmod='chmod --preserve-root'
alias chgrp='chgrp --preserve-root'

#{{{1 /tmp
export MY_TMP_DIR="/tmp/.$USER"
mkDir $MY_TMP_DIR
#export PATH=".:$PATH"
export HISTCONTROL='ignoreboth'
export HISTSIZE=96
export HISTFILESIZE=97
export HISTFILE="$MY_TMP_DIR/.bash_history"
#mkDir `dirname $HISTFILE`
export TMPDIR="$MY_TMP_DIR/bash_tmp"
mkDir $TMPDIR #&& [[ 'root' == $USER ]] && chmod a+w $TMPDIR
[[ -x /usr/bin/vim ]] && export EDITOR=/usr/bin/vim
export LESSHISTFILE=- #/dev/null
export LESSHISTSIZE=9


#{{{1 eval $(dircolors -b)
LS_COLORS='rs=0:di=01;34:ln=01;36:mh=00:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:su=37;41:sg=30;43:ca=30;41:tw=30;42:ow=34;42:st=37;44:ex=01;32'
LS_COLORS="$LS_COLORS:*.tar=01;31:*.tgz=01;31:*.arj=01;31:*.taz=01;31:*.lzh=01;31:*.lzma=01;31:*.tlz=01;31:*.txz=01;31:*.zip=01;31:*.z=01;31:*.Z=01;31:*.dz=01;31:*.gz=01;31:*.lz=01;31:*.xz=01;31:*.bz2=01;31:*.bz=01;31:*.tbz=01;31:*.tbz2=01;31:*.tz=01;31:*.deb=01;31:*.rpm=01;31:*.jar=01;31:*.rar=01;31:*.ace=01;31:*.zoo=01;31:*.cpio=01;31:*.7z=01;31:*.rz=01;31"
LS_COLORS="$LS_COLORS:*.jpg=01;35:*.jpeg=01;35:*.gif=01;35:*.bmp=01;35:*.pbm=01;35:*.pgm=01;35:*.ppm=01;35:*.tga=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.tiff=01;35:*.png=01;35:*.svg=01;35:*.svgz=01;35:*.mng=01;35:*.pcx=01;35"
LS_COLORS="$LS_COLORS:*.mov=01;35:*.mpg=01;35:*.mpeg=01;35:*.m2v=01;35:*.mkv=01;35:*.ogm=01;35:*.mp4=01;35:*.m4v=01;35:*.mp4v=01;35:*.vob=01;35:*.qt=01;35:*.nuv=01;35:*.wmv=01;35:*.asf=01;35:*.rm=01;35:*.rmvb=01;35:*.flc=01;35:*.avi=01;35:*.fli=01;35:*.flv=01;35"
LS_COLORS="$LS_COLORS:*.gl=01;35:*.dl=01;35:*.xcf=01;35:*.xwd=01;35:*.yuv=01;35:*.cgm=01;35:*.emf=01;35"
LS_COLORS="$LS_COLORS:*.axv=01;35:*.anx=01;35:*.ogv=01;35:*.ogx=01;35:*.aac=00;36:*.au=00;36:*.flac=00;36:*.mid=00;36:*.midi=00;36:*.mka=00;36:*.mp3=00;36:*.mpc=00;36:*.ogg=00;36:*.ra=00;36:*.wav=00;36:*.axa=00;36:*.oga=00;36:*.spx=00;36:*.xspf=00;36"
export LS_COLORS


#{{{1 colorful man page
#export PAGER="`which less` -s"
export PAGER="/bin/less -s"
export BROWSER="$PAGER"
export LESS_TERMCAP_mb=$'\E[01;34m'
export LESS_TERMCAP_md=$'\E[01;34m'
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_se=$'\E[0m'
export LESS_TERMCAP_so=$'\E[01;44;33m'
export LESS_TERMCAP_ue=$'\E[0m'
export LESS_TERMCAP_us=$'\E[01;33m'

#{{{1 setleds
if [[ 'linux' == $TERM ]]; then
	#for tty in /dev/tty?; do
	#for tty in /dev/tty{1..3}; do
	#for tty in /dev/tty[1-3]; do
	#	/usr/bin/setleds -D +num < $tty
	#done
	TTY=`ps | /bin/grep tty. -o -m 1`
	if [[ ! -z $TTY ]]; then
		/usr/bin/setleds -D +num < /dev/$TTY
	fi
fi


#set -o vi
#set -o emacs
#setmetamode meta

#Check for an interactive session
[ -z "$PS1" ] && return


#{{{1 PS1
if [[ 'linux' == $TERM ]]; then
	export PS1='\[\e[31m\][\[\e[0m\e[31;1m\]\u\[\e[0m\e[36m\]@ \[\e[32;5m\]\t\[\e[0m\] \[\e[4m\e[34;1m\]\W\[\e[0m\e[31m\]]\[\e[0m\e[33m\]\$\[\e[0m\]'
elif [[ 'xterm' == $TERM ]]; then
	export PS1='\[\e[31m\][\[\e[0m\e[31;1m\]\u\[\e[0m\e[36m\]@ \[\e[4m\e[34;1m\]\W\[\e[0m\e[31m\]]\[\e[0m\e[33m\]\$\[\e[0m\]'
fi

bash_prompt_command() {
	RTN=$?
	smiley=$(smiley $RTN)
	smileyc=$(smileyc $RTN)
}
PROMPT_COMMAND=bash_prompt_command
            
smiley() {
	if [ $1 == 0 ] ; then
		echo ":)"
	else
		echo ":("
	fi
}
smileyc() {
	if [ $1 == 0 ] ; then
		echo $GREEN
	else
		echo $RED
	fi
}
                                                                    
if [ $(tput colors) -gt 0 ] ; then
	RED=$(tput setaf 1)
	GREEN=$(tput setaf 2)
	RST=$(tput op)
fi
PS1="\[\$smileyc\]\$smiley \$RTN$PS1\[$RST\]"

#GENTOO_BASHRC=/opt/hxLinux/home/gentoo-bashrc-2008.0
#[[ -r "$GENTOO_BASHRC" ]] && . $GENTOO_BASHRC
