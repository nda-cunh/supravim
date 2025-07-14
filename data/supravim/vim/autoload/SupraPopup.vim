vim9script

var all_popups: dict<any> = {}

var focus_actual = 0

#############################################################################
# Define 
#############################################################################

export const NOBLOCK: number = 0 # Ne bloque pas le traitement de l'event (les autres popup peuvent traiter l'event)
export const BLOCK: number = 1 # Bloque le traitement de l'event (aucun autre popup n'aura acces à l'event)
export const CONTINUE: number = 2 # Seulement pour le no_focus event, permet de continuer de traiter aussi le focus event

#############################################################################
# Signal
#############################################################################

# AddEventClose: Add a function to the close event of the popup.
export def AddEventClose(popup: dict<any>, Func: func): func
	add(popup.cb_close, Func)
	return Func
enddef
# RemoveEventClose: Remove a function from the close event of the popup.
export def RemoveEventClose(popup: dict<any>, Func: func): void
	remove(popup.cb_close, Func)
enddef

# AddEventFilterFocus: Add a function to the focus event of the popup.
export def AddEventFilterFocus(popup: dict<any>, Func: func): func 
	add(popup.cb_fitler_focus, Func)
	return Func
enddef

# AddEventFilterNoFocus: Add a function to the no focus event of the popup.
export def AddEventFilterNoFocus(popup: dict<any>, Func: func): func 
	add(popup.cb_fitler_nofocus, Func)
	return Func
enddef

# RemoveEventFocus: Remove a function from the focus event of the popup.
export def RemoveEventFocus(popup: dict<any>, Func: func): void
	remove(popup.cb_fitler_focus, Func)
enddef

# RemoveEventNoFocus: Remove a function from the no focus event of the popup.
export def RemoveEventNoFocus(popup: dict<any>, Func: func): void
	remove(popup.cb_fitler_nofocus, Func)
enddef

# AddEventGetFocus: a callback when the popup gains focus.
export def AddEventGetFocus(popup: dict<any>, Func: func): func
	add(popup.cb_gainfocus, Func)
	return Func
enddef

# RemoveEventgetFocus: remove a callback when the popup gains focus.

export def RemoveEventgetFocus(popup: dict<any>, Func: func): void
	remove(popup.cb_gainfocus, Func)
enddef
#############################################################################
# Utility Functions 
#############################################################################
export def GetPos(popup: dict<any>): dict<any>
	var dict = {
		col: popup.col,
		line: popup.line,
		width: popup.width,
		height: popup.height,
	}
	return dict
enddef

export def SetPos(popup: dict<any>, col: number = 0, line: number = 0)
	if col != 0
		popup.col = col
	endif
	if line != 0
		popup.line = line
	endif

	if has_key(all_popups, popup.wid)
		popup_move(popup.wid, {
			col: popup.col,
			line: popup.line,
		})
	endif
enddef

export def SetSize(popup: dict<any>, width: number = -1, height: number = -1)
	if width != -1
		popup.width = width
	endif
	if height != -1
		popup.height = height
	endif

	popup_move(popup.wid, {
		minwidth: popup.width,
		minheight: popup.height,
		maxwidth: popup.maxwidth,
		maxheight: popup.maxheight,
	})
enddef

export def GetSize(popup: dict<any>): list<number>
	var res = [0, 0] # width and height
	if has_key(all_popups, popup.wid)
		var options = popup_getpos(popup.wid)
		res[0] = options.width
		res[1] = options.height
	endif
	return res
enddef

export def Close(popup: dict<any>)
	if has_key(all_popups, popup.wid)
		popup_close(popup.wid)
	endif
enddef

export def SetText(popup: dict<any>, text: list<string>)
	popup_settext(popup.wid, text)
enddef

export def GetText(popup: dict<any>, begin: number = 1, end: number = -1): list<string>
	var buffer = winbufnr(popup.wid)
	end = end == -1 ? '$' : end
	return getbufline(buffer, begin, end)
enddef

export def SetFocus(popup: dict<any>, focus: bool = true)
	
	if popup.focus == focus
		return
	endif

	popup.focus = focus
	if popup.focus == true 
		if focus_actual != 0
			SetFocus(all_popups[focus_actual], false)
		endif
		focus_actual = popup.wid 
		if len(popup.cb_gainfocus) != 0
			for Func in popup.cb_gainfocus
				Func(popup)
			endfor
		endif
	endif

	if popup.type == 'input'
		if focus == false
			if popup.mid != 0
				matchdelete(popup.mid, popup.wid)
				popup.mid = 0
			endif
		else
			ActualiseCursor(popup, popup.wid, popup.cur_pos)
		endif
	endif
