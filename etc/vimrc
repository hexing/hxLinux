"hexing's vim script
"source $VIM/hexing_gvim.vim

"ctags -R --c++-kinds=+p --fields=+iaS --extra=+q -f tag01 E:\develop\Core_Libs

"term settings {{{1
	syntax enable
	syntax on
	filetype plugin indent on

	set number ruler showcmd showmode more "splitright
	set nospell nocompatible
	set incsearch hlsearch ignorecase
	set shortmess=oOtTI "启动的时候不显示那个援助索马里儿童的提示
	"set showmatch "显示匹配括号

	set nowrap whichwrap=b,s "不自动换行，只有<BS><SPACE>可以在行间回绕
	set scrolloff=0	scroll=0 sidescroll=1 sidescrolloff=0
	set textwidth=0 shiftwidth=4 tabstop=4 softtabstop=4
	set smartindent autoindent
	"set autoread
	"set cdpath path
	set completeopt=menuone
	set wildmode=full wildmenu wildchar=<Tab>
	set foldenable foldmethod=marker "foldnestmax=7 foldclose=all foldopen=all
	set diffopt+=vertical switchbuf=split
	set matchpairs+=<:>

	set viminfo= "退出时不保存信息
	"set bufhidden=
	set ambiwidth=double nobomb	"设置字节顺序 只有写入的时候才会有效，现在设置是无效的
	set history=9 undolevels=36 maxfuncdepth=97
	set selection=exclusive "inclusive

	set nobackup nowritebackup updatecount=0 backupdir=	"关闭备份功能
	set noswapfile	"可在编辑过程中禁止使用交换文件

	"文字编码加入utf8
	" 设定默认解码
	"set fenc=utf-8
	"set fencs=utf-8,usc-bom,euc-jp,gb18030,gbk,gb2312,cp936
	"set enc=utf-8
	"let &termencoding=&encoding
	 
	"设置语法折叠
	"set foldmethod=syntax
	"设置折叠区域的宽度
	"set foldcolumn=3 
	"设置为自动关闭折叠
	"set foldclose=all 
	 
	" 用空格键来开关折叠
	"set foldenable
	"nnoremap <space> @=((foldclosed(line('.')) < 0) ? 'zc' : 'zo')<CR>
	 
	"设置帮助语言
	"if version >= 603
	"  set helplang=cn
	"  set encoding=utf-8
	"endif

	if has("win32")
		if executable('mingw32-make.exe')
			set makeprg=mingw32-make.exe
		endif
		set	directory=b:/temp/ "将所有.swp发入指定目录
		set fileformat=dos
	else
		set	directory=/tmp/ "将所有.swp发入指定目录
		set fileformat=unix
	endif

	"if executable('grep')
	"	set grepprg=grep\ -nHubE
	"endif
	"grep -nHubE -d skip -e

	"find -type f -name "*.vim" -maxdepth 1
	set isfname+=32 "让gf也能查找包含space的文件名

	"set tags+=E:/develop/tags/tags_core_libs
	"set tags+=E:/develop/tags/tags_wxWidgets_include
	"set tags+=E:/develop/tags/tags_wxWidgets_msw 

	"set iskeyword+=.	"把.也认为是word的一个合法字符

	"scriptnames	"列出所有加载的 plugins, _vimrcs
	"verbose set history	"显示history的值并指出设置文件的位置

