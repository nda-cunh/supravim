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
