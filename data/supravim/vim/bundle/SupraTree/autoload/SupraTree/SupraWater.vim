vim9script

import autoload 'SupraPopup.vim' as Popup
import autoload './SupraTree.vim' as SupraTree
import autoload './Utils.vim' as Utils
import autoload './Preview.vim' as Preview
import autoload './Colors.vim' as Colors

export var local: dict<any> = {}

# Function to create a new SupraWater buffer
export def Water(tree_mode: bool = false, force_id: number = -1): number
	const rd = rand() % 1000
	const id = bufadd('/tmp/suprawater' .. rd .. '.water')
	const last_buffer = bufnr()
	var actual_path = expand('%:p:h')

	silent! mkview
	var file_name = expand("%:t")
	execute "b! " .. id
	set wincolor=NormalDark

	if has_key(local, id) == 1
		return id
	endif

	var dict = {
		first_path: actual_path,
		first_filename: file_name,
		actual_path: actual_path,
		cursor_pos: {},
		last_buffer: last_buffer,
		edit: {},
		clipboard: [],
		clipboard_mode: 'yank',
		popup_clipboard: {},
		tree_mode: tree_mode,
	}

	var winid: number = winnr()
	var win_width = winwidth(winid)
	var win_height = winheight(winid)
	var [row, col_start] = win_screenpos(winid)

	var popup_width = 20
	var popup_height = 5

	var col: number
	if dict.tree_mode == true
		col = &columns
	else
		col = col_start + win_width - 2
	endif
	var line: number
	if dict.tree_mode == true
		line = row + 1
	else
		line = row + 3
	endif

	dict.popup_clipboard = Popup.Simple({
		close_key: [],
		col: col,
		line: line, 
		pos: 'topright',
		width: popup_width,
		height: popup_height,
		scrollbar: 1,
		title: '📋 Clipboard',
		hidden: 1,
		mapping: true,
	})
	local[id] = dict

	set filetype=suprawater
	setlocal fillchars+=eob:\ 
	setbufvar(id, '&buflisted', 0)
    setbufvar(id, '&modeline', 0)
    setbufvar(id, '&swapfile', 0)
    setbufvar(id, '&undolevels', -1)
    setbufvar(id, '&modifiable', 1)
    setbufvar(id, '&nu', 0)
    setbufvar(id, '&relativenumber', 0)
	setbufvar(id, "&updatetime", 2500)
    setbufvar(id, '&signcolumn', 'yes')
    setbufvar(id, '&wrap', 0)


	if dict.tree_mode == true
		b:is_supra_tree = true
		setbufvar(id, '&ea', 0)
		setbufvar(id, '&relativenumber', 0)
		setbufvar(id, '&winfixwidth', 1)
		setbufvar(id, '&cursorline', 0)
		setbufvar(id, '&winminwidth', 10)
	endif

	nnoremap <buffer><c-s>			<esc><scriptcmd>WaterSaveBuffer()<cr>
	inoremap <buffer><c-s>			<esc><scriptcmd>WaterSaveBuffer()<cr>
	nnoremap <buffer>-				<scriptcmd>call Back()<cr>
	nnoremap <buffer><bs>			<scriptcmd>call Back()<cr>
	nnoremap <buffer><cr>			<scriptcmd>call EnterFolder()<cr>
	nnoremap <buffer><c-t>			<scriptcmd>call EnterFolder('tab')<cr>
	nnoremap <buffer><c-n>			<scriptcmd>call EnterFolder('tab')<cr>
	noremap <buffer><RightMouse>	<Nop>
	noremap <buffer><2-RightMouse>	<Nop>
	noremap <buffer><2-LeftMouse>	<LeftMouse><scriptcmd>call EnterFolder()<cr>
	noremap <buffer><3-LeftMouse>	<Nop>
	noremap <buffer><4-LeftMouse>	<Nop>
	nnoremap <buffer><c-p>			<scriptcmd>call Preview.Preview()<cr>
	nnoremap <buffer>~				<scriptcmd>call EnterWithPath($HOME .. '/')<cr>
	nnoremap <buffer>_				<scriptcmd>call EnterWithPathAndJump()<cr>
	nnoremap <buffer>h				<scriptcmd>call Preview.HelpPreview()<cr>
	nnoremap <buffer>?				<scriptcmd>call Preview.HelpPreview()<cr>
	nnoremap <buffer><c-n>			<esc>:tabnew<space>
	nnoremap <buffer><tab>			<Nop>
	nnoremap <buffer><leader>s		<scriptcmd>call EnterFolder('horizontal')<cr>
	nnoremap <buffer><leader>v		<scriptcmd>call EnterFolder('vertical')<cr>
	nnoremap <buffer><leader>d		<Nop>
	nnoremap <buffer><leader>f		<Nop>
	nnoremap <buffer><leader>g		<Nop>
	nnoremap <buffer><leader>h		<Nop>
	nnoremap <buffer><tab>			<Nop>
	nnoremap <buffer><a-up>			<Nop>
	nnoremap <buffer><a-down>		<Nop>
	nnoremap <buffer><c-_>			<Nop>
	nnoremap <buffer>dw				<scriptcmd>noautocmd normal! dw<cr>
	nnoremap <buffer>db				<scriptcmd>noautocmd normal! db<cr>
	nnoremap <buffer>yw				<scriptcmd>noautocmd normal! yw<cr>
	nnoremap <buffer>yb				<scriptcmd>noautocmd normal! yb<cr>
	nnoremap <buffer>p				<scriptcmd>call Paste()<cr>
	if tree_mode == false
		nnoremap <buffer><c-q>			<esc><scriptcmd>ForceQuit()<cr>
		inoremap <buffer><c-q>			<esc><scriptcmd>ForceQuit()<cr>
		command! -buffer Q call ForceQuit()
	else
		nnoremap <buffer><c-q>	<esc><scriptcmd>SupraTree.Close()<cr>
		inoremap <buffer><c-q>	<esc><scriptcmd>SupraTree.Close()<cr>
		command! -buffer Q call SupraTree.Close()
		autocmd BufEnter <buffer> call ClosingTreeIfNeeded()
	endif
	cnoreabbrev <buffer> q Q

	autocmd ModeChanged,CursorMovedI,CursorMoved,WinScrolled <buffer> call Actualize()
	autocmd CursorMoved,CursorMovedI <buffer> call Utils.CancelMoveOneLine()
	autocmd BufWritePost <buffer> call WaterSaveBuffer()
	autocmd TextChangedI,TextChanged <buffer> call Changed()
	autocmd TextYankPost <buffer> if v:event.operator ==# 'd' && v:event.regname ==# '' | call Cut() | endif
	autocmd TextYankPost <buffer> if v:event.operator ==# 'y' && v:event.regname ==# '' | call Yank() | endif
	# I Don't know why but IMAP BS dont work if is not in an autocmd
	autocmd BufEnter <buffer> {
		if &filetype == 'suprawater'
			inoremap <buffer><Cr>			<scriptcmd>call SupraOverLoadCr()<cr>
			inoremap <buffer><del>			<scriptcmd>call SupraOverLoadDel()<cr>
			nnoremap <buffer><del>			<esc>i<del>
			inoremap <buffer><bs>			<scriptcmd>call SupraOverLoadBs()<cr>
		endif
		# When we need to go to Normal mode
		feedkeys("\<esc>", 'n')
	}

	EnterWithPathAndJump()
	return id
