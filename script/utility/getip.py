#!/usr/bin/python
#coding=utf-8

import urllib.request, re, sys
import socket



arr = (
'www.bliao.com/ip.phtml',
'www.net.cn/static/customercare/yourIP.asp',
'www.ip138.com/ip2city.asp',
#'whois.ipcn.org',
'www.dheart.net/ip',
'members.3322.org/dyndns/getip', #19.6ms
'www.whereismyip.com',
'www.sz800.com/haoserver/ipself.asp',
'ip.appspot.com', #68.6ms
'checkip.dyndns.org', #128ms
#'myip.haitundao.com:88',
#'www.haitundao.com/ip',
#'www.ip138.com',
)

def getMyIP():
	s = ''
	for i in arr:
		try:
			f = urllib.request.urlopen('http://' + i)
			bytes = f.read()
			m = re.search(b'(\d{1,3}\.){3}\d{1,3}', bytes)
			if m:
				s = m.group(0).decode('ascii')
			else:
				continue
			break
		except:
			continue
	return s



if (__name__ == "__main__"):
	if (1 == len(sys.argv)):
		print(socket.gethostname() + '\t' + getMyIP())
	else:
		for i in sys.argv[1:]:
			print(i + '\t' + socket.gethostbyname(i))
		#print(socket.gethostbyname(socket.gethostname()))
		#print(socket.gethostbyname_ex(socket.gethostname()))
