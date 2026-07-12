vim9script

import autoload 'SupraPop/Base.vim'        as Base
import autoload 'SupraPop/Simple.vim'       as Simple
import autoload 'SupraPop/Input.vim'        as Input
import autoload 'SupraPop/ToggleButton.vim' as ToggleButton

var first_buffer = []

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

def GetCompletion(input: string): string
	if len(input) < 2
		return ''
	endif
	var esc = escape(input, '\^$.*[]~')
	var save_pos = getpos('.')
	var result = ''
	try
		call cursor(1, 1)
		var pos = searchpos('\<' .. esc .. '\w\+', 'nW')
		if pos[0] != 0
			var m = matchstr(getline(pos[0]), '\<' .. esc .. '\w*')
			if len(m) > len(input)
				result = m[len(input) :]
			endif
		endif
	catch
	endtry
	call setpos('.', save_pos)
	return result
enddef

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
	var ghost_text: string = ''
	var ghost_mid: number = 0
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
		line: 2,
		col: &columns - 34,
		width: 31,
		height: 9,
	})

	const c = '➜ '
	var pop1 = Input.Input.new({
		prompt: c,
		title: ' Find',
		title_pos: 'left',
		col: &columns - 32,
		line: 3,
		width: 27,
		maxwidth: 27,
	})

	var pop2 = Input.Input.new({
		prompt: c,
		title: ' Replace',
		title_pos: 'left',
		col: &columns - 32,
		line: 6,
		maxwidth: 27,
		width: 27,
	})

	var btn_case = ToggleButton.ToggleButton.new({
		text: 'Aa',
		col: &columns - 32,
		line: 9,
		width: 6,
	})

	var btn_regex = ToggleButton.ToggleButton.new({
		text: '.*',
		col: &columns - 22,
		line: 9,
		width: 6,
		toggled: true,
	})

	var btn_word = ToggleButton.ToggleButton.new({
		text: 'Word',
		col: &columns - 12,
		line: 9,
		width: 7,
	})

	pop1.SetFocus()

	# Build the flags prefix (\c/\C + optional \V for literal mode)
	var GetFlags = (): string => {
		return (btn_case.IsToggled() ? '\c' : '\C') .. (btn_regex.IsToggled() ? '' : '\V')
	}

	# Wrap pattern with word boundaries if btn_word is on
	var GetWordPat = (raw: string): string => {
		return btn_word.IsToggled() ? '\<' .. raw .. '\>' : raw
	}

	var BuildPattern = (raw: string): string => {
		return GetFlags() .. GetWordPat(raw)
	}

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

	var UpdateFindTitle = (hl_pat: string) => {
		try
			var sc = searchcount({pattern: hl_pat, recompute: 1, maxcount: 0})
			if sc.total == 0
				pop1.SetTitle(' Find')
			elseif sc.current == 0
				pop1.SetTitle($' Find ?/{sc.total}')
			else
				pop1.SetTitle($' Find {sc.current}/{sc.total}')
			endif
		catch
			pop1.SetTitle(' Find')
		endtry
	}

	var ClearGhost = () => {
		if ghost_mid != 0
			try
				matchdelete(ghost_mid, pop1.GetWid())
			catch
			endtry
			ghost_mid = 0
		endif
		ghost_text = ''
	}

	var UpdateGhost = (input: string) => {
		ClearGhost()
		if input == '' || !pop1.IsAtEnd()
			return
		endif
		ghost_text = GetCompletion(input)
		if ghost_text == ''
			return
		endif
		pop1.SetText([c .. input .. ghost_text])
		var ghost_col = len(c) + len(input) + 1
		try
			ghost_mid = matchaddpos('Comment', [[1, ghost_col, len(ghost_text)]], 5, -1, {window: pop1.GetWid()})
		catch
			ghost_mid = 0
		endtry
	}

	var CloseAll = () => {
		silent! pop1.Close()
		silent! pop2.Close()
		silent! btn_case.Close()
		silent! btn_regex.Close()
		silent! btn_word.Close()
		silent! background.Close()
	}

	var EventWhenFindInput = (line) => {
		RemoveSupramid()
		RemoveMidSearch()
		if line == ''
			pop1.SetTitle(' Find')
			return
		endif

		const hl_pat = BuildPattern(line)
		var jump_line: number = 0
		var scope_pat: string

		if visualmode == true
			if min == max
				scope_pat = GetFlags() .. '\%' .. min .. 'l' .. GetWordPat(line)
			else
				scope_pat = GetFlags() .. '\%>' .. (min - 1) .. 'l\%<' .. (max + 1) .. 'l' .. GetWordPat(line)
			endif
			silent! jump_line = search(hl_pat, 'c', max)
		else
			scope_pat = hl_pat
			silent! jump_line = search(hl_pat, 'c')
		endif

		UpdateFindTitle(scope_pat)

		try
			if jump_line != 0
				mid_search = matchadd('Search', '\%#' .. line, 42)
			endif
			silent! mid_occurence = matchadd('Cursor', scope_pat, 10)
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

	#### Set Focus (Tab cycle: Find → Replace → Aa → .* → W → Find)
	pop1.SetEventFocus((_) => {
		return {next: pop2, prev: btn_word}
	})

	pop2.SetEventFocus((_) => {
		return {next: btn_case, prev: pop1}
	})

	btn_case.SetEventFocus((_) => {
		return {next: btn_regex, prev: pop2}
	})

	btn_regex.SetEventFocus((_) => {
		return {next: btn_word, prev: btn_case}
	})

	btn_word.SetEventFocus((_) => {
		return {next: pop1, prev: btn_regex}
	})

	#### Move the Find Cursor with Up and Down
	pop1.AddEventKeyPressedFocus((_, key) => {
		#### Accept ghost suggestion with Right, only when cursor is already at end
		if key == "\<Right>" && ghost_text != '' && pop1.IsAtEnd()
			try
				matchdelete(ghost_mid, pop1.GetWid())
			catch
			endtry
			ghost_mid = 0
			pop1.SetInput(pop1.GetInput() .. ghost_text)
			ghost_text = ''
			return Base.BLOCK
		endif
		if key == "\<C-Up>"
			if history_search_idx <= 0
				history_search_idx -= 1
				var history = histget('search', history_search_idx)
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
			mid_search = matchadd('Search', '\%#' .. input_search, 42)
			UpdateFindTitle(BuildPattern(input_search))
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
		ghost_text = ''
		ghost_mid = 0
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
		CloseAll()
		RemoveMidCursor()
		RemoveMidSearch()
	})

	#### When Replace Popup is Entered, replace with the substitution
	pop2.AddEventInputEnter((_) => {
		first_buffer = getline(1, '$')
		noautocmd w!
		CloseAll()
		RemoveMidCursor()
		RemoveMidSearch()
	})

	#### When pop2 is focused, preview the substitution
	pop2.AddEventGetFocus((_) => {
		first_buffer = getline(1, '$')
		var line = pop2.GetInput()
		var save_pos = getpos('.')
		call cursor(1, 1)
		noautocmd normal! "0dG"
		noautocmd call setline(1, first_buffer)
		noautocmd silent! execute ':' .. min .. ',' .. max .. 's/' .. escape(BuildPattern(pop1.GetInput()), '/') .. '/' .. escape(line, '/') .. '/g'
		call setpos('.', save_pos)
	})

	pop1.AddEventGetFocus((_) => {
		if first_buffer == []
			return
		endif
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
		noautocmd silent! execute ':' .. min .. ',' .. max .. 's/' .. escape(BuildPattern(input_pop1), '/') .. '/' .. escape(line, '/') .. '/g'
		call setpos('.', save_pos)
	})

	# When typing in the Find Popup (jump to first match)
	pop1.AddEventInputChanged((_, _, line) => EventWhenFindInput(line))

	# After every redraw (typing OR cursor movement), re-apply ghost
	pop1.AddEventRedraw((_) => UpdateGhost(pop1.GetInput()))

	#### Re-run search when any toggle changes
	var OnToggle = (_, _) => EventWhenFindInput(pop1.GetInput())
	btn_case.AddEventToggle(OnToggle)
	btn_regex.AddEventToggle(OnToggle)
	btn_word.AddEventToggle(OnToggle)
enddef