enddef

def ClosingTreeIfNeeded()
	var lst_tab = tabpagebuflist()
	var enrtab = tabpagenr('$')
	if len(lst_tab) == 1
		Utils.DestroyBuffer(bufnr('%'))
		if enrtab == 1
			silent! quit!
		endif
	endif
enddef

export def ClosePopup(id: number)
	var dict = local[id]
	if has_key(dict, 'popup_clipboard') == 0
		return
	endif
	Popup.Close(dict.popup_clipboard)
enddef

def RefreshTree(id: number)
	if has_key(local, id) == 0
		return
	endif
	var dict = local[id]

	# Do not Refresh if modification is in progress
	var modified_files = GetModifiedFile(id)
	if len(modified_files.rename) > 0 || len(modified_files.new_file) > 0 || len(modified_files.deleted) > 0 || len(modified_files.all_copy) > 0
		return
	endif
	# If the buffer is not SupraWater, we don't need to refresh the tree
	if dict.tree_mode == false
		return
	endif

	# If the buffer is SupraWater, we need to refresh the tree
	if dict.actual_path != ''
		DrawPath(dict.actual_path, id)
	else
		DrawPath($PWD .. '/', id)
	endif
enddef

export def Refresh()
	var lst_buf = tabpagebuflist()
	for i in lst_buf
		if getbufvar(i, '&filetype') == 'suprawater' 
			RefreshTree(i)
		endif
	endfor
enddef

