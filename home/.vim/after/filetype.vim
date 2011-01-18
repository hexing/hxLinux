augroup filetypedetect
	au BufNewFile,BufRead *.txt	                    setf text
	au BufNewFile,BufRead *.log	                    setf text

	"最后未检测出file type
	au BufNewFile,BufRead *		                    setf unkown
augroup END
