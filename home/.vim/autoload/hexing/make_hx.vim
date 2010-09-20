function!  hexing#make_hx#HX_make() "{{{3
	exec "silent! normal! :update\<CR>"
	exec "silent! normal! :make! -f % --quiet\<CR>"
	if (0 == v:shell_error)
		exec "silent! normal! :cw\<CR>"
	else
		exec "silent! normal! :copen\<CR>"
	endif
endfunction

function!  hexing#make_hx#HX_auto_variable(c) "{{{3
	let y = col('.')
	let s = getline('.')
	if y>2 && ('D'==a:c || 'F'==a:c)
		if '$'==s[y-3] && -1<stridx('@%<?^+*', s[y-2])
			return "\<Left>(\<Right>" . a:c . ")\<Left>"
		endif
	"-1<stridx('@%<?^+*',a:c)
	elseif y>2 && y<=len(s)
		if ')'==s[y-1] && '('==s[y-2] && '$'==s[y-3]
			return "\<Del>\<BS>" . a:c
		endif
	endif
	return a:c
endfunction