####################################
# Draw the 'ls' command and load it in local.edit
####################################
def DrawPath(path: string, force_id: number = -1)
	var id = bufnr('%')
	if force_id != -1
		id = force_id
	endif
	var dict = local[id]
	const r1 = getreg('1')
	const r2 = getreg('2')
	const r3 = getreg('3')
	const r4 = getreg('4')
	const r5 = getreg('5')
	const r6 = getreg('6')
	const r7 = getreg('7')
	const r8 = getreg('8')
	const r9 = getreg('9')

	dict.edit = {}
	var sp: list<string> = []
	try
		sp = readdir(path)  # ensure the path exists
		sp = sort(sp)
	catch
		const cur_pos = getcurpos()
		DrawPath(dict.actual_path)
		setpos('.', cur_pos)
		return
	endtry
	dict.actual_path = path

	# Regex to ignore files and folders
	var ignore_lst = []
	if dict.tree_mode && exists('g:SupraTreeIgnoreTree') == 1
		ignore_lst = g:SupraTreeIgnoreTree
	endif

	# Set to 2 because the first line is the path and the second line is just empty
	var nb = 3
	var result = [' ', '../']
	dict.edit[2] = {
		name: '../', # the name of the file or folder
		is_deleted: false, # if the file is deleted
		new_file: false, # if the file is a new file
		copy_of: '', # link to the original file if it is a copy
	}
	for i in sp
		if (i == '')
			continue
		endif
		# Ignore the files in the ignore list
		var is_continue = false
		for j in ignore_lst
			if i =~# j
				is_continue = true
				break
			endif
		endfor
		if is_continue == true
			continue
		endif
		var name: string
		if isdirectory(path .. '/' .. i) == 0
			name = i
		else
			name = i .. '/'
		endif
		add(result, name)
		var tmp = {
			name: name, # the name of the file or folder
			is_deleted: false, # if the file is deleted
			new_file: false, # if the file is a new file
			copy_of: '', # link to the original file if it is a copy
		}
		dict.edit[nb] = tmp
		nb = nb + 1
	endfor
	setbufvar(id, '&modifiable', 1)  # set the buffer as not modified
	noautocmd setbufline(id, 1, result)
	noautocmd call deletebufline(id, nb, '$')  # delete all lines in the buffer
	Actualize(id)
	if len(dict.edit) == 0
		feedkeys("o\<esc>", 'n')
	endif
	# Restore the registers
	setreg('1', r1)
	setreg('2', r2)
	setreg('3', r3)
	setreg('4', r4)
	setreg('5', r5)
	setreg('6', r6)
	setreg('7', r7)
	setreg('8', r8)
	setreg('9', r9)
enddef


###############################################
#  Back function (When you press <bs> or -)
###############################################
def Back()
	const id = bufnr('%')
	var dict = local[id]

	# Do not quit if the buffer is modified
	const modified_files = GetModifiedFile(id)
	if len(modified_files.rename) > 0 || len(modified_files.new_file) > 0
		OpenPopupCancelFile(modified_files)
		return
	endif

	if dict.actual_path == '/'
		return
	endif

	var actual_path: string = dict.actual_path
	var jump: string = actual_path

	dict.cursor_pos[actual_path] = getcurpos()
	dict.actual_path = Utils.LeftPath(actual_path)
	actual_path = dict.actual_path

	# If the path is root (/), we don't need to add a slash
	if actual_path == '/'
		call DrawPath(actual_path)
	else
		call DrawPath(actual_path .. '/')
	endif

	actual_path = dict.actual_path
	if jump != ''
		const folder_name: string = jump[len(actual_path) : ]
		const lines = getbufline(id, 0, '$')
		for i in range(len(lines))
			if stridx(lines[i], folder_name) == 0
				call cursor(i + 1, 0)
				normal! zz
				break
			endif
		endfor
	endif
enddef


#######################################################
#  Enter function (When you press <cr> or <LeftMouse>)
#######################################################
def EnterFolder(mode: string = '')
	const id = bufnr('%')
	var dict = local[id]

	var line = getline('.')
	# check if line is only space
	if line =~# '^\s*$'
		return
	endif
	if line == '../'
		# If the line is ../, we go back to the parent directory
		call Back()
		return
	endif

	const path: string = dict.actual_path .. line
	EnterWithPath(path, mode)
	if has_key(dict.cursor_pos, path)
		call setpos('.', dict.cursor_pos[path])
		normal! zz
	endif
enddef

#################################################
# Open a file or folder with the given path
# By default use :edit to open a file
# If the path is a directory, Move to it
#################################################
def EnterWithPath(path: string, mode: string = '')
	const id = bufnr('%')
	var dict = local[id]

	const modified_files = GetModifiedFile(id)
	if len(modified_files.rename) > 0 || len(modified_files.new_file) > 0
		OpenPopupCancelFile(modified_files)
		return
	endif

	if isdirectory(path)
		if mode == 'tab'
			execute 'tabnew! ' .. path
		else
			DrawPath(path)
		endif
	elseif Utils.IsBinary(path)
		system('xdg-open ' .. shellescape(path))
		if v:shell_error != 0
			var last_chdir = $PWD
			chdir(fnamemodify(path, ':h'))
			$EXECPATH = path
			feedkeys("\<esc>:!" .. path .. ' ' ..  $ARGS .. "\<cr>", 'n')
			chdir(last_chdir)
			redraw!
		endif
	else

		if mode == 'horizontal'
			wincmd p
			execute 'split! ' .. path
			set wincolor=Normal
		elseif mode == 'vertical'
			wincmd p
			execute 'vsplit! ' .. path
			set wincolor=Normal
		elseif mode == 'tab'
			execute 'tabnew! ' .. path
			set wincolor=Normal
		else
			if dict.tree_mode == true
				wincmd p
			endif
			execute 'edit! ' .. path
			set wincolor=Normal
		endif
		silent! loadview
	endif
