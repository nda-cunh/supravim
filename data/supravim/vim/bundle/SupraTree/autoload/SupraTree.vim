vim9script

import autoload 'SupraWater.vim' as SupraWater
var is_open = false

def SupraTreeExists(): bool
	var lst = tabpagebuflist()
	for buf in lst
		if getbufvar(buf, '&filetype') == 'suprawater'
			return true
		endif
	endfor
	return false
enddef

export def OpenTree()
	if exists('t:SupraTree')
		return
	endif
	var last_winid = win_getid()
	var nb_size: number = 30
	if exists('g:SupraTreeWinSize')
		nb_size = g:SupraTreeWinSize
	endif
	execute 'topleft vertical :' .. nb_size .. 'split .'
	var wid = win_getid()
	t:SupraTree = SupraWater.Water(true)
	normal gg
	win_gotoid(last_winid)
enddef

export def Close()
	is_open = false
	CloseTree()
enddef

export def Open()
	is_open = true 
	OpenTree()
enddef

export def CloseTree()
	if !exists('t:SupraTree')
		return
	endif
	SupraWater.ClosePopup(t:SupraTree)
	silent! noautocmd execute 'bdelete! ' .. t:SupraTree
	unlet t:SupraTree
enddef

export def Toggle()
	if is_open
		Close()
	else
		Open()
	endif
enddef

export def OnTabEnter()
	if is_open == true 
		OpenTree()
		SupraWater.Refresh()
	else
		CloseTree()
	endif
enddef
