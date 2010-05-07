#!/usr/bin/python

from email.MIMEMultipart import MIMEMultipart
from email.MIMEText import MIMEText
from email.MIMEImage import MIMEImage
import email.Utils
import smtplib
import datetime
import locale
import os
import sys
import base64
 

def sendMail(mailContent):
	fromAddr = 'hexing20100113@189.cn'
	toAddr = '18939771309@189.cn'

	mail = MIMEMultipart()
	mail['To'] = ','.join(toAddr)
	mail['From'] = fromAddr
	mail['Subject'] = 'My Address IP'
	mail['Date'] = email.Utils.formatdate(localtime=1)

	body = MIMEText(mailContent, 'plain', 'utf-8')
	mail.attach(body)

	isTls = False
	smtp = 'smtp.189.cn'
	port = '25'
	username = fromAddr
	password = 'hexiaoxing'
	username = base64.encodestring(username)
	password = base64.encodestring(password)
	username = username[0:len(username)-1]
	password = password[0:len(password)-1]
	svr = smtplib.SMTP(smtp, port)
	#svr.set_debuglevel(1)
	if isTls:
		svr.starttls()
	svr.ehlo_or_helo_if_needed()
	svr.docmd("AUTH", "LOGIN")
	svr.docmd(username)
	svr.docmd(password)

	#isTls = True
	#smtp = 'smtp.gmail.com'
	#port = '587'
	#username = 'hexing.net'
	#password = 'hexinglq'
	#svr = smtplib.SMTP(smtp, port)
	#if isTls:
	#	svr.starttls()
	#svr.login(username, password)

	svr.sendmail(fromAddr, toAddr, mail.as_string())
	svr.quit()

	print('Success to diliver email.')


if __name__ == '__main__':
	if (2 == len(sys.argv)):
		sendMail(sys.argv[1])
	else:
		print(len(sys.argv))
