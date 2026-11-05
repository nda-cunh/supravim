vim9script

const SkipQuotesAndComments = "synIDattr(synID(line('.'), col('.'), 1), 'name') =~? 'string\\|comment'"

export def Ft_count_line()
	const position = getpos('.')
	const end_view_line = line('w$')
	const begin_view_line = line('w0')

	var lst = prop_list(begin_view_line, {types: ['ft_count_line'], end_lnum: end_view_line})
	for item in lst
		call prop_remove(item)
	endfor
	if end_view_line - begin_view_line < 3
		return
	endif
	cursor(begin_view_line, 1)

	while true
		const idx = search('^}', '', line('w$'))
		if idx == 0
			break
		endif
		const i = searchpair("{", '', '}', 'bnW', SkipQuotesAndComments)
		# check if it's a function
		if stridx(getline(i), ')') == -1 && stridx(getline(i - 1), ')') == -1
			continue
		endif
		const diff = (idx - i) - 1
		if i == 0
			continue
		endif
		call prop_add(idx, 0, {text: "---- FUNCTION LINES: " .. (diff) .. ' ----', type: 'ft_count_line', text_align: 'after', text_padding_left: 1})
	endwhile
	call setpos('.', position)
enddef

export def EnableAugroup()
	augroup Ft_count_line
		autocmd!
		autocmd CursorMovedI,CursorMoved,WinScrolled,VimResized *.vala,*.c,*.h call Ft_count_line()
	augroup END
enddef

export def SimpleSupravimChangeOption(value: bool)
	if value == true
		hi! Ft_count_line cterm=bold
		call prop_type_add("ft_count_line", {highlight: "Ft_count_line"})
		call Ft_count_line()
		call EnableAugroup()
	else
		try 
		var lst = prop_list(1, {types: ['ft_count_line'], end_lnum: line('$')})
		for item in lst
			call prop_remove(item)
		endfor
		auto! Ft_count_line
		catch
		endtry
	endif
enddef
