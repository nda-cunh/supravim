vim9script
g:c_formatter_42_exec           = get(g:, 'c_formatter_42_exec', 'c_formatter_42')

def g:C42Formatter()
	w
	normal! mq
	var equalprg_tmp = &equalprg
	&equalprg = g:c_formatter_42_exec
    silent normal! gg=G
    &equalprg = equalprg_tmp
	normal! `q
    normal! zz
enddef

autocmd FileType c,cpp nnoremap <leader><F2>		<esc>:call C42Formatter()<cr>
autocmd FileType c,cpp inoremap <leader><F2>		<esc>:call C42Formatter()<cr>
