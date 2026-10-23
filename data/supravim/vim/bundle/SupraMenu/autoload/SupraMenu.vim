vim9script

export type Row = dict<any>
export type Block = dict<any>
export type Source = func(dict<any>): Block

var sources: list<dict<any>> = []
var next_id = 1
var stack: list<dict<any>> = []
var saved_mousemoveevent = 0
var last_hover = [0, 0]

const MOUSE_KEYS = [
	"\<MouseMove>", "\<LeftMouse>", "\<LeftDrag>", "\<LeftRelease>",
	"\<RightMouse>", "\<RightDrag>", "\<RightRelease>",
	"\<MiddleMouse>", "\<MiddleDrag>", "\<MiddleRelease>",
	"\<ScrollWheelUp>", "\<ScrollWheelDown>", "\<ScrollWheelLeft>", "\<ScrollWheelRight>",
	"\<2-LeftMouse>", "\<3-LeftMouse>", "\<4-LeftMouse>",
]
const ARROW = ""

export def Register(Src: any): number
	var id = next_id
	next_id += 1
	add(sources, {id: id, src: Src})
	return id
enddef

export def Unregister(id: number)
	filter(sources, (_, s) => s.id != id)
enddef

def IsVisual(): bool
	return index(['v', 'V', "\<C-v>", 's', 'S', "\<C-s>"], mode()) != -1
enddef

def Filtered(rows: list<any>, mode: string, default_modes: string): list<dict<any>>
	var items: list<dict<any>> = []
	for row in rows
		if empty(row)
			continue
		endif
		if get(row, 'sep', false)
			if !empty(items) && !items[-1].sep
				add(items, {sep: true})
			endif
			continue
		endif
		var modes = get(row, 'modes', default_modes)
		if stridx(modes, mode) == -1
			continue
		endif
		var item = {
			sep: false,
			label: get(row, 'label', ''),
			icon: get(row, 'icon', ''),
			shortcut: get(row, 'shortcut', ''),
			enabled: get(row, 'enabled', true),
			cmd: get(row, 'cmd', ''),
			children: [],
		}
		if has_key(row, 'children')
			item.children = Filtered(row.children, mode, modes)
			if empty(item.children)
				continue
			endif
		endif
		add(items, item)
	endfor
	while !empty(items) && items[-1].sep
		remove(items, -1)
	endwhile
	return items
enddef

def Collect(context: dict<any>, mode: string): list<dict<any>>
	var blocks: list<Block> = []
	for source in sources
		var block: Block
		try
			block = type(source.src) == v:t_func ? source.src(context) : source.src
		catch
			continue
		endtry
		if empty(block) || !has_key(block, 'rows')
			continue
		endif
		add(blocks, block)
	endfor
	sort(blocks, (a, b) => get(b, 'priority', 0) - get(a, 'priority', 0))

	var items: list<dict<any>> = []
	for block in blocks
		var rows = Filtered(block.rows, mode, 'n')
		if empty(rows)
			continue
		endif
		if !empty(items)
			add(items, {sep: true})
		endif
		extend(items, rows)
	endfor
	return items
enddef

def Selectable(item: dict<any>): bool
	return !item.sep && item.enabled
enddef

def Render(items: list<dict<any>>): list<string>
	var lefts: list<string> = []
	var left_width = 0
	var shortcut_width = 0
	for item in items
		var left = item.sep ? '' : $' {empty(item.icon) ? " " : item.icon} {item.label}'
		add(lefts, left)
		left_width = max([left_width, strdisplaywidth(left)])
		if !item.sep
			shortcut_width = max([shortcut_width, strdisplaywidth(item.shortcut)])
		endif
	endfor
	var gap = shortcut_width > 0 ? 3 : 0
	var width = max([left_width + gap + shortcut_width + 3, 20])

	var lines: list<string> = []
	for i in range(len(items))
		var item = items[i]
		if item.sep
			add(lines, repeat('─', width))
			continue
		endif
		var arrow = empty(item.children) ? ' ' : ARROW
		var right = item.shortcut .. $' {arrow} '
		var pad = width - strdisplaywidth(lefts[i]) - strdisplaywidth(right)
		add(lines, lefts[i] .. repeat(' ', pad) .. right)
	endfor
	return lines
enddef

