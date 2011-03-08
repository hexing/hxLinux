"nnoremap <C-x><C-s> :update<CR> 有冲突，无效 需要在bash中：stty -ixon
nnoremap <C-x>s :update<CR>
nnoremap <C-x>k :call <SID>CloseCurrentBuffer()<CR>

inoremap <C-x>s <C-o>:update<CR>
inoremap <C-k> <C-o>d$
"inoremap <Home> <C-o>1_
inoremap <C-a> <C-o>^
inoremap <expr> <C-e> pumvisible()?"\<C-e>":"\<C-o>$"
"inoremap <C-/> <C-o>u
inoremap <C-_> <C-o>u
"inoremap <C-x>u <C-o>u
inoremap <C-s> <C-o>/
inoremap <C-r> <C-o>?
inoremap <expr> <C-y> pumvisible()?"\<C-y>":"\<C-o>p"

if has('gui_running')
	nnoremap <C-x><C-s> :update<CR>
	vnoremap <M-w> y
	vnoremap <C-w> d

	inoremap <C-/> <C-o>u
	inoremap <A-Del> <C-w>
	inoremap <A-d> <C-o>de
	inoremap <A-y> <C-o>P
	inoremap <A-^> <C-o>J
	inoremap <A-g> <C-r>=<SID>GotoLine()<CR>
	inoremap <A-y> <C-o>P
	inoremap <A-l> <C-o>gue
	inoremap <A-u> <C-o>gUe
	inoremap <A-c> <C-o>~e
	inoremap <A-%> <C-o>:s/
	inoremap <A-r> <Esc>cc
else
	vnoremap <Esc>w y
	vnoremap <C-w> x

	inoremap <Esc><Del> <C-w>
	inoremap <Esc>d <C-o>de
	inoremap <Esc>y <C-o>P
	inoremap <Esc>^ <C-o>J
	inoremap <Esc>g <C-r>=<SID>GotoLine()<CR>
	inoremap <Esc>l <C-o>gue
	inoremap <Esc>u <C-o>gUe
	inoremap <Esc>c <C-o>~e
	inoremap <Esc>% <C-o>:s/
	inoremap <Esc>r <Esc>cc
	inoremap <C-@> <C-o>v
endif

function! s:GotoLine()
	let n = inputdialog('goto-line:')
	return "\<C-o>".n.'G'
endfunction

function! s:CloseCurrentBuffer()
	let cmd = 'normal :'
	let buf_name = bufname('#')
	if bufexists(buf_name)
		let cmd = cmd . 'bwipeout'
	else
		let cmd = cmd . 'confirm quit'
	endif
	let cmd = cmd . "\<CR>"
	exe cmd
endfunction
