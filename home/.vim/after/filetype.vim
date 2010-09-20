augroup filetypedetect
	au BufNewFile,BufRead *.txt	                    setf text
	au BufNewFile,BufRead *.log	                    setf text

	"×îºóÎ´¼ì²â³öfile type
	au BufNewFile,BufRead *		                    setf unkown
augroup END
