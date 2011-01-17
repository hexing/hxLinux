#!/usr/bin/python
#coding=utf8

import sendmail


class email_info:
	m_toAddress = ''
	m_title = ''
	m_message = ''
	m_content = ''


def writeLog(s):
	print(s)

def getFileContent(sFile):
	try:
		f = open(sFile, "r")
		s = f.read()
		f.close()
	except:
		return ""
	return s

def init_email_list(list_email):
	e1 = email_info();
	e1.m_toAddress = "hexing20100113@189.cn"
	e1.m_title = u"春眠不觉晓"
	e1.m_message = "你好：\n\t处处闻啼鸟\n夜来风雨声\n\t花落知多少\n\n\n"
	e1.m_content = "f.txt"
	list_email.append(e1)

	e2 = email_info();
	e2.m_toAddress = "hexing20100113@189.cn"
	e2.m_title = u"云青青兮欲雨"
	e2.m_message = "你好：\n水湛湛兮生烟\n\t旧时王谢堂前燕\n飞入寻常百姓家\n\t酉阳杂俎\n\n\n\n\n\n\n"
	e2.m_content = "f.txt"
	list_email.append(e2)

def sendEmail(ei):
	s = getFileContent(ei.m_content)
	if 0 == len(s):
		writeLog("Can't read file:" + ei.m_content)
		return
	s = ei.m_message + s

	email_backup = "hexing.job@gmail.com,hexiaoxing20100113@189.cn"
	#email_backup = ""
	ok = sendmail.sendMail_gmail(ei.m_toAddress, ei.m_title, s, usr = "hexing.job")
	if (False == ok):
		writeLog("#Failure to diliver email:" + ei.m_toAddress)
	elif 0 != len(email_backup):
		sendmail.sendMail_gmail(email_backup, ei.m_title, s, usr = "hexing.job")
	#else:
		#writeLog("*Success to diliver email:" + ei.m_toAddress)



def main():
	le = []
	init_email_list(le)
	for i in le:
		sendEmail(i)

if __name__ == '__main__':
	main()
