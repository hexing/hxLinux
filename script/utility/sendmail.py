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
		print("Can't attach file:'" + os.path.basename(f))
		return False

	return True


def sendEmail_gmail(mail, usr="hexing.net", pwd="hexinglq"):
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
	#except smtplib.SMTPHeloError as e:
	#	print('SMTPHeloError')
	#except smtplib.SMTPRecipientsRefused as e:
	#	print('SMTPRecipientsRefused')
	#except smtplib.SMTPSenderRefused as e:
	#	print('SMTPSenderRefused')
	#except smtplib.SMTPDataError as e:
	#	print('SMTPDataError')
	except:
		print ("Failed to diliver email:" + mail["To"])
		print(sys.exc_info()[0])
		#print ("Failed to diliver email:" + mail.as_string())
		return False

	#print('Success to diliver email:' + toAddr)
	return True


def sendEmail_189(mail, usr=b"hexing20100113@189.cn", pwd=b"hexiaoxing"):
	fromAddr = mail["From"]
	toAddr = mail["To"]
	isTls = False
	smtp = 'smtp.189.cn'
	port = '25'
	username = base64.standard_b64encode(usr).decode('utf-8')
	password = base64.standard_b64encode(pwd).decode('utf-8')

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
		print("Failure to diliver email:" + toAddr)
		print(sys.exc_info()[0])
		return False

	#print('Success to diliver email:' + toAddr)
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
	usr = b"hexing20100113@189.cn"
	pwd = b"hexiaoxing"
	return sendEmail_189(mail, usr, pwd)



if __name__ == '__main__':
	if (2 == len(sys.argv)):
		sendMail(sys.argv[1])
	else:
		print(len(sys.argv))
