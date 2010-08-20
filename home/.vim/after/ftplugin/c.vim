" OmniCppComplete initialization
call omni#cpp#complete#Init()


"functions {{{1
	function! <SID>CppFoldText()
		return (v:foldstart - v:foldend) . ' lines foldlevel: ' . v:foldlevel . ' ' . getline(v:foldstart)
	endfunction

	function! <SID>CColourScheme()
		let lst = ['hexing_wuye', 'wuye', 'django', 'desert', 'camo', 'slate', 'doriath', 'darkspectrum', 'khaki', 'scite']
		for i in lst
			if i == g:colors_name
				return
			endif
		endfor

		if 1 == localtime()%3
			let k = len(g:colors_name) % len(lst)
			exec 'silent! normal :colorscheme ' . lst[k] . "\<CR>"
			let &titlestring = &titlestring . '|' . lst[k]
		else
			colorscheme	hexing_wuye
			let &titlestring = &titlestring . '|' . 'hexing_wuye'
		endif
	endfunction

if !exists("g:ft_C")
	let g:ft_C = 1
	set guioptions-=T guioptions-=r guioptions-=l guioptions+=h guioptions-=m guioptions-=R guioptions-=b guioptions-=L
	if (!&diff)
		call <SID>CColourScheme()
	endif
endif


"setting {{{1
	"setlocal completefunc=hexing#hexing_autoload#HX_cpp_user_complete
	setlocal autoread 
	setlocal cinoptions+=)6 cinoptions+=:0 cinoptions+=(0 cinoptions+=g0 cinoptions-=:0
	setlocal complete=. complete+=t
	setlocal foldmethod=syntax foldlevel=9
	"setlocal makeprg=make
	setlocal formatoptions-=cro

	"setlocal guifont=Bitstream\ Vera\ Sans\ Mono:h11.8:w6.7:b
	"setlocal guifont=Vera\ Sans\ YuanTi\ Mono:h11.8:w6.3:b

	setlocal foldtext=<SID>CppFoldText()
"map {{{1
	"nnoremap <buffer> <silent> <F7> :update <Bar> make! --quiet <Bar> copen<CR>
	nnoremap <buffer> <silent> <F7> :call hexing#c_hx#HX_make('')<CR>
	nnoremap <buffer> <silent> <F5> :call hexing#c_hx#HX_make('run=1')<CR>
	nnoremap <buffer> <silent> <C-F7> :call hexing#c_hx#HX_syntax_check()<CR>
	nnoremap <buffer> <silent> <F3> :AT<CR>
	"nnoremap <buffer> <silent> <F3> :call hexing#c_hx#HX_switch_h_cpp()<CR>
	nnoremap <buffer> <silent> <F8> :TlistToggle<CR>
	nnoremap <buffer> <silent> <A-t> :tnext<CR>
	nnoremap <buffer> <silent> <A-h> :call hexing#c_hx#HX_header_file()<CR>
	"nnoremap <buffer> <silent> gf :tabedit <cfile><CR>
	nnoremap <buffer> <silent> gf :call hexing#c_hx#HX_gf()<CR>

	"inoremap <buffer> <silent> { {}<Left><CR><Up><End><CR>
	"inoremap <buffer> <silent> [ []<Left>
	inoremap <buffer> <silent> <CR> <C-R>=pumvisible() ? "\<lt>C-Y>\<lt>C-R>=hexing#hexing_autoload#HX_setion_complete()\<lt>CR>" :  "\<lt>C-R>=hexing#c_hx#HX_keymap_Enter()\<lt>CR>"<CR>
	inoremap <buffer> <silent> <A-u> <C-R>=hexing#hexing_autoload#HX_popup_setion_completion('*')<CR>
	inoremap <buffer> <silent> <Esc> <C-R>=hexing#c_hx#HX_keymap_Escape()<CR>
	imap <buffer> <silent> <F7> <Esc><F7>
	imap <buffer> <silent> <F5> <Esc><F5>
	imap <buffer> <silent> <C-F7> <Esc><C-F7>
	inoremap <buffer> <silent> " <C-R>=hexing#hexing_autoload#HX_pair('"')<CR>
	inoremap <buffer> <silent> { <C-R>=hexing#c_hx#HX_keymap_Dkh()<CR>
	inoremap <buffer> <silent> : <C-R>=hexing#c_hx#HX_keymap_Colon()<CR>

	vnoremap <buffer> <silent> <kDivide><kMultiply> :call hexing#c_hx#HX_comment_c()<CR>

"iabbr {{{1
	"iabbr <buffer> <silent>  if if ()<Left>
	iabbr <buffer> <silent>  #i #include
	iabbr <buffer> <silent>  #d #define
	iabbr <buffer> <silent>  #f #ifdef<CR>#endif<Up><End>
	iabbr <buffer> <silent>  #n #ifndef<CR>#endif<Up><End>
	iabbr <buffer> <silent> tchar TCHAR
	inorea <buffer> <silent>  _ _("")<Left><Left>
	inorea <buffer> <silent>  _t _T("")<Left><Left>
	"iabbr <buffer> <silent>  ' _T('')<Left><Left>
	"iabbr <buffer> <silent>  { {<CR>}<Up><End><CR>
	"iabbr <buffer> <silent>  typ typedef

"Popup menu {{{1
	nnoremenu 0.01 PopUp.Cpp/H :AT<CR>
	nnoremenu 0.02 PopUp.TlistToggle :TlistToggle<CR>
	nnoremenu 0.09 PopUp.-SEP0-	<Nop>
