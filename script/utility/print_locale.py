#!/usr/bin/python
#vim:fileencoding=utf-8

#系统的缺省编码(一般就是ascii)：sys.getdefaultencoding() 
#系统当前的编码：locale.getdefaultlocale() 
#系统代码中临时被更改的编码（通过locale.setlocale(locale.LC_ALL,"zh_CN.UTF-8")）：locale.getlocale() 
#文件系统的编码：sys.getfilesystemencoding() 
#终端的输入编码：sys.stdin.encoding 
#终端的输出编码：sys.stdout.encoding 
#代码的缺省编码：文件头上# -*- coding: utf-8 -*-

import sys,locale 

print(sys.getdefaultencoding())
print(locale.getdefaultlocale())
print(sys.getfilesystemencoding())
print(sys.stdin.encoding)
print(sys.stdout.encoding)
try: 
	locale.setlocale(locale.LC_ALL,"zh_CN.GB2312") 
except locale.Error(e): 
	print(e)
	print(locale.getlocale())
	print(locale.getdefaultlocale())
