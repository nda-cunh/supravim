vim9script

import autoload 'SupraPopup.vim' as Popup

export def MoveLineDown(mode: string)
	var array = getline(line("'<"), line("'>"))
	const len = len(array)
	const begin = line('.')

	if mode == 'n'
		const tmp = getline(line('.') + 1)
		setline(line('.') + 1, getline(line('.')))
		setline(line('.'), tmp)
		normal j==
		return
	elseif line("'<") != begin
		return
	endif

	const tmp = getline(begin + len)
	var i = 0
	reverse(array)

	for str in array
		setline(begin + len - i, str)
		i = i + 1
	endfor
	setline(begin, tmp)
	setpos("'<", [0, begin + 1, 0, 0])
	setpos("'>", [0, begin + len, 0, 0])
	normal! gv=gv
enddef

export def MoveLineUp(mode: string)
	var array = getline(line("'<"), line("'>"))
	var len = len(array)
	var begin = line('.')

	if begin == 1
		return
	elseif mode == 'n'
		const tmp = getline(line('.') - 1)
		setline(line('.') - 1, getline(line('.')))
		setline(line('.'), tmp)
		normal k==
		return
	endif

	if line("'<") != begin
		return
	endif

	const tmp = getline(line('.') - 1)
	var i = begin
	for str in array
		setline(i - 1, str)
	 	i = i + 1
	endfor
	setline(i - 1, tmp)

	setpos("'<", [0, begin - 1, 0, 0])
	setpos("'>", [0, begin + len - 2, 0, 0])
	normal! gv=gv
enddef

export def AutoLspHold()
	var c_pos = getcurpos()
	var m_pos = getmousepos()
	var cm = m_pos.column
	var lm = m_pos.line
	var cc = c_pos[2]
	var lc = c_pos[1]
	if cm == cc && lm == lc
		var word = expand('<cword>')
		if word != ''
			silent! LspHover
		endif
	endif
enddef

export def AutoSaveActivate(activate: bool)
	if activate == true 
		augroup AutoSave
			autocmd!
			autocmd BufLeave,FocusLost,VimLeavePre * {
				if &modifiable == true && &buflisted == true &&  filereadable(expand('%'))
					silent! write
				endif
			}
		augroup END
	else
		autocmd! AutoSave
	endif
enddef



export def RenameSymbol()
	const line_pt = line('.')
	const col_pt = col('.')
	var all_servers = lsp#get_allowed_servers()
	var can_rename_lsp = false
	for server in all_servers
		var value = lsp#capabilities#has_rename_provider(server)
		if value == 1
			can_rename_lsp = true
			break
		endif
	endfor

	var popup = Popup.Input({width: 16, prompt: '➜ ', title_pos: 'left', title: '󰑕 Rename', line: "cursor-3", col: "cursor+1", moved: 'WORD'})
	var cword = expand('<cword>')
	popup->Popup.SetInput(cword)

	if can_rename_lsp == false
		popup->Popup.AddEventInputEnter((line: string) => {
			Popup.Close(popup)
			silent! execute ':%s/' .. cword .. '/' .. line .. '/g'
			w!
		})
		return
	else
		popup->Popup.AddEventInputEnter((line: string) => {
			Popup.Close(popup)
			feedkeys("\<esc>:LspRename\<cr>", "n")
			timer_start(100, (_) => {
				var i = strcharlen(expand('<cword>'))
				for j in range(0, i - 1)
					feedkeys("\<bs>", "n")
				endfor
				feedkeys(line .. "\<cr>", "n")
				timer_start(500, (_) => {
					wall!
				})
			})
		})
	endif
enddef
