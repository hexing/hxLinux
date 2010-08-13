inoremap $ $()<Left>
inoremap <buffer> <silent> " <C-R>=hexing#hexing_autoload#HX_pair('"')<CR>
imap <buffer> <silent> <F7> <Esc><F7>
inoremap <buffer> <silent> @ <C-R>=hexing#make_hx#HX_auto_variable('@')<CR>
inoremap <buffer> <silent> % <C-R>=hexing#make_hx#HX_auto_variable('%')<CR>
inoremap <buffer> <silent> < <C-R>=hexing#make_hx#HX_auto_variable('<')<CR>
inoremap <buffer> <silent> ? <C-R>=hexing#make_hx#HX_auto_variable('?')<CR>
inoremap <buffer> <silent> ^ <C-R>=hexing#make_hx#HX_auto_variable('^')<CR>
inoremap <buffer> <silent> + <C-R>=hexing#make_hx#HX_auto_variable('+')<CR>
inoremap <buffer> <silent> <kPlus> <C-R>=hexing#make_hx#HX_auto_variable('+')<CR>
inoremap <buffer> <silent> * <C-R>=hexing#make_hx#HX_auto_variable('*')<CR>
inoremap <buffer> <silent> <kMultiply> <C-R>=hexing#make_hx#HX_auto_variable('*')<CR>
inoremap <buffer> <silent> D <C-R>=hexing#make_hx#HX_auto_variable('D')<CR>
inoremap <buffer> <silent> F <C-R>=hexing#make_hx#HX_auto_variable('F')<CR>

nnoremap <buffer> <silent> <F7> :call hexing#make_hx#HX_make()<CR>
