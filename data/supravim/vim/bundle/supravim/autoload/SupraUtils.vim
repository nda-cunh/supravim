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

export def MoveCharRight(mode: string)
	if mode == 'n'
		const lnum = line('.')
		var chars = split(getline(lnum), '\zs')
		const n = len(chars)
		const c = charcol('.')
		if c >= n
			return
		endif
		const tmp = chars[c - 1]
		chars[c - 1] = chars[c]
		chars[c] = tmp
		setline(lnum, join(chars, ''))
		setcursorcharpos(lnum, c + 1)
	else
		if line("'<") != line("'>")
			return
		endif
		const lnum = line("'<")
		var chars = split(getline(lnum), '\zs')
		const n = len(chars)
		const s = charcol("'<")
		const e = charcol("'>")
		if e >= n
			return
		endif
		const moved = remove(chars, e)
		insert(chars, moved, s - 1)
		setline(lnum, join(chars, ''))
		setcharpos("'<", [0, lnum, s + 1, 0])
		setcharpos("'>", [0, lnum, e + 1, 0])
		normal! gv
	endif
enddef

export def MoveCharLeft(mode: string)
	if mode == 'n'
		const lnum = line('.')
		var chars = split(getline(lnum), '\zs')
		const c = charcol('.')
		if c <= 1
			return
		endif
		const tmp = chars[c - 1]
		chars[c - 1] = chars[c - 2]
		chars[c - 2] = tmp
		setline(lnum, join(chars, ''))
		setcursorcharpos(lnum, c - 1)
	else
		if line("'<") != line("'>")
			return
		endif
		const lnum = line("'<")
		var chars = split(getline(lnum), '\zs')
		const s = charcol("'<")
		const e = charcol("'>")
		if s <= 1
			return
		endif
		const moved = remove(chars, s - 2)
		insert(chars, moved, e - 1)
		setline(lnum, join(chars, ''))
		setcharpos("'<", [0, lnum, s - 1, 0])
		setcharpos("'>", [0, lnum, e - 1, 0])
		normal! gv
	endif
enddef

export def AutoSaveActivate(activate: bool)
	if activate == true 
		augroup AutoSave
			autocmd!
			autocmd BufLeave,FocusLost,VimLeavePre * {
				if &modifiable == true && &buflisted == true && filereadable(expand('%'))
					silent! write
				endif
			}
		augroup END
	else
		autocmd! AutoSave
	endif
enddef
