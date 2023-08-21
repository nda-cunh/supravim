vim9script
noremap <c-_>	:call Commentary()<CR>

def Comment(char: string, line: string)
	var new_content = substitute(line, '\(\s*\)\(.*\)$', '\1' .. char .. ' \2', '')
	setline('.', new_content)
enddef

def UnComment(char: string, line: string)
	var new_content = substitute(line, char .. '\s*', '', '')
	setline('.', new_content)
enddef

def g:Commentary()
	var e = expand('%:e')
	var line = getline('.')

	if e == 'cpp' || e == 'vala' || e == 'vapi' || e == 'hpp' || e == 'tpp' || e == 'h' || e == 'c' || e == 'vue' || e == 'ts' || e == 'js'
		if line =~ '^\s*[/][/].*$'
			UnComment('//', line)
		else
			Comment('//', line)
		endif
	else
		if line =~ '^\s*[#].*$'
			UnComment('#', line)
		else
			Comment('#', line)
		endif
	endif
enddef
