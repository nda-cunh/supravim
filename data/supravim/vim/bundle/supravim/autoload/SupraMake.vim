vim9script

import autoload 'SupraPop/Base.vim'         as Base
import autoload 'SupraPop/Simple.vim'       as Simple
import autoload 'SupraPop/Input.vim'        as Input
import autoload 'SupraPop/Selector.vim'     as Selector
import autoload 'SupraPop/Button.vim'       as Button
import autoload 'SupraPop/ToggleButton.vim' as ToggleButton
import autoload 'SupraNotification.vim'     as Notify

export var is_supramake = false

var job: job    = null_job
var buf: number = 0
var wid: number = -1

const EFM = join([
	'%f:%l.%c-%*\d.%*\d: %trror: %m',
	'%f:%l.%c-%*\d.%*\d: %tarning: %m',
	'%f:%l:%c: %trror: %m',
	'%f:%l:%c: %tarning: %m',
	'%f:%l:%c: %tote: %m',
	'%f:%l: %trror: %m',
	'%f:%l: %tarning: %m',
	'%-G%.%#',
], ',')

def Truthy(v: any): bool
	return !empty(v)
enddef


const CFG_PATH = $HOME .. '/.cache/supravim/supramake.json'

var cfg:        dict<any>    = {}
var cfg_loaded: bool         = false
var root_cache: dict<string> = {}

def LoadCfg()
	if cfg_loaded
		return
	endif
	cfg_loaded = true
	if !filereadable(CFG_PATH)
		return
	endif
	try
		var data = readfile(CFG_PATH)->join("\n")->json_decode()
		if type(data) == v:t_dict
			cfg = data
		endif
	catch
		cfg = {}
	endtry
enddef

def SaveCfg()
	mkdir(fnamemodify(CFG_PATH, ':h'), 'p')
	writefile([json_encode(cfg)], CFG_PATH)
enddef

def Root(): string
	const cwd = getcwd()
	if root_cache->has_key(cwd)
		return root_cache[cwd]
	endif
	var path = trim(system('supramake --project-path'))
	if v:shell_error != 0 || path == ''
		path = cwd
	endif
	root_cache[cwd] = path
	return path
enddef

def Project(): dict<any>
	LoadCfg()
	const key = Root()
	if !cfg->has_key(key)
		cfg[key] = {rules: {}, last: ''}
	endif
	return cfg[key]
enddef

def RuleCfg(rule: string): dict<any>
	var p = Project()
	if !p.rules->has_key(rule)
		p.rules[rule] = {args: '', run: true, valgrind: false}
	endif
	var r = p.rules[rule]
	if !r->has_key('run')
		r.run = true
	endif
	return r
enddef

def StoreRule(rule: string, args: string, run: bool, valgrind: bool)
	var r = RuleCfg(rule)
	r.args     = args
	r.run      = run
	r.valgrind = valgrind
enddef

def SetLast(rule: string)
	var p = Project()
	p.last = rule
enddef

def LastRule(): string
	const last = Project().last
	return last == '' ? 'run' : last
enddef



var slots_ready: dict<bool> = {}

def SlotNames(): list<string>
	var p = Project()
	if slots_ready->get(Root(), false)
		return p.slot_order
	endif
	slots_ready[Root()] = true
	if !p->has_key('slots')
		p.slots = {}
	endif
	if !p->has_key('slot_order')
		p.slot_order = []
	endif
	for [old, name] in [['1', 'F5'], ['2', 'F6'], ['3', 'F7']]
		if p.slots->has_key(old)
			p.slots[name] = p.slots[old]
			remove(p.slots, old)
		endif
	endfor
	for name in sort(keys(p.slots))
		if index(p.slot_order, name) < 0
			add(p.slot_order, name)
		endif
	endfor
	return p.slot_order
enddef

def SlotCfg(name: string): dict<any>
	SlotNames()
	var p = Project()
	if !p.slots->has_key(name)
		p.slots[name] = {kind: 'rule', value: ''}
		add(p.slot_order, name)
	endif
	return p.slots[name]
enddef

def HasSlot(name: string): bool
	SlotNames()
	const p = Project()
	return p.slots->has_key(name) && p.slots[name].value != ''
enddef

def StoreSlot(name: string, kind: string, value: string)
	var s = SlotCfg(name)
	s.kind  = kind
	s.value = value
enddef

def RenameSlot(old: string, to: string): bool
	var p = Project()
	SlotCfg(old)
	if to == '' || to == old || p.slots->has_key(to)
		return false
	endif
	p.slots[to] = p.slots[old]
	remove(p.slots, old)
	const i = index(p.slot_order, old)
	if i >= 0
		p.slot_order[i] = to
	else
		add(p.slot_order, to)
	endif
	if p->has_key('slot') && type(p.slot) == v:t_string && p.slot == old
		p.slot = to
	endif
	return true
enddef

def DeleteSlot(nm: string): bool
	var p = Project()
	if len(SlotNames()) <= 1 || !p.slots->has_key(nm)
		return false
	endif
	remove(p.slots, nm)
	const i = index(p.slot_order, nm)
	if i >= 0
		remove(p.slot_order, i)
	endif
	return true
enddef

