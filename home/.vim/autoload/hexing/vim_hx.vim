function! hexing#vim_hx#HX_KeyPress_Return()
	let arr1 = ['^\s*\<function\>','^\s*\<while\>','^\s*\<for\>','^\s*\<if\>']
	let arr2 = ['endfunction','endwhile','endfor','endif']

	let lCur = getline('.')
	let lNxt = getline(line('.')+1)

	let i = 0
	for m in arr1
		if lCur =~ m
			"let nt = '^\s*\<' . arr2[i] . '\>'
			"if lNxt !~ nt
				return "\<CR>" . arr2[i] . "\<Up>\<End>\<CR>"
			"endif
		endif
		let i += 1
	endfor

	return "\<CR>"
endfunction

function! hexing#vim_hx#HX_KeyPress_Escape()
	let lCur = getline('.')
	if lCur =~ '^\s*$'
		let lNxt = getline(line('.')+1)
		if lNxt =~ '^\s*end.\+$'
			return "\<Esc>dd"
		endif
	endif

	return "\<Esc>"
endfunction
