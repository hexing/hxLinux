#!/usr/bin/python
#vim:fileencoding=utf-8


HX_UTILITY = '/opt/hxLinux/script/utility'
HX_RESUME = '/opt/myPrivateData/milestone/resume.txt'

import sys
sys.path.append(HX_UTILITY)
import sendmail

class JobEmailInfo:
	def __init__(self, toAddr, subject, fromAddr='hexing.job@gmail.com'):
		self.toAddr = toAddr
		self.subject = subject
		self.fromAddr = fromAddr

def getResume():
	f = open(HX_RESUME, 'r', encoding='utf-8')
	sResume = f.read()
	f.close()
	return sResume


if __name__=='__main__':
	myResume = getResume()

	arr = [
			JobEmailInfo('hexing.job@gmail.com,18939771309@189.cn', 'jobEmailInfo-test'),
			]

	for jei in arr:
		print(jei.toAddr)
		print(jei.subject)
		print(jei.fromAddr)