def Decorate(wid: number, items: list<dict<any>>, lines: list<string>)
	matchadd('SupraMenuSeparator', '^─\+$', 10, -1, {window: wid})
	for i in range(len(items))
		var item = items[i]
		if item.sep
			continue
		endif
		if !item.enabled
			matchaddpos('SupraMenuDisabled', [i + 1], 11, -1, {window: wid})
		elseif !empty(item.shortcut)
			var col = strridx(lines[i], item.shortcut) + 1
			matchaddpos('SupraMenuShortcut', [[i + 1, col, len(item.shortcut)]], 11, -1, {window: wid})
		endif
	endfor
enddef

def FirstSelectable(items: list<dict<any>>): number
	var idx = indexof(items, (_, item) => Selectable(item))
	return idx == -1 ? 0 : idx
enddef

def OpenLevel(items: list<dict<any>>, lines: list<string>, line: number, col: number)
	var opts: dict<any> = {
		line: line,
		col: col,
		pos: 'topleft',
		fixed: true,
		wrap: false,
		scrollbar: false,
		mapping: false,
		cursorline: true,
		zindex: 300 + len(stack),
		highlight: 'SupraMenu',
		border: [],
		borderhighlight: ['SupraMenuBorder'],
		borderchars: ['─', '│', '─', '│', '╭', '╮', '╯', '╰'],
		padding: [0, 0, 0, 0],
	}
	if empty(stack)
		opts.filter = Filter
		opts.callback = OnClose
	endif
	var wid = popup_create(lines, opts)
	Decorate(wid, items, lines)
	add(stack, {wid: wid, items: items, idx: 0})
	Select(len(stack) - 1, FirstSelectable(items))
enddef

def Size(lines: list<string>): list<number>
	return [len(lines) + 2, strdisplaywidth(lines[0]) + 2]
enddef

def OpenRoot(items: list<dict<any>>, screenrow: number, screencol: number)
	var lines = Render(items)
	var [height, width] = Size(lines)
	var max_line = &lines - &cmdheight
	var line = screenrow + 1
	if line + height - 1 > max_line
		line = max([1, screenrow - height])
	endif
	var col = screencol
	if col + width - 1 > &columns
		col = max([1, &columns - width + 1])
	endif
	OpenLevel(items, lines, line, col)
enddef

def OpenSub(level: number)
	CloseAbove(level)
	var entry = stack[level]
	var item = entry.items[entry.idx]
	if empty(item.children) || !item.enabled
		return
	endif
	var lines = Render(item.children)
	var [height, width] = Size(lines)
	var parent = popup_getpos(entry.wid)
	var line = parent.core_line + entry.idx - 1
	var max_line = &lines - &cmdheight
	if line + height - 1 > max_line
		line = max([1, max_line - height + 1])
	endif
	var col = parent.col + parent.width
	if col + width - 1 > &columns
		col = max([1, parent.col - width])
	endif
	OpenLevel(item.children, lines, line, col)
enddef

def Select(level: number, idx: number)
	var wid = stack[level].wid
	stack[level].idx = idx
	win_execute(wid, $'call cursor({idx + 1}, 1)')
	popup_setoptions(wid, {cursorline: true})
enddef

def Move(delta: number)
	var level = len(stack) - 1
	var items = stack[level].items
	var n = len(items)
	var idx = stack[level].idx
	for _ in range(n)
		idx = (idx + delta + n) % n
		if Selectable(items[idx])
			break
		endif
	endfor
	Select(level, idx)
enddef

def CloseAbove(level: number)
	while len(stack) > level + 1
		popup_close(remove(stack, -1).wid)
	endwhile
enddef

def Close()
	if empty(stack)
		return
	endif
	var levels = stack
	stack = []
	last_hover = [0, 0]
	for entry in reverse(levels)
		popup_close(entry.wid)
	endfor
	&mousemoveevent = saved_mousemoveevent
enddef

def OnClose(wid: number, _: any)
	if !empty(stack) && stack[0].wid == wid
		Close()
	endif
enddef

