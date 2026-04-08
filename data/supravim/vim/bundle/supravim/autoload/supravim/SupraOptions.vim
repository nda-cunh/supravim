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

var normal_bg: string = ''
var endofbuffer_bg: string = ''
var nontext_bg: string = ''

export def ChangeNoBackgroundOption(value: bool)
	if value == true
		silent! hi Normal guibg=NONE ctermbg=NONE
		silent! hi NonText guibg=NONE ctermbg=NONE
		silent! hi EndOfBuffer guibg=NONE ctermbg=NONE
	else
		exec 'silent! hi! Normal guibg=' .. normal_bg
		exec 'silent! hi! NonText guibg=' .. nontext_bg
		exec 'silent! hi! EndOfBuffer guibg=' .. endofbuffer_bg
	endif
	silent! doautocmd ColorScheme
enddef

export def ChangeSupravimTheme(theme: string, typemode: string)
	exec 'colorscheme ' .. theme
	exec 'set background=' .. typemode
	normal_bg = synIDattr(synIDtrans(hlID('Normal')), 'bg#')
	endofbuffer_bg = synIDattr(synIDtrans(hlID('EndOfBuffer')), 'bg#')
	nontext_bg = synIDattr(synIDtrans(hlID('NonText')), 'bg#')
enddef

export def ChangeColorStyleStatic(style: string, value: string)
	exec 'hi! ' .. style .. ' gui=' .. value .. ' cterm=' .. value
enddef