enddef
#############################################################################
# Input Popup
#############################################################################

export def Input(options: dict<any> = {}): dict<any>

	var simple = Simple(options)

	simple.type = 'input'
	simple.input_line = []
	simple.prompt = 'Input: '
	simple.cur_pos = 0
	simple.mid = 0
	simple.max_pos = 0
	simple.height = 1
	simple.cb_enter = []
	simple.cb_changed = []

	for key in keys(options)
		simple[key] = options[key]
	endfor

	simple.prompt_charlen = len(simple.prompt)

	AddEventFilterFocus(simple, FilterInput)
	
	SetText(simple, [simple.prompt .. ' '])
	ActualiseCursor(simple, simple.wid, simple.cur_pos)
	SetFocus(simple, true)
	return simple
enddef

def ActualiseCursor(popup: dict<any>, wid: number, cur_pos: number)
	const promptchar_len = popup.prompt_charlen
	var hl = 'Cursor'
	if popup.mid != 0
		matchdelete(popup.mid, wid)
	endif
    var hi_end_pos = promptchar_len + 1
    if cur_pos > 0
        hi_end_pos += len(join(popup.input_line[: cur_pos - 1], ''))
    endif
    popup.mid = matchaddpos(hl, [[1, hi_end_pos]], 10, -1, {window: wid})
enddef


def FilterInput(popup: dict<any>, wid: number, key: string): number
	var ascii_val = char2nr(key)
	var cur_pos = popup.cur_pos
	var line = popup.input_line
	var max_pos = popup.max_pos

	var is_changed = false

	if (len(key) == 1 && ascii_val >= 32 && ascii_val <= 126)
        || (ascii_val >= 19968 && ascii_val <= 205743) # chinese or more character support
		is_changed = true
        if cur_pos == len(line)
            line->add(key)
        else
            var pre = cur_pos - 1 >= 0 ? line[: cur_pos - 1] : []
            line = pre + [key] + line[cur_pos :]
        endif
        cur_pos += 1
    elseif key == "\<bs>" 
		is_changed = true
		if cur_pos == 0
			return 1	
		endif
		if cur_pos == len(line)
            line = line[: -2]
        else
            var before = cur_pos - 2 >= 0 ? line[: cur_pos - 2] : []
            line = before + line[cur_pos :]
        endif
        cur_pos = max([ 0, cur_pos - 1 ])
	elseif key == "\<Enter>" || key == "\<CR>"
		var copy_line = join(copy(popup.input_line), '')
		for Func in popup.cb_enter
			Func(copy_line)
		endfor
		return 1
	elseif key == "\<Tab>"
		if popup.focus == false
			return NOBLOCK
		endif
		if popup.cb_focus != null_function
			var tab_focus = popup.cb_focus(popup)
			if has_key(tab_focus, 'next')
				SetFocus(tab_focus.next, true)
				return BLOCK
			endif
		endif
		return NOBLOCK
	elseif key == "\<S-Tab>"
		if popup.focus == false
			return NOBLOCK
		endif
		if popup.cb_focus != null_function
			var tab_focus = popup.cb_focus(popup)
			if has_key(tab_focus, 'prev')
				SetFocus(tab_focus.prev, true)
				return BLOCK
			endif
		endif
		return NOBLOCK
	elseif key == "\<Left>"
        cur_pos = max([ 0, cur_pos - 1 ])
    elseif key == "\<Right>"
        cur_pos = min([ max_pos, cur_pos + 1 ])
    elseif key == "\<End>"
		cur_pos = max_pos
    elseif key == "\<Home>"
			cur_pos = 0	
	elseif key ==? "\<Del>"
		is_changed = true
        if cur_pos == max_pos
            return 1
        endif
        if cur_pos == 0
            line = line[1 : ]
        else
            var before = cur_pos - 1 >= 0 ? line[: cur_pos - 1] : []
            line = before + line[cur_pos + 1 :]
        endif
        max_pos -= 1
	elseif key ==? "\<LeftMouse>" || key ==? "\<2-LeftMouse>"
        var pos = getmousepos()
        if pos.winid != wid
            return 0
        endif
        var promptchar_len = popup.prompt_charlen
        cur_pos = pos.wincol - promptchar_len - 1
        if cur_pos > max_pos
            cur_pos = max_pos
        endif
        if cur_pos < 0
            cur_pos = 0
		endif
	else 
		return NOBLOCK
	endif
	# Draw the line and actualise the cursor position
	SetText(popup, [popup.prompt .. join(line, '') .. ' '])
	max_pos = len(line)
	popup.input_line = line
	popup.cur_pos = cur_pos
	popup.max_pos = max_pos

	# Draw the cursor
	ActualiseCursor(popup, wid, cur_pos)
	if is_changed
		if len(popup.cb_changed) == 0
			return BLOCK
		endif
		var copy_line: string
		if len(popup.input_line) == 0
			copy_line = ''
		else
			copy_line = join(copy(popup.input_line), '')
		endif
		for Func in popup.cb_changed
			Func(key, copy_line)
		endfor
	endif
	return BLOCK 
