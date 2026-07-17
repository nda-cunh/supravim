vim9script

export def Leader(): string
	return get(g:, 'mapleader', '\')
enddef

def Describe(m: dict<any>): string
	var custom = get(g:whisper_desc, m.lhs, '')
	if !empty(custom)
		return custom
	endif
	var s = m.rhs
	s = substitute(s, '\c^<plug>(\(.\{-}\))$', '\1', '')
	s = substitute(s, '\c<scriptcmd>\|<cmd>\|<silent>\|<plug>', '', 'g')
	s = substitute(s, '\c<cr>$', '', '')
	s = substitute(s, '^\s*:\?\s*call\s\+', '', '')
	s = substitute(s, '^\s*:', '', '')
	return empty(s) ? m.lhs : s
enddef

def Mappings(flux: string): list<dict<any>>
	var found: list<dict<any>> = []
	for m in maplist()
		if m.mode !~ '[ n]' || m.abbr
			continue
		endif
		if stridx(m.lhsraw, flux) != 0 || m.lhsraw == flux
			continue
		endif
		if index(g:whisper_ignore, m.lhs) >= 0
			continue
		endif
		add(found, m)
	endfor
	return found
enddef

def GroupDesc(seq: string, key: string): string
	return '+' .. get(g:whisper_desc, keytrans(seq), keytrans(key))
enddef

def Entries(flux: string): list<dict<any>>
	var seen: dict<dict<any>> = {}
	for m in Mappings(flux)
		var rest = strpart(m.lhsraw, strlen(flux))
		var key = strcharpart(rest, 0, 1)
		var leaf = strcharlen(rest) == 1
		if seen->has_key(key) && !leaf
			continue
		endif
		seen[key] = {
			key: key,
			label: keytrans(key),
			leaf: leaf,
			desc: leaf ? Describe(m) : GroupDesc(flux .. key, key),
		}
	endfor
	var self = flux == Leader() ? {} : maparg(flux, 'n', false, true)
	if !empty(self)
		seen["\<CR>"] = {
			key: "\<CR>",
			label: '⏎',
			leaf: true,
			desc: Describe(self),
		}
	endif
	return seen->keys()->sort()->mapnew((_, k) => seen[k])
enddef

def Render(entries: list<dict<any>>): list<dict<any>>
	var keyw = entries->copy()->map((_, e) => strdisplaywidth(e.label))->max()
	var descw = entries->copy()->map((_, e) => strdisplaywidth(e.desc))->max()
	var cellw = keyw + 3 + descw
	var avail = max([cellw, &columns * g:whisper_width / 100])
	var cols = max([1, avail / (cellw + 2)])
	var rows = float2nr(ceil(len(entries) * 1.0 / cols))
	cols = float2nr(ceil(len(entries) * 1.0 / rows))

	var lines: list<dict<any>> = []
	for r in range(rows)
		var text = ''
		var props: list<dict<any>> = []
		for c in range(cols)
			var i = c * rows + r
			if i >= len(entries)
				break
			endif
			var e = entries[i]
			var pad = repeat(' ', keyw - strdisplaywidth(e.label))
			add(props, {
				col: strlen(text) + strlen(pad) + 1,
				length: strlen(e.label),
				type: e.leaf ? 'WhisperKey' : 'WhisperGroup',
			})
			var cell = pad .. e.label .. ' → ' .. e.desc
			add(props, {
				col: strlen(text) + strlen(pad) + strlen(e.label) + strlen(' → ') + 1,
				length: strlen(e.desc),
				type: 'WhisperDesc',
			})
			text ..= cell .. repeat(' ', max([0, cellw - strdisplaywidth(cell)]) + 2)
		endfor
		add(lines, {text: substitute(text, '\s\+$', '', ''), props: props})
	endfor
	return lines
enddef

def HintLine(flux: string): dict<any>
	var pairs = [['<Esc>', 'close']]
	if flux != Leader()
		add(pairs, ['<BS>', 'go up a level'])
	endif
	var text = ''
	var props: list<dict<any>> = []
	for pair in pairs
		if !empty(text)
			text ..= '   '
		endif
		add(props, {col: strlen(text) + 1, length: strlen(pair[0]), type: 'WhisperKey'})
		add(props, {col: strlen(text) + strlen(pair[0]) + 2, length: strlen(pair[1]), type: 'WhisperHint'})
		text ..= pair[0] .. ' ' .. pair[1]
	endfor
	return {text: text, props: props}
enddef

def ShowMenu(flux: string): number
	var entries = Entries(flux)
	if empty(entries)
		return 0
	endif
	var lines = Render(entries)
	if g:whisper_hint
		add(lines, {text: '', props: []})
		add(lines, HintLine(flux))
	endif
	return popup_create(lines, {
		pos: 'center',
		maxheight: &lines - 6,
		padding: [0, 1, 0, 1],
		border: [1, 1, 1, 1],
		borderchars: ['─', '│', '─', '│', '╭', '╮', '╯', '╰'],
		title: ' ' .. keytrans(flux) .. ' ',
		highlight: 'Normal',
		borderhighlight: ['Comment'],
		zindex: 300,
	})
enddef

def WaitKey(ms: number): string
	var start = reltime()
	while reltimefloat(reltime(start)) * 1000 < ms
		var key = getcharstr(0)
		if !empty(key)
			return key
		endif
		sleep 10m
	endwhile
	return ''
enddef

export def Whisper()
	var cnt = v:count > 0 ? string(v:count) : ''
	var flux = Leader()
	var winid = 0
	var replay = ''
	try
		while true
			var key = getcharstr(0)
			if empty(key) && winid == 0
				key = WaitKey(g:whisper_delay)
			endif
			if empty(key)
				if winid == 0
					winid = ShowMenu(flux)
					if winid == 0
						break
					endif
					redraw
				endif
				key = getcharstr()
			endif
			if key == "\<Esc>" || key == "\<C-c>"
				break
			endif
			if key == "\<CR>" && flux != Leader() && !empty(maparg(flux, 'n'))
					&& empty(maparg(flux .. key, 'n')) && empty(Mappings(flux .. key))
				replay = flux
				break
			endif
			if key == "\<BS>" && flux != Leader()
					&& empty(maparg(flux .. key, 'n')) && empty(Mappings(flux .. key))
				flux = flux[: -2]
				if winid != 0
					popup_close(winid)
				endif
				winid = ShowMenu(flux)
				redraw
				continue
			endif
			flux ..= key
			var deeper = Mappings(flux)
			if empty(deeper)
				if empty(maparg(flux, 'n'))
					feedkeys(cnt .. flux, 'n')
				else
					replay = flux
				endif
				break
			endif
			if winid != 0
				popup_close(winid)
				winid = ShowMenu(flux)
				redraw
			endif
		endwhile
	finally
		if winid != 0
			popup_close(winid)
			redraw
		endif
	endtry
	if !empty(replay)
		feedkeys(cnt .. replay, 'm')
	endif
enddef
