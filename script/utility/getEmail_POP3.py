#!/usr/bin/python
#coding=utf-8


import poplib,email.header,email.message
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
	try:
		if (pop3):
			numMsgs,totalSize = pop3.stat()
			for i in range(1, numMsgs+1):
				m = {}
				m['Id'] = i
				hdr = pop3.top(i, 0)
				for k in hdr[1]:
					if (0 == k.find(b'Subject: ')):
						k = k.replace(b'Subject: ', b'')
						s = k.decode()
						try:
							v = email.header.decode_header(s)
							m['Subject'] = v[0][0].decode(v[0][1])
						except:
							m['Subject'] = s
					elif (0 == k.find(b'From:')):
						m['From'] = k.decode()
					elif (0 == k.find(b'Date:')):
						m['Date'] = k.decode()
				l.append(m)
	except:
		return None
	return l

def printSubjectList(pop3):
	l = getList(p)
	if l:
		for i in l:
			print('#' + str(i['Id']))
			print(i['Subject'])
			print(i['Date'])
			print(i['From'])
			print('*******\n')

def getEmailContent(pop3, id):
	s = ''
	r = pop3.retr(id)
	if r:
		lines = r[1]
		for i in lines:
			s += i.decode()
			s += '\n'

		msg = email.message_from_string(s)
		s = ''
		if msg:
			for k in msg.walk():
				if k.is_multipart(): 
					continue

				ch = k.get_content_charset()#k.get_charset()
				if ch: 
					#s += unicode(k.get_payload(decode = True),ch).encode('utf-8') 
					#s += k.get_payload(decode = True).decode('gb2312').encode('utf-8')
					s += k.get_payload(decode = True).decode()
				else: 
					#s += k.get_payload(decode = True).decode('gb2312').encode('utf-8')
					s += k.get_payload(decode = True).decode()

		return s




if (__name__ == '__main__'):
	if (1 == len(sys.argv)):
		p = connPop3('pop.189.cn', 110, 'hexing20100113@189.cn', 'hexiaoxing')
		if (None == p):
			exit()
		printSubjectList(p)

		while True:
			sCmd = input('input the command(List/Read/Delete/Quit):')
			if 'List'==sCmd or 'L'==sCmd:
				printSubjectList(p)
			elif 'Read'==sCmd or 'R'==sCmd:
				sCmd = input('type the id:')
				if sCmd.isdigit():
					n = int(sCmd)
					print(getEmailContent(p, n))
			elif 'Delete'==sCmd or 'D'==sCmd:
				sCmd = input('type the id:')
				if sCmd.isdigit():
					n = int(sCmd)
					p.dele(n)
			elif 'Quit'==sCmd or 'Q'==sCmd or ''==sCmd:
				break

		p.quit()
	else:
		print('Error arguments!')