enddef

#############################################################################
# Utility Functions for Input Popup
#############################################################################

# Clear all text in the input popup.
export def ClearInput(popup: dict<any>)
	popup.input_line = []
	popup.cur_pos = 0
	popup.max_pos = 0
	SetText(popup, [popup.prompt .. ' '])
	ActualiseCursor(popup, popup.wid, popup.cur_pos)
enddef

# Set the input text of the input popup.
export def SetInput(popup: dict<any>, text: string)
	popup.input_line = []
	for i in text
		add(popup.input_line, i)
	endfor
	popup.cur_pos = len(popup.input_line)
	popup.max_pos = popup.cur_pos
	SetText(popup, [popup.prompt .. text .. ' '])
	ActualiseCursor(popup, popup.wid, popup.cur_pos)
enddef

# Get the input text of the input popup.
export def GetInput(popup: dict<any>): string
	return join(popup.input_line, '')
enddef


# Add a function to the enter event of the input popup.
export def AddEventInputEnter(popup: dict<any>, Func: func): func
	add(popup.cb_enter, Func)
	return Func
enddef

# Remove a function from the enter event of the input popup.
export def RemoveEventInputEnter(popup: dict<any>, Func: func): void
	remove(popup.cb_enter, Func)
enddef

export def AddEventInputChanged(popup: dict<any>, Func: func): func
	add(popup.cb_changed, Func)
	return Func
enddef

export def RemoveEventInputChanged(popup: dict<any>, Func: func): void
	remove(popup.cb_changed, Func)
enddef

export def SetEventFocus(popup: dict<any>, Func: func): func
	popup.cb_focus = Func
	return Func
enddef

# Add a function to the focus event of the popup.
export def AddEventKeyPressedFocus(popup: dict<any>, Func: func): func
	add(popup.cb_keypressed_focus, Func)
	return Func
enddef

# Remove a function from the focus event of the popup.
export def RemoveEventKeyPressedFocus(popup: dict<any>, Func: func): void
	remove(popup.cb_keypressed_focus, Func)
enddef

export def AddEventKeyPressedNoFocus(popup: dict<any>, Func: func): func
	add(popup.cb_keypressed_nofocus, Func)
	return Func
enddef

export def RemoveEventKeyPressedNoFocus(popup: dict<any>, Func: func): void
	remove(popup.cb_keypressed_nofocus, Func)
enddef

#############################################################################
# Entry Popup 
#############################################################################

# Add a function to the select event of the selector popup.
export def AddEventSelectorMove(popup: dict<any>, Func: func): func
	add(popup.cb_selector_move, Func)
	return Func
enddef

export def AddEventSelectorSelect(popup: dict<any>, Func: func): func
	add(popup.cb_selector_select, Func)
	return Func
enddef

export def Selector(options: dict<any>, values: list<string>): dict<any>
	options.type = 'selector'
	options.cb_selector_move = []
	options.cb_selector_select = []
	options.cursorline = 1
	var simple = Simple(options)
	SetSize(simple, simple.width, len(values))
	SetText(simple, values)


	AddEventFilterNoFocus(simple, (popup, wid, key) => {
		var buf = winbufnr(popup.wid)
		if key ==? "\<Up>"
			win_execute(popup.wid, 'norm! k')
			var cursorlinepos = line('.', wid)
			var linetext = getbufline(buf, cursorlinepos, cursorlinepos)[0]
			for Func in popup.cb_selector_move
				Func(linetext)
			endfor
			return BLOCK
		elseif key ==? "\<Down>"
			win_execute(popup.wid, 'norm! j')
			var cursorlinepos = line('.', wid)
			var linetext = getbufline(buf, cursorlinepos, cursorlinepos)[0]
			for Func in popup.cb_selector_move
				Func(linetext)
			endfor
			return BLOCK
		elseif key == "\<Enter>" || key ==? "\<CR>"
			var cursorlinepos = line('.', wid)
			var linetext = getbufline(buf, cursorlinepos, cursorlinepos)[0]
			for Func in popup.cb_selector_select
				Func(linetext)
			endfor
			return BLOCK
		elseif key ==? "\<LeftMouse>" || key ==? "\<2-LeftMouse>"
			var mousepos = getmousepos()
			if mousepos.winid == wid
				win_execute(wid, 'norm! ' .. mousepos.line .. 'G')
				var cursorlinepos = line('.', wid)
				var linetext = getbufline(buf, cursorlinepos, cursorlinepos)[0]
				for Func in popup.cb_selector_select
					Func(linetext)
				endfor
			endif
			return BLOCK
		endif
		return CONTINUE 
	})

	return simple