enddef

#################################################
# call EnterWithPath and jump to the firstpath `_`
#################################################
def EnterWithPathAndJump()
	const id = bufnr('%')
	const dict = local[id]

	var jump: string = dict.first_path
	# if the end is not a slash, add it
	if jump[-1] != '/'
		jump = jump .. '/'
	endif
	call EnterWithPath(jump)

	if jump != ''
		var lines = getbufline(id, 0, '$')
		for i in range(len(lines))
			if stridx(lines[i], dict.first_filename) == 0
				call cursor(i + 1, 0)
				break
			endif
		endfor
	endif
enddef


#################################################
# When the buffer is save
#################################################
def WaterSaveBuffer()
	const id = bufnr('%')
	if CheckAndAddSigns() == true
		return
	endif

	const modified_files = GetModifiedFile(id)
	# If is empty we don't need to open the popup
	if len(modified_files.rename) == 0 &&
			len(modified_files.new_file) == 0 &&
			len(modified_files.deleted) == 0 &&
			len(modified_files.all_copy) == 0
		return
	endif
	OpenPopupModifiedfile(modified_files)
enddef

##################################################
# Quit the buffer (used by <c-q> or :q)
# If the buffer is modified
# it will open a popup to confirm
##################################################
def Quit(force_id: number = -1): bool
	var id = bufnr('%')
	if force_id != -1
		id = force_id
	endif
	const last_id = local[id].last_buffer
	var dict = local[id]
	const name = bufname(last_id)

	# Do not quit if the buffer is modified
	const modified_files = GetModifiedFile(id)
	if len(modified_files.rename) > 0 || len(modified_files.new_file) > 0
		OpenPopupCancelFile(modified_files)
		return false
	endif

	Popup.Close(local[id].popup_clipboard)
	if dict.tree_mode == true
		return true
	endif
	if !isdirectory(name)
		:b!#
	endif
	if bufexists(last_id) == 0
		return false
	endif
	return true
enddef

def ForceQuit()
	const id = bufnr('%')
	if has_key(local, id) == 0
		return
	endif
	var dict = local[id]
	if Quit() == false
		return
	endif
	Utils.DestroyBuffer(id)
	if isdirectory(bufname(dict.last_buffer)) == 1
		silent! quit!
	endif
enddef

def CheckAndAddSigns(): bool
	const id = bufnr('%')
	var dict = local[id]

	var lines = getbufline(id, 2, '$')
	var all_lines: list<string> = []


	Actualize()
	var error = false
	var i = 2
	exe "sign unplace 2 buffer=" .. id
	for _line in lines
		var line = substitute(_line, '/\+$', '', 'g')
		if index(all_lines, line) != -1
			exe "sign place 2 line=" .. i .. " name=SupraWaterSign"
			var txt = 'Duplicate'
			prop_add(i, 0, {text: txt, type: 'suprawatersigns', text_align: 'after', text_padding_left: 3})
			error = true
		endif

		if dict.edit[i].new_file == true
			if (_line =~? '^\s*$')
				exe "sign place 2 line=" .. i .. " name=SupraWaterSign"
				var txt = 'New file with only spaces.'
				prop_add(i, 0, {text: txt, type: 'suprawatersigns', text_align: 'after', text_padding_left: 3})
				error = true
			endif
		elseif dict.edit[i].copy_of == ''
			if dict.edit[i].name[-1] == '/' && _line[-1] != '/'
				exe "sign place 2 line=" .. i .. " name=SupraWaterSign"
				var txt = 'You cannot rename a folder to a file.'
				prop_add(i, 0, {text: txt, type: 'suprawatersigns', text_align: 'after', text_padding_left: 3})
				error = true
			endif

			if dict.edit[i].name[-1] != '/' && _line[-1] == '/'
				exe "sign place 2 line=" .. i .. " name=SupraWaterSign"
				var txt = 'You cannot rename a file to a folder'
				prop_add(i, 0, {text: txt, type: 'suprawatersigns', text_align: 'after', text_padding_left: 3})
				error = true
			endif
		else
			if dict.edit[i].copy_of[-1] == '/' && _line[-1] != '/'
				exe "sign place 2 line=" .. i .. " name=SupraWaterSign"
				var txt = 'You cannot copy a folder to a file'
				prop_add(i, 0, {text: txt, type: 'suprawatersigns', text_align: 'after', text_padding_left: 3})
				error = true
			endif

			if dict.edit[i].copy_of[-1] != '/' && _line[-1] == '/'
				exe "sign place 2 line=" .. i .. " name=SupraWaterSign"
				var txt = 'You cannot copy a file to a folder.'
				prop_add(i, 0, {text: txt, type: 'suprawatersigns', text_align: 'after', text_padding_left: 3})
				error = true
			endif
		endif



		i = i + 1
		if dict.edit[i - 1].is_deleted == false
			add(all_lines, line)
		endif
	endfor
	return error
