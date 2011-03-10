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

		if !has('gui_running')
			let arr = ['doorhinge','lingodirector','PapayaWhip','baycomb',
						\'industrial','busybee']
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

	function! s:LoadFavoriteColorScheme()
		let arrFavorite = ['hexing_wuye','jellybeans','impact','desert256',
					\'desertedoceanburnt','lucius','zenburn','herald']
		let n = localtime() % 7
		if n > 0
			return 0
		endif

		let n = len(arrFavorite)
		let n = localtime() % n
		let s = 'colors/'.arrFavorite[n].'.vim'
		let s = globpath(&runtimepath, s)
		exec 'source' s
		return 1
	endfunction
endif
"----------------------------------------------------------"

if !s:LoadFavoriteColorScheme()
	call s:LoadRandomColorScheme()
endif
