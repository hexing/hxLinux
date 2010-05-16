#!/bin/sh

if [ -z "$*" ]; then
	curl -s members.3322.org/dyndns/getip #19.6ms
	#curl -s ip.appspot.com #68.6ms
	#curl -s checkip.dyndns.org | grep -Eo '[0-9|.]*' #128ms
	exit
fi

IP=`ping -c 1 "$*" | grep -Eo -m 1 '[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}'`
[ '218.83.175.155' = "$IP" ] && echo "Error domain!" && exit
echo "$IP"
grep -E -m 1 "$IP\s+$*" /etc/hosts >/dev/null
[ 0 -ne $? ] && echo "$IP\t$*" >> /etc/hosts
