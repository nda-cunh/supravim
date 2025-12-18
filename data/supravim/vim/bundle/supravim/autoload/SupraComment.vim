vim9script

export const NORMAL = 0
export const FORCE_COMMENT = 1
export const FORCE_UNCOMMENT = 2

# Define comment styles for various languages
# The format is: [Begin comment, End comment]
const C_COMMENT = ['//', '']
const LUA_COMMENT = ['--', '']
const LISP_COMMENT = [';', '']
const TEX_COMMENT = ['%', '']
const XML_COMMENT = ['<!--', '-->']

const comment_map: dict<list<string>> = {
# C-style (//)
	'c': C_COMMENT,
	'cpp': C_COMMENT,
	'cs': C_COMMENT,
	'java': C_COMMENT,
	'javascript': C_COMMENT,
	'typescript': C_COMMENT,
	'php': C_COMMENT,
	'go': C_COMMENT,
	'rust': C_COMMENT,
	'scala': C_COMMENT,
	'kotlin': C_COMMENT,
	'swift': C_COMMENT,
	'dart': C_COMMENT,
	'groovy': C_COMMENT,
	'jsonc': C_COMMENT,
	'verilog': C_COMMENT,
	'systemverilog': C_COMMENT,
	'javascriptreact': C_COMMENT,
	'typescriptreact': C_COMMENT,
	'blp': C_COMMENT,
	'vala': C_COMMENT,
	'c3': C_COMMENT,
	'ts': C_COMMENT,
	'tsx': C_COMMENT,
	'zig': C_COMMENT,

# SQL/Lua style (--)
	'lua': LUA_COMMENT,
	'sql': LUA_COMMENT,
	'haskell': LUA_COMMENT,
	'ada': LUA_COMMENT,
	'vhdl': LUA_COMMENT,
	'applescript': LUA_COMMENT,

# Lisp/ASM style (;)
	'asm': LISP_COMMENT,
	'lisp': LISP_COMMENT,
	'scheme': LISP_COMMENT,
	'clojure': LISP_COMMENT,
	'dune': LISP_COMMENT,
	'ini': LISP_COMMENT,

# LaTeX/Erlang (%)
	'tex': TEX_COMMENT,
	'plaintex': TEX_COMMENT,
	'erlang': TEX_COMMENT,
	'matlab': TEX_COMMENT,
	'bib': TEX_COMMENT,

# Langages à balises (besoin de fermeture)
	'html': XML_COMMENT,
	'xml': XML_COMMENT,
	'markdown': XML_COMMENT,
	'vue': XML_COMMENT,
	'svg': XML_COMMENT,
	'xhtml': XML_COMMENT,
# Others
	'css': ['/*', '*/'],
	'ocaml': ['(*', '*)'],
	'fortran': ['!', ''],
	'dosbatch': ['REM ', ''],
}

def CommentLine(begin: string, end: string, nb_line: number, nb_max: number, force: number)
	const line = getline(nb_line, nb_max)
	const begin_esc = escape(begin, '/*^$.~[]')
    const end_esc = escape(end, '/*^$.~[]')
	const regex = '^\s*' .. begin_esc
	const regex_uncomment = '^\s*\zs' .. begin_esc .. ' \?\ze'
	const regex_comment = '&' .. begin_esc .. ' '
	const regex_uncomment_end = ' \?' .. end_esc .. '$'

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
			var content = substitute(l, regex_uncomment, '', '')
            if end != ''
                content = substitute(content, regex_uncomment_end, '', '')
			endif
			setline(nb, content)
		endfor
	elseif (is_only_comment == false && force == NORMAL) || force == FORCE_COMMENT
		# Comment lines
		for nb in range(nb_line, nb_max)
			const l = line[nb - nb_line]
			var content = substitute(l, '^\s*', regex_comment, '')
            if end != ''
                content = content .. ' ' .. end
			endif
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

	if e == 'vim'
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
		if has_key(comment_map, e)
			const markers = comment_map[e]
			CommentLine(markers[0], markers[1], min, max, force)
		else
			# Default to hash (#)
			CommentLine('#', '', min, max, force)
		endif
	endif
enddef

