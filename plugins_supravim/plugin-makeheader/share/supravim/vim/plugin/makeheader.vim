vim9script

var makeheader_42_exec = get(g:, 'makeheader_42_exec', 'makeheader --format')

def MakeHeader()
	normal! mq
	const line = line('.')
	const equalprg_tmp = &equalprg
	&equalprg = makeheader_42_exec
    silent normal! gg=G
    &equalprg = equalprg_tmp
	silent! cursor(line, 1)
enddef


def MenuColor(ctx: dict<any>): dict<any>
	echoerr ctx
	return {}
enddef

def InitMenuColor()
	call SupraMenu#Register(MenuColor)
enddef

au User SupraMenuLoaded InitMenuColor()



autocmd FileType c,cpp nnoremap <F9>	<scriptcmd>MakeHeader()<cr>
autocmd FileType c,cpp inoremap <F9>	<scriptcmd>MakeHeader()<cr>
