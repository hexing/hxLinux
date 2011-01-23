#!/usr/bin/python
#coding=utf-8

#FG_BLACK='30'
#FG_RED='31'
#FG_GREEN='32'
#FG_ZONGSE='33'
#FG_BLUE='34'
#FG_ZISE='35'
#FG_QINGSE='36'
#FG_WHITE='37'
#FG_UNDER_LINE='38'
#FG_UNDER_LINE_OFF='39'
#
#BG_BLACK='40'
#BG_RED='41'
#BG_GREEN='42'
#BG_ZONGSE='43'
#BG_BLUE='44'
#BG_ZISE='45'
#BG_QINGSE='46'
#BG_WHITE='47'
#BG_BLACK_DEFAULT='49'
#
#BOLD='1'
#BRIGHT_HALF='2'
#UNDER_LINE='4'
#FLASH='5'
#REVERT='7'
#NORMAL_DENSITY='22'
#UNDER_LINE_OFF='24'
#FLASH_OFF='25'
#REVERT_OFF='27'

#DEFAULT_SET='0'

#def colorString(s, *flags):
#	sFlags = ';'
#	s =  '\x1b['+ sFlags.join(flags) + 'm' + s
#	s += '\x1b[' + DEFAULT_SET + 'm'
#	return s

def colorString(s, sFlags):
	s =  '\x1b['+ sFlags + 'm' + s
	s += '\x1b[0m'
	return s


if '__main__' == __name__:
	s = 'ok'
	#s = colorString(s,'1', '44')
	s = colorString(s,'1;43')
	print(s)
