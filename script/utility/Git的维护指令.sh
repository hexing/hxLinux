#!/bin/sh

#������r���S�o��ָ�����׌ Git �׵Ŀ��g׃С��
#view plaincopy to clipboardprint?
git count-objects  

#Git ���ش����: 11 objects, 44 kilobytes �@��ʾ 11 �� object ɢ���ˣ� ���M�� 44 kilobytes �Ŀ��g�� Ҫ��Q�@�����}����ָ�
#view plaincopy to clipboardprint?
git gc  

#���@��ָ���S�� Git �Ľ����� �����N�S�ֵ���Ҳ��֪����
#view plaincopy to clipboardprint?
git fsck --full 