enddef


def PopupYes(modified_file: dict<any>)
	const id = bufnr('%')
	var dict = local[id]
	const actual_path = dict.actual_path

	var commands = []
	var copy_history = []
	var delete_history = []

	for i in modified_file.all_copy
		var copy_of = i
		if copy_of[-1] == '/'
			var sp = split(copy_of, ' -> ')
			var full_path = substitute(sp[0], '/\+$', '', 'g')
			sp[1] = substitute(sp[1], '/\+$', '', 'g')
			var tmp_copy_file = g:SupraMakeTempDir()
			add(commands, 'g:SupraCopyDir(' .. shellescape(full_path) .. ', "' .. tmp_copy_file .. '")')
			var cmd = '"mv ' .. shellescape(tmp_copy_file) .. ' ' .. shellescape(actual_path .. sp[1]) .. '"'
			add(copy_history, "system(" .. cmd .. ")")
			if fnamemodify(sp[0], ':h') .. '/' != actual_path
				if dict.clipboard_mode == 'cut'
					add(delete_history, "delete(" .. shellescape(sp[0]) .. ", 'rf')")
				endif
			endif
		else
			var sp = split(copy_of, ' -> ')
			var tmp_copy_file = tempname()
			add(commands, 'g:SupraCopyFile(' .. shellescape(sp[0]) .. ', "' .. tmp_copy_file .. '")')
			add(copy_history, 'rename("' .. tmp_copy_file .. '", ' .. shellescape(actual_path .. fnamemodify(sp[1], ':t')) .. ')')
			if fnamemodify(sp[0], ':h') .. '/' != actual_path
				if dict.clipboard_mode == 'cut'
					add(delete_history, "delete(" .. shellescape(sp[0]) .. ")")
				endif
			endif
		endif
	endfor

	for i in modified_file.deleted
		var new_name = i
		if new_name[-1] == '/'
			new_name = fnamemodify(new_name, ':h:t')
			add(commands, 'delete(' .. shellescape(actual_path .. new_name) .. ', "rf")')
		else
			add(commands, 'delete(' .. shellescape(actual_path .. new_name) .. ')')
		endif
	endfor

	for i in modified_file.new_file
		var new_name = i
		if new_name[-1] == '/'
			add(commands, 'mkdir(' .. shellescape(actual_path .. new_name) .. ')')
		else
			add(commands, 'writefile([], ' .. shellescape(actual_path .. new_name) .. ')')
		endif
	endfor

	for i in modified_file.rename
		var [old_name, new_name] = split(i, ' -> ')
		if old_name[-1] == '/'
			old_name = fnamemodify(old_name, ':h:t')
			new_name = fnamemodify(new_name, ':h:t')
			add(commands, 'rename(' .. shellescape(actual_path .. old_name) .. ', ' .. shellescape(actual_path .. new_name) .. ')')
		else
			add(commands, 'rename(' .. shellescape(actual_path .. old_name) .. ', ' .. shellescape(actual_path .. new_name) .. ')')
		endif
	endfor

	extend(commands, copy_history)
	extend(commands, delete_history)

	for c in commands
		execute(c)
	endfor

	dict.clipboard = []
	Popup.Hide(dict.popup_clipboard)
	Actualize()
enddef

def OpenPopupCancelFile(modified_file: dict<any>)
	const id = bufnr('%')
	var dict = local[id]
	const width = float2nr(&columns * 0.4)

	var popup = Popup.Simple({
		close_key: ["\<esc>", "\<cr>", "\<c-q>"],
		scrollbar: 1,
		minwidth: width,
		width: width,
	})
	Popup.AddEventFilterNoFocus(popup, (_, _, key) => {
		var ascii_val = char2nr(key)
		if key ==? 'y' || key ==? 'c' || key ==? "\<c-q>"
			var pos = getpos('.')
			dict.clipboard = []
			DrawPath(dict.actual_path)
			Actualize()
			Popup.Close(popup)
			setpos('.', pos)
		elseif len(key) == 1 && ascii_val >= 32 && ascii_val <= 126
			Popup.Close(popup)
		endif
		return Popup.BLOCK
	})
	const nb_minus: number = (width / 2)
	const nb_space = repeat(' ', (nb_minus))
	var lines: list<string> = [nb_space .. 'do you really want to Cancel ?' .. nb_space]
	extend(lines, Utils.GetStrPopup(modified_file))
	add(lines, nb_space .. ' [(Y)es] [Any key for continue] ' .. nb_space)
	Popup.SetText(popup, lines)
	Popup.SetSize(popup, width, len(lines))
	var bufnr = winbufnr(popup.wid)
	setbufvar(bufnr, '&filetype', 'suprawater_popup')