enddef

#############################################################################
# Base Popup 
#############################################################################

# Simple: Create a simple popup with the given options.
export def Simple(options: dict<any>): dict<any>
	var supradict = {
		col: 0,
		line: 0,
		width: 4,
		height: 1,
		maxwidth: 999,
		maxheight: 999,
		cursorline: 0, # The line where the cursor is located
		scrollbar: 0, # 0: no scrollbar, 1: scrollbar
		wid: 0,
		type: 'simple',
		close_key: ["\<Esc>", "\<C-c>"], # List of keys to close the popup
		cb_fitler_focus: [], # Function (supra: SupraPopup, wid: number, key: string) -> number (NOBLOCK or BLOCK)
		cb_fitler_nofocus: [], # Function (supra: SupraPopup,wid: number, key: string) -> number (NOBLOCK or BLOCK or CONTINUE)
		cb_close: [], # Function (SupraPopup) -> void 
		cb_focus: null_function, # Function () -> {next: SupraPopup, prev:SupraPopup}
		cb_gainfocus: [], # Function (SupraPopup) -> void
		cb_keypressed_focus: [], # Function (SupraPopup: popup, key: string) -> void 
		cb_keypressed_nofocus: [], # Function (SupraPopup: popup, key: string) -> void
	}

	for key in keys(options)
		supradict[key] = options[key]
	endfor

	var wid = popup_create([], {
		col: supradict.col,
		line: supradict.line,
		minwidth: supradict.width,
		minheight: supradict.height,
		maxwidth: supradict.maxwidth,
		maxheight: supradict.height,
		pos: 'topright',
		time: 90000,
		tabpage: -1,
		zindex: 300,
		drag: 0,
		wrap: 0,
		border: [1],
		borderhighlight: ['Normal', 'Normal', 'Normal', 'Normal'],
		borderchars: ['─', '│', '─', '│', '╭', '╮', '╯', '╰'],
		highlight: 'Normal',
		padding: [0, 1, 0, 1],
		mapping: 0,
		fixed: 1,
		cursorline: supradict.cursorline,
		scrollbar: supradict.scrollbar,
		hidden: 0,
		filter: FilterSimple, 
		callback: (wid, _) => {
			var popup = all_popups[wid]
			for Func in popup.cb_close
				Func(popup)
			endfor
			if focus_actual == wid
				focus_actual = 0
			endif
			remove(all_popups, wid)
		},
	})

	AddEventFilterNoFocus(supradict, (_, _, key) => {
		if key ==? "\<LeftMouse>"
			var mousepos = getmousepos()
			if mousepos.winid == wid
				SetFocus(supradict, true)
			endif
		endif
		return CONTINUE 
	})

	supradict.wid = wid
	supradict.focus = false
	all_popups[wid] = supradict

	AddEventFilterNoFocus(supradict, (popup, _, key) => {
		for k in popup.close_key
			if key ==? k
				feedkeys("\<Esc>", 'n')
				popup_close(wid)
			endif
		endfor
		return CONTINUE
	})

	return supradict
enddef


# FilterSimple: A simple filter function for the popup.
# call cb_filter_focus if the popup is focused.
# call cb_filter_nofocus if the popup is unfocused.
def FilterSimple(wid: number, key: string): number
	var popup = all_popups[wid]

	for Func in popup.cb_keypressed_nofocus
		Func(popup, key)
	endfor

	# call the no focus function 
	for Func in popup.cb_fitler_nofocus
		var ret = Func(popup, wid, key)
		if ret == NOBLOCK || ret == BLOCK 
			return ret
		endif
	endfor

	if popup.focus == false
		return NOBLOCK 
	endif

	for Func in popup.cb_keypressed_focus
		var ret = Func(popup, key)
		if ret == NOBLOCK || ret == BLOCK 
			return ret
		endif
	endfor

	for Func in popup.cb_fitler_focus
		var ret = Func(popup, wid, key)
		if ret == NOBLOCK || ret == BLOCK 
			return ret
		endif
	endfor
	return 0
enddef












