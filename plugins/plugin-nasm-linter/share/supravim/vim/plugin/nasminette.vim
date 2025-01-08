vim9script

au BufWritePost *.s,*.asm,*.nasm call Nasminette()
au BufEnter *.s,*.asm,*.nasm call Nasminette()

highlight NasmPointColor ctermfg=9
highlight NasmPointColorWarn ctermfg=227
sign define NasmLinter text=\ ✖ texthl=NasmPointColor
sign define NasmLinterWarn text=\ ✖ texthl=NasmPointColorWarn

g:error = []
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
	call add(g:error, group)
enddef

def g:Nasminette()
	sign unplace * 
	g:error = []
	var file: string = expand("%:p")
	var out = system('nasm -L+ -w+all -f elf64 ' .. file .. ' -o /tmp/' .. expand('$USER') .. '_supranasm 1>/dev/stderr')
	var lines = split(out, '\n')
	for line in lines
		call NasminetteLine(line)
	endfor
enddef

def DisplayNasmErrorMsg()
	final line_now: number = line('.')
	final line_end: number = line('$') + 1
	for error in g:error
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

autocmd CursorMoved *.s DisplayNasmErrorMsg()
