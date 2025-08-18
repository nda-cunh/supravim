vim9script

def Comment(regex: string, line: string, nb: number)
	var new_content = substitute(line, '\(\s*\)\(.*\)$', regex, '')
	setline(nb, new_content)
enddef

def UnComment(regex: string, line: string, nb: number)
	var new_content = substitute(line, regex, '', '')
	setline(nb, new_content)
enddef

def CommentLine(regex: string, char: string, nb_line: number, nb_max: number, force: number)
	const line = getline(nb_line, nb_max)
	const regex_uncomment = char .. '\s*'
	const regex_comment = '\1' .. char .. ' \2'
	var i = 0
	for nb in range(nb_line, nb_max)
		if line[i] =~ regex
			if force == FORCE_UNCOMMENT || force == NORMAL
				UnComment(regex_uncomment, line[i], nb)
			endif
		else
			if force == FORCE_COMMENT || force == NORMAL
				Comment(regex_comment, line[i], nb)
			endif
		endif
		i += 1
	endfor
enddef

export const NORMAL = 0
export const FORCE_COMMENT = 1
export const FORCE_UNCOMMENT = 2

export def Commentary(visual: bool, force: number = NORMAL)
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
		CommentLine('^\s*[/][/].*$', '//', min, max, force)
	elseif e == 'lua' || e == 'sql'
		CommentLine('^\s*--.*$', '--', min, max, force)
	elseif e == 'asm'
		CommentLine('^\s*[;].*$', ';', min, max, force)
	else
		if e == 'vim'
			# if first line is not vim9script use '#'
			try
			var content = readfile(expand('%:p'), '', 10)
			if index(content, 'vim9script') < 0
				CommentLine('^\s*".*$', '"', min, max, force)
				return
			endif
			catch
			endtry
		endif
		CommentLine('^\s*[#].*$', '#', min, max, force)
	endif
enddef