def LastSlot(): string
	const names = SlotNames()
	const p = Project()
	const n = p->has_key('slot') && type(p.slot) == v:t_string ? p.slot : ''
	if index(names, n) >= 0
		return n
	endif
	return empty(names) ? '' : names[0]
enddef


const HIST_MAX = 50

def History(): list<string>
	var p = Project()
	if !p->has_key('history') || type(p.history) != v:t_list
		p.history = []
	endif
	return p.history
enddef

def PushHistory(line: string)
	var h = History()
	const i = index(h, line)
	if i >= 0
		remove(h, i)
	endif
	insert(h, line, 0)
	if len(h) > HIST_MAX
		remove(h, HIST_MAX, -1)
	endif
enddef

def ForgetHistory(line: string)
	var h = History()
	const i = index(h, line)
	if i >= 0
		remove(h, i)
	endif
enddef

def CmdOpts(name: string): dict<any>
	var s = SlotCfg(name)
	if !s->has_key('qf')
		s.qf = true
	endif
	if !s->has_key('close')
		s.close = false
	endif
	return s
enddef

def Rules(): list<string>
	const content = system('supramake --print-rules')
	if v:shell_error != 0
		return []
	endif
	return split(content, '\n')->filter((_, r) => r !~ '^\s*$')
enddef

export def AutoComplete_gMake(lead: string, cmdline: string, cursorpos: number): list<string>
	if cmdline =~ '^\s*\S\+\s\+!'
		return glob(lead .. '*', 0, 1)
	endif
	var index = match(cmdline, '\s')
	index = match(cmdline, '\s', index + 1)
	if index == -1
		return Rules()
	else
		return glob(lead .. '*', 0, 1)
	endif
enddef



def Cmd(rule: string, run: bool, valgrind: bool, args: string): list<string>
	var cmd = ['supramake']
	if run
		add(cmd, '--run')
	endif
	if valgrind
		add(cmd, '--mode-valgrind')
	endif
	add(cmd, rule)
	if args != ''
		extend(cmd, ['--'] + split(args))
	endif
	return cmd
enddef

augroup SupraMakeResize
	autocmd!
augroup END

var pending_qf = false

var use_qf     = true
var auto_close = false

def CloseOutput()
	pending_qf = false
	if wid != -1
		popup_close(wid)
		wid = -1
	endif
	autocmd! SupraMakeResize
	if buf != 0 && bufexists(buf)
		exe 'bd! ' .. buf
		buf = 0
	endif
enddef

def Dismiss(open_qf: bool = false)
	const want = open_qf && pending_qf
	CloseOutput()
	if want
		copen
		silent! cfirst
	endif
enddef

const ANY_KEYS = ['<cr>', '<space>', '<bs>', '<tab>', '<esc>', '<c-c>',
	'<up>', '<down>', '<left>', '<right>']

const KEEP_KEYS = ['y', 'v', 'V']

