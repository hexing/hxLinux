" Read the C syntax to start with
"if version < 600
"  so <sfile>:p:h/c.vim
"else
"  runtime! syntax/c.vim
"  unlet b:current_syntax
"endif


syntax keyword cppExtention	__super
syntax keyword Keyword		tstring TCHAR
syntax keyword Special		NULL
syntax keyword cppSpecialKeyword	inline virtual explicit export extern const
syntax keyword cppSpecialKeyword	typename template namespace
syntax keyword cppBoolean		TRUE FALSE

syn match cOperator	'[.,:;&!~^|<>?=*+%()\[\]\-]'
syn match cOperator	'[/*]\@<!/[/*]\@!'

syntax region cppString	start=+_T\=("+ skip=+\\\\\|\\"+ end=+")+


" Default highlighting
if version >= 508 || !exists("did_cpp_syntax_inits")
	if version < 508
		command -nargs=+ HiLink hi link <args>
	else
		command! -nargs=+ HiLink hi def link <args>
	endif

	HiLink cppExtention		cppSpecialKeyword
	HiLink cppString		String
	"HiLink cppCharacter		Character
	"HiLink cOperator		Operator 

	delcommand HiLink
endif

hi cppAccess gui=ITALIC guifg=#FF0008 guibg=bg		cterm=UNDERCURL ctermfg=lightgreen ctermbg=black
hi cppSpecialKeyword gui=ITALIC guifg=#08FF08 guibg=bg		cterm=UNDERCURL ctermfg=lightgreen ctermbg=black

hi link cppStatement		cppSpecialKeyword
hi link cppOperator			cppSpecialKeyword
hi link cppStorageClass		cppSpecialKeyword
hi link cppCast				cppSpecialKeyword
