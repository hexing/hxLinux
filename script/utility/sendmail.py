#!/usr/bin/python
#coding=utf-8

from email.MIMEMultipart import MIMEMultipart
from email.MIMEText import MIMEText
from email.MIMEImage import MIMEImage
import email.Utils
from email.Header import Header
import smtplib
import datetime
import locale
import os
import sys
import base64
 


def buildEMail(toAddr, fromAddr, subject, mailContent, encode = "utf-8", type = "plain", files = []):
	mail = MIMEMultipart()
	#mail['To'] = ','.join(toAddr)
	mail['To'] = toAddr
	mail['From'] = fromAddr
	mail['Subject'] = Header(subject, "utf-8")
	mail['Date'] = email.Utils.formatdate(localtime=True)

	body = MIMEText(mailContent, type, encode)
	mail.attach(body)

	if (0 < len(files)):
		if (False == addAttachments(mail, files)):
			return False
	
	return mail


def addAttachments(mail, files):
	try:
		for f in files:
			s = open(f, "rb").read()

			attachment = MIMEText(s, 'base64', 'utf-8')
			#attachment = MIMEText(s, 'base64', 'gbk')
			fn = os.path.basename(f)
			fn = Header(fn, 'utf-8')
			#attachment.replace_header('Content-type','Application/octet-stream;name="%s"' % fn)
			#attachment.add_header('Content-Disposition','attachment;filename="%s"' % fn)
			attachment["Content-Type"] = 'application/octet-stream'
			attachment["Content-Disposition"] = 'attachment; filename="%s"' % fn
			mail.attach(attachment)
	except:
		print("Can't attach file:'" + os.path.basename(f))
		return False

	return True


def sendEmail_gmail(mail, usr = "hexing.net", pwd = "hexinglq"):
	fromAddr = mail["From"]
	toAddr = mail["To"]
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
		#print ("Failed to diliver email:" + mail["To"])
		#print ("Failed to diliver email:" + mail.as_string())
		return False

	#print('Success to diliver email:' + toAddr)
	return True


def sendMail_gmail(toAddr, subject, mailContent,
		encode = "utf-8", type = "plain",
		usr = "hexing.net", pwd = "hexinglq",
		files = []):
	fromAddr = 'hexing.net@gmail.com'
	mail = buildEMail(toAddr, fromAddr, subject, mailContent, encode, files = files)

	return sendEmail_gmail(mail, usr, pwd)


def sendEmail_189(mail, usr = "hexing.net", pwd = "hexinglq"):
	fromAddr = mail["From"]
	toAddr = mail["To"]
	isTls = False
	smtp = 'smtp.189.cn'
	port = '25'
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


def sendMail_189(toAddr, subject, mailContent,
		encode = "utf-8", type = "plain",
		usr = "hexing20100113@189.cn", pwd = "hexiaoxing",
		files = []):
	fromAddr = 'hexing20100113@189.cn'
	mail = buildEMail(toAddr, fromAddr, subject, mailContent, encode, files = files)

	return sendEmail_189(mail, usr, pwd)



def sendMail(mailContent):
	toAddr = '18939771309@189.cn'
	subject = 'My Address IP'
	sendMail_189(toAddr, subject, mailContent)
	#sendMail_gmail(toAddr, subject, mailContent)
	#sendMail_189("18939771309@189.cn", "工资单 20101111-lili",  "工资单 20101111-lili", files = ["./何幸.7z"])
	#sendMail_189("hexing.job@gmail.com", "工资单 20101111-mimi",  "工资单 20101111-mimi", files = ["./何幸.7z"])
	#sendMail_gmail("hexing.job@gmail.com", "工资单 20101111-lulu",  "工资单 20101111-lulu", files = ["./何幸.7z"])
	#sendMail_gmail("18939771309@189.cn", "工资单 20101111a-neo",  "工资单 20101111a-neo", files = ["./何幸.7z"])



if __name__ == '__main__':
	if (2 == len(sys.argv)):
		sendMail(sys.argv[1])
	else:
		print(len(sys.argv))
