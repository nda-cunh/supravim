vim9script

const pair = {
	'"': '"',
	"'": "'",
	'`': '`',
	'(': ')',
	'[': ']',
	'{': '}',
	'<': '>',
}

export def EnableAutoRound(char: string)
	execute 'silent! iunmap ' .. char
	execute 'silent! sunmap ' .. char

	if has_key(pair, char)
		var charend = pair[char]

		var c1 = (char == "\"" ? "\\\"" : char)
		var c2 = (charend == "\"" ? "\\\"" : charend)

		execute 'vnoremap ' .. char .. ' <esc><scriptcmd>RoundIt("' .. c1 .. '", "' .. c2 .. '")<CR>'
		execute 'snoremap ' .. char .. ' ' .. char .. charend .. '<left>'
	endif
enddef

export def DisableAutoRound(char: string)
	execute 'silent! iunmap ' .. char
	execute 'silent! sunmap ' .. char
enddef


def RoundIt(char: string, charend: string)
	const p1 = getpos("'<")
	const p2 = getpos("'>")
	call cursor(p1[1], p1[2])
	execute('normal! i' .. char)
	call cursor(p2[1], p2[2] + 1)
	execute('normal! a' .. charend)
enddef
