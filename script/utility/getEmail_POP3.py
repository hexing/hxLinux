#!/usr/bin/python
#coding=utf-8


import poplib
import os,sys


def connPop3(host, port, usr, pwd):
	try:
		p = poplib.POP3(host, port)
		p.user(usr)
		p.pass_(pwd)
	except Exception as e:
		p.quit()
		print(e)
		return None
	return p

def getList(pop3):
	l = []
	t = (b'Subject:', b'From:', b'Date:')
	if (pop3):
		numMsgs,totalSize = p.stat()
		for i in range(1, numMsgs+1):
			hdr = pop3.top(i, 0)
			l.append(i)
			for k in hdr[1]:
				for n in t:
					if (0 == k.find(n)):
						l.append(k)
	return len(t)+1,l



if (__name__ == '__main__'):
	if (1 == len(sys.argv)):
		p = connPop3('pop.189.cn', 110, 'hexing20100113@189.cn', 'hexiaoxing')
		n,l = getList(p)

		k = 0
		for i in l:
			print(i)
			k += 1
			if k == n:
				k = 0
				print('*******\n')
	else:
		print('Error arguments!')
		if (p):
			numMsgs, totalSize = p.stat()
			print(numMsgs, totalSize)
			for i in range(1, numMsgs+1):
				hdr = p.top(i, 0)
				for k in hdr[1]:
					print(k)
				print('\n\n\n')
