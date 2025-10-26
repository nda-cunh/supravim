vim9script

import autoload 'fuzzbox/selector.vim'
import autoload 'SupraNotification.vim' as Notify

def Select(wid: number, result: list<any>)
	var num = str2nr(result[0]) - 1

	var txt = g:SUPRA_CLIP[num]
	setreg('"', txt)
	UpdateClipboard
enddef

def Preview(wid: number, result: string)
	var num = str2nr(result[0]) - 1
    var content = g:SUPRA_CLIP[num]
	# split by new line and remove all \n
	var sp = content->split('\n\zs')->map('substitute(v:val, "\n", "", "g")')
    popup_settext(wid, sp)
enddef

def GetList(): list<string>
	var result: list<string> = []
	var i: number = 1
	var len = len(g:SUPRA_CLIP)

	while i < (len + 1)
		var res = g:SUPRA_CLIP[i - 1]
		var first_line: string 
		var sp = res->split('\n')
		var j = 0
		while j < len(sp)
			if !(sp[j] =~? '^\s\+$')
				first_line = sp[j]
				break
			endif
			j += 1
		endwhile
		first_line = first_line->substitute('^\s\+', '', 'g')
		if first_line == ''
			i += 1
			continue
		endif
		add(result, i .. '   ' .. first_line)
		i += 1
	endwhile
	return result
enddef

export def Start()
	var lst = GetList()
	if len(lst) == 0
		call Notify.Notification(["FuzzyClip", "No clipboard history found"], {type: 'info'})
		return
	endif

	selector.Start(lst, {
		select_cb: Select,
		preview_cb: Preview,
		height: 0.5,
		width: 0.7,
		actions: {
			"\<c-t>": null_function,
			"\<c-v>": null_function,
			"\<c-s>": null_function,
			"\<c-q>": null_function,
		},
		prompt_title: 'FuzzyClip',
	})
enddef

def IsSpace(str: string): bool
	for c in str
		const n = char2nr(c)
		if ((n >= 9 && n <= 13) || n == 32)
			continue
		else
			return false
		endif
	endfor
	return true
enddef

export def UpdateYankRegisters()
	# if has_key(v:event, 'operator') != 0 && v:event.operator != 'y'
		# return
	# endif
	var value = getreg('0')
	if IsSpace(value)
		return
	endif
	if len(g:SUPRA_CLIP) == 0
		g:SUPRA_CLIP = [getreg('"')]
	else
		var last = g:SUPRA_CLIP[-1]
		if getreg('"') != last
			# if already in the list, remove it first
			var idx = index(g:SUPRA_CLIP, getreg('"'))
			if idx != -1
				call remove(g:SUPRA_CLIP, idx)
			endif
			# keep only 20 items
			if len(g:SUPRA_CLIP) >= 20
				call remove(g:SUPRA_CLIP, -1)
			endif
			insert(g:SUPRA_CLIP, getreg('"'), 0)
		endif
	endif
enddef

var s_time = 0
export def LoadRegisterFromExtern(copy_os: list<string>)
	if empty(copy_os)
		const cpy = getreg('+')
		setreg('"', cpy)
		UpdateYankRegisters()
		return
	endif

	var t = localtime()
	if (((s_time + 1) < t) == false)
		return
	endif
	job_start(copy_os, {
		out_io: 'buffer',
		out_msg: 0,
		out_mode: 'raw',
		timeout: 100,
		close_cb: (ch: channel) => {
			s_time = localtime()
			const buffer = ch->ch_getbufnr('out')
			const all = getbufline(buffer, 0, '$')
			const last = getreg('"')
			const result = join(all, "\n")
			if result == last
				return
			endif
			UpdateYankRegisters()
			setreg('"', result)
		},
	})
enddef

export def SetClipBoardExtern(copy_os: list<string>)
	if empty(copy_os)
		setreg('+', getreg('"'))
		return
	endif

	if has_key(v:event, 'operator') != 0 && v:event.operator == 'c'
		setreg('"', getreg('"'))
		return
	endif
	var job: job
	job = job_start(copy_os, {
		out_io: 'buffer',
		in_mode: 'raw',
		timeout: 100,
		out_msg: 0,
		close_cb: (ch: channel) => {
			var info = job_info(job)
			if info.exitval != 0
				call Notify.Notification(["Copy failed", "Please check if `" .. copy_os[0] .. "` is installed"], {type: 'error'})
			endif
		},
	})
	vim9cmd call ch_sendraw(job, getreg('"'))
	vim9cmd call ch_close_in(job)
enddef