if has("gui_running")
	set winaltkeys=no tabpagemax=96

	"set title titlestring=千里暮云平
	"set title titlestring=%<%F%=%l/%L-%P titlelen=70
	set title titlestring=千里暮云平\ %t%(\ %M%)%(\ (%{expand(\"%:~:.:h\")})%)%(\ %a%)
	"set title titlestring=%<%F%=%l/%L-%P titlelen=70
	"set titlestring=%t%(\ %M%)%(\ (%{expand(\"%:~:.:h\")})%)%(\ %a%)
	"set title titlestring=山横春烟\ %t%(\ %M%)%(\ (%{expand(\"%:~:.:h\")})%)%(\ %a%)
endif


"plugin settings {{{1
	"taglist.vim {{{2
		let g:Tlist_Exit_OnlyWindow = 1
		let g:Tlist_Show_One_File = 1
		let g:Tlist_Sort_Type = 'name'
		let g:Tlist_File_Fold_Auto_Close = 1
		if has("win32")
			let g:Tlist_Ctags_Cmd = $VIM . '/vimfiles/bin/ctags.exe'
		endif

	"matchparen.vim {{{2
		"let g:loaded_matchparen = 0

	"autoclose.vim {{{2
		let g:autoclose_on = 1

	"hexing_autoload.vim
	if has("win32")
		let g:Ctags = $VIM . '/vimfiles/bin/ctags.exe'
		let g:TagDirectory = 'b:/tags'
		call hexing#hexing_autoload#HX_LoadTagFiles(g:TagDirectory . '/*.tag')
	endif

"autocmd {{{1
		set autochdir "autocmd BufEnter * exec "cd %:p:h"
		"autocmd BufEnter * let &titlestring = hostname() . "/" . expand("%:p")
		autocmd BufReadPre * call hexing#hexing_autoload#HX_OnOpenFile()
		au BufRead,BufNewFile *.h++	set filetype=cpp
		au BufRead,BufNewFile *.c++	set filetype=cpp
		if has("gui_running")
			let g:colors_name=''
			autocmd ColorScheme * let &titlestring=&titlestring.'|'.g:colors_name
		endif
		

"maps {{{1 
	"normal mode {{{2
		"nnoremap <F1> :call hexing#hexing_autoload#HX_debug_test()<CR>
		nnoremap <silent> <S-Tab> :call hexing#hexing_autoload#HX_switch_showtabline()<CR>
		nnoremap / :nohlsearch<CR>/
		nnoremap ? :nohlsearch<CR>?
		nnoremap <silent> <Esc> :nohlsearch<CR><Esc>
		nnoremap Y y$
		nnoremap <Home> ^
		"nnoremap <Home> 1_
		"nnoremap 0 ^
		nnoremap <silent> <kPlus> :set foldlevel-=1<CR>
		nnoremap <silent> <kMinus> :set foldlevel+=1<CR>
		nnoremap <C-F4> :call hexing#hexing_autoload#HX_close_buffer()<CR>
		nnoremap <silent> <F6> :call  hexing#hexing_autoload#HX_toggle_quickfix_wnd()<CR>
		nnoremap <silent> <C-F12> :call hexing#hexing_autoload#HX_CreateTagFile()<CR>
		nnoremap <silent> <A-F12> :call hexing#hexing_autoload#HX_LoadTagFiles('')<CR>

	"insert mode {{{2
		inoremap <CR> <C-R>=pumvisible() ? "\<lt>C-Y>" : "\<lt>CR>"<CR>
		inoremap <expr> <Esc> pumvisible() ? "\<C-E>" : "\<Esc>"
		imap <C-CR> <End><CR>
		inoremap <S-CR> <C-O>O
		inoremap <Home> <C-O>^
		inoremap <silent> <C-S> <C-O>:update<CR>

		inoremap <A-o> <C-X><C-O>
		inoremap <A-u> <C-X><C-U>
		inoremap <A-p> <C-X><C-P>
		inoremap <A-n> <C-X><C-N>
		inoremap <A-l> <C-X><C-L>
		inoremap <A-k> <C-X><C-K>
		inoremap <A-v> <C-X><C-V>

		inoremap [ <C-R>=hexing#hexing_autoload#HX_pair('[')<CR>
		inoremap ] <C-R>=hexing#hexing_autoload#HX_pair(']')<CR>
		inoremap ( <C-R>=hexing#hexing_autoload#HX_pair('(')<CR>
		inoremap ) <C-R>=hexing#hexing_autoload#HX_pair(')')<CR>
		inoremap } <C-R>=hexing#hexing_autoload#HX_pair('}')<CR>
		inoremap ' <C-R>=hexing#hexing_autoload#HX_pair("'")<CR>

	"visual mode {{{2
		vnoremap <silent> <A-F8> :call hexing#hexing_autoload#HX_align_lines()<CR>

		vnoremap <silent> [ :call hexing#hexing_autoload#HX_make_paire('[')<CR>
		vnoremap <silent> ( :call hexing#hexing_autoload#HX_make_paire('(')<CR>
		vnoremap <silent> { :call hexing#hexing_autoload#HX_make_paire('{')<CR>
		vnoremap <silent> ' :call hexing#hexing_autoload#HX_make_paire("'")<CR>
		vnoremap <silent> " :call hexing#hexing_autoload#HX_make_paire('"')<CR>

	"map
		map <kPoint> G


"command {{{1
	command! -range Align : call hexing#hexing_autoload#HX_align_word_column(<line1>, <line2>)
"}}}1

	if ('linux' == $TERM)
		set t_Co=256
	endif
	colorscheme	random "source $VIMRUNTIME/colors/春山眉wuye.vim
	"echo g:colors_name
	if &diff
		call hexing#hexing_autoload#HX_diff_colorscheme()
	endif
