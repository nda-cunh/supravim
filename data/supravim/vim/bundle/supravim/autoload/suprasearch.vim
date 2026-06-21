vim9script

import autoload 'SupraPop/Base.vim'   as Base
import autoload 'SupraPop/Simple.vim' as Simple
import autoload 'SupraPop/Input.vim'  as Input

var first_buffer = []
#
########### MENU Part ############
export def InitMenu()
	call SupraMenu#Register(MenuSearch)
enddef

export def SupraSearchMenu()
	var pos1 = getpos("'<")
	var pos2 = getpos("'>")
	var content = getregion(pos1, pos2, {type: visualmode()})
	var text = join(content, '\n')
	SupraSearch(false, text)
enddef

def MenuSearch(ctx: dict<any>): dict<any>
	return {
        priority: 0,
        rows: [
            {
                label: 'Search selection',
                cmd: $':vim9cmd call suprasearch#SupraSearchMenu()<cr>',
                icon: '󱈄',
                type: 'v'
            }
        ]
    }
enddef

############ END of MENU Part ############

export def SupraSearch(_visualmode: bool = false, _pre_text: string = '')
	const r1 = getreg('1')
	const r2 = getreg('2')
	const r3 = getreg('3')
	const r4 = getreg('4')
	const r5 = getreg('5')
	const r6 = getreg('6')
	const r7 = getreg('7')
	const r8 = getreg('8')
	const r9 = getreg('9')
	var mid_cursor: number = 0
	var mid_occurence: number = 0
	var mid_search: number = 0
	var visualmode = _visualmode
	var pre_text = _pre_text
	var history_search_idx = 0
	var find = false

	var view = winsaveview()
	var min: number
	var max: number
	if visualmode == true
		var p1 = getpos("'<")
		var p2 = getpos("'>")
		min = p1[1]
		max = p2[1]
		if min == max
			visualmode = false
			var cword = expand('<cword>')
			pre_text = cword
		else
			var list_pos: list<list<number>> = []
			for i in range(min, max)
				var pos: list<number> = [i, 0, 0]
				add(list_pos, pos)
			endfor
			mid_cursor = matchaddpos('Visual', list_pos, 1)
		endif
	else
		min = 0
		max = line('$')
	endif

	var background = Simple.Simple.new({
		# prompt: 'SupraSearch',
		line: 2,
		col: &columns - 34,
		width: 31,
		height: 6,
	})

	const c = '➜ '
	var pop1 = Input.Input.new({
		prompt: c,
		title: ' Find',
		title_pos: 'left',
		col: &columns - 32,
		line: 3,
		width: 27,
		maxwidth: 27,
	})

	var pop2 = Input.Input.new({
		prompt: c,
		title: ' Replace',
		title_pos: 'left',
		col: &columns - 32,
		line: 6,
		maxwidth: 27,
		width: 27,
	})
	
	pop1.SetFocus()
	
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


	var EventWhenFindInput = (line) => {
		const count = CountOccurences(line)
		if count == 0 
			pop1.SetTitle(' Find')
		else
			pop1.SetTitle(' Find ' .. CountOccurences(line))
		endif
		RemoveSupramid()
		var jump_line: number = 0

		RemoveMidSearch()
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
		try
		if jump_line != 0 
			const pos = getpos('.')
			const len = len(line)
			mid_search = matchadd('Search', '\%#' .. line, 42)
		endif

		silent! mid_occurence = matchadd('Cursor', search, 10)
		if mid_occurence <= 0
			mid_occurence = 0
		endif
		catch
		endtry

	}

	if pre_text != ''
		pop1.SetInput(pre_text)
		EventWhenFindInput(pre_text)
	endif

	#### Set Focus
	pop1.SetEventFocus((_) => {
		return {next: pop2, prev: pop2}
	})

	pop2.SetEventFocus((_) => {
		return {next: pop1, prev: pop1}
	})

	#### Move the Find Cursor with Up and Down
	pop1.AddEventKeyPressedFocus((_, key) => {
		if key == "\<C-Up>"
			if history_search_idx <= 0
				history_search_idx -= 1
				var history = histget('search', history_search_idx)
				echo history .. ' ' .. history_search_idx
				if history != ''
					pop1.SetInput(history)
				else
					history_search_idx += 1
				endif
			endif
			return Base.BLOCK
		elseif key == "\<C-Down>"
			if history_search_idx != 0 
				history_search_idx += 1
				var history = histget('search', history_search_idx)
				echo history .. ' ' .. history_search_idx
				if history_search_idx == 0
					pop1.SetInput('')
				elseif history != ''
					pop1.SetInput(history)
				else
					history_search_idx -= 1
				endif
			endif
			return Base.BLOCK
		endif
		var jump_line: number = 0
		var event = false
		const input_search = pop1.GetInput()
		const len = len(input_search)
		if visualmode == true
			if key == "\<Up>"
				if input_search == ''
					return Base.BLOCK
				endif
				jump_line = search(input_search, 'b', min)
				if jump_line == 0
					call cursor(max + 1, 1)
					jump_line = search(input_search, 'b', min)
				endif
				event = true
			elseif key == "\<Down>"
				if input_search == ''
					return Base.BLOCK
				endif
				jump_line = search(input_search, '', max)
				if jump_line == 0
					call cursor(min - 1, 1)
					jump_line = search(input_search, '', max)
				endif
				event = true
			endif
		else
			if key == "\<Up>"
				if input_search == ''
					return Base.BLOCK
				endif
				jump_line = search(input_search, 'b')
				event = true
			elseif key == "\<Down>"
				if input_search == ''
					return Base.BLOCK
				endif
				jump_line = search(input_search)
				event = true
			endif
		endif
		if jump_line != 0 
			RemoveMidSearch()
			const pos = getpos('.')
			mid_search = matchadd('Search', '\%#' .. input_search, 42)
		endif
		if event == true
			return Base.BLOCK
		endif
		return Base.CONTINUE
	})


	#### Remove the Find Cursor if the find is terminated
	pop1.AddEventClose((pop) => {
		if first_buffer != []
			noautocmd call setline(1, first_buffer)
			first_buffer = []
		endif
		# Restore the registers
		setreg('1', r1)
		setreg('2', r2)
		setreg('3', r3)
		setreg('4', r4)
		setreg('5', r5)
		setreg('6', r6)
		setreg('7', r7)
		setreg('8', r8)
		setreg('9', r9)
		RemoveMidCursor()
		RemoveSupramid()
		RemoveMidSearch()
		if find == false
			call winrestview(view)
		endif
	})

	#### When Find Popup is Entered, Go to the first match
	pop1.AddEventInputEnter((p) => {
		var line = p.GetInput()
		setreg('/', line)
		histadd('search', line)
		find = true
		silent! pop1.Close()
		silent! pop2.Close()
		silent! background.Close()
		RemoveMidCursor()
		RemoveMidSearch()
		RemoveMidSearch()
	})

	#### When Replace Popup is Entered, replace the with the substitution
	pop2.AddEventInputEnter((_) => {
		first_buffer = getline(1, '$')
		noautocmd w!
		pop1.Close()
		pop2.Close()
		background.Close()
		RemoveMidCursor()
		RemoveMidSearch()
		RemoveMidSearch()
	})

	#### When pop2 is focused, save the first buffer
	pop2.AddEventGetFocus((_) => {
		echo 'popup2 focused'
		first_buffer = getline(1, '$')
		var line = pop2.GetInput()
		var save_pos = getpos('.')
		call cursor(1, 1)
		noautocmd normal! "0dG"
		noautocmd call setline(1, first_buffer)
		noautocmd silent! execute ':' .. min .. ',' .. max .. 's/' .. pop1.GetInput() .. '/' .. line .. '/g'
		call setpos('.', save_pos)
	})

	pop1.AddEventGetFocus((_) => {
		echo 'popup1 focused'
		var save_pos = getpos('.')
		call cursor(1, 1)
		noautocmd normal! "0dG"
		noautocmd setline(1, first_buffer)
		call setpos('.', save_pos)
	})


	pop2.AddEventInputChanged((_, key, line) => {
		silent! undojoin
		var input_pop1 = pop1.GetInput()
		if input_pop1 == ''
			pop2.ClearInput()
			return
		endif
		var save_pos = getpos('.')
		call cursor(1, 1)
		noautocmd normal! "0dG"
		noautocmd call setline(1, first_buffer)
		noautocmd silent! execute ':' .. min .. ',' .. max .. 's/' .. input_pop1 .. '/' .. line .. '/g'
		call setpos('.', save_pos)
	})

	# When typing in the Find Popup (jump to the first match)
	pop1.AddEventInputChanged((_, _, line) => EventWhenFindInput(line))
enddef

def CountOccurences(search_term: string): number
	try
    var count: number = 0
    const cursor_pos = getpos(".")
    call cursor(1, 1)

    while true
        var pos = searchpos(search_term, 'W')
        if pos[0] == 0
            break
        endif
        count += 1
    endwhile

    call setpos('.', cursor_pos)
    return count
	catch
		return 0 
	endtry
enddef

