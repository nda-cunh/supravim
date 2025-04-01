vim9script

highlight NasmPointColor ctermfg=9
highlight NasmPointColorWarn ctermfg=227
sign define NasmLinter text=\ ✖ texthl=NasmPointColor
sign define NasmLinterWarn text=\ ✖ texthl=NasmPointColorWarn

var g_error = []
const g:user_name = expand('$USER')

def NasminetteLine(line: string)
	var list: list<string> = split(line, ':')
	var line_nu: string = list[1]
	var type: string = list[2]
	var msg: string
	if type == ' error'
		msg = substitute(line, '^.*error: ', '', 'g')
	else
		msg = substitute(line, '^.*warning: ', '', 'g')
	endif

	final n: number = str2nr(line_nu)
	if n == line('$') + 1
		sign place 3 name=NasmLinter line=1
	else
		if type == ' error'
			exe ":sign place 3 name=NasmLinter line=" .. line_nu
		else
			exe ":sign place 3 name=NasmLinterWarn line=" .. line_nu
		endif
	endif
	var group = [line_nu, msg]
	call add(g_error, group)
enddef

def GotOutput(channel: channel, msg: string)
	call NasminetteLine(msg)
enddef

def DisplayNasmErrorMsg()
	final line_now: number = line('.')
	final line_end: number = line('$') + 1
	for error in g_error
		final line_err = str2nr(error[0])
		if line_now == 1 && line_err == line_end
			echo "[Nasm]: " .. error[1]
			break
		elseif line_now == line_err
			echo "[Nasm]: " .. error[1]
			break
		else
			echo ""
		endif
	endfor
enddef

def g:Nasminette()
	sign unplace * 
	g_error = []
	var file = expand('%:p')
	if findfile(file, &rtp) == ''
		return
	endif
	job_start(['nasm', '-L+', '-w+all', '-f elf64', expand("%:p"), '-o /tmp/' .. expand('$USER') .. '_supranasm'], {
		out_cb: GotOutput,
		err_cb: GotOutput,
		out_timeout: 3000
	})
enddef

augroup Nasminette
	autocmd!
	au BufWritePost *.s,*.asm,*.nasm call Nasminette()
	au BufEnter *.s,*.asm,*.nasm call Nasminette()
	au CursorMoved *.s DisplayNasmErrorMsg()
augroup END
