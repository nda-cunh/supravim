vim9script

const SkipQuotesAndComments = "synIDattr(synID(line('.'), col('.'), 1), 'name') =~? 'string\\|comment'"

export def Ft_count_line()
	const position = getpos('.')
	if g:sp_count_line == false
		return
	endif
	var start_line: number = 0
	const end_view_line = line('w$')
	const begin_view_line = line('w0')

	prop_clear(begin_view_line, end_view_line, {type: 'ft_count_line'})
	cursor(begin_view_line, 1)

	while true
		const idx = search('^}', '', line('w$'))
		if idx == 0
			break
		endif
		const i = searchpair("{", '', '}', 'bnW', SkipQuotesAndComments)
		const diff = (idx - i) - 1
		if i == 0
			continue
		endif
		call prop_add(idx, 0, {text: "---- FUNCTION LINES: " .. (diff) .. ' ----', type: 'ft_count_line', text_align: 'below'})
	endwhile
	call setpos('.', position)
enddef

export def EnableAugroup()
	augroup Ft_count_line
		autocmd!
		autocmd CursorMovedI,CursorMoved,WinScrolled,VimResized *.vala,*.c,*.h call Ft_count_line()
	augroup END
enddef

export def SimpleSupravimChangeOption()
	if g:supravim_option_changed == 'count_line'
		if g:supravim_option_value == 'true'
			g:sp_count_line = true
			call Ft_count_line()
			call EnableAugroup()
		else
			g:sp_count_line = false
			prop_clear(1, line('$'), {type: 'ft_count_line'})
			auto! Ft_count_line
		endif
	endif
enddef
