vim9script

import autoload 'SupraPopup.vim' as Popup

var supramid = 0
var first_buffer = []

def g:SupraSearch(visualmode: bool = false)
	var mid_cursor: number = 0
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
		mid_cursor = matchaddpos('Visual', list_pos)
	else
		mid_cursor = matchadd('Visual', '.*')
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

	#### Set Focus
	Popup.SetEventFocus(pop1, (_) => {
		return {next: pop2, prev: pop2}
	})
	Popup.SetEventFocus(pop2, (_) => {
		return {next: pop1, prev: pop1}
	})

	#### Esc key Close background
	Popup.AddEventKeyPressedNoFocus(background, (_, key) => {
		if key == "\<Esc>"
			Popup.Close(background)
		endif
		return Popup.CONTINUE
	})

	#### Move the Find Cursor with Up and Down
	Popup.AddEventKeyPressedFocus(pop1, (_, key) => {
		const input_search = Popup.GetInput(pop1)
		if visualmode == true
			if key == "\<Up>"
				var line_found = search(input_search, 'b', min)
				if line_found == 0
					call cursor(max + 1, 1)
					search(input_search, 'b', min)
				endif
				return Popup.BLOCK
			elseif key == "\<Down>"
				var line_found = search(input_search, '', max)
				if line_found == 0
					call cursor(min - 1, 1)
					search(input_search, '', max)
				endif
				return Popup.BLOCK
			endif
		else
			if key == "\<Up>"
				search(input_search, 'b')
				return Popup.BLOCK
			elseif key == "\<Down>"
				search(input_search)
				return Popup.BLOCK
			endif
		endif
		return Popup.CONTINUE
	})


	#### Remove the Find Cursor if the find is terminated
	Popup.AddEventClose(pop1, (pop) => {
		if supramid > 0
			call matchdelete(supramid)
			supramid = 0
		endif
		if first_buffer != []
			call setline(1, first_buffer)
			first_buffer = []
		endif
		if mid_cursor > 0
			call matchdelete(mid_cursor)
			mid_cursor = 0
		endif
	})

	#### When Find Popup is Entered, Go to the first match
	Popup.AddEventInputEnter(pop1, (line) => {
		setreg('/', line)
		silent! Popup.Close(pop1)
		silent! Popup.Close(pop2)
		silent! Popup.Close(background)
		if mid_cursor > 0
			call matchdelete(mid_cursor)
			mid_cursor = 0
		endif
	})

	#### When Replace Popup is Entered, replace the with the substitution
	Popup.AddEventInputEnter(pop2, (line) => {
		first_buffer = getline(1, '$')
		noautocmd w!
		Popup.Close(pop1)
		Popup.Close(pop2)
		Popup.Close(background)
		if mid_cursor > 0
			call matchdelete(mid_cursor)
			mid_cursor = 0
		endif
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

	Popup.AddEventInputChanged(pop1, (key, line) => {
		if supramid > 0
			call matchdelete(supramid)
			supramid = 0
		endif

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
			silent! search(line, 'c', max)
		else 
			silent! search(line, 'c')
			search = line
		endif

		silent! supramid = matchadd('Cursor', search)
		if supramid <= 0
			supramid = 0
		endif
	})
enddef
