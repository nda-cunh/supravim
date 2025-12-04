vim9script

import autoload 'SupraUtils.vim' as Utils

def RoundIt(char: string, charend: string)
	const p1 = getpos("'<")
	const p2 = getpos("'>")
	call cursor(p1[1], p1[2])
	execute('normal! i' .. char)
	call cursor(p2[1], p2[2] + 1)
	execute('normal! a' .. charend)
enddef

export def AutoCloseActivate()
	# disable all first
	silent! iunmap "
	silent! sunmap "
	silent! iunmap '
	silent! sunmap '
	silent! iunmap `
	silent! sunmap `
	silent! iunmap (
	silent! sunmap (
	silent! iunmap [
	silent! sunmap [
	silent! iunmap {
	silent! sunmap {
	silent! iunmap <
	silent! sunmap <

	if g:sp_roundvisual_quotes
		vnoremap "		<esc><scriptcmd>RoundIt('"', '"')<CR>
		snoremap "		""<left>
		vnoremap '		<esc><scriptcmd>RoundIt("'", "'")<CR>
		snoremap '		''<left>
		vnoremap `		<esc><scriptcmd>RoundIt('`', '`')<CR>
		snoremap `		``<left>
	endif
	if g:sp_roundvisual_brackets
		vnoremap (		<esc><scriptcmd>RoundIt('(', ')')<CR>
		vnoremap [		<esc><scriptcmd>RoundIt('[', ']')<CR>
		snoremap (		()<left>
		snoremap [		[]<left>
	endif
	if g:sp_roundvisual_braces
		vnoremap {		<esc><scriptcmd>RoundIt('{', '}')<CR>
		snoremap {		{}<left>
	endif
	if g:sp_roundvisual_angle
		vnoremap <		<esc><scriptcmd>RoundIt('<', '>')<CR>
		snoremap <		<><left>
	endif
enddef

export def GotOutput(channel: channel, msg: string)
	# change_theme: [onehalf] <dark>
	if matchstr(msg, '^change_theme: ') != ''
		var theme = matchstr(msg, '\[\zs.*\ze\]')
		var typemode = matchstr(msg, '<\zs.*\ze>')
		call g:ChangeSupravimTheme(theme, typemode)
	# onChangeOption: [tree] <true>
	elseif matchstr(msg, '^onChangeOption: ') != ''
		var changed = matchstr(msg, '\[\zs.*\ze\]')
		var value = matchstr(msg, '<\zs.*\ze>')
		call g:ChangeSupravimOption(changed, value)
	endif
enddef

export def ChangeSupravimTheme(theme: string, typemode: string)
	exec 'colorscheme ' .. theme
	exec 'set background=' .. typemode
	AirlineRefresh
	if g:sp_nobackground == true
		hi Normal guibg=NONE ctermbg=NONE
		hi! link SignColumn Normal
		hi! link EndOfBuffer Normal
		hi! link CursorLine Normal 
	endif
enddef

export def ChangeSupravimOption(changed: string, value: string)
	var v = get(g:, 'sp_' .. changed)
	var type_of_value = type(v)
	var text: string

	g:supravim_option_changed = changed
	g:supravim_option_value = value
	
	if type_of_value == v:t_string
		text = 'g:sp_' .. g:supravim_option_changed .. ' = "' .. g:supravim_option_value .. '"'
	else
		text = 'g:sp_' .. g:supravim_option_changed .. ' = ' .. g:supravim_option_value
	endif

	try
		echom "SupraInfo: Changing option " .. g:supravim_option_changed .. " to " .. g:supravim_option_value 
		execute text
	catch
	endtry
	try
		doautocmd User SupravimChangeOption
	catch
		echom "SupraError: doautocmd SupravimChangeOption"
	endtry
enddef
	
export def SimpleSupravimChangeOption()
	if g:supravim_option_changed == 'tree'
		if g:supravim_option_value == 'false'
			SupraTreeClose
		else
			SupraTreeOpen
		endif
	elseif g:supravim_option_changed == 'swap'
		if g:supravim_option_value == 'false'
			set noswapfile
		else
			set swapfile
		endif
	elseif g:supravim_option_changed == 'fold'
		if g:supravim_option_value == 'false'
			set nofoldenable
		else
			set foldenable
		endif
	elseif g:supravim_option_changed == 'nobackground'
		if g:supravim_option_value == 'false'
			exec 'colorscheme ' .. g:sp_theme
			exec 'set background=' .. &background
			g:sp_nobackground = false
		else
			hi Normal guibg=NONE ctermbg=NONE
			hi! link SignColumn Normal
			hi! link EndOfBuffer Normal
			hi! link CursorLine Normal 
			g:sp_nobackground = true
		endif
		redraw!
		AirlineRefresh
	elseif g:supravim_option_changed == 'wrap'
		if g:supravim_option_value == 'false'
			set nowrap
		else
			set wrap
		endif
	elseif g:supravim_option_changed == 'autosave'
		if g:supravim_option_value == 'false'
			Utils.AutoSaveActivate(false)
		else
			Utils.AutoSaveActivate(true)
		endif
	endif
enddef

def ChangeColorStyleStatic(style: string, value: number)
	if value == 1
		exec 'hi! ' .. style .. ' gui=bold cterm=bold'
	elseif value == 2
		exec 'hi! ' .. style .. ' gui=italic cterm=italic'
	elseif value == 3
		exec 'hi! ' .. style .. ' gui=underline cterm=underline'
	else 
		exec 'hi! ' .. style .. ' gui=none cterm=none'
	endif
enddef

export def ChangeColorStyle()
	ChangeColorStyleStatic('Function', g:sp_theme_style_function)
	ChangeColorStyleStatic('Variable', g:sp_theme_style_variable)
	ChangeColorStyleStatic('Type', g:sp_theme_style_type)
	ChangeColorStyleStatic('Keyword', g:sp_theme_style_keyword)
	ChangeColorStyleStatic('Comment', g:sp_theme_style_comment)
enddef

