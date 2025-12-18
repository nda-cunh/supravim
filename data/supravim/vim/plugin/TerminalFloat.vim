vim9script

def g:CloseTerminalPopup(winid: number, bufnr: number)
	if winid != -1
		call popup_close(winid)
	endif
	# delete the terminal buffer
	exe "bd! " .. bufnr
enddef

def g:SupraTerm()
	hi link Terminal Search
	var buf = term_start([expand("$SHELL")], {
		hidden: 1,
		term_finish: 'close',
	})

	var winid = popup_create(buf, {
		minwidth: float2nr(&columns * 0.7),
		maxwidth: float2nr(&columns * 0.7),
		minheight: float2nr(&lines * 0.8),
		maxheight: float2nr(&lines * 0.8),
		border: [1],
		borderhighlight: ['Normal', 'Normal', 'Normal', 'Normal'],
		borderchars: ['─', '│', '─', '│', '╭', '╮', '󰧄', '╰'],
		drag: 1,
		dragall: 1,
		resize: 1,
		callback: (_, _) => {
			echom "Closing SupraTerm"
		},
	})
	term_sendkeys(buf, "\<c-l>")
	win_execute(winid, 'tnoremap <buffer> <esc>		<c-\><c-n>:call CloseTerminalPopup(' .. winid .. ', ' .. buf .. ')<cr>')
	win_execute(winid, 'tmap <buffer> <c-\><c-n>		<c-\><c-n>:call CloseTerminalPopup(' .. winid .. ', ' .. buf .. ')<cr>')
enddef
