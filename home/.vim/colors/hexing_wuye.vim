" Vim color file
" Name:        WuYe
" Maintainer:  Yeii
" Last Change: 2007-12-11
" Version:     0.1.1

" Init
set background=dark
if has("gui_running")
    set cursorline
endif
hi clear
if exists("syntax_on")
    syntax reset
endif
let g:colors_name = "hexing_wuye"

""""""""\ Highlighting groups for various occasions \"""""""" {{{1
hi Cursor		gui=NONE guifg=#000000 guibg=#00FF00		cterm=NONE ctermfg=black	   ctermbg=green 
hi CursorIM		gui=NONE guifg=fg	   guibg=#FF0000		cterm=NONE ctermfg=black	   ctermbg=red  
hi CursorColumn	gui=NONE guifg=NONE	   guibg=#001630 
hi CursorLine	gui=NONE guifg=NONE	   guibg=#0e2a1a 
hi Directory	gui=UNDERCURL guifg=#20B2AA guibg=bg		cterm=NONE ctermfg=darkcyan	   ctermbg=black 
hi DiffAdd		gui=NONE guifg=fg	   guibg=#008B8B		cterm=NONE ctermfg=white	   ctermbg=darkcyan  
hi DiffChange	gui=NONE guifg=fg	   guibg=#008B00		cterm=NONE ctermfg=white	   ctermbg=darkgreen  
hi DiffDelete	gui=NONE guifg=#8B3A62 guibg=bg				cterm=NONE ctermfg=darkmagenta ctermbg=black
hi DiffText		gui=BOLD guifg=#FF69B4 guibg=#00008B		cterm=BOLD ctermfg=darkmagenta ctermbg=darkblue
hi ErrorMsg		gui=NONE guifg=#FFFF00 guibg=#B22222		cterm=NONE ctermfg=yellow	   ctermbg=red 
hi VertSplit	gui=NONE guifg=#CDB79E guibg=#102436		cterm=NONE ctermfg=white	   ctermbg=darkgray 
"hi Folded		gui=BOLD guifg=#E0FFFF guibg=#240068		cterm=BOLD ctermfg=white	   ctermbg=darkblue 
hi Folded		gui=BOLD guifg=#808080 guibg=bg		cterm=BOLD ctermfg=white	   ctermbg=darkblue 
"hi Folded		gui=BOLD guifg=#FF8000 guibg=bg		cterm=BOLD ctermfg=white	   ctermbg=darkblue 
hi FoldColumn	gui=NONE guifg=#FF8000 guibg=#104E8B		cterm=NONE ctermfg=white	   ctermbg=darkblue 
"hi FoldColumn	gui=BOLD guibg=#395602 guifg=#6f9b1f		cterm=NONE ctermfg=white	   ctermbg=darkblue 
hi SpecialKey	gui=NONE guifg=#000000 guibg=#00008B		cterm=NONE ctermfg=black	   ctermbg=darkblue 
"hi SignColumn
hi IncSearch	gui=BOLD	  guifg=#FF0000 guibg=bg			cterm=BOLD		ctermfg=red		 ctermbg=black
hi LineNr		gui=UNDERLINE guifg=#607B8B guibg=#121212		cterm=underline ctermfg=darkgrey ctermbg=black
hi MatchParen	gui=BOLD	  guifg=red	guibg=yellow
hi ModeMsg		gui=NONE	  guifg=#7CFC00 guibg=#00688B		cterm=NONE		ctermfg=yellow	 ctermbg=darkcyan
hi MoreMsg		gui=BOLD	  guifg=#00FF7F guibg=bg			cterm=BOLD		ctermfg=darkcyan ctermbg=black
hi NonText		gui=NONE	  guifg=#191970 guibg=#001220		cterm=NONE		ctermfg=darkblue ctermbg=black
hi Normal		gui=NONE	  guifg=#E6E6FA guibg=black			cterm=NONE		ctermfg=white	 ctermbg=black
"hi Normal		gui=NONE	  guifg=#E6E6FA guibg=#0E2A1A			cterm=NONE		ctermfg=white	 ctermbg=black
"hi Pmenu
"hi PmenuSel
"hi PmenuSbar
"hi PmenuThumb
hi Question	gui=BOLD	guifg=#00FF00 guibg=bg			cterm=BOLD ctermfg=green ctermbg=black
hi Search	gui=reverse guibg=NONE	  guifg=#EFFB06 	cterm=BOLD ctermfg=red	 ctermbg=white
"hi SpecialKey
"hi SpellBad
"hi SpellCap
"hi SpellLocal
"hi SpellRare
hi StatusLine	gui=NONE guifg=#FFFFFF guibg=#203080	cterm=NONE ctermfg=white ctermbg=darkblue
hi StatusLineNC	gui=NONE guifg=#CDB79E guibg=#102436	cterm=NONE ctermfg=white ctermbg=darkgray
"hi TabLine
"hi TabLineFill
"hi TabLineSel
hi Title	gui=BOLD guifg=#1E90FF guibg=bg		cterm=BOLD	  ctermfg=lightblue ctermbg=black
"hi Visual	gui=NONE guibg=bisque1 guifg=bg		cterm=reverse ctermbg=yellow	ctermfg=blue
hi Visual	gui=NONE guibg=#f6ffe5 guifg=#400080		cterm=reverse ctermbg=yellow	ctermfg=blue
"hi VisualNOS
hi WarningMsg	gui=BOLD guifg=#FFFF00 guibg=bg			cterm=NONE ctermfg=lightyellow ctermbg=black
hi WildMenu		gui=BOLD guifg=#000000 guibg=#7FFF00	cterm=BOLD ctermfg=black	   ctermbg=darkgreen 

""""""\ Syntax highlighting groups \"""""" {{{1
hi Comment	gui=ITALIC guifg=#3F3F00 guibg=bg		cterm=NONE ctermfg=grey ctermbg=black
hi Constant	gui=ITALIC guifg=#87CEEB guibg=bg		cterm=NONE ctermfg=darkcyan ctermbg=black
	hi String		gui=NONE guifg=#408080 guibg=bg		cterm=NONE ctermfg=darkcyan ctermbg=black
	hi Character	gui=NONE guifg=#90EE90 guibg=bg		cterm=NONE ctermfg=darkcyan ctermbg=black
	hi Number		gui=NONE guifg=#6495ED guibg=bg		cterm=NONE ctermfg=darkcyan ctermbg=black
	hi Boolean		gui=ITALIC guifg=#FF8080 guibg=bg		cterm=NONE ctermfg=darkcyan ctermbg=black
	hi Float		gui=NONE guifg=#6495ED guibg=bg		cterm=NONE ctermfg=darkcyan ctermbg=black
hi Identifier	gui=NONE guifg=#FFFF80 guibg=bg		cterm=NONE ctermfg=lightcyan ctermbg=black
	hi Function	gui=UNDERLINE guifg=yellow guibg=bg		cterm=NONE ctermfg=lightcyan ctermbg=black
hi Statement	gui=ITALIC guifg=#006C00 guibg=bg		cterm=NONE ctermfg=lightgreen ctermbg=black
	hi Conditional	gui=NONE guifg=#4169E1 guibg=bg		cterm=NONE ctermfg=lightgreen ctermbg=black
	hi Repeat		gui=NONE guifg=#1874CD guibg=bg		cterm=NONE ctermfg=lightgreen ctermbg=black
	hi Label		gui=ITALIC guifg=#1874CD guibg=bg		cterm=NONE ctermfg=lightgreen ctermbg=black
	hi Operator		gui=NONE guifg=#4169E1 guibg=bg		cterm=NONE ctermfg=lightgreen ctermbg=black
	hi Keyword		gui=ITALIC guifg=#007600 guibg=bg		cterm=NONE ctermfg=lightgreen ctermbg=black
	hi Exception	gui=ITALIC guifg=yellow guibg=bg		cterm=NONE ctermfg=lightgreen ctermbg=black
hi PreProc	gui=NONE guifg=#8470FF guibg=bg		cterm=NONE ctermfg=magenta ctermbg=black
	hi Include		gui=ITALIC guifg=#8A2BE2 guibg=bg		cterm=NONE ctermfg=lightmagenta ctermbg=black
	hi Define		gui=ITALIC guifg=#8470FF guibg=bg		cterm=NONE ctermfg=lightmagenta ctermbg=black
	hi Macro		gui=ITALIC guifg=#8470FF guibg=bg		cterm=NONE ctermfg=lightmagenta ctermbg=black
	hi PreCondit	gui=NONE guifg=yellow  guibg=bg		cterm=NONE ctermfg=lightmagenta ctermbg=black 
hi Type		gui=ITALIC guifg=#006C00 guibg=bg		cterm=NONE ctermfg=blue ctermbg=black
	hi StorageClass	gui=ITALIC guifg=#006C00 guibg=bg	cterm=NONE ctermfg=blue ctermbg=black
	hi Structure	gui=ITALIC guifg=#006C00 guibg=bg	cterm=NONE ctermfg=blue ctermbg=black
	hi Typedef		gui=BOLD guifg=#006C00 guibg=bg	cterm=NONE ctermfg=blue ctermbg=black
hi Special	gui=ITALIC guifg=#FF8040 guibg=bg		cterm=NONE ctermfg=yellow ctermbg=black
	hi Specialchar	gui=NONE guifg=#CD6839 guibg=bg		cterm=NONE ctermfg=yellow ctermbg=black
	hi Tag			gui=NONE guifg=#CD853F guibg=bg		cterm=NONE ctermfg=yellow ctermbg=black
	hi Delimiter	gui=NONE guifg=#EE9A49 guibg=bg		cterm=NONE ctermfg=yellow ctermbg=black
	hi Debug		gui=NONE guifg=#DAA520 guibg=bg		cterm=NONE ctermfg=yellow ctermbg=black
hi Underlined	gui=UNDERLINE guifg=#F0E68C guibg=bg		cterm=underline ctermfg=white		ctermbg=black
hi Ignore		gui=UNDERCURL	  guifg=#BFBFBF guibg=bg		cterm=NONE		ctermfg=grey		ctermbg=black
hi Error		gui=UNDERCURL	  guifg=#F0E68C guibg=#FF00FF	cterm=NONE		ctermfg=lightyellow ctermbg=lightmagenta
hi Todo			gui=UNDERCURL	  guifg=#00EEEE guibg=#551A8B	cterm=BOLD		ctermfg=lightcyan	ctermbg=darkgray 
