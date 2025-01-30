vim9script

g:sp_count_line = true # shows how many lines have functions


highlight Ft_count_line cterm=bold
call prop_type_add("ft_count_line", {highlight: "Ft_count_line"})

def g:Ft_count_line()
	if g:sp_count_line == false 
		return
	endif
	var found_function = false
	var start_line = 0
	var end_view_line = line('w$')
	prop_clear(1, line('$'), {type: 'ft_count_line'})
	
	var begin = line('w0')
	while begin != 0
		var current: string = getline(begin)
		if match(current, '^{') == 0
			begin = begin - 1
			break
		endif
		begin -= 1
	endwhile
	if begin == 0
		begin = line('w0')
	endif

	for row in range(begin, line('$'))
		var current: string = getline(row)
		if row > end_view_line + 1  # dont show lines that are not in the view
			return
		endif
		if match(current, '^{') == 0
			found_function = true
			start_line = row
			continue
		endif
		if match(current, '^}') == 0
			found_function = false
			call prop_add(row, 0, {text: "---- FUNCTION LINES: " .. (row - start_line - 1) .. ' ----', type: 'ft_count_line', text_align: 'below'})
			continue
		endif
	endfor
enddef

if g:sp_count_line == true
	autocmd BufEnter *.c,*.h call g:Ft_count_line()
endif

autocmd CursorMovedI,CursorMoved,TextChanged,TextChangedI,WinScrolled,VimResized *.c,*.h call g:Ft_count_line()

def SimpleSupravimChangeOption()
	if g:supravim_option_changed == 'count_line'
		if g:supravim_option_value == 'true'
			g:sp_count_line = true
			call g:Ft_count_line()
		else
			g:sp_count_line = false 
			prop_clear(1, line('$'), {type: 'ft_count_line'})
		endif
	endif
enddef

autocmd User SupravimChangeOption call SimpleSupravimChangeOption()
