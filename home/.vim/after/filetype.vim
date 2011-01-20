augroup filetypedetect
	au BufNewFile,BufRead *.txt,*.log	            setf text

	"最后未检测出file type
	au BufNewFile,BufRead *		                    setf unkown
augroup END
