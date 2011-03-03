"----------------------------------------------------------"
" Vim meta color file                                      "
" Maintainer         : W. h. Jou                           "
" Email              : whjou@singnet.com.sg                "
" Most Recent Update : 2003-09-15                          "
" Version            : 1.3                                 "
"----------------------------------------------------------"

" Define function once only
if !exists("*s:LoadRandomColorScheme")
	let s:self            = expand("<sfile>")
	"let self            = globpath(&runtimepath, 'colors/random.vim')
	"let color_file_list = globpath(&runtimepath, 'colors/*.vim'     )

	function! s:LoadRandomColorScheme()
		let cfl = globpath(fnamemodify(s:self, ":h"), '*.vim')
		let color_file_list = split(cfl, '\n')

		if has('gui_running')
			let arr = ['doorhinge','lingodirector']
		else
			let arr = []
		endif
		if &diff
			let nonList = ['adobe','buttercream','professional','pyte']
			call extend(arr, nonList)
		endif

		let s = ''
		let cnt = 0
		for i in arr
			let cnt = len(color_file_list)
			let s = 'v:val !~ "'.i.'.vim"'
			call filter(color_file_list, s)
			let cnt -= len(color_file_list)
			if cnt != 1
				let &statusline .= ' $'.i.cnt.'$'
			endif
		endfor

		if empty(color_file_list)
			return
		endif

		let n = len(color_file_list)
		let n = localtime() % n
		execute "source" color_file_list[n]

		unlet! s:self
	endfunction
endif
"----------------------------------------------------------"

call s:LoadRandomColorScheme()
