vim9script

def Comment(regex: string, line: string, nb: number)
	var new_content = substitute(line, '\(\s*\)\(.*\)$', regex, '')
	setline(nb, new_content)
enddef

def UnComment(regex: string, line: string, nb: number)
	var new_content = substitute(line, regex, '', '')
	setline(nb, new_content)
enddef

def CommentLine(regex: string, char: string, nb_line: number, nb_max: number)
	const line = getline(nb_line, nb_max)
	const regex_uncomment = char .. '\s*'
	const regex_comment = '\1' .. char .. ' \2'
	var i = 0
	for nb in range(nb_line, nb_max)
		if line[i] =~ regex
			UnComment(regex_uncomment, line[i], nb)
		else
			Comment(regex_comment, line[i], nb)
		endif
		i += 1
	endfor
enddef

export def Commentary(visual: bool)
	const line = getline('.')
	const e = &filetype
	var min: number
	var max: number
	if visual
		min = getpos("'<")[1]
		max = getpos("'>")[1]
	else
		min = line('.')
		if exists('v:count') && v:count != 0
			max = min + v:count - 1
		else
			max = min
		endif
	endif

	if max > line('$')
		max = line('$')
	endif

	const s = ['c', 'cpp', 'cs', 'c3', 'java', 'javascript', 'php', 'swift', 'kotlin', 'go', 'rust', 'typescript', 'scala', 'vala']
	if index(s, e) >= 0
		CommentLine('^\s*[/][/].*$', '//', min, max)
	elseif e == 'lua' || e == 'sql'
		CommentLine('^\s*--.*$', '--', min, max)
	elseif e == 'asm'
		CommentLine('^\s*[;].*$', ';', min, max)
	else
		CommentLine('^\s*[#].*$', '#', min, max)
	endif
enddef
