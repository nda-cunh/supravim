vim9script

g:sp_count_line = false # shows how many lines have functions

highlight Ft_count_line cterm=bold
call prop_type_add("ft_count_line", {highlight: "Ft_count_line"})

def Ft_count_line()
	if g:sp_count_line == false
		return
	endif
	var found_function = false
	var start_line: number = 0
	const end_view_line = line('w$')
	const begin_view_line = line('w0')

	prop_clear(begin_view_line, end_view_line, {type: 'ft_count_line'})

	for row in range(begin_view_line, end_view_line)
		const current: string = getline(row)
		if current =~# '^{'
			found_function = true
			start_line = row
			continue
		endif
		if current =~# '^}'
			if found_function == false
				var i = begin_view_line
				while i != 1
					const prev_line: string = getline(i)
					if prev_line =~# '^{'
						start_line = i
						break
					endif
					i -= 1
				endwhile
			endif
			found_function = false
			call prop_add(row, 0, {text: "---- FUNCTION LINES: " .. (row - start_line - 1) .. ' ----', type: 'ft_count_line', text_align: 'below'})
			continue
		endif
	endfor
enddef

if g:sp_count_line == true
	autocmd BufEnter *.c,*.h call Ft_count_line()
endif

autocmd CursorMoved,CursorMovedI,TextChanged,TextChangedI,WinScrolled,VimResized *.c,*.h silent! call Ft_count_line()

def SimpleSupravimChangeOption()
	if g:supravim_option_changed == 'count_line'
		if g:supravim_option_value == 'true'
			g:sp_count_line = true
			call Ft_count_line()
		else
			g:sp_count_line = false
			prop_clear(1, line('$'), {type: 'ft_count_line'})
		endif
	endif
enddef

autocmd User SupravimChangeOption call SimpleSupravimChangeOption()
