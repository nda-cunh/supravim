vim9script

import autoload 'supravim/SupravimServer.vim' as Server

def Inbox(line: string)
	var base = empty($XDG_CONFIG_HOME) ? $HOME .. '/.config' : $XDG_CONFIG_HOME
	var dir = base .. '/supravim'
	if isdirectory(dir)
		writefile([line], dir .. '/achievements.inbox', 'a')
	endif
enddef

def SendMetric(name: string, n: number)
	if !Server.Send('Metric: ' .. name .. ' ' .. n)
		Inbox('M ' .. name .. ' ' .. n)
	endif
enddef

def SendEvent(id: string)
	if !Server.Send('Ach: ' .. id)
		Inbox('E ' .. id)
	endif
enddef

def g:SupraAchMetric(name: string, n: number = 1)
	SendMetric(name, n)
enddef

def g:SupraAchEvent(id: string)
	SendEvent(id)
enddef

def InitCount()
	var wc = wordcount()
	b:sa_chars = get(wc, 'chars', 0)
	b:sa_words = get(wc, 'words', 0)
	b:sa_lines = line('$')
enddef

def OnTextChanged()
	if !exists('b:sa_chars')
		InitCount()
		return
	endif
	var wc = wordcount()
	var c = get(wc, 'chars', 0)
	var w = get(wc, 'words', 0)
	var l = line('$')
	if c - b:sa_chars > 0
		SendMetric('chars', c - b:sa_chars)
	endif
	if w - b:sa_words > 0
		SendMetric('words', w - b:sa_words)
	endif
	if l - b:sa_lines > 0
		SendMetric('lines', l - b:sa_lines)
	endif
	b:sa_chars = c
	b:sa_words = w
	b:sa_lines = l
enddef

var mode_since: list<any> = []

def ModeElapsedMs(): number
	if empty(mode_since)
		mode_since = reltime()
		return 0
	endif
	var ms = float2nr(reltimefloat(reltime(mode_since)) * 1000)
	mode_since = reltime()
	return ms
enddef

def OnInsertEnter()
	var el = ModeElapsedMs()
	if el > 0
		SendMetric('normal_ms', el)
	endif
enddef

def OnInsertLeave()
	var el = ModeElapsedMs()
	if el > 0
		SendMetric('insert_ms', el)
	endif
enddef

def OnWrite()
	SendMetric('write', 1)
	if exists('b:sa_last_write_tick') && b:sa_last_write_tick == b:changedtick
		b:sa_noop_writes = get(b:, 'sa_noop_writes', 0) + 1
		if b:sa_noop_writes >= 3
			SendEvent('www')
		endif
	else
		b:sa_noop_writes = 0
	endif
	b:sa_last_write_tick = b:changedtick
enddef

def Bump(name: string, keys: string): string
	SendMetric(name, 1)
	return keys
enddef

var undo_seq: list<string> = []

def TrackSeq(op: string)
	add(undo_seq, op)
	if len(undo_seq) > 3
		remove(undo_seq, 0)
	endif
	if undo_seq == ['u', 'r', 'u']
		SendEvent('ctrl_z_philo')
	endif
enddef

def OnUndo(): string
	SendMetric('undo', 1)
	TrackSeq('u')
	return 'u'
enddef

def OnRedo(): string
	SendMetric('redo', 1)
	TrackSeq('r')
	return "\<C-r>"
enddef

def OnAt(): string
	SendMetric('macro_play', 1)
	if v:count1 >= 2
		SendMetric('macro_count', 1)
	endif
	return '@'
enddef

var theme_ready = false

def OnColorScheme()
	if theme_ready
		SendMetric('theme_change', 1)
	endif
enddef

def OnReadFile()
	if &buftype != '' || expand('%') == ''
		return
	endif
	b:sa_opened_tick = b:changedtick
	var ft = getftime(expand('%:p'))
	if ft > 0 && localtime() - ft > 15552000
		SendEvent('archeologue')
	endif
	if ft > localtime() + 60
		SendEvent('retour_futur')
	endif
enddef

def OnUnload()
	if &buftype != '' || !filereadable(expand('%:p'))
		return
	endif
	if exists('b:sa_opened_tick') && b:changedtick == b:sa_opened_tick && !&modified
		SendEvent('page_blanche')
	endif
enddef

def SafeNmap(lhs: string, rhs: string)
	if empty(maparg(lhs, 'n'))
		exec 'nnoremap <expr> ' .. lhs .. ' ' .. rhs
	endif
enddef

export def Setup()
	SafeNmap('dd', 'Bump("dd", "dd")')
	SafeNmap('ciw', 'Bump("ciw", "ciw")')
	SafeNmap('f', 'Bump("fchar", "f")')
	SafeNmap('.', 'Bump("dot", ".")')
	SafeNmap('`', 'Bump("mark_jump", "`")')
	SafeNmap('<C-v>', 'Bump("vblock", "\<C-v>")')
	SafeNmap('u', 'OnUndo()')
	SafeNmap('<C-r>', 'OnRedo()')
	SafeNmap('@', 'OnAt()')

	augroup SupraAchievements
		autocmd!
		autocmd TextChanged,TextChangedI * OnTextChanged()
		autocmd BufEnter * InitCount()
		autocmd InsertEnter * OnInsertEnter()
		autocmd InsertLeave * OnInsertLeave()
		autocmd BufWritePost * OnWrite()
		autocmd QuitPre * SendMetric('quit', 1)
		autocmd ColorScheme * OnColorScheme()
		autocmd VimEnter * theme_ready = true
		autocmd BufReadPost * OnReadFile()
		autocmd BufUnload * OnUnload()
	augroup END
enddef
