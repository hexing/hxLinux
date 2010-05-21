#!/bin/sh

ping -c 1 192.168.1.1 || exit

MY_IP=`sh /usr/local/sbin/getip.sh`
F_IP='/tmp/myIP.txt'
if [ -r $F_IP ]; then
	grep "$MY_IP" "$F_IP" >/dev/null && exit
fi
python /usr/local/sbin/sendmail.py "$MY_IP" && echo $MY_IP > $F_IP
