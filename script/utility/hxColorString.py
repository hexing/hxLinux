#!/usr/bin/python
#coding=utf-8

'''
#other chose type  
编码    颜色/动作  
0       重新设置属性到缺省设置  
1       设置粗体  
2       设置一半亮度（模拟彩色显示器的颜色）  
4       设置下划线（模拟彩色显示器的颜色）  
5       设置闪烁  
7       设置反向图象  
22      设置一般密度  
24      关闭下划线  
25      关闭闪烁  
27      关闭反向图象  
30      设置黑色前景  
31      设置红色前景  
32      设置绿色前景  
33      设置棕色前景  
34      设置蓝色前景  
35      设置紫色前景  
36      设置青色前景  
37      设置白色前景  
38      在缺省的前景颜色上设置下划线  
39      在缺省的前景颜色上关闭下划线  
40      设置黑色背景  
41      设置红色背景  
42      设置绿色背景  
43      设置棕色背景  
44      设置蓝色背景  
45      设置紫色背景  
46      设置青色背景  
47      设置白色背景  
49      设置缺省黑色背景  
''' 

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
