#!/bin/sh

ps aux | grep -E 'rtorrent' >/dev/null
[ -z $? ] && echo -e '[\e[1m\e[33;5mWARNING\e[0m] \e[33mrtorrent is running!\e[0m' && exit 1

[ -d /tmp/rtorrent ]  && echo -e '[\e[1m\e[33;5mWARNING\e[0m] \e[33m/tmp/rtorrent exists!\e[0m' &&  exit 2

exit 0
