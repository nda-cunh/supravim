vim9script

# Exit Vim if NERDTree is the only window remaining in the only tab.
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | call feedkeys(":quit\<CR>:\<BS>") | endif
autocmd BufEnter * if winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | call feedkeys(":quit\<CR>:\<BS>") | endif

var is_open = false

export def OpenTreeTabs()
	var id = win_getid()
	is_open = true
	if g:NERDTree.IsOpen() == 0
		silent! NERDTree
	else
		NERDTreeMirror
	endif
	call win_gotoid(id)
enddef

export def CloseTreeTabs()
	is_open = false 
	NERDTreeClose
enddef

export def ToggleTreeTabs()
	if is_open == true
		call CloseTreeTabs()
	else
		call OpenTreeTabs()
	endif
enddef

export def OnTabEnter()
	if &filetype == 'nerdtree'
		wincmd p
	endif

	if is_open == true
		var new_page = tabpagenr()
		var all_buffer = tabpagebuflist(new_page)
		if len(all_buffer) == 1 
			call OpenTreeTabs()
		endif
	else
		call CloseTreeTabs()
	endif
enddef

def NERDTreeHighlightFile(extension: string, fg: string)
	exec 'autocmd filetype nerdtree highlight ' .. extension .. ' ctermbg=none' .. ' ctermfg=' .. fg
	exec 'autocmd filetype nerdtree syn match ' .. extension .. ' #^\s\+.*' .. extension .. '$#'
enddef

export def NerdTreeRefreshColor()
	NERDTreeHighlightFile('.c', 'blue')
	NERDTreeHighlightFile('h', 'green')
	NERDTreeHighlightFile('.cpp', 'blue')
	NERDTreeHighlightFile('.hpp', 'green')
	NERDTreeHighlightFile('vala', 'magenta')
	NERDTreeHighlightFile('vapi', 'darkmagenta')
	NERDTreeHighlightFile('py', 'yellow')
	NERDTreeHighlightFile('java', 'red')
	NERDTreeHighlightFile('sh', 'green')
	NERDTreeHighlightFile('go', 'cyan')
	NERDTreeHighlightFile('Makefile', 'red')
	NERDTreeHighlightFile('.rs', 'red')

	var id = win_getid()
	if g:sp_tree == true
		echom 'NERDTreeTabs: Refreshing NERDTree...' .. expand('%:p')
		if expand('%:p') != ''
			silent! NERDTreeClose
			silent! NERDTree
		endif
	endif
	silent! call win_gotoid(id)
enddef

export def NerdTreeRefreshRoot()
	if (is_open == true)
		silent! NERDTreeRefreshRoot
		silent! NERDTreeRefreshRoot
	endif
enddef
