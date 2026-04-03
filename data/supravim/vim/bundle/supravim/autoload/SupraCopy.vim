vim9script

import autoload './SupraNotification.vim' as Notify

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
			execute "bd! " .. buffer
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
			const buffer = ch->ch_getbufnr('out')
			if info.exitval != 0
				call Notify.Notification(["Copy failed", "Please check if `" .. copy_os[0] .. "` is installed"], {type: 'error'})
			endif
			execute "bd! " .. buffer
		},
	})
	vim9cmd call ch_sendraw(job, getreg('"'))
	vim9cmd call ch_close_in(job)
enddef