enddef

def OpenPopupModifiedfile(modified_file: dict<any>)
	const width = float2nr(&columns * 0.6)
	const id = bufnr('%')
	var dict = local[id]
	var popup = Popup.Simple({
		close_key: ["q", "n", "\<esc>"],
		scrollbar: 1,
		minwidth: width,
		width: width,
		title: 'Modified Files',
	})
	Popup.AddEventFilterNoFocus(popup, (_, _, keys) => {
		if keys ==? 'y'
			Popup.Close(popup)
			var current = getline('.')
			call PopupYes(modified_file)
			DrawPath(dict.actual_path)
			Actualize()
			search(current, 'c')
		endif
		if keys ==? 'c'
			dict.clipboard = []
			var pos = getpos('.')
			DrawPath(dict.actual_path)
			Actualize()
			setpos('.', pos)
			Popup.Close(popup)
		endif
		return Popup.BLOCK
	})
	const nb_minus: number = (width / 2)
	const nb_space = repeat(' ', (nb_minus))
	var lines = []
	extend(lines, Utils.GetStrPopup(modified_file))
	add(lines, nb_space .. ' [(Y)es] [(N)o] [(C)ancel] ' .. nb_space)
	Popup.SetText(popup, lines)
	Popup.SetSize(popup, width, len(lines))
	var bufnr = winbufnr(popup.wid)
	setbufvar(bufnr, '&filetype', 'suprawater_popup')
enddef

def GetModifiedFile(id: number): dict<any>
	var dict = local[id]

	var all_deleted: list<string> = []
	var all_new_file: list<string> = []
	var all_rename: list<string> = []
	var all_copy: list<string> = []
	var bufs = getbufline(id, 1, '$')

	for i in keys(dict.edit)
		if dict.edit[i].is_deleted == true
			add(all_deleted, dict.edit[i].name)
		elseif dict.edit[i].copy_of != ''
			const nb = str2nr(i)
			const nm = getbufline(id, nb)[0]
			const copy_of = dict.edit[i].copy_of
			add(all_copy, copy_of .. ' -> ' .. nm)
		elseif dict.edit[i].new_file == false
			const nb = str2nr(i)
			const nm = getbufline(id, nb)[0]
			if nm != dict.edit[i].name && nm != ''
				add(all_rename, dict.edit[i].name .. " -> " .. nm)
			endif
		elseif dict.edit[i].new_file == true
			const nb = str2nr(i)
			const nm = getbufline(id, nb)[0]
			if nm =~# '^\s*$'
				continue
			endif
			add(all_new_file, nm)
		endif
	endfor

	var result: dict<any> = {
		rename: all_rename,
		deleted: all_deleted,
		new_file: all_new_file,
		all_copy: all_copy
	}

	return result
enddef


##################################################
# Overload the <cr> key to fix bug when pressing <cr> at the begin of the line
##################################################
def SupraOverLoadCr()
	const col = col('.')
	const line = line('.')
	const end = strlen(getline('.'))
	if line == 2
		return
	endif
	if col == 1
		silent! normal O
	elseif col == end + 1
		silent! normal o
	endif
	Actualize()
enddef

def SupraOverLoadDel()
	if &filetype != 'suprawater'
		feedkeys("\<del>", 'n')
		return 
	endif		
	const col = col('.')
	const line = line('.')
	const end = strlen(getline('.'))
	var dict = local[bufnr('%')]
	if col == 1 && end == 1
		setline(line, dict.edit[line].name)
		dict.edit[line].is_deleted = true
		return
	elseif col == end + 1 || end == 0
	else
		feedkeys("\<del>", 'n')
	endif
enddef

def SupraOverLoadBs()
	if &filetype != 'suprawater'
		feedkeys("\<bs>", 'n')
		return 
	endif		
	const col = col('.')
	const line = line('.')
	const end = strlen(getline('.'))
	var dict = local[bufnr('%')]
	if end == 1
		setline(line, dict.edit[line].name)
		dict.edit[line].is_deleted = true
	elseif end == 0 || col == 1
		return
	else
		feedkeys("\<bs>", 'n')
	endif
enddef

def GetBeginEndYank(): list<number>
	var ln = line('.')
	var count: number
	if v:count > 0
		count = v:count1
	else
		count = 1
	endif
	if (count + ln) > line('$')
		count = line('$') - ln + 1
	endif

	var begin = getpos("'<")
	var end = getpos("'>")
	setpos("'<", [0, 0, 0, 0])
	setpos("'>", [0, 0, 0, 0])
	if begin[1] != 0 && end[1] != 0
		ln = begin[1]
		count = end[1] - begin[1] + 1
	endif

	if visualmode() == "\<c-v>" && (begin[2] != 1 || end[2] != 2147483647)
		return [-1, -1]
	endif
	return [ln, count]
