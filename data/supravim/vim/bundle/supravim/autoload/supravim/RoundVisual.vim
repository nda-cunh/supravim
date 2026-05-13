vim9script

def RoundIt(char: string, charend: string)
        const p1 = getpos("'<")
        const p2 = getpos("'>")
        call cursor(p1[1], p1[2])
        execute('normal! i' .. char)
        call cursor(p2[1], p2[2] + 1)
        execute('normal! a' .. charend)
enddef

export def EnableAutoRound(char: string, charend: string)
        execute 'silent! iunmap ' .. char
        execute 'silent! sunmap ' .. char

	const c1 = (char == "\"" ? "\\\"" : char)
	const c2 = (charend == "\"" ? "\\\"" : charend)

	execute 'vnoremap ' .. char .. ' <esc><scriptcmd>RoundIt("' .. c1 .. '", "' .. c2 .. '")<CR>'
	execute 'snoremap ' .. char .. ' ' .. char .. charend .. '<left>'
enddef

export def DisableAutoRound(char: string)
        execute 'silent! iunmap ' .. char
        execute 'silent! sunmap ' .. char
enddef


