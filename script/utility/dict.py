#!/usr/bin/python
#coding=utf8
#http://github.com/panweizeng/home/tree/master/code/python/dict

import urllib
from urllib.request import urlopen
import sys
import re
import xml.dom.minidom as xml
from hxColorString import colorString

API_URL = 'http://dict.cn/ws.php?utf8=true&q=%s'
#API_URL = 'http://dict-co.iciba.com/api/dictionary.php?w=%s'

def getword(word):
	xmls = urlopen(API_URL%urllib.parse.quote(word)).read()
	root = xml.parseString(xmls).documentElement

	tags = {'key':'单词', 'pron':'音标', 'def':'释义', 'sent':'例句', 'orig':'例句', 'trans':'翻译', 'acceptation':'释义'}

	def isElement(node):
		return node.nodeType == node.ELEMENT_NODE
	def isText(node):
		return node.nodeType == node.TEXT_NODE
	def show(node, tagName=None):
		if isText(node):
			s = node.nodeValue
			s = s.replace('<em>','')
			s = s.replace('</em>','')
			tag = tags.get(tagName, tagName)
			print('%s:%s'%(tag, s))
		elif isElement(node):
			[show(i, node.tagName) for i in node.childNodes]

	[ show(i) for i in root.childNodes if isElement(i) and i.tagName in ['key', 'pron', 'def', 'sent', 'acceptation'] ]

class WordInfo:
	sKey = ''
	sPron = ''
	sDef = ''
	sExample = []

def getInfo(word):
	xmls = urlopen(API_URL%urllib.parse.quote(word)).read()
	root = xml.parseString(xmls).documentElement

	tagNames = ['key', 'pron', 'def', 'sent', 'acceptation']

	wi = WordInfo;
	def isElement(node):
		return node.nodeType == node.ELEMENT_NODE
	def isText(node):
		return node.nodeType == node.TEXT_NODE
	def parseInfo(node, tagName=None):
		if isText(node):
			if 'key' == tagName:
				wi.sKey = node.nodeValue
			elif 'pron' == tagName:
				wi.sPron = node.nodeValue
			elif 'def' == tagName:
				wi.sDef = node.nodeValue
			elif 'orig' == tagName:
				wi.sExample.append(node.nodeValue)
			elif 'trans' == tagName:
				wi.sExample.append(node.nodeValue)
		elif isElement(node):
			[parseInfo(i, node.tagName) for i in node.childNodes]

	[ parseInfo(i) for i in root.childNodes if isElement(i) and i.tagName in tagNames ]
	return wi
    
def main():
	if len(sys.argv) >= 2:
		word = ' '.join(sys.argv[1:])
		#getword(word)

		wi = getInfo(word)
		s = colorString(wi.sKey, '2;4') + ' [' + colorString(wi.sPron, '32;1')  + ']'
		print(s)

		s = '释义：'
		print(colorString(s, '2'))
		s = '\t' + wi.sDef
		s = s.replace('\n', '\n\t')
		print(colorString(s, '36;1'))

		s ='例句：'
		print(colorString(s, '2'))
		s = '\n\t'
		s = s.join(wi.sExample)
		s = '\t' + s
		#s = s.replace('<em>'+wi.sKey+'</em>', colorString(wi.sKey, '7'))
		s = re.sub(r'<em>(\w+)</em>', colorString(r'\1','7'), s)
		print(s)
	else:
		print('usage:dict [word]')


if __name__ == '__main__':
	#reload(sys)
	#sys.setdefaultencoding('utf8')
	main()
