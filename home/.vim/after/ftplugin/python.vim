let fn=expand('%:p')
let fl=getfsize(fn)
if -1==fl || 0==fl
	let s=system('which python 2>/dev/null')
	if ''!=s
		let s=strpart(s, 0, strlen(s)-1)
		let s='#!'.s
		call append(0, '')
		"call append(0, '#coding=utf-8')
		let sComment='#vim:fileencoding=utf-8'
		call append(0, sComment)
		call append(0, s)
	endif
endif
