vim9script

import autoload 'fuzzbox/utils/selector.vim'
import autoload 'SupraNotification.vim' as Notify

def Select(wid: number, result: list<any>)
	var res = result[0]
	if empty(res)
		return
	endif
	var txt = getreg(res[0])
	setreg('@', txt)
	setreg('0', txt)
	UpdateClipboard
enddef

def Preview(wid: number, result: string)
    var content = getreg(result[0]) 
	var sp = content->split('\n')
    popup_settext(wid, sp)
enddef

def GetList(): list<string>
	var result: list<string> = []
	var i: number = 1

	while i < 10
		var res: string = getreg(string(i))
		if empty(res)
			i += 1
			continue
		endif
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

export def UpdateYankRegisters()
		if has_key(v:event, 'operator') != 0 && v:event.operator != 'y'
		return
	endif
	setreg('9', getreg('8'))
	setreg('8', getreg('7'))
	setreg('7', getreg('6'))
	setreg('6', getreg('5'))
	setreg('5', getreg('4'))
	setreg('4', getreg('3'))
	setreg('3', getreg('2'))
	setreg('2', getreg('1'))
	setreg('1', getreg('0'))
enddef

var s_time = 0
export def LoadRegisterFromExtern(copy_os: list<string>)
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
			const last = getreg('@')
			const result = join(all, "\n")
			if result == last
				return
			endif
			UpdateYankRegisters()
			setreg('@', result)
			setreg('0', result)
		},
	})
enddef

export def SetClipBoardExtern(copy_os: list<string>)
	if has_key(v:event, 'operator') != 0 && v:event.operator == 'c'
		setreg('@', getreg('0'))
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
	vim9cmd call ch_sendraw(job, getreg('@'))
	vim9cmd call ch_close_in(job)
enddef
