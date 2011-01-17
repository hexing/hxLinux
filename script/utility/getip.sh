#!/bin/sh

arr=(
'www.bliao.com/ip.phtml'
'www.net.cn/static/customercare/yourIP.asp'
'www.ip138.com/ip2city.asp'
#'whois.ipcn.org'
'www.dheart.net/ip'
'members.3322.org/dyndns/getip' #19.6ms
'www.whereismyip.com'
'www.sz800.com/haoserver/ipself.asp'
'ip.appspot.com' #68.6ms
'checkip.dyndns.org' #128ms
#'myip.haitundao.com:88',
#'www.haitundao.com/ip',
#'www.ip138.com',
)

if [ -z "$*" ]; then
	for i in ${arr[@]}; do
		#[ 0 -eq $? ] && exit
		IP=$(curl -s $i | grep -Eo -m 1 '([0-9]{1,3}\.){3}[0-9]{1,3}')
		[ -z "$IP" ] && continue
		echo $HOSTNAME $IP
		break
	done
	exit
fi

IP=`ping -c 1 "$*" | grep -Eo -m 1 '([0-9]{1,3}\.){3}[0-9]{1,3}'`
[ '218.83.175.155' = "$IP" ] && echo "Error domain!" && exit
echo "$IP"
grep -E -m 1 "$IP\s+$*" /etc/hosts >/dev/null
[ 0 -ne $? ] && echo -e "$IP\t$*" >> /etc/hosts
