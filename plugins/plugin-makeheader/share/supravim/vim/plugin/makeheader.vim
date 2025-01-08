vim9script
g:makeheader_42_exec = get(g:, 'makeheader_42_exec', 'makeheader --format')

def g:MakeHeader()
	normal! mq
	var line = line('.')
	var equalprg_tmp = &equalprg
	&equalprg = g:makeheader_42_exec
    silent normal! gg=G
    &equalprg = equalprg_tmp
	silent! cursor(line, 1)
enddef

autocmd FileType c,cpp nnoremap <F9>		<esc>:call MakeHeader()<cr>
autocmd FileType c,cpp inoremap <F9>		<esc>:call MakeHeader()<cr>
