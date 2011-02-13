#!/usr/bin/python
#coding=utf-8

from email.mime.multipart import MIMEMultipart
from email.mime.text import MIMEText
from email.mime.image import MIMEImage
import email.utils
from email.header import Header
import smtplib
import datetime
import locale
import os
import sys
import base64
 


def buildEMail(toAddr, fromAddr, subject, mailContent,
		encode="utf-8", type="plain", files=None):
	mail = MIMEMultipart()
	#mail['To'] = ','.join(toAddr)
	mail['To'] = toAddr
	mail['From'] = fromAddr
	mail['Subject'] = Header(subject, "utf-8")
	mail['Date'] = email.utils.formatdate(localtime=True)

	body = MIMEText(mailContent, type, encode)
	mail.attach(body)

	if (None != files):
		if (False == addAttachments(mail, files)):
			return None
	
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
		print("Can't attach file:'" + os.path.basename(f), file=sys.stderr)
		return False

	return True


def connSmtp_gmail(username, password):
	host = 'smtp.gmail.com'
	port = 587
	isTls = True
	usr = username
	pwd = password

	try:
		svr = smtplib.SMTP(host, port)
		if isTls:
			svr.starttls()
		svr.login(usr, pwd)
	except:
		return None
	return svr


def sendEmail_gmail(mail, username="hexing.net", password="hexinglq"):
	svr = connSmtp_gmail(username, password)
	if None == svr :
		return False

	fromAddr = mail["From"]
	toAddr = mail["To"]

	try:
		svr.sendmail(fromAddr, toAddr, mail.as_string())
		svr.quit()
	#except smtplib.SMTPHeloError as e:
	#	print('SMTPHeloError', file=sys.stderr)
	#except smtplib.SMTPRecipientsRefused as e:
	#	print('SMTPRecipientsRefused', file=sys.stderr)
	#except smtplib.SMTPSenderRefused as e:
	#	print('SMTPSenderRefused', file=sys.stderr)
	#except smtplib.SMTPDataError as e:
	#	print('SMTPDataError', file=sys.stderr)
	except:
		print ("Failed to diliver email:" + mail["To"], file=sys.stderr)
		print(sys.exc_info()[0], file=sys.stderr)
		#print ("Failed to diliver email:" + mail.as_string(), file=sys.stderr)
		return False

	#print('Success to diliver email:' + toAddr, file=sys.stderr)
	return True


def connSmtp_189(username, password):
	host = 'smtp.189.cn'
	port = 25
	isTls = False
	usr = base64.standard_b64encode(username.encode()).decode()
	pwd = base64.standard_b64encode(password.encode()).decode()

	try:
		svr = smtplib.SMTP(host, port)
		#svr.set_debuglevel(1)
		if isTls:
			svr.starttls()
		svr.ehlo_or_helo_if_needed()
		svr.docmd("AUTH", "LOGIN")
		svr.docmd(usr)
		svr.docmd(pwd)
	except:
		return None
	return svr


def sendEmail_189(mail, username="hexing20100113@189.cn", password="hexiaoxing"):
	svr = connSmtp_189(username, password)
	if None == svr :
		return False

	fromAddr = mail["From"]
	toAddr = mail["To"]

	try:
		svr.sendmail(fromAddr, toAddr, mail.as_string())
		svr.quit()
	except:
		print("Failure to diliver email:" + toAddr, file=sys.stderr)
		print(sys.exc_info()[0], file=sys.stderr)
		return False

	#print('Success to diliver email:' + toAddr, file=sys.stderr)
	return True


def sendMail(mailContent):
	toAddr = '18939771309@189.cn'
	subject = 'My Address IP'

	#fromAddr = 'hexing.net@gmail.com'
	#mail = buildEMail(toAddr, fromAddr, subject, mailContent)
	##toAddr = "hexing.job@gmail.com"
	##subject = "工资单 20101111"
	##fromAddr = 'hexing.net@gmail.com'
	##files = ["./何幸.7z"]
	##mail = buildEMail(toAddr, fromAddr, subject, mailContent, files=files)
	#usr = "hexing.net"
	#pwd = "hexinglq"
	#return sendEmail_gmail(mail, usr, pwd)

	fromAddr = 'hexing20100113@189.cn'
	mail = buildEMail(toAddr, fromAddr, subject, mailContent)
	usr = "hexing20100113@189.cn"
	pwd = "hexiaoxing"
	return sendEmail_189(mail, usr, pwd)



if __name__ == '__main__':
	if (2 == len(sys.argv)):
		sendMail(sys.argv[1])
	elif (5 == len(sys.argv)):
		toAddr = sys.argv[1]
		subject = sys.argv[2]
		mailContent = sys.argv[3]
		attachFiles = sys.argv[4]

		fromAddr = 'hexing.net@gmail.com'
		mail = buildEMail(toAddr, fromAddr, subject, mailContent, files=[attachFiles])
		usr = "hexing.net"
		pwd = "hexinglq"
		if False == sendEmail_gmail(mail, usr, pwd):
			exit(1)
	else:
		print(len(sys.argv))
