#!/usr/bin/python
#coding=utf-8

from email.mime.multipart import MIMEMultipart
from email.mime.text import MIMEText
from email.mime.image import MIMEImage
import email.utils
from email.header import Header
import smtplib, base64
import os, sys, datetime, locale, re
 


def buildEMail(toAddr, fromAddr, subject, mailContent,
		encode="utf-8", type="plain", attaches=None):
	mail = MIMEMultipart()
	#mail['To'] = ','.join(toAddr)
	mail['To'] = toAddr
	mail['From'] = fromAddr
	mail['Subject'] = Header(subject, "utf-8")
	mail['Date'] = email.utils.formatdate(localtime=True)

	body = MIMEText(mailContent, type, encode)
	mail.attach(body)

	if (None != attaches):
		if (False == addAttachments(mail, attaches)):
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


def sendMail(toAddr, subject, mailContent,
		fromAddr = 'hexing20100113@189.cn', usr = "18939771309@189.cn", pwd = "hexiaoxing", attaches=None):
	mail = buildEMail(toAddr, fromAddr, subject, mailContent, attaches=attaches)
	mh = re.search('\@189\.cn$', fromAddr)
	if None != mh :
		Err = sendEmail_189(mail, usr, pwd)
	else:
		Err = sendEmail_gmail(mail, usr, pwd)

	return Err



if __name__ == '__main__':
	if (2 == len(sys.argv)):
		toAddr = '18939771309@189.cn'
		subject = 'My Address IP'
		mailContent = sys.argv[1]
		fromAddr = 'hexing20100113@189.cn'
		usr = 'hexing20100113@189.cn'
		pwd = "hexiaoxing"

		if False == sendMail(toAddr, subject, mailContent, fromAddr, usr, pwd):
			exit(99)
	elif (7 == len(sys.argv)):
		toAddr = sys.argv[1]
		subject = sys.argv[2]
		mailContent = sys.argv[3]
		fromAddr = sys.argv[4]
		usr = sys.argv[5]
		pwd = sys.argv[6]

		if False == sendMail(toAddr, subject, mailContent, fromAddr, usr, pwd):
			exit(99)
	elif (8 == len(sys.argv)):
		toAddr = sys.argv[1]
		subject = sys.argv[2]
		mailContent = sys.argv[3]
		fromAddr = sys.argv[4]
		usr = sys.argv[5]
		pwd = sys.argv[6]
		attaches = []
		attaches.append(sys.argv[7])

		if False == sendMail(toAddr, subject, mailContent, fromAddr, usr, pwd, attaches):
			exit(98)
	else:
		print('Error parameters!', file=sys.stderr)
		exit(7)
