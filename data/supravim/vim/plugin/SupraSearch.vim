vim9script

import autoload 'SupraPopup.vim' as Popup

var first_buffer = []

def g:SupraSearch(visualmode: bool = false)
	var mid_cursor: number = 0
	var mid_occurence: number = 0
	var mid_search: number = 0

	var min: number
	var max: number
	if visualmode == true
		var p1 = getpos("'<")
		var p2 = getpos("'>")
		min = p1[1]
		max = p2[1]
		var list_pos: list<list<number>> = []
		for i in range(min, max)
			var pos: list<number> = [i, 0, 0]
			add(list_pos, pos)
		endfor
		mid_cursor = matchaddpos('Visual', list_pos, 1)
	else
		# mid_cursor = matchadd('Visual', '.*')
		min = 0
		max = line('$')
	endif


	var background = Popup.Simple({
		prompt: 'SupraSearch',
		line: 2,
		col: &columns,
		width: 31,
		height: 6,
	})

	var pop1 = Popup.Input({
		prompt: 'Find │ ',
		col: &columns - 2,
		line: 3,
		width: 27,
		maxwidth: 27,
	})

	var pop2 = Popup.Input({
		prompt: 'Replace │ ',
		col: &columns - 2,
		line: 6,
		maxwidth: 27,
		width: 27,
	})
	
	Popup.SetFocus(pop1)

	var RemoveMidCursor = () => {
		if mid_cursor > 0
			call matchdelete(mid_cursor)
			mid_cursor = 0
		endif
	}
	var RemoveSupramid = () => {
		if mid_occurence > 0
			call matchdelete(mid_occurence)
			mid_occurence = 0
		endif
	}
	var RemoveMidSearch = () => {
		if mid_search > 0
			call matchdelete(mid_search)
			mid_search = 0
		endif
	}

	#### Set Focus
	Popup.SetEventFocus(pop1, (_) => {
		return {next: pop2, prev: pop2}
	})

	Popup.SetEventFocus(pop2, (_) => {
		return {next: pop1, prev: pop1}
	})

	#### Move the Find Cursor with Up and Down
	Popup.AddEventKeyPressedFocus(pop1, (_, key) => {
		var jump_line: number = 0
		var event = false
		const input_search = Popup.GetInput(pop1)
		const len = len(input_search)
		if visualmode == true
			if key == "\<Up>"
				jump_line = search(input_search, 'b', min)
				if jump_line == 0
					call cursor(max + 1, 1)
					jump_line = search(input_search, 'b', min)
				endif
				event = true
			elseif key == "\<Down>"
				jump_line = search(input_search, '', max)
				if jump_line == 0
					call cursor(min - 1, 1)
					jump_line = search(input_search, '', max)
				endif
				event = true
			endif
		else
			if key == "\<Up>"
				jump_line = search(input_search, 'b')
				event = true
			elseif key == "\<Down>"
				jump_line = search(input_search)
				event = true
			endif
		endif
		if jump_line != 0 
			RemoveMidSearch()
			const pos = getpos('.')
			mid_search = matchaddpos('Search', [[jump_line, pos[2], len]], 42)
		endif
		if event == true
			return Popup.BLOCK
		endif
		return Popup.CONTINUE
	})


	#### Remove the Find Cursor if the find is terminated
	Popup.AddEventClose(pop1, (pop) => {
		if first_buffer != []
			call setline(1, first_buffer)
			first_buffer = []
		endif
		RemoveMidCursor()
		RemoveSupramid()
		RemoveMidSearch()
	})

	#### When Find Popup is Entered, Go to the first match
	Popup.AddEventInputEnter(pop1, (line) => {
		setreg('/', line)
		silent! Popup.Close(pop1)
		silent! Popup.Close(pop2)
		silent! Popup.Close(background)
		RemoveMidCursor()
		RemoveMidSearch()
			RemoveMidSearch()
	})

	#### When Replace Popup is Entered, replace the with the substitution
	Popup.AddEventInputEnter(pop2, (line) => {
		first_buffer = getline(1, '$')
		noautocmd w!
		Popup.Close(pop1)
		Popup.Close(pop2)
		Popup.Close(background)
		RemoveMidCursor()
		RemoveMidSearch()
		RemoveMidSearch()
	})

	#### When pop2 is focused, save the first buffer
	Popup.AddEventGetFocus(pop2, (_) => {
		echo 'popup2 focused'
		first_buffer = getline(1, '$')
		var line = Popup.GetInput(pop2)
		var save_pos = getpos('.')
		call cursor(1, 1)
		normal! "0dG"
		call setline(1, first_buffer)
		silent! execute ':' .. min .. ',' .. max .. 's/' .. Popup.GetInput(pop1) .. '/' .. line .. '/g'
		call setpos('.', save_pos)
	})

	Popup.AddEventGetFocus(pop1, (_) => {
		echo 'popup1 focused'
		var save_pos = getpos('.')
		call cursor(1, 1)
		normal! "0dG"
		call setline(1, first_buffer)
		call setpos('.', save_pos)
	})


	Popup.AddEventInputChanged(pop2, (key, line) => {
		silent! undojoin
		var input_pop1 = Popup.GetInput(pop1)
		if input_pop1 == ''
			Popup.ClearInput(pop2)
			return
		endif
		var save_pos = getpos('.')
		call cursor(1, 1)
		normal! "0dG"
		call setline(1, first_buffer)
		silent! execute ':' .. min .. ',' .. max .. 's/' .. input_pop1 .. '/' .. line .. '/g'
		call setpos('.', save_pos)
	})

	# When typing in the Find Popup (jump to the first match)
	Popup.AddEventInputChanged(pop1, (key, line) => {
		RemoveSupramid()
		var jump_line: number = 0

		if line == ''
			return
		endif

		var search: string
		if visualmode == true
			if min == max
				search = '\%' .. min .. 'l' .. line
			else
				var min_tmp = min - 1
				var max_tmp = max + 1
				search = '\%>' .. min_tmp .. 'l\%<' .. max_tmp .. 'l' .. line
			endif
			silent! jump_line = search(line, 'c', max)
		else 
			silent! jump_line = search(line, 'c')
			search = line
		endif
		RemoveMidSearch()
		if jump_line != 0 
			const pos = getpos('.')
			const len = len(line)
			mid_search = matchaddpos('Search', [[jump_line, pos[2], len]], 42)
		endif

		silent! mid_occurence = matchadd('Cursor', search, 10)
		if mid_occurence <= 0
			mid_occurence = 0
		endif
	})
enddef
