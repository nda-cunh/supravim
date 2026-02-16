vim9script

import autoload 'SupraUtils.vim' as Utils

export def OpenWindow()
	job_start(["supravim-gui"], {
		out_cb: GotOutput,
	})
enddef

def GotOutput(channel: channel, msg: string)
	# change_theme: [onehalf] <dark>
	if matchstr(msg, '^onChangeOption: ') != ''
		var changed = matchstr(msg, '\[\zs.*\ze\]')
		var value = matchstr(msg, '<\zs.*\ze>')
		supraconfig#UpdateWithString(changed, value)
		echom 'Option ' .. changed .. ' changed to ' .. value
	endif
enddef

export def ChangeNoBackgroundOption(value: bool)
	if value == true
		g:sp_nobackground = true
	else
		g:sp_nobackground = false
	endif
enddef

export def ChangeSupravimTheme(theme: string, typemode: string)
	exec 'colorscheme ' .. theme
	exec 'set background=' .. typemode
	# AirlineRefresh
enddef

export def ChangeColorStyleStatic(style: string, value: string)
	exec 'hi! ' .. style .. ' gui=' .. value .. ' cterm=' .. value
enddef
