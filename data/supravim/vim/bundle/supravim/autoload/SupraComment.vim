vim9script

export const NORMAL = 0
export const FORCE_COMMENT = 1
export const FORCE_UNCOMMENT = 2

def CommentLine(begin: string, end: string, nb_line: number, nb_max: number, force: number)
	const line = getline(nb_line, nb_max)
	const regex = '^\s*' .. begin
	const regex_uncomment = '^\s*\zs' .. begin .. ' \?\ze'
	const regex_comment = '&' .. begin .. ' '

	var is_only_comment = true 

	if force == NORMAL 
		for nb in range(nb_line, nb_max)
			if !(line[nb - nb_line] =~ regex)
				is_only_comment = false 
				break
			endif
		endfor
	endif

	if (is_only_comment && force == NORMAL) || force == FORCE_UNCOMMENT
		# Uncomment lines
		for nb in range(nb_line, nb_max)
			const l = line[nb - nb_line]
			const content = substitute(l, regex_uncomment, '', '')
			setline(nb, content)
		endfor
	elseif (is_only_comment == false && force == NORMAL) || force == FORCE_COMMENT
		# Comment lines
		for nb in range(nb_line, nb_max)
			const l = line[nb - nb_line]
			const content = substitute(l, '^\s*', regex_comment, '')
			setline(nb, content)
		endfor
	endif
enddef

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

	const s = ['c', 'cpp', 'cs', 'c3', 'java', 'javascript', 'php', 'swift', 'kotlin', 'go', 'rust', 'typescript', 'scala', 'vala', 'ts', 'tsx']
	if index(s, e) >= 0
		CommentLine('//', '', min, max, force)
	elseif e == 'lua' || e == 'sql'
		CommentLine('--', '', min, max, force)
	elseif e == 'asm'
		CommentLine(';', '', min, max, force)
	elseif e == 'vim'
			try
			var content = readfile(expand('%:p'), '', 10)
			for l in content
				if stridx(l, 'vim9script') == 0
					CommentLine('#', '', min, max, force)
					return
				endif
			endfor
			CommentLine('"', '', min, max, force)
			catch
			endtry
	else
		CommentLine('#', '', min, max, force)
	endif
enddef
