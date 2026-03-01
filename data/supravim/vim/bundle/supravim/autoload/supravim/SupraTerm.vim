vim9script

def CloseTerminalPopup(winid: number, bufnr: number)
	if winid != -1
		popup_close(winid)
	endif
	autocmd! SupraTermResize
	# delete the terminal buffer
	exe "bd! " .. bufnr
enddef

def ResizePopup(winid: number)
	if winid == -1 || popup_getpos(winid) == {}
		return
	endif
	popup_move(winid, {
		minwidth: float2nr(&columns * 0.7),
		maxwidth: float2nr(&columns * 0.7),
		minheight: float2nr(&lines * 0.8),
		maxheight: float2nr(&lines * 0.8),
	})
enddef

export def SupraTerm()
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

	augroup SupraTermResize
		autocmd!
		exe $"autocmd VimResized * call s:ResizePopup({winid})"
	augroup END

	const close_call = $"<ScriptCmd>CloseTerminalPopup({winid}, {buf})<cr>"
	term_sendkeys(buf, "\<c-l>")
	win_execute(winid, 'tnoremap <buffer> <esc>		<c-\><c-n>' .. close_call)
	win_execute(winid, 'tnoremap <buffer> <c-q>		<c-\><c-n>' .. close_call)
	win_execute(winid, 'tmap <buffer> <c-\><c-n>	<c-\><c-n>' .. close_call)
enddef
