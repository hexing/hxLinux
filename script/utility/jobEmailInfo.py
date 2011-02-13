#!/usr/bin/python
#vim:fileencoding=utf-8


HX_UTILITY = '/opt/hxLinux/script/utility'
HX_RESUME = '/opt/myPrivateData/milestone/resume.txt'

HEADER_INFO = '''
您好:
我对贵公司招聘的职位非常感兴趣，并满足该岗位的多项技术要求，希望能当面交流；
我已有10年的工作经验，参与过多个领域的商业系统开发，包括：RPG游戏服务器、棋牌类休闲游戏服务器、ERP系统、财物系统、进销存系统，BT-Tracker服务器等;
我个人也很享受技术的创新以及工作所带来的成就感。

以下是我的个人简历，感谢您在百忙中抽空浏览，谢谢。

'''

import sys
sys.path.append(HX_UTILITY)
import sendEmail, hxColorString


class JobEmailInfo:
	def __init__(self, toAddr, subject, header_addition, fromAddr='hexing.job@gmail.com'):
		self.toAddr = toAddr
		self.subject = subject
		self.header_addition = header_addition
		self.fromAddr = fromAddr


def getResume():
	f = open(HX_RESUME, 'r', encoding='utf-8')
	sResume = f.read()
	f.close()
	return sResume


def sendJobEmail(jei, content, svr_stmp):
	if len(jei.header_addition) > 0 :
		content = jei.header_addition + content
	em = sendEmail.buildEMail(jei.toAddr, jei.fromAddr, jei.subject, content)

	try:
		svr_stmp.sendmail(jei.fromAddr, jei.toAddr, em.as_string())
	except:
		sLog = hxColorString.colorString("Failure:", '2' )
		sLog += hxColorString.colorString(jei.toAddr, '1;31') 
		print(sLog, file=sys.stderr)
		#print("Failure to diliver email:" + toAddr, file=sys.stderr)
		#print(sys.exc_info()[0], file=sys.stderr)
		return False

	sLog = "Success:"
	sLog += jei.toAddr
	print(sLog)
	return True



if __name__=='__main__':
	arr = [
			#JobEmailInfo('hexing.job@gmail.com, 18939771309@189.cn', '何幸的简历', '谢谢你\n\n\n'),
			JobEmailInfo('18939771309@189.cn, hexing.job@gmail.com', '何幸的简历', '谢谢你\n\n\n'),
			JobEmailInfo('18939771309@189.cn', '何幸的简历01', '谢谢你\n\n\n'),
			JobEmailInfo('hexing.job@gmail.com', '何幸的简历03', HEADER_INFO),
			]


	myResume = getResume()
	usr = 'hexing.job@gmail.com'
	pwd =  'hexinglq'
	svr_stmp = sendEmail.connSmtp_gmail(usr, pwd)
	if None == svr_stmp :
		sLog = "Can't connect to gmail stmp server!"
		print(sLog, file=sys.stderr)
		exit(1)

	for jei in arr:
		sendJobEmail(jei, myResume, svr_stmp)
	
	svr_stmp.quit()
