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
 


def sendMail_gmail(toAddr, subject, mailContent, encode = "utf-8", type = "plain", usr = "hexing.net", pwd = "hexinglq"):
	fromAddr = 'hexing.job@gmail.com'

	mail = MIMEMultipart()
	#mail['To'] = ','.join(toAddr)
	mail['To'] = toAddr
	mail['From'] = fromAddr
	mail['Subject'] = subject
	mail['Date'] = email.Utils.formatdate(localtime=1)

	body = MIMEText(mailContent, type, encode)
	mail.attach(body)

	isTls = True
	smtp = 'smtp.gmail.com'
	port = '587'
	username = usr
	password = pwd

	try:
		svr = smtplib.SMTP(smtp, port)
		if isTls:
			svr.starttls()
		svr.login(username, password)

		svr.sendmail(fromAddr, toAddr, mail.as_string())
		svr.quit()
	except:
		#print ("Failed to diliver email:" + toAddr)
		return False

	#print('Success to diliver email:' + toAddr)
	return True


def sendMail_189(toAddr, subject, mailContent, encode = "utf-8", type = "plain", usr = "hexing20100113@189.cn", pwd = "hexiaoxing"):
	fromAddr = 'hexing20100113@189.cn'

	mail = MIMEMultipart()
	#mail['To'] = ','.join(toAddr)
	mail['To'] = toAddr
	mail['From'] = fromAddr
	mail['Subject'] = subject
	mail['Date'] = email.Utils.formatdate(localtime=1)

	body = MIMEText(mailContent, type, encode)
	mail.attach(body)

	isTls = False
	smtp = 'smtp.189.cn'
	port = '25'
	#username = fromAddr
	#password = 'hexiaoxing'
	username = base64.encodestring(usr)
	password = base64.encodestring(pwd)
	username = username[0:len(username)-1]
	password = password[0:len(password)-1]

	try:
		svr = smtplib.SMTP(smtp, port)
		#svr.set_debuglevel(1)
		if isTls:
			svr.starttls()
		svr.ehlo_or_helo_if_needed()
		svr.docmd("AUTH", "LOGIN")
		svr.docmd(username)
		svr.docmd(password)

		svr.sendmail(fromAddr, toAddr, mail.as_string())
		svr.quit()
	except:
		#print("Failure to diliver email:" + toAddr)
		return False

	#print('Success to diliver email:' + toAddr)
	return True


def sendMail(mailContent):
	toAddr = '18939771309@189.cn'
	subject = 'My Address IP'
	sendMail_189(toAddr, subject, mailContent)


if __name__ == '__main__':
	if (2 == len(sys.argv)):
		sendMail(sys.argv[1])
	else:
		print(len(sys.argv))
