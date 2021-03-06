#!/bin/sh

ping -c 1 192.168.1.1 &>/dev/null || exit

HX_BIN=$(dirname "$0")
MY_IP=`sh $HX_BIN/getip.sh` || exit
F_IP='/tmp/myIP.txt'
if [ -r $F_IP ]; then
	grep "$MY_IP" "$F_IP" >/dev/null && exit
fi
python $HX_BIN/sendEmail.py "$MY_IP" && echo $MY_IP > $F_IP
