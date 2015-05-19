#!/usr/bin/env python
# -*- coding: UTF-8 -*- 

import os,sys
sys.path.append(os.path.join(os.path.dirname(os.path.dirname(__file__)), 'cms_post'))
import cms_post
import urllib, urllib2, re, cookielib

def main():
	cookies = cookielib.LWPCookieJar()
	opener = urllib2.build_opener( urllib2.HTTPCookieProcessor(cookies) )
	opener.open('http://www.kehutong.com/api/v1/session?token=P8uhZFltEv62Qze5hGbGkQ')
	#for c in cookies:
	#	print c.name, ':', c.value
	customer_management = opener.open('http://www.kehutong.com/customer_service/custom_menu')
	ret = customer_management.read()
	code = 500
	if responseOk(ret):
		code = 200	
	cms_post.post('1389417067478860', 'customer_management', code, 'status=12')

def responseOk(str):
	return '自定义菜单' in str

if __name__ == '__main__':
	main()
