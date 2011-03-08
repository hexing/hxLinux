let fn=expand('%:p')
let fl=getfsize(fn)
if -1==fl || 0==fl
	let s=expand('%:e')
	let s=system('which '.s.' 2>/dev/null')
	if ''!=s
		let s=strpart(s, 0, strlen(s)-1)
		let s='#!'.s
		call append(0, '')
		call append(0, s)
	endif
endif