enddef


def Paste()
	const id = bufnr('%')
	var dict = local[id]

	var pos = getpos('.')
	if len(dict.clipboard) == 0
		return
	endif
	var nb_len = len(dict.clipboard)

	for i in range(len(dict.edit) + 1, pos[1] + 1, -1)
		dict.edit[i + nb_len] = dict.edit[i]
	endfor

	# Add Edit[New_id] with the clipboard content
	for i in range(0, nb_len - 1)
		var new_id = pos[1] + i
		var name = dict.clipboard[i]

		dict.edit[new_id + 1] = {
			name: fnamemodify(name, ':t'),
			new_name: '',
			is_deleted: false,
			new_file: true,
			copy_of: name
		}
	endfor

	noautocmd var lines = getbufline(id, 1, '$')
	var new_lines: list<string> = []
	var i: number = 1
	var len_lines = len(lines)
	while i <= len_lines
		add(new_lines, lines[i - 1])
		if i == pos[1]
			var lst = copy(dict.clipboard)
			for y in range(0, len(lst) - 1)
				if lst[y][-1] == '/'
					lst[y] = fnamemodify(lst[y], ':h:t') .. '/'
				else
					lst[y] = fnamemodify(lst[y], ':t')
				endif
			endfor
			extend(new_lines, lst)
		endif
		i = i + 1
	endwhile
	noautocmd setbufline(id, 1, new_lines)

enddef

def Yank()
	const id = bufnr('%')
	var dict = local[id]
	const pos = getpos('.')
	Popup.SetTitle(dict.popup_clipboard, '📋 Clipboard (Yank)')

	var [ln, count] = GetBeginEndYank()
	if ln == -1 || count == -1
		return
	endif
	dict.clipboard = []
	dict.clipboard_mode = 'yank'
	for i in range(ln, ln + count - 1)
		# Special case for ../
		if dict.edit[i].name == '../'
			continue
		endif
		var complete_path = dict.actual_path .. dict.edit[i].name
		if complete_path == dict.actual_path
			continue
		endif
		add(dict.clipboard, complete_path)
	endfor
	Actualize_popupclipboard(dict)
enddef

def Cut()
	const id = bufnr('%')
	var dict = local[id]
	const pos = getpos('.')
	Popup.SetTitle(dict.popup_clipboard, '📋 Clipboard (Delete)')

	var [ln, count] = GetBeginEndYank()
	if ln == -1 || count == -1
		return
	endif

	dict.clipboard = []
	dict.clipboard_mode = 'cut'
	var remove_line: list<number> = []
	for i in range(ln, ln + count - 1)
		# Special case for ../
		if dict.edit[i].name == '../'
			continue
		endif
		var complete_path = dict.actual_path .. dict.edit[i].name
		if dict.edit[i].is_deleted == false
			if dict.edit[i].copy_of != '' || dict.edit[i].name == ''
				remove_line = add(remove_line, i)
				continue
			endif
			dict.edit[i].is_deleted = true
			if complete_path == dict.actual_path
				continue
			endif
			add(dict.clipboard, complete_path)
		else
			dict.edit[i].is_deleted = false
			var index = index(dict.clipboard, complete_path)
		endif
	endfor

	remove_line = reverse(remove_line)
	#delete the lines and move all lines after it
	var old_buffer = getbufline(id, 1, '$')
	var new_buffer: list<string> = []

	for i in range(len(old_buffer))
		if index(remove_line, i + 1) != -1
			add(new_buffer, '')
			continue
		endif
		var line_content = old_buffer[i]
		add(new_buffer, line_content)
	endfor

	Actualize_popupclipboard(dict)

	timer_start(10, (_) => {
		set eventignore=
		noautocmd setbufline(id, 1, new_buffer)
		setpos('.', pos)
		Changed()
	})
enddef

##########################################################
# Actualize the popup clipboard
# This function is called when the user copy or cut files
##########################################################
def Actualize_popupclipboard(dict: dict<any>)
	# Close the popup if the clipboard is empty
	if len(dict.clipboard) == 0
		Popup.Hide(dict.popup_clipboard)
		return
	endif
	# Print all clipboard content in the popup
	var new_text = []
	# change the home path to ~
	for i in dict.clipboard
		var text = substitute(i, '^' .. $HOME .. '/', '~/', 'g')
		text = Utils.GetIcon(text) .. '  ' .. text
		add(new_text, text)
	endfor
	Popup.SetText(dict.popup_clipboard, new_text)
	Popup.SetSize(dict.popup_clipboard, -1, len(dict.clipboard))
	Popup.Show(dict.popup_clipboard)
enddef


