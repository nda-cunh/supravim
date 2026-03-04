vim9script

export def MoveLineDown(mode: string)
	var array = getline(line("'<"), line("'>"))
	const len = len(array)
	const begin = line('.')

	if mode == 'n'
		const tmp = getline(line('.') + 1)
		setline(line('.') + 1, getline(line('.')))
		setline(line('.'), tmp)
		normal j==
		return
	elseif line("'<") != begin
		return
	endif

	const tmp = getline(begin + len)
	var i = 0
	reverse(array)

	for str in array
		setline(begin + len - i, str)
		i = i + 1
	endfor
	setline(begin, tmp)
	setpos("'<", [0, begin + 1, 0, 0])
	setpos("'>", [0, begin + len, 0, 0])
	normal! gv=gv
enddef

export def MoveLineUp(mode: string)
	var array = getline(line("'<"), line("'>"))
	var len = len(array)
	var begin = line('.')

	if begin == 1
		return
	elseif mode == 'n'
		const tmp = getline(line('.') - 1)
		setline(line('.') - 1, getline(line('.')))
		setline(line('.'), tmp)
		normal k==
		return
	endif

	if line("'<") != begin
		return
	endif

	const tmp = getline(line('.') - 1)
	var i = begin
	for str in array
		setline(i - 1, str)
	 	i = i + 1
	endfor
	setline(i - 1, tmp)

	setpos("'<", [0, begin - 1, 0, 0])
	setpos("'>", [0, begin + len - 2, 0, 0])
	normal! gv=gv
enddef

export def AutoSaveActivate(activate: bool)
	if activate == true 
		augroup AutoSave
			autocmd!
			autocmd BufLeave,FocusLost,VimLeavePre * {
				if &modifiable == true && &buflisted == true &&  filereadable(expand('%'))
					silent! write
				endif
			}
		augroup END
	else
		autocmd! AutoSave
	endif
enddef
