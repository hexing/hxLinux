setlocal formatoptions-=r formatoptions-=o

inoremap <buffer> <silent> < <C-R>=hexing#hexing_autoload#HX_pair('<')<CR>
inoremap <buffer> <silent> > <C-R>=hexing#hexing_autoload#HX_pair('>')<CR>
inoremap <buffer> <silent> <CR> <C-R>=pumvisible() ? "\<lt>C-Y>" : "\<lt>C-R>=hexing#vim_hx#HX_KeyPress_Return()\<lt>CR>"<CR>
inoremap <buffer> <silent> <Esc> <C-R>=hexing#vim_hx#HX_KeyPress_Escape()<CR>