def ArmAnyKey()
	if wid == -1
		return
	endif
	const close_call = '<ScriptCmd>Dismiss()<cr>'
	var keys = copy(ANY_KEYS)
	for c in range(33, 126)
		const k = nr2char(c)
		if index(KEEP_KEYS, k) >= 0
			continue
		endif
		add(keys, k ==# '|' ? '<bar>' : k ==# '<' ? '<lt>' : k ==# '\' ? '<bslash>' : k)
	endfor
	var cmds = mapnew(keys, (_, k) => 'nnoremap <buffer> ' .. k .. ' ' .. close_call)
	const qf_call = '<ScriptCmd>Dismiss(true)<cr>'
	extend(cmds, ['nnoremap <buffer> <c-q> ' .. qf_call,
		'tnoremap <buffer> <c-q> <c-\><c-n>' .. qf_call])
	win_execute(wid, cmds)
enddef

def ResizeOutput(id: number)
	if id == -1 || popup_getpos(id) == {}
		return
	endif
	popup_move(id, {
		minwidth:  float2nr(&columns * 0.9),
		maxwidth:  float2nr(&columns * 0.9),
		minheight: float2nr(&lines * 0.8),
		maxheight: float2nr(&lines * 0.8),
	})
enddef

def Publish(label: string, status: number)
	const rule = Ellipsis(label, 60)
	var nb = 0
	var nw = 0
	if use_qf
		const lines = buf != 0 && bufexists(buf) ? getbufline(buf, 1, '$') : []
		setqflist([], ' ', {title: 'SupraMake ' .. label, lines: lines, efm: EFM})
		const valid = getqflist()->filter((_, e) => e.valid)
		nb = len(copy(valid)->filter((_, e) => e.type ==? 'e'))
		nw = len(copy(valid)->filter((_, e) => e.type ==? 'w'))
	endif

	pending_qf = nb > 0 || nw > 0
	if auto_close && status == 0 && !pending_qf
		CloseOutput()
	endif
	if wid != -1
		const state = status == 0 ? 'ok' : $'exit {status}'
		const hint = pending_qf ? 'any key to close · <C-q> quickfix' : 'press any key to close'
		const room = float2nr(&columns * 0.9) - strcharlen($'   — {state} · {hint} ')
		popup_setoptions(wid, {title: $'  {Ellipsis(rule, room)} — {state} · {hint} '})
	endif
	ArmAnyKey()

	if !pending_qf
		if status == 0
			Notify.Notification([$'SupraMake: {rule}', 'Finished without errors'], {type: 'success'})
		else
			Notify.Notification([$'SupraMake: {rule}', $'Failed (exit {status})'], {type: 'error'})
		endif
		return
	endif

	var parts: list<string> = []
	if nb > 0
		add(parts, nb == 1 ? '1 error' : $'{nb} errors')
	endif
	if nw > 0
		add(parts, nw == 1 ? '1 warning' : $'{nw} warnings')
	endif
	Notify.Notification([$'SupraMake: {rule}', join(parts, ', ')],
		{type: nb > 0 ? 'error' : 'warning'})
enddef

def Busy(): bool
	if job != null_job && job_status(job) == 'run'
		Notify.Notification(['SupraMake', 'A build is already running'], {type: 'warning'})
		return true
	endif
	return false
enddef

def Ellipsis(s: string, w: number): string
	return strcharlen(s) > w ? strcharpart(s, 0, w - 1) .. '…' : s
enddef

def Exec(label: string, cmd: list<string>, qf: bool = true, close: bool = false)
	use_qf     = qf
	auto_close = close
	is_supramake = true
	silent! wall

	CloseOutput()
	hi link Terminal Normal

	try
		buf = term_start(cmd, {
			hidden: 1,
			exit_cb: (_, status) => {
				is_supramake = false
				job = null_job
				timer_start(50, (_) => Publish(label, status))
			},
		})
	catch
		is_supramake = false
		Notify.Notification(['SupraMake', v:exception], {type: 'error'})
		return
	endtry
	job = term_getjob(buf)

	wid = popup_create(buf, {
		minwidth:  float2nr(&columns * 0.9),
		maxwidth:  float2nr(&columns * 0.9),
		minheight: float2nr(&lines * 0.8),
		maxheight: float2nr(&lines * 0.8),
		title:     $'  {Ellipsis(label, float2nr(&columns * 0.9) - 8)} … ',
		border:    [1],
		borderhighlight: ['Normal', 'Normal', 'Normal', 'Normal'],
		borderchars: ['─', '│', '─', '│', '╭', '╮', '󰧄', '╰'],
		drag: 1,
		resize: 1,
		zindex: 200,
	})

	augroup SupraMakeResize
		autocmd!
		exe $'autocmd VimResized * call s:ResizeOutput({wid})'
	augroup END

	const close_call = '<ScriptCmd>Dismiss()<cr>'
	win_execute(wid, 'tnoremap <buffer> <esc>	<c-\><c-n>' .. close_call)
	win_execute(wid, 'tnoremap <buffer> <c-q>	<c-\><c-n>' .. close_call)
	win_execute(wid, 'nnoremap <buffer> <esc>	' .. close_call)
	win_execute(wid, 'nnoremap <buffer> q	' .. close_call)
	redraw
enddef

def Run(rule: string, run: bool, valgrind: bool, args: string)
	if Busy()
		return
	endif
	StoreRule(rule, args, run, valgrind)
	SetLast(rule)
	SaveCfg()
	Exec(rule, Cmd(rule, run, valgrind, args))
enddef

export def RunCmd(cmdline: string, qf: bool = true, close: bool = false)
	const line = trim(cmdline)
	if line == ''
		return
	endif
	if line =~ '^:'
		PushHistory(line)
		SaveCfg()
		feedkeys(line .. "\<cr>", 'n')
		return
	endif
	if Busy()
		return
	endif
	PushHistory(line)
	SaveCfg()
	Exec(line, [&shell, &shellcmdflag, line], qf, close)
enddef



def Fit(items: list<string>, n: number, w: number): list<string>
	var out = mapnew(items, (_, l) => strcharlen(l) > w ? strcharpart(l, 0, w - 1) .. '…' : l)
	if len(out) > n
		out = out[: n - 1]
	endif
	while len(out) < n
		add(out, '')
	endwhile
	return out
enddef

def PinList(pop: any, count: number, w: number, h: number)
	const bar = count > h
	popup_setoptions(pop.GetWid(), {minheight: h, maxheight: h, scrollbar: bar ? 1 : 0, minwidth: w - (bar ? 1 : 0), maxwidth: w - (bar ? 1 : 0)})
enddef

def Preview(rule: string, clean: bool, valgrind: bool, args: string): string
	return join(Cmd(rule, clean, valgrind, args), ' ')
enddef

def Wrap(s: string, w: number): list<string>
	var out: list<string> = []
	var rest = s
	while strcharlen(rest) > w
		add(out, strcharpart(rest, 0, w))
		rest = strcharpart(rest, w)
	endwhile
	add(out, rest)
	return out
enddef

var panel_open = false

export def Panel(name: string = '')
	if Busy()
		return
	endif
	CloseOutput()

	if panel_open
		return
	endif

	const rules = Rules()
	if empty(rules)
		Notify.Notification(['SupraMake', 'No rule found here'], {type: 'warning'})
		return
	endif
	panel_open = true

	const PW = float2nr(&columns * 0.8)
	const PH = float2nr(&lines * 0.8)
	const col0  = (&columns - PW) / 2
	const line0 = (&lines - PH) / 2

	const bg_core_w = PW - 4
	const bg_core_h = PH - 2
	const in_col  = col0 + 2
	const in_line = line0 + 1
	const in_w    = PW - 4
	const in_h    = PH - 2

	const side_screen = max([22, in_w * 30 / 100])
	const side_core   = side_screen - 4
	const right_col   = in_col + side_screen
	const right_core  = in_w - side_screen - 4

	const l_cmd  = in_line
	const l_prev = in_line + 3
	const l_bar  = in_line + in_h - 6
	const l_btn  = l_bar + 1
	const l_args = l_bar - 3
	const prev1_core = max([1, (l_args - l_cmd) - 2])
	const hist_core = max([1, (l_bar - l_prev) - 2])

	const l_search = in_line
	const l_list   = in_line + 3
	const list_core = max([1, in_h - 6])
	const full_core = in_w - 4
	const btn_launch_col2 = in_col + full_core - 12

	const pick_core   = max([20, in_w - 12])
	const pick_core_h = max([3, in_h - 8])
	const pick_col    = col0 + (PW - (pick_core + 4)) / 2
	const pick_line   = line0 + (PH - (pick_core_h + 2)) / 2

	const btn_launch_col = max([right_col + 24, right_col + right_core - 12])

	var current = LastRule()
	if index(rules, current) < 0
		current = rules[0]
	endif

	var slot = name != '' ? name : LastSlot()
	if slot == ''
		panel_open = false
		Notify.Notification(['SupraMake', 'No slot yet: press the key of the one to open'], {type: 'warning'})
		return
	endif
	var page = SlotCfg(slot).kind == 'cmd' ? 2 : 1
	var slots = copy(SlotNames())

	var fkeys: dict<string> = {}
	for n in range(1, 12)
		fkeys[eval($'"\<F{n}>"')] = $'F{n}'
	endfor

	var SlotAt = (l: number): string => l >= 1 && l <= len(slots) ? slots[l - 1] : ''

	var background = Simple.Simple.new({
		close_key: [],
		col: col0,
		line: line0,
		width: bg_core_w,
		height: bg_core_h,
	})

	var Fits = (long: string, short: string): string => strcharlen(long) + 2 <= bg_core_w ? long : short
	const help = Fits('↑↓ move · Tab focus · ^T page · ^S slots · ⏎ run · Esc close',
		'↑↓ · ^T page · ^S slots · ⏎ run · Esc')
	const help2 = Fits('↑↓ history · Tab focus · d forget · ^T page · ^S slots · ⏎ run · Esc',
		'↑↓ history · d forget · ^T page · ^S slots · ⏎ run')
	const help_pick = Fits('↑↓ move · ⏎ open · r rename · n new · d delete · Esc back',
		'⏎ open · r rename · n new · d delete · Esc')

	var Help = (txt: string) => {
		const pad = max([0, (bg_core_w - strcharlen(txt)) / 2])
		var bg_text = repeat([''], bg_core_h - 1)
		add(bg_text, repeat(' ', pad) .. txt)
		background.SetText(bg_text)
		popup_setoptions(background.GetWid(), {minwidth: bg_core_w, maxwidth: bg_core_w, minheight: bg_core_h, maxheight: bg_core_h})
	}
	Help(help)

	var Title = () => {
		background.SetTitle(page == 1
			? $' ● SupraMake   ○ Command — {slot} '
			: $' ○ SupraMake   ● Command — {slot} ')
	}

	var TabZone = (): list<number> => {
		const pos = popup_getpos(background.GetWid())
		if empty(pos)
			return []
		endif
		var first = 0
		var last  = 0
		var split = 0
		var seen  = 0
		for c in range(2, pos.width - 1)
			const ch = screenstring(pos.line, pos.col + c - 1)
			if ch == '─'
				continue
			endif
			if first == 0
				first = c
			endif
			last = c
			if ch == '○' || ch == '●'
				seen += 1
				if seen == 2
					split = c
				endif
			endif
		endfor
		return split == 0 ? [] : [first, split, last]
	}

	var search = Input.Input.new({
		close_key: [],
		col: in_col,
		line: l_search,
		width: side_core,
		maxwidth: side_core,
		prompt: '➜ ',
		title: ' Search',
		title_pos: 'left',
	})

	var sel = Selector.Selector.new({
		close_key: [],
		col: in_col,
		line: l_list,
		width: side_core,
		title: ' Rules',
		title_pos: 'left',
	}, rules)

	var filtered = copy(rules)
	var FixList = () => PinList(sel, len(filtered), side_core, list_core)
	FixList()

	var cmdline = Input.Input.new({
		close_key: [],
		col: in_col,
		line: l_cmd,
		width: full_core,
		maxwidth: full_core,
		prompt: '➜ ',
		title: ' Command',
		title_pos: 'left',
	})

	var hist_view = copy(History())
	var hist_browsing = false
	var hist_draft    = ''
	var histsel = Selector.Selector.new({
		close_key: [],
		col: in_col,
		line: l_prev,
		width: full_core,
		title: ' History',
		title_pos: 'left',
	}, [''])
	var FixHist = () => PinList(histsel, len(hist_view), full_core, hist_core)
	var HistText = () => {
		histsel.SetText(empty(hist_view)
			? ['(no command yet)']
			: mapnew(hist_view, (_, l) => Ellipsis(l, full_core - 1)))
		FixHist()
		histsel.SetTitle(empty(hist_view) ? ' History' : $' History ({len(hist_view)})')
	}
	HistText()

	var preview1 = Simple.Simple.new({
		close_key: [],
		col: right_col,
		line: l_cmd,
		width: right_core,
		height: prev1_core,
		title: ' Command',
		title_pos: 'left',
	})

	var args = Input.Input.new({
		close_key: [],
		col: right_col,
		line: l_args,
		width: right_core,
		maxwidth: right_core,
		prompt: '➜ ',
		title: ' Arguments',
		title_pos: 'left',
	})

	var bar = Simple.Simple.new({
		close_key: [],
		col: right_col,
		line: l_bar,
		width: right_core,
		height: 3,
	})

	var btn_exec = ToggleButton.ToggleButton.new({
		close_key: [],
		text: '--run',
		col: right_col + 2,
		line: l_btn,
		width: 5,
	})

	var btn_valgrind = ToggleButton.ToggleButton.new({
		close_key: [],
		text: 'Valgrind',
		col: right_col + 12,
		line: l_btn,
		width: 8,
	})

	var btn_qf = ToggleButton.ToggleButton.new({
		close_key: [],
		text: 'Quickfix',
		col: in_col + 2,
		line: l_btn,
		width: 8,
	})

	var btn_keep = ToggleButton.ToggleButton.new({
		close_key: [],
		text: 'Auto-close',
		col: in_col + 15,
		line: l_btn,
		width: 10,
	})

	var btn_launch = Button.Button.new({
		close_key: [],
		text: '▶ Run',
		col: btn_launch_col,
		line: l_btn,
		width: 9,
	})

	var picker = Selector.Selector.new({
		close_key: [],
		col: pick_col,
		line: pick_line,
		width: pick_core,
		title: ' Slots',
		title_pos: 'left',
	}, [''])
	var FixPicker = () => PinList(picker, len(slots), pick_core, pick_core_h)
	FixPicker()
	picker.Hide()

	var namein = Input.Input.new({
		close_key: [],
		col: pick_col,
		line: pick_line + pick_core_h + 2,
		width: pick_core,
		maxwidth: pick_core,
		prompt: '➜ ',
		title: ' Name',
		title_pos: 'left',
	})
	namein.Hide()

	var pops: list<Base.SupraPopup> = [background, search, sel, cmdline, histsel, preview1, args, bar, btn_exec, btn_valgrind, btn_qf, btn_keep, btn_launch]
	var overlay: list<Base.SupraPopup> = [picker, namein]

	var Current = (): string => page == 1
		? Preview(current, btn_exec.IsToggled(), btn_valgrind.IsToggled(), args.GetInput())
		: cmdline.GetInput()

	var cmd_title = ' Command'

	var RefreshCmd = () => {
		const line = Current()
		if page == 1
			popup_setoptions(args.GetWid(), {minwidth: right_core, maxwidth: right_core})
			preview1.SetText(Fit(Wrap(line, right_core), prev1_core, right_core))
		else
			const want = line =~ '^:' ? ' Vim command' : ' Command'
			if want != cmd_title
				cmd_title = want
				cmdline.SetTitle(want)
			endif
			popup_setoptions(cmdline.GetWid(), {minwidth: full_core, maxwidth: full_core})
		endif
	}

	var Commit = () => {
		StoreRule(current, args.GetInput(),
			btn_exec.IsToggled(), btn_valgrind.IsToggled())
	}

	var Populate = (rule: string) => {
		var r = RuleCfg(rule)
		const room = right_core - strcharlen(' Arguments () ')
		args.SetTitle(room < 4 ? ' Arguments'
			: $' Arguments ({Ellipsis(rule, room)})')
		args.SetInput(r.args)
		btn_exec.SetToggled(Truthy(r.run), true)
		btn_valgrind.SetToggled(Truthy(r.valgrind), true)
		RefreshCmd()
	}

	var Load = (rule: string) => {
		if rule == current
			return
		endif
		Commit()
		current = rule
		Populate(rule)
	}

	var cmd_loaded = ''
	var cmd_ready = false

	var CommitCmd = () => {
		if page != 2 || !cmd_ready
			return
		endif
		var o = CmdOpts(slot)
		o.qf    = btn_qf.IsToggled()
		o.close = btn_keep.IsToggled()
		const line = cmdline.GetInput()
		if line != '' && line != cmd_loaded
			StoreSlot(slot, 'cmd', line)
		endif
	}

	var LoadSlot = (n: string) => {
		if n == ''
			return
		endif
		CommitCmd()
		slot = n
		Title()
		const st = SlotCfg(n)
		if page == 2
			cmd_loaded = st.kind == 'cmd' ? st.value : ''
			cmdline.SetInput(cmd_loaded)
			const o = CmdOpts(n)
			btn_qf.SetToggled(Truthy(o.qf), true)
			btn_keep.SetToggled(Truthy(o.close), true)
			cmd_ready = true
		elseif st.kind == 'rule'
			const i = index(filtered, st.value)
			if i >= 0
				win_execute(sel.GetWid(), 'norm! ' .. (i + 1) .. 'G')
				Load(st.value)
			endif
		endif
		RefreshCmd()
		redraw
	}

	var ShowPage = (n: number) => {
		CommitCmd()
		page = n
		const p1 = [search, sel, preview1, args, btn_exec, btn_valgrind]
		const p2 = [cmdline, histsel, btn_qf, btn_keep]
		for pop in (n == 1 ? p2 : p1)
			pop.Hide()
		endfor
		for pop in (n == 1 ? p1 : p2)
			pop.Show()
		endfor
		popup_setoptions(bar.GetWid(), n == 1
			? {col: right_col, line: l_bar, minwidth: right_core, maxwidth: right_core}
			: {col: in_col, line: l_bar, minwidth: full_core, maxwidth: full_core})
		popup_setoptions(btn_launch.GetWid(), {col: n == 1 ? btn_launch_col : btn_launch_col2, line: l_btn})
		Help(n == 1 ? help : help2)
		Title()
		LoadSlot(slot)
		if n == 1
			search.SetFocus(true)
		else
			cmdline.SetFocus(true)
		endif
		redraw
	}

	var picker_open = false
	var name_mode   = ''
	var name_target = ''

	var GotoSlot = (n: string) => {
		if n == ''
			return
		endif
		const want = SlotCfg(n).kind == 'cmd' ? 2 : 1
		LoadSlot(n)
		if want != page
			ShowPage(want)
		endif
	}

	var PickerText = () => {
		slots = copy(SlotNames())
		const w = max(mapnew(slots, (_, n) => strcharlen(n)))
		picker.SetText(mapnew(slots, (_, n) => {
			const st = SlotCfg(n)
			const txt = (n == slot ? '▸ ' : '  ') .. n .. repeat(' ', w - strcharlen(n))
				.. '  ' .. (st.kind == 'cmd' ? st.value : '⚙ ' .. st.value)
			return Ellipsis(txt, pick_core)
		}))
		FixPicker()
		win_execute(picker.GetWid(), 'norm! ' .. max([1, index(slots, slot) + 1]) .. 'G')
	}

	var ClosePicker = () => {
		picker_open = false
		namein.Hide()
		picker.Hide()
		Help(page == 1 ? help : help2)
		if page == 1
			search.SetFocus(true)
		else
			cmdline.SetFocus(true)
		endif
		redraw
	}

	var OpenPicker = () => {
		picker_open = true
		PickerText()
		picker.Show()
		picker.SetFocus(true)
		Help(help_pick)
		redraw
	}

	var AskName = (mode: string) => {
		name_mode   = mode
		name_target = SlotAt(line('.', picker.GetWid()))
		if mode == 'rename' && name_target == ''
			return
		endif
		namein.SetTitle(mode == 'new' ? ' New slot' : $' Rename {name_target}')
		namein.SetInput(mode == 'new' ? '' : name_target)
		popup_setoptions(namein.GetWid(), {minwidth: pick_core, maxwidth: pick_core})
		namein.Show()
		namein.SetFocus(true)
		redraw
	}

	var DeleteAt = () => {
		const nm = SlotAt(line('.', picker.GetWid()))
		if nm == '' || !DeleteSlot(nm)
			return
		endif
		if nm == slot
			slot = SlotNames()[0]
			LoadSlot(slot)
		endif
		PickerText()
		redraw
	}

	var closing = false
	var CloseAll = () => {
		if closing
			return
		endif
		closing = true
		panel_open = false
		Commit()
		CommitCmd()
		var pr = Project()
		pr.slot = slot
		SaveCfg()
		for pop in pops + overlay
			silent! pop.Close()
		endfor
	}

	var Launch = () => {
		if page == 2
			const line = cmdline.GetInput()
			if line == ''
				return
			endif
			const qf    = btn_qf.IsToggled()
			const close = btn_keep.IsToggled()
			StoreSlot(slot, 'cmd', line)
			CloseAll()
			timer_start(0, (_) => RunCmd(line, qf, close))
			return
		endif
		if empty(filtered)
			return
		endif
		const rule     = current
		const argline  = args.GetInput()
		const exec     = btn_exec.IsToggled()
		const valgrind = btn_valgrind.IsToggled()
		StoreSlot(slot, 'rule', rule)
		CloseAll()
		timer_start(0, (_) => Run(rule, exec, valgrind, argline))
	}

	var Hovered = (): string => {
		const sw = sel.GetWid()
		const l = line('.', sw)
		const txt = getbufline(winbufnr(sw), l, l)
		return empty(txt) ? '' : txt[0]
	}

	var LoadHistAt = () => {
		const l = line('.', histsel.GetWid())
		if l < 1 || l > len(hist_view)
			return
		endif
		cmdline.SetInput(hist_view[l - 1])
		RefreshCmd()
	}

	var MoveList = (down: bool, cnt: number) => {
		if page == 2
			if empty(hist_view)
				return
			endif
			if !hist_browsing
				hist_draft    = cmdline.GetInput()
				hist_browsing = true
				win_execute(histsel.GetWid(), 'norm! 1G')
			elseif !down && line('.', histsel.GetWid()) <= 1
				hist_browsing = false
				cmdline.SetInput(hist_draft)
				RefreshCmd()
				redraw
				return
			else
				win_execute(histsel.GetWid(), 'norm! ' .. cnt .. (down ? 'j' : 'k'))
			endif
			LoadHistAt()
			redraw
			return
		endif
		if empty(filtered)
			return
		endif
		win_execute(sel.GetWid(), 'norm! ' .. cnt .. (down ? 'j' : 'k'))
		const hit = Hovered()
		if hit != ''
			Load(hit)
		endif
		redraw
	}

	var Filter = (pattern: string) => {
		popup_setoptions(search.GetWid(), {minwidth: side_core, maxwidth: side_core})
		if pattern == ''
			filtered = copy(rules)
		else
			const pat = '\c' .. join(split(pattern, '\zs')->map((_, c) => escape(c, '\.*$^~[]')), '.\{-}')
			filtered = copy(rules)->filter((_, r) => r =~ pat)
		endif
		sel.SetText(filtered)
		FixList()
		const title = len(filtered) == len(rules) ? ' Rules' : $' Rules ({len(filtered)}/{len(rules)})'
		sel.SetTitle(title)
		if empty(filtered)
			return
		endif
		win_execute(sel.GetWid(), 'norm! 1G')
		Load(filtered[0])
		redraw
	}

	search.AddEventInputChanged((_, _, text) => Filter(text))
	search.AddEventInputEnter((_) => Launch())

	var PanelKey = (_, key: string): number => {
		if key == "\<Esc>" || key ==? "\<C-q>"
			CloseAll()
			return Base.BLOCK
		elseif key == "\<Up>"
			MoveList(false, 1)
			return Base.BLOCK
		elseif key == "\<Down>"
			MoveList(true, 1)
			return Base.BLOCK
		elseif key == "\<C-t>"
			ShowPage(page == 1 ? 2 : 1)
			return Base.BLOCK
		elseif key == "\<C-s>"
			OpenPicker()
			return Base.BLOCK
		elseif fkeys->has_key(key) && index(slots, fkeys[key]) >= 0
			GotoSlot(fkeys[key])
			return Base.BLOCK
		elseif key ==? "\<ScrollWheelUp>" || key ==? "\<ScrollWheelDown>"
			const over = getmousepos().winid
			if over == (page == 1 ? sel.GetWid() : histsel.GetWid())
				MoveList(key ==? "\<ScrollWheelDown>", 3)
			endif
			return Base.BLOCK
		endif
		return Base.CONTINUE
	}

	sel.AddEventFilterNoFocus((_, sw: number, key: string): number => {
		if key ==? "\<LeftMouse>"
			const mp = getmousepos()
			if mp.winid == sw
				win_execute(sw, 'norm! ' .. mp.line .. 'G')
				sel.SetFocus(true)
				const hit = Hovered()
				if hit != ''
					Load(hit)
				endif
				redraw
				return Base.BLOCK
			endif
		endif
		return Base.CONTINUE
	})

	sel.AddEventSelectorMove((line) => Load(line))
	sel.AddEventSelectorSelect((line) => {
		Load(line)
		Launch()
	})
	background.AddEventFilterNoFocus((_, bw: number, key: string): number => {
		if key !=? "\<LeftMouse>" && key !=? "\<2-LeftMouse>"
			return Base.CONTINUE
		endif
		const mp = getmousepos()
		if mp.winid != bw || mp.winrow != 1 || mp.line != 0
			return Base.CONTINUE
		endif
		if picker_open
			return Base.BLOCK
		endif
		const zone = TabZone()
		if empty(zone) || mp.wincol < zone[0] || mp.wincol > zone[2]
			return Base.CONTINUE
		endif
		const want = mp.wincol < zone[1] ? 1 : 2
		if want != page
			ShowPage(want)
		endif
		return Base.BLOCK
	})

	var ReplayHist = () => {
		if empty(hist_view)
			return
		endif
		hist_browsing = true
		LoadHistAt()
		cmdline.SetFocus(true)
		redraw
	}

	var ForgetAt = () => {
		if empty(hist_view)
			return
		endif
		const l = line('.', histsel.GetWid())
		if l < 1 || l > len(hist_view)
			return
		endif
		ForgetHistory(hist_view[l - 1])
		hist_view = copy(History())
		HistText()
		if !empty(hist_view)
			win_execute(histsel.GetWid(), 'norm! ' .. min([l, len(hist_view)]) .. 'G')
		endif
		redraw
	}

	histsel.AddEventFilterNoFocus((_, hw: number, key: string): number => {
		if key ==? "\<LeftMouse>"
			const mp = getmousepos()
			if mp.winid == hw
				win_execute(hw, 'norm! ' .. mp.line .. 'G')
				histsel.SetFocus(true)
				redraw
				return Base.BLOCK
			endif
		endif
		return Base.CONTINUE
	})

	histsel.AddEventSelectorMove((_) => {
		if !hist_browsing
			hist_draft    = cmdline.GetInput()
			hist_browsing = true
		endif
		LoadHistAt()
	})
	histsel.AddEventSelectorSelect((_) => ReplayHist())
	histsel.AddEventKeyPressedFocus((_, key: string): number => {
		if key ==# 'd'
			ForgetAt()
			return Base.BLOCK
		endif
		return Base.CONTINUE
	})

	picker.AddEventSelectorSelect((_) => {
		const nm = SlotAt(line('.', picker.GetWid()))
		ClosePicker()
		GotoSlot(nm)
	})
	picker.AddEventKeyPressedFocus((_, key: string): number => {
		if key ==# 'r'
			AskName('rename')
		elseif key ==# 'n'
			AskName('new')
		elseif key ==# 'd'
			DeleteAt()
		elseif key == "\<Esc>" || key == "\<C-s>"
			ClosePicker()
		else
			return Base.CONTINUE
		endif
		return Base.BLOCK
	})

	namein.AddEventInputEnter((_) => {
		const nm = trim(namein.GetInput())
		namein.Hide()
		picker.SetFocus(true)
		if nm != ''
			if name_mode == 'new'
				SlotCfg(nm)
				LoadSlot(nm)
			elseif RenameSlot(name_target, nm) && slot == name_target
				slot = nm
				Title()
			endif
		endif
		PickerText()
		redraw
	})
	namein.AddEventKeyPressedFocus((_, key: string): number => {
		if key == "\<Esc>" || key ==? "\<C-q>"
			namein.Hide()
			picker.SetFocus(true)
			redraw
			return Base.BLOCK
		endif
		return Base.CONTINUE
	})
	cmdline.AddEventInputChanged((_, _, _) => {
		hist_browsing = false
		RefreshCmd()
	})
	cmdline.AddEventInputEnter((_) => Launch())
	args.AddEventInputChanged((_, _, _) => RefreshCmd())
	args.AddEventInputEnter((_) => Launch())
	btn_exec.AddEventToggle((_, _) => RefreshCmd())
	btn_valgrind.AddEventToggle((_, _) => RefreshCmd())
	btn_launch.AddEventButtonClick((_) => Launch())

	var Head = (): any => page == 1 ? search : cmdline
	var Tail = (): any => page == 1 ? btn_valgrind : btn_keep
	search.SetEventFocus((_)       => ({next: args,         prev: btn_launch}))
	cmdline.SetEventFocus((_)      => ({next: histsel,      prev: btn_launch}))
	histsel.SetEventFocus((_)      => ({next: btn_qf,       prev: cmdline}))
	btn_qf.SetEventFocus((_)       => ({next: btn_keep,     prev: histsel}))
	btn_keep.SetEventFocus((_)     => ({next: btn_launch,   prev: btn_qf}))
	args.SetEventFocus((_)         => ({next: btn_exec,     prev: search}))
	sel.SetEventFocus((_)          => ({next: args,         prev: search}))
	btn_exec.SetEventFocus((_)     => ({next: btn_valgrind, prev: args}))
	btn_valgrind.SetEventFocus((_) => ({next: btn_launch,   prev: btn_exec}))
	btn_launch.SetEventFocus((_)   => ({next: Head(),       prev: Tail()}))

	for pop in pops
		pop.AddEventClose((_) => CloseAll())
		pop.AddEventKeyPressedFocus(PanelKey)
	endfor

	const idx = index(rules, current)
	if idx > 0
		win_execute(sel.GetWid(), 'norm! ' .. (idx + 1) .. 'G')
	endif
	Populate(current)
	ShowPage(page)
enddef



export def RunSlot(name: string)
	if !HasSlot(name)
		Panel(name)
		return
	endif
	const s = SlotCfg(name)
	var p = Project()
	p.slot = name
	if s.kind == 'cmd'
		const o = CmdOpts(name)
		RunCmd(s.value, Truthy(o.qf), Truthy(o.close))
	else
		SupraMake(s.value)
	endif
enddef

export def Slots(): list<dict<string>>
	var out: list<dict<string>> = []
	for name in SlotNames()
		const s = SlotCfg(name)
		var cmd = s.value
		if s.value == ''
			cmd = ''
		elseif s.kind != 'cmd'
			const r = RuleCfg(s.value)
			cmd = Preview(s.value, Truthy(r.run), Truthy(r.valgrind), r.args)
		endif
		add(out, {name: name, kind: s.kind, value: s.value, cmd: cmd})
	endfor
	return out
enddef

export def RunLast()
	RunSlot(LastSlot())
enddef

export def SupraMake(rule: string)
	var r = RuleCfg(rule)
	Run(rule, Truthy(r.run), Truthy(r.valgrind), r.args)
enddef

export def MakeSpecial(cmdline: string = '')
	const line = trim(cmdline)
	if line =~ '^!'
		RunCmd(trim(line[1 : ]))
		return
	endif
	const args = split(line)
	const length = len(args)
	if length == 0
		SupraMake('all')
	elseif length == 1
		SupraMake(args[0])
	else
		var r = RuleCfg(args[0])
		Run(args[0], Truthy(r.run), Truthy(r.valgrind), join(args[1 : ], ' '))
	endif
enddef
