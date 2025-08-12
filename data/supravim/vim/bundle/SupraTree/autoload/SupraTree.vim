vim9script

import autoload 'SupraWater.vim' as SupraWater
var is_open = false

autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('t:SupraTree') | quit! | endif
autocmd BufEnter * if winnr('$') == 1 && exists('t:SupraTree') | call feedkeys(":quit!\<CR>:\<BS>") | endif

export def OpenTree()
	if exists('t:SupraTree')
		return
	endif
	var last_winid = win_getid()
	execute 'topleft vertical :26split supra_water'
	var wid = win_getid()
	t:SupraTree = SupraWater.Water(true)
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
	execute 'bdelete! ' .. t:SupraTree
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
