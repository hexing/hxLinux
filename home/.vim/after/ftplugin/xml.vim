source $VIM/vimfiles/after/ftplugin/XMLFolding.vim

setlocal foldlevel=9
setlocal foldtext=XMLFoldLabel()
 function! XMLFoldLabel()
	let getcontent = substitute(getline(v:foldstart), "^[[:space:]]*", "", 'g')
	"let linestart = substitute(v:folddashes, ".", '?, 'g')
	"return linestart . " " . getcontent
	
	let l:count = indent(v:foldstart)
	let l:i = 0
	while l:i < l:count
		let l:i += 1
		let getcontent = ' ' . getcontent
	endwhile

	return getcontent . '-----lines: ' . (v:foldend - v:foldstart) . ' -----foldlevel: ' . v:foldlevel
endfunction