def Key(name: string): string
	var lower = tolower(name)
	if lower == '<leader>'
		return get(g:, 'mapleader', '\')
	elseif lower == '<localleader>'
		return get(g:, 'maplocalleader', '\')
	elseif lower == '<snr>' || lower == '<sid>'
		return name
	endif
	try
		return eval('"\' .. name .. '"')
	catch
		return name
	endtry
enddef

def Run(Cmd: any)
	if type(Cmd) == v:t_func
		timer_start(0, (_) => Cmd())
	elseif type(Cmd) == v:t_string && !empty(Cmd)
		feedkeys(substitute(Cmd, '<[^<> ]\+>', (m) => Key(m[0]), 'g'), 'mt')
	endif
enddef

def Activate(level: number, idx: number)
	var item = stack[level].items[idx]
	if !Selectable(item)
		return
	endif
	Select(level, idx)
	if !empty(item.children)
		if len(stack) == level + 1
			OpenSub(level)
		endif
		return
	endif
	Close()
	Run(item.cmd)
enddef

def Mouse(key: string): bool
	var pos = getmousepos()
	if key == "\<MouseMove>"
		if last_hover == [pos.winid, pos.line]
			return true
		endif
		last_hover = [pos.winid, pos.line]
	endif
	var level = indexof(stack, (_, v) => v.wid == pos.winid)
	if level == -1
		if index(["\<MouseMove>", "\<LeftDrag>", "\<RightDrag>", "\<LeftRelease>", "\<RightRelease>"], key) != -1
			return true
		endif
		Close()
		return false
	endif

	var items = stack[level].items
	var idx = pos.line - 1
	if idx < 0 || idx >= len(items) || !Selectable(items[idx])
		return true
	endif

	if key == "\<LeftRelease>" || key == "\<RightRelease>"
		Activate(level, idx)
	elseif index(["\<MouseMove>", "\<LeftDrag>", "\<RightDrag>", "\<LeftMouse>", "\<RightMouse>"], key) != -1
		if stack[level].idx != idx || len(stack) == level + 1
			CloseAbove(level)
			Select(level, idx)
			if !empty(items[idx].children)
				OpenSub(level)
			endif
		endif
	endif
	return true
enddef

def Filter(_: number, key: string): bool
	if empty(stack)
		return false
	endif
	if index(MOUSE_KEYS, key) != -1
		return Mouse(key)
	endif

	var level = len(stack) - 1
	var current = stack[level].items[stack[level].idx]
	if key == "\<Esc>" || key == 'q' || key == "\<C-c>"
		Close()
	elseif index(['j', "\<Down>", "\<C-n>", "\<Tab>"], key) != -1
		Move(1)
	elseif index(['k', "\<Up>", "\<C-p>", "\<S-Tab>"], key) != -1
		Move(-1)
	elseif key == 'l' || key == "\<Right>"
		if Selectable(current) && !empty(current.children)
			OpenSub(level)
		endif
	elseif key == 'h' || key == "\<Left>"
		if level > 0
			CloseAbove(level - 1)
		endif
	elseif index(["\<CR>", "\<NL>", ' '], key) != -1
		Activate(level, stack[level].idx)
	endif
	return true
enddef

export def Open()
	Close()
	if win_gettype() == 'popup'
		return
	endif
	if exists('*g:SupraAchMetric')
		call g:SupraAchMetric('rightclick', 1)
	endif

	var mouse = getmousepos()
	const visual = IsVisual()
	if !visual && mouse.winid != 0 && mouse.line > 0 && win_gettype(mouse.winid) == ''
		win_gotoid(mouse.winid)
		setpos('.', [0, mouse.line, mouse.column, 0])
	endif

	var screenrow = mouse.screenrow
	var screencol = mouse.screencol
	if screenrow == 0
		var cursor = screenpos(win_getid(), line('.'), col('.'))
		screenrow = cursor.row
		screencol = cursor.col
		mouse = extend(mouse, {line: line('.'), column: col('.'), winid: win_getid()})
	endif

	const mode = visual ? 'v' : 'n'
	const context = {
		mode: mode,
		ft: &filetype,
		bufnr: bufnr('%'),
		word: expand('<cword>'),
		path: expand('%:p'),
		is_git: isdirectory('.git'),
		line: mouse.line,
		col: mouse.column,
		winid: mouse.winid,
		screenrow: screenrow,
		screencol: screencol,
	}

	var items = Collect(context, mode)
	if empty(items)
		return
	endif
	saved_mousemoveevent = &mousemoveevent ? 1 : 0
	&mousemoveevent = 1
	OpenRoot(items, screenrow, screencol)
enddef

export def IsOpen(): bool
	return !empty(stack)
enddef
