"variables {{{1
let s:IsInHxCmp = 0

let s:HX_cpp_dictionary = [
			\{'word':"_(\"\")", 'abbr':'_("")', 'menu':"h", 'info':'info', 'kind':'v', 'icase':1, 'dup':1},
			\{'word':"_T(\"\")", 'abbr':'_T("")', 'menu':"h", 'info':'info', 'kind':'v', 'icase':1, 'dup':1},
			\{'word':"_T('')", 'abbr':'_T('''')', 'menu':"h", 'info':'info', 'kind':'v', 'icase':1, 'dup':1},
			\
			\{'word':"if ()", 'abbr':'if()', 'menu':"", 'info':'info', 'kind':'v', 'icase':1, 'dup':1},
			\{'word':"if ()\n{\n}", 'abbr':'if(){}', 'menu':"2k$", 'info':'info', 'kind':'f', 'icase':1, 'dup':0},
			\{'word':"elseif ()", 'abbr':'elseif()', 'menu':"", 'info':'info', 'kind':'m', 'icase':1, 'dup':1},
			\{'word':"elseif ()\n{\n}", 'abbr':'elseif(){}', 'menu':"2k$", 'info':'info', 'kind':'m', 'icase':1, 'dup':1},
			\{'word':"for ()\n{\n}", 'abbr':'for(){}', 'menu':"2k$", 'info':'info', 'kind':'m', 'icase':1, 'dup':1},
			\{'word':"switch ()\n{\ncase 1:\nbreak;\ndefault:\nbreak;\n}", 'abbr':'switch()', 'menu':"4k$X2k$", 'info':'info', 'kind':'v', 'icase':1, 'dup':1},
			\{'word':"case 1:\nbreak;", 'abbr':'case', 'menu':"k$X", 'info':'info', 'kind':'v', 'icase':1, 'dup':1},
			\{'word':"#ifdef DEBUG\n#endif", 'abbr':'#ifDEBUG', 'menu':"ko", 'info':'info', 'kind':'f', 'icase':1, 'dup':0}, 
			\
			\{'word':"dynamic_cast<>()", 'abbr':'dynamic_cast', 'menu':"2h", 'info':'info', 'kind':'v', 'icase':1, 'dup':1},
			\{'word':"reinterpret_cast<>()", 'abbr':'reinterpret_cast', 'menu':"2h", 'info':'info', 'kind':'v', 'icase':1, 'dup':1},
			\{'word':"static_cast<>()", 'abbr':'static_cast', 'menu':"2h", 'info':'info', 'kind':'v', 'icase':1, 'dup':1},
			\{'word':"const_cast<>()", 'abbr':'const_cast', 'menu':"2h", 'info':'info', 'kind':'v', 'icase':1, 'dup':1},
			\
			\{'word':"mutable ", 'abbr':'mutable', 'menu':"", 'info':'info', 'kind':'v', 'icase':1, 'dup':1},
			\{'word':"virtual ", 'abbr':'virtual', 'menu':"", 'info':'info', 'kind':'v', 'icase':1, 'dup':1},
			\{'word':"unsigned ", 'abbr':'unsigned', 'menu':"", 'info':'info', 'kind':'v', 'icase':1, 'dup':1},
			\{'word':"explicit ", 'abbr':'explicit', 'menu':"", 'info':'info', 'kind':'v', 'icase':1, 'dup':1},
			\{'word':"operator ", 'abbr':'operator', 'menu':"", 'info':'info', 'kind':'v', 'icase':1, 'dup':1},
			\{'word':"typedef ", 'abbr':'typd', 'menu':"", 'info':'info', 'kind':'v', 'icase':1, 'dup':1},
			\{'word':"typename ", 'abbr':'typn', 'menu':"", 'info':'info', 'kind':'v', 'icase':1, 'dup':1},
			\]

"functions {{{1
"complete functions {{{2
		function! s:HX_getCurWordBeg() "{{{3
            let line = getline('.')
            let start = col('.') - 1
            while start > 0 && line[start - 1] !~ '\s'
              let start -= 1
            endwhile
            return start
		endfunction

		function! s:HX_get_complete_array(base) "{{{3
			let arr = []
			for m in s:HX_cpp_dictionary
				if m['abbr'] =~ '^' . a:base
					call add(arr, m['abbr'])
				endif
			endfor
			return arr
		endfunction

		function! hexing#hexing_autoload#HX_popup_setion_completion(base_str) "{{{3
			let base = a:base_str
			if '*' == base
				let line = getline('.')
				let begin = s:HX_getCurWordBeg()
				let cnt = col('.') - begin - 1
				if cnt > 0
					let base = strpart(line, begin, cnt)
				else
					let base = ''
				endif
			endif

			let arr = s:HX_get_complete_array(base)
			let pos = col('.')

			if empty(arr)
				let i = strlen(base) - 1
				let s = ''
				while i > -1
					let s = base[i] . s
					let arr = s:HX_get_complete_array(s)

					if !empty(arr)
						let pos -= strlen(base) - i
						break
					endif
					let i -= 1
				endwhile
				
				if empty(arr)
					for m in s:HX_cpp_dictionary
						call add(arr, m['abbr'])
					endfor
				endif
			else
				let pos -= strlen(base)
			endif

			call complete(pos, arr)
			let s:IsInHxCmp = 1
			return ''
		endfunction

		function! s:HX_do_setion_complete(base, word, motion) "{{{3
			let line = getline('.')
			let action = 'silent! normal! '
			if col('.') > strlen(line)
				let action = action . (strlen(a:base) - 1) . 'XxA'
			else
				let action = action . strlen(a:base) . 'Xi'
			endif
			let action = action . a:word
			exe action

			if strlen(a:motion) > 0
				exe 'silent! normal! ' . a:motion
			endif
		endfunction

		function! hexing#hexing_autoload#HX_setion_complete() "{{{3
			if 0 == s:IsInHxCmp
				return ''
			endif
			let s:IsInHxCmp = 0

			let line = getline('.')
			let begin = s:HX_getCurWordBeg()
			let cnt = col('.') - begin - 1
			let base = ''

			if cnt > 0
				let base = strpart(line, begin, cnt)
				let len = strlen(base)

				if len > 0
					for m in s:HX_cpp_dictionary
						if m['abbr'] == base
							call s:HX_do_setion_complete(base, m['word'], m['menu'])
							return ''
						elseif base =~ m['abbr'] . '$'
							call s:HX_do_setion_complete(m['abbr'], m['word'], m['menu'])
							return ''
						endif
					endfor
				endif
			endif

			return ''
		endfunction

"Align functions {{{2
function! hexing#hexing_autoload#HX_align_word_column(ln_beg, ln_end) "{{{3
		"befor check {{{4
		let b = a:ln_beg
		let e = a:ln_end
		if b < 1
			let b = 1
		endif
		if e > line('$')
			let e = line('$')
		endif
		if b >= e
			return
		endif
		"}}}4

		"before {{{4
		let ve_save = &virtualedit
		setlocal virtualedit=
		exe 'silent! normal! :' . b . ',' . e . "left\<CR>"
		"}}}4

		"get lines array {{{4
		let ln_num = []
		let i = b
		while i <= e
			call add(ln_num, i)
			let i += 1
		endwhile
		"}}}4

		let i = 1
		while 1
			let arr_ln = []
			let arr_vcol = []

			for it in ln_num "get lines and columns {{{4
				let pos = 0
				let k = 0
				while k < i
					let pos = matchend(getline(it), '\s\+\S', pos)
					if pos < 1
						break
					endif
					let k += 1
				endwhile

				if pos > 1
					call add(arr_ln, it) 

					call cursor(it, pos)
					"exe 'silent! normal! ' . (pos - 1) . 'l'
					call add(arr_vcol, virtcol('.'))
				endif
			endfor "}}}4

			let len = len(arr_ln)
			if 0 == len
				break
			endif
			let ln_num = arr_ln
			let max_vcol = max(arr_vcol)

			let k = 0
			"set virtualedit=all
			while k < len "align {{{4
				let ln = get(arr_ln, k)
				let vcol = get(arr_vcol, k)
				if vcol < max_vcol
					call cursor(ln, 1)
					"exe 'silent! normal! ' . vcol . '|"zd$' . max_vcol . '|' . '"zP'
					exe 'silent! normal! ' . vcol . '|"zd$'
					while virtcol('.') < max_vcol
						exe "silent! normal! a\<Tab>"
					endwhile
					setlocal virtualedit=all
					if virtcol('.') > max_vcol
						exe 'silent! normal! a' . "\<BS>"
						exe 'silent! normal! ' . max_vcol . '|'
					endif
					exe 'silent! normal! "zP'
					setlocal virtualedit=
				endif

				let k += 1
			endwhile "}}}4
			"set virtualedit=

			let i += 1
		endwhile

		"after {{{4
		let &virtualedit = ve_save
		call cursor(b, 1)
		exe 'silent! normal! =' . (e - b) . 'j'
		"}}}4
	endfunction

	function! hexing#hexing_autoload#HX_align_lines() range "{{{3
		if 'V' == visualmode()
			call hexing#hexing_autoload#HX_align_word_column(a:firstline, a:lastline)
		endif
	endfunction

	function! <SID>Get_extension_dll()
		let sDll = $VIM
	endfunction

"additional functions {{{2
	function! hexing#hexing_autoload#HX_toggle_quickfix_wnd() "{{{3 
		let buf_count = bufnr('$')
		let i = 1
		while i <= buf_count
			if 'quickfix' == getbufvar(bufname(i), '&buftype')
				break
			endif
			let i += 1
		endwhile
		let cmd = 'silent! :'
		if i <= buf_count
			let cmd = cmd . 'cclose'
		else
			let cmd = cmd . 'copen'
		endif
		exe cmd
	endfunction

"keymap functions {{{2
	function!  hexing#hexing_autoload#HX_pair(ch) "{{{3
		let sCmd = a:ch

		let lel = '({<['
		let ler = ')}>]'
		let cnt = strlen(lel)

		let i = 0
		while i < cnt
			if a:ch == lel[i]
				"if ('['==a:ch)
				"	if (0 < searchpair('\[','','\]','nm',0))
				"		return a:ch
				"	endif
				"elseif (0 < searchpair(a:ch,'',ler[i],'nm',0))
				"	return a:ch
				"endif
				let sCmd = a:ch . ler[i] . "\<Left>"
				return sCmd
			endif

			let i += 1
		endwhile

		let i = 0
		while i < cnt
			if a:ch == ler[i]
				let sCmd = <SID>HX_close_pair(lel[i], a:ch)
				return sCmd
			endif

			let i += 1
		endwhile

		let lel = "\"'"
		let cnt = strlen(lel)

		let i = 0
		while i < cnt
			if a:ch == lel[i]
				let sCmd = <SID>HX_close_pair(a:ch, a:ch)
				return sCmd
			endif

			let i += 1
		endwhile

		return sCmd
	endfunction

	function! <SID>HX_close_pair(l, r) "{{{3
		let sCmd = a:r
		if a:l==a:r
			let sCmd = a:l . a:r . "\<left>"
		endif

		let line = getline('.')
		let len = strlen(line)
		if len>0
			let chPrev = line[col('.')-2]
			let chNext = line[col('.')-1]
			if chPrev==a:l
				if chNext==a:r
					let sCmd = "\<Right>"
				else
					let sCmd = a:r . "\<left>"
				endif
			"elseif (0 < searchpair(a:l,'',a:r,'nmb',0))
			"		let sCmd = a:r
			endif
		endif
		return sCmd
	endfunction

	function! <SID>HX_GetCtags() "{{{3
		if !exists('g:Ctags')
			let g_Ctags = 'ctags.exe'
		else
			let g_Ctags = g:Ctags
		endif
	
		if 0 == strlen(g_Ctags) || !executable(g_Ctags)
			let g_Ctags = 'ctags.exe'
		endif
		return g_Ctags
	endfunction
	
	function! <SID>HX_GetTagFileName() "{{{3 
		if !exists('g:TagDirectory')
			return 'tags'
		endif
	
		let tagFile = expand('%:p:h') . '.tag'
		let tagFile = substitute(tagFile, ':', '%', '')
		let tagFile = substitute(tagFile, '/', '%', 'g')
		let tagFile = substitute(tagFile, '\', '%', 'g')
	
		if exists('g:TagDirectory')
			let tagFile = g:TagDirectory . '/' . tagFile
		endif
		return tagFile
	endfunction

	function! hexing#hexing_autoload#HX_CreateTagFile() "{{{3
		let CtagsCmd = <SID>HX_GetCtags()
		if !executable(CtagsCmd)
			call confirm('ctags is invalid!')
			return
		endif

		if exists('g:TagDirectory') && !isdirectory(g:TagDirectory)
			let nChoice = confirm(g:TagDirectory . " does not exist!\nDo you want to create the directory?\n" . g:TagDirectory, "&Ok\n&Cancel", 2)
			if 2 == nChoice
				return
			elseif 1 == nChoice
				let n = mkdir(g:TagDirectory, 'p')
				if 0 == n
					call confirm('Can not mkdir: ' . g:TagDirectory)
					return
				endif
			endif
		endif

		let tagFile = <SID>HX_GetTagFileName()
		if tagFile == findfile(tagFile)
			let nChoice = confirm("The file:\n" . tagFile . "\n already exists!" . "\nDo you want to continue?", "&Yes\n&No", 2)
			if 2 == nChoice
				return
			endif
		endif

		let s = expand('%:p:h')
		let s = 'ctags -R --c++-kinds=+p --fields=+iaS --extra=+q -f' . tagFile . ' ' . s
		let s = system(s)
		if 0 != v:shell_error
			call confirm(s)
		else
			call confirm("Success to build the tag file:\n" . tagFile)
		endif
	endfunction

	function! hexing#hexing_autoload#HX_LoadTagFiles(sPath) "{{{3
		let s = a:sPath
		if 0 == strlen(s)
			if exists('g:TagDirectory') && isdirectory(g:TagDirectory)
				let s = g:TagDirectory
			else
				let s = expand('%:p:h') . '/*.tag'
			endif
			let s = inputdialog('请指定标签文件：', s)
		endif

		if 0 != strlen(s)
			if isdirectory(s)
				let s = s . '/*'
			endif
			let s = glob(s)
			if 0 != strlen(s)
				let &tags = &tags . ',' . substitute(s, '\n', ',', 'g')
			endif
		endif
	endfunction

	function! hexing#hexing_autoload#HX_OnOpenFile()
		let file_length = getfsize(expand('%'))
		if (file_length > 3072*1024)
			call confirm('file size > 3M')
			exec 'bwipeout'
		endif
	endfunction

	function! hexing#hexing_autoload#HX_switch_showtabline()
		let i = &showtabline
		if (0==i)
			exec 'silent! :set showtabline=2'
		else
			exec 'silent! :set showtabline=0'
		endif
	endfunction

	function! hexing#hexing_autoload#HX_make_paire(cChar) range "{{{3
		if ('[' == a:cChar || ']' == a:cChar)
			let l:left = '['
			let l:right = ']'
		elseif ('(' == a:cChar || ')' == a:cChar)
			let l:left = '('
			let l:right = ')'
		elseif ('{' == a:cChar || '}' == a:cChar)
			let l:left = '{'
			let l:right = '}'
		else
			let l:left = a:cChar
			let l:right = a:cChar
		endif

		let l:vm = visualmode()

		if char2nr('v') == char2nr(l:vm)
			let l:ss = getline(a:firstline)
			let l:ss = strpart(l:ss, 0, col("'<")-1) . l:left . strpart(l:ss, col("'<")-1)
			call setline(a:firstline, l:ss)
			let l:st = getline(a:lastline)
			let l:st = strpart(l:st, 0, col("'>")+1) . l:right . strpart(l:st, col("'>")+1)
			call setline(a:lastline, l:st)
		elseif char2nr('V') == char2nr(l:vm)
			let l:ss = getline(a:firstline)
			let l:ss = strpart(l:ss, 0, col("'<")-1) . l:left . strpart(l:ss, col("'<")-1)
			call setline(a:firstline, l:ss)
			let l:st = getline(a:lastline)
			let l:st = strpart(l:st, 0, col("'>")-1) . l:right . strpart(l:st, col("'>")-1)
			call setline(a:lastline, l:st)
		endif
	endfunction

	"function! hexing#hexing_autoload#HX_debug_test()
	"	let sFile = expand('<cfile>:p')
	"	let i = bufloaded(sFile)
	"	if (0==i)
	"		exec 'silent! :tabedit ' . sFile
	"	else
	"		exec 'silent! :buffer ' . i
	"	endif
	"endfunction
