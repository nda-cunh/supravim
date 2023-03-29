vim9script
vnoremap c		:call Commentary()<CR>
noremap c		:call Commentary()<CR>
noremap gcc		:call Commentary()<CR>

def Commentator(char: string, line: string)
	if line =~ '^\s*' .. char .. '.*'
		var new_content = substitute(line, char .. '\(.*\)$', '\1', '')
		setline('.', new_content)
	else
		var new_content = substitute(line, '\(\s*\)\(.*\)$', '\1' .. char .. '\2', '')
		setline('.', new_content)
	endif
enddef

def g:Commentary()
	var e = expand('%:e')
	var line = getline('.')

	if e == 'cpp' || e == 'vala' || e == 'hpp' || e == 'tpp' || e == 'h' || e == 'c'
		Commentator('// ', line)
	else
		Commentator('# ', line)
	endif
enddef