#######################################################################
# When the buffer is changed by the user
# This function is called by the autocmd TextChangedI and TextChanged
#######################################################################
def Changed()
	const id = bufnr('%')
	var dict = local[id]
	const nb_lines = line('$') - 1

	# ../ is a special case
	noautocmd setline(2, '../')
	dict.edit[2] = {
		name: '../', # the name of the file or folder
		is_deleted: false, # if the file is deleted
		new_file: false, # if the file is a new file
		copy_of: '', # link to the original file if it is a copy
	}


	if nb_lines == 0
		noautocmd setline(1, '   ')
		noautocmd setline(2, ' ')
		dict.edit[2] = {
			name: '',
			is_deleted: false,
			new_file: true,
			copy_of: '',
		}
		timer_start(10, (_) => {
			normal k
		})
	endif


	# NEW FILE (When a new line is added)
	if len(dict.edit) < nb_lines
		var current = line('.')
		var new_file = {
			name: '',
			is_deleted: false,
			new_file: true,
			copy_of: '',
		}
		for i in range(nb_lines, current, -1)
			dict.edit[i + 1] = dict.edit[i]
		endfor
		dict.edit[current] = new_file
		return
	endif

	const cursor = getpos('.')

	var p_begin = line('w0') - 1
	var p_end = len(dict.edit) - 1
	if p_end >= line('w$')
		p_end = line('w$')
	endif

	# If the line is deleted, force the firstname of the file
	for i in range(p_begin, p_end + 1)
		if i == 0
			continue
		endif
		if dict.edit[i + 1].is_deleted == true
			if getline(i + 1) != dict.edit[i + 1].name
				noautocmd setline(i + 1, dict.edit[i + 1].name)
			endif
		endif
	endfor

	for i in range(line('$'), 1, -1)
		if getline(i) == ''
			noautocmd execute ':' .. i .. 'd'
			for j in range(i, len(dict.edit))
				if has_key(dict.edit, j)
					dict.edit[j] = dict.edit[j + 1]
				endif
			endfor
			unlet dict.edit[len(dict.edit) + 1]
			continue
		endif
	endfor

	setpos('.', cursor)
	if line('.') == 1
		normal! j
	endif
	Actualize()
enddef

###############################################
# Draw the icon and the path in the buffer
###############################################
def Actualize(force_id: number = -1)
	var id = bufnr('%')
	if force_id != -1
		id = force_id
	endif
	var dict = local[id]
	const actual_path = dict.actual_path
	var winid = win_findbuf(id)[0]

	var sort_text = 'Sort by name ▲  | hidden files: 🗸 ' # or 🗶 ✕
	const help_text = 'Press ("?" or "h") for Help !'
	sort_text ..= repeat(' ', (winwidth(winid) - len(sort_text) - len(help_text))) ..  help_text
	prop_clear(1, line('$', winid))
	if dict.tree_mode == true 
		var get_width_window = winwidth(winid)
		const txt_title = '󰥨 SupraTree'
		const center_len = (get_width_window - len(txt_title)) / 2
		prop_add(1, 0, {bufnr: id, text: txt_title, type: 'suprawaterpath', text_align: 'above', text_padding_left: center_len})
	endif
	var draw_path = substitute(actual_path, '^' .. $HOME, '~', 'g')
	var lines = []
	var width_line = winwidth(winid) - 2
	{
		var i = 0
		while true
			if draw_path == ''
				break
			endif
			lines[i] = draw_path[0 : width_line]
			draw_path = draw_path[width_line : ]
			i = i + 1
		endwhile
	}
	for line in lines
		prop_add(1, 0, {bufnr: id, text: line, type: 'suprawaterpath', text_align: 'above'})
	endfor
	if dict.tree_mode == false 
		prop_add(1, 0, {bufnr: id, text: sort_text, type: 'suprawatersort', text_align: 'above'})
	endif
	const result = getbufline(id, 1, '$')
	const p_begin = line('w0', winid) - 1
	var p_end = len(result) - 1
	if p_end >= line('w$', winid)
		p_end = line('w$', winid)
	endif

	for i in range(p_begin, p_end)
		if result[i] == '' || i == 0
			continue
		endif
		var sym: string
		var ext: string
		var complete_path = actual_path .. result[i]

		if has_key(dict.edit, i + 1) != 0 && dict.edit[i + 1].is_deleted == true
			ext = 'DELETED'
			sym = ''
		elseif complete_path[-1] == '/'
			sym = Utils.GetIcon(complete_path, 1)
			ext = 'FOLDER'
		else
			sym = Utils.GetIcon(complete_path)
			ext = fnamemodify(result[i], ':e')
			if ext == ''
				ext = result[i]
			endif
		endif
		if has_key(Colors.colors, ext)
			const color = Colors.colors[ext]
			silent! call prop_add(i + 1, 1, {bufnr: id, text: sym .. '  ', type: color})
		else
			silent! call prop_add(i + 1, 1, {bufnr: id, text: sym .. '  ', type: 'suprawater'})
		endif
	endfor
enddef
