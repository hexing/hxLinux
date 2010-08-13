"如果只打开一个txt文件"
"let s:buf_name = bufname('#')
"if (0 == bufexists(s:buf_name)
if (1 == bufnr('$'))
	setlocal guioptions+=m
endif
"unlet s:buf_name
