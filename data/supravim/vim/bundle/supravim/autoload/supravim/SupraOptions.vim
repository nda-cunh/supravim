vim9script

import autoload 'SupraUtils.vim' as Utils

export def OpenWindow()
	job_start(["supravim-gui", "--from-supravim"], {
		out_cb: GotOutput,
	})
enddef

def GotOutput(channel: channel, msg: string)
	# change_theme: [onehalf] <dark>
	if matchstr(msg, '^onChangeOption: ') != ''
		var changed = matchstr(msg, '\[\zs.*\ze\]')
		var value = matchstr(msg, '<\zs.*\ze>')
		supraconfig#UpdateWithString(changed, value)
		echom printf(gettext("Option %s changed to %s", "supravim"), changed, value)
	# onEasterEgg: [snake] -> sent by the Magic Mode popup of the GUI
	elseif matchstr(msg, '^onEasterEgg: ') != ''
		PlayEasterEgg(matchstr(msg, '\[\zs.*\ze\]'))
	endif
enddef

const EASTER_EGGS = {
	snake:    'Snake',
	pacman:   'Pacman',
	rain:     'Crumble make_it_rain',
	scramble: 'Crumble scramble',
}

export def PlayEasterEgg(effect: string)
	if EASTER_EGGS->has_key(effect)
		exec EASTER_EGGS[effect]
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
	if typemode == 'light' || typemode == 'dark'
		exec 'set background=' .. typemode
	endif
	normal_bg = synIDattr(synIDtrans(hlID('Normal')), 'bg#')
	endofbuffer_bg = synIDattr(synIDtrans(hlID('EndOfBuffer')), 'bg#')
	nontext_bg = synIDattr(synIDtrans(hlID('NonText')), 'bg#')
enddef

const STYLE_ATTRS = ['bold', 'italic', 'underline', 'undercurl',
	'strikethrough', 'reverse', 'inverse', 'standout']

export def ChangeColorStyleStatic(style: string, value: string)
	var styles: dict<bool> = {}
	for attr in split(value, ',')
		if STYLE_ATTRS->index(attr) >= 0
			styles[attr] = true
		endif
	endfor

	var attrs = get(hlget(style, true), 0, {})
	if attrs->has_key('cleared')
		attrs->remove('cleared')
	endif
	attrs->extend({name: style, force: true,
		gui: styles, cterm: styles, term: styles})
	hlset([attrs])
enddef
