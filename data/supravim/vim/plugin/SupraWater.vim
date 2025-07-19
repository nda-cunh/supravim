vim9script

map - <scriptcmd>:call g:Water()<CR>

var local: dict<any> = {}

def g:Water()
	var rd = rand() % 1000
	var id = bufadd('suprawater_vim' .. rd)
	const last_buffer = bufnr()
	const actual_path = expand('%:p:h')

	mkview
	var file_name = expand("%:t")
	execute "b! " .. id 

	local.id = {
		first_path: actual_path, 
		first_filename: file_name,
		actual_path: actual_path, 
		cursor_pos: {},
		last_buffer: last_buffer,
	}

	set filetype=suprawater
	setbufvar(id, '&buflisted', 0)
    setbufvar(id, '&modeline', 0)
    setbufvar(id, '&buftype', 'nofile')
    setbufvar(id, '&swapfile', 0)
    setbufvar(id, '&undolevels', -1)
    setbufvar(id, '&modifiable', 1)
    setbufvar(id, '&nu', 0)
	setbufvar(id, "&updatetime", 2500)
    setbufvar(id, '&signcolumn', 'yes')

	execute("nnoremap <buffer><c-q>			<scriptcmd>Quit()<cr>")
	execute("nnoremap <buffer>-				<scriptcmd>call Back(" .. id .. ")<cr>")
	execute("nnoremap <buffer><bs>			<scriptcmd>call Back(" .. id .. ")<cr>")
	execute("nnoremap <buffer><cr>			<scriptcmd>call EnterFolder(" .. id .. ")<cr>")
	execute("nnoremap <buffer><c-h>			<scriptcmd>call EnterFolder(" .. id .. ", 'horizontal')<cr>")
	execute("nnoremap <buffer><c-v>			<scriptcmd>call EnterFolder(" .. id .. ", 'vertical')<cr>")
	execute("nnoremap <buffer><c-t>			<scriptcmd>call EnterFolder(" .. id .. ", 'tab')<cr>")
	execute("nnoremap <buffer><c-n>			<scriptcmd>call EnterFolder(" .. id .. ", 'tab')<cr>")
	execute("nnoremap <buffer><2-LeftMouse>	<LeftMouse><scriptcmd>call EnterFolder(" .. id .. ")<cr>")
	execute("nnoremap <buffer><c-p>			<scriptcmd>call Preview(" .. id .. ")<cr>")
	execute("nnoremap <buffer>~				<scriptcmd>call EnterWithPath(" .. id .. ", $HOME .. '/')<cr>")
	execute("nnoremap <buffer>_				<scriptcmd>call EnterWithPathAndJump(" .. id .. ")<cr>")
	

	augroup SupraWater
		autocmd!
		execute ("autocmd ModeChanged,CursorMovedI,CursorMoved,WinScrolled <buffer> call Actualize(" .. id .. ")")
		execute ("autocmd BufLeave <buffer> local[" .. id .. "] = {}")
		# execute ("autocmd CursorHold <buffer> call Preview(" .. id .. ")")
		autocmd CursorMoved,CursorMovedI <buffer> call CancelMoveOneLine()
		autocmd QuitPre <buffer> call Quit()
	augroup END

	EnterWithPathAndJump(id)
	
    setbufvar(id, '&undolevels', 100)
enddef

def EnterWithPathAndJump(id: number)
	var jump = local.id.first_path 
	# if the end is not a slash, add it
	if jump[-1] != '/'
		jump = jump .. '/'
	endif
	call EnterWithPath(id, jump)

	if jump != ''
		var lines = getbufline(id, 0, '$')
		for i in range(len(lines))
			if stridx(lines[i], local.id.first_filename) == 0 
				call cursor(i + 1, 0)
				break
			endif
		endfor
	endif
enddef

import autoload 'SupraPopup.vim' as Popup

def Preview(id: number)
	var line = getline('.')
	if line =~# '^\s*$'
		return
	endif
	var file_path = local.id.actual_path .. line
	if isdirectory(file_path)
		echo 'This is a directory, not a file: ' .. file_path
		return
	endif
	# echom 'Preview file: ' .. file_path
	var buf_to_preview = bufadd(file_path)
	bufload(buf_to_preview)
	var popup = Popup.Simple({
		close_key: ["q", "\<UP>", "\<DOWN>", "\<Left>", "\<Right>", "\<esc>", "\<c-p>"],
		scrollbar: 1,
	})
	var lines = getbufline(buf_to_preview, 1, '$')
	Popup.SetText(popup, lines)
	Popup.SetSize(popup, 80, 20)
	popup_setoptions(popup.wid, {
		maxwidth: 80,
		maxheight: 20,
	})

	setwinvar(popup.wid, '&number', 1)
	setwinvar(popup.wid, '&signcolumn', 'no')
	setwinvar(popup.wid, '&numberwidth', 1)
	setwinvar(popup.wid, '&wrap', 0)
	setbufvar(winbufnr(popup.wid), '&filetype', 'java')
	win_execute(popup.wid, 'filetype detect')
	setwinvar(popup.wid, '&filetype', '')
    win_execute(popup.wid, 'silent! doautocmd filetypedetect BufNewFile ' .. file_path)
    win_execute(popup.wid, 'silent! setlocal nospell nolist')
enddef

def Actualize(id: number)
	const actual_path = local.id.actual_path
	prop_clear(line('w0'), line('w$'))
	prop_add(1, 0, {text: 'Press ("?" or "h") for Help !   ', type: 'suprawatersort', text_align: 'right'})
	prop_add(1, 0, {text: actual_path, type: 'suprawaterpath', text_align: 'above'})
	prop_add(1, 0, {text: 'Sort by name ▲   |   Show .hidden', type: 'suprawatersort', text_align: 'above'})
	var result = getbufline(id, 1, '$')
	var p_begin = line('w0') - 1
	var p_end = len(result) - 1
	if p_end >= line('w$') 
		p_end = line('w$')
	endif

	for i in range(p_begin, p_end)
		if result[i] == ''
			continue
		endif
		var sym: string
		var ext: string
		if isdirectory(actual_path .. result[i])
			sym = ''
			ext = 'FOLDER'
		else
			sym = g:WebDevIconsGetFileTypeSymbol(result[i], 0)
			ext = fnamemodify(result[i], ':e')
			if ext == ''
				ext = result[i]
			endif
		endif
		if has_key(all_colors, ext)
			var color = all_colors[ext]
			silent! call prop_add(i + 1, 1, {text: sym .. '  ', type: color})
		else
			silent! call prop_add(i + 1, 1, {text: sym .. '  ', type: 'suprawater'})
		endif
	endfor
enddef


####################################
# Draw the 'ls' command 
####################################
def DrawPath(id: number, path: string)
	local.id.actual_path = path
	var lines = system('ls -a ' .. path .. ' 2> /dev/null')

	# clear the buffer
	execute ':%d'
	var result = [' ']
	var sp = split(lines, '\n')
	for i in range(len(sp))
		if (sp[i] == '.' || sp[i] == '..' || sp[i] == '')
			continue
		endif
		if isdirectory(path .. '/' .. sp[i]) == 0
			add(result, sp[i])
		else
			add(result, sp[i] .. '/')
		endif
	endfor
	setbufline(bufnr(), 1, result)
	normal j
	Actualize(id)
enddef

###################
#  Back function
###################
def Back(id: number)
	if local.id.actual_path == '/'
		return
	endif
	var actual_path = local.id.actual_path
	var jump = actual_path
	# echom 'Saving cursor position of: ' .. actual_path
	local.id.cursor_pos[actual_path] = getcurpos()
	local.id.actual_path = LeftPath(actual_path)
	actual_path = local.id.actual_path

	# echom 'Back to: ' .. actual_path
	if actual_path == '/'
		call DrawPath(id, actual_path)
	else
		call DrawPath(id, actual_path .. '/')
	endif
	actual_path = local.id.actual_path
	if jump != ''
		var folder_name = jump[len(actual_path) : ] 
		var lines = getbufline(id, 0, '$')
		for i in range(len(lines))
			if stridx(lines[i], folder_name) == 0 
				call cursor(i + 1, 0)
				normal! zz
				break
			endif
		endfor
	endif
enddef

def LeftPath(str: string): string
	var path = str 
	if len(path) > 1
		path = fnamemodify(path[0 : -2], ':h')
	endif
	return path
enddef


###################
#  Enter function
###################
def EnterFolder(id: number, mode: string = '')
	var line = getline('.')
	# check if line is only space
	if line =~# '^\s*$'
		return
	endif

	const path = local.id.actual_path .. line
	EnterWithPath(id, path, mode)
	if has_key(local.id.cursor_pos, path)
		call setpos('.', local.id.cursor_pos[path])
		normal! zz
	endif
enddef

def EnterWithPath(id: number, path: string, mode: string = '')
	if isdirectory(path)
		DrawPath(id, path)
	else
		if mode == 'horizontal'
			execute 'split ' .. path
		elseif mode == 'vertical'
			execute 'vsplit ' .. path
		elseif mode == 'tab'
			execute 'tabnew ' .. path
		else
			execute 'edit ' .. path
		endif
		silent! loadview
	endif
enddef

def Quit()
	:b!#
enddef

def CancelMoveOneLine()
	if (line('.') == 1)
		normal! j
		return
	endif
enddef

#####################################
# Highlighting and properties
#####################################

highlight SupraWaterPath cterm=bold guifg=#f1c058
highlight SupraWaterSort guifg=#00CAFF
# highlight link SupraWaterFolder vimmark

call prop_type_add("suprawaterpath", {highlight: "SupraWaterPath"})
call prop_type_add("suprawatersort", {highlight: "SupraWaterSort"})
# call prop_type_add("suprawaterfolder", {highlight: "SupraWaterFolder"})
call prop_type_add("suprawater", {})

var all_colors: dict<any> = {}

def InitColor(name: string, color: string, lst: list<string>)
	const name_prop = 'suprawaterFile' .. name
	execute 'highlight ' .. name_prop .. ' ' .. color
	call prop_type_add(name_prop, {highlight: name_prop})
	for i in lst 
		all_colors[i] = name_prop
	endfor
enddef

InitColor('Folder', 'guifg=#f1c058', ['FOLDER'])
InitColor('Vim', 'ctermfg=green guifg=#06923E', ['vim', 'vimrc', '.vimrc'])
InitColor('HPP', 'ctermfg=green guifg=#5CB338', ['hpp', 'h'])
InitColor('C', 'ctermfg=blue guifg=#344CB7', ['c', 'cpp'])
InitColor('Lua', 'ctermfg=blue guifg=#00CAFF', ['lua', 'meson.build'])
InitColor('Vala', 'ctermfg=magenta guifg=#7239b3', ['vala', 'cs'])
InitColor('JavaScript', 'ctermfg=blue guifg=#F1C058', ['js', 'javascript', 'ts'])
InitColor('HTML', 'ctermfg=blue guifg=#F1C058', ['html', 'css'])
InitColor('Markdown', 'ctermfg=blue guifg=#F1C058', ['md', 'markdown'])
InitColor('JSonxml', 'ctermfg=blue guifg=#F1C058', ['json', 'xml', 'toml', 'blp', 'vsupp'])
InitColor('Shell', 'ctermfg=223 guifg=#FDEBD0', ['sh', 'bash', 'zsh'])
InitColor('Java', 'ctermfg=130 guifg=#E84393', ['java'])
InitColor('Go', 'ctermfg=108 guifg=#00B4D8', ['go', 'jpg', 'jpeg', 'png', 'gif', 'webp'])
InitColor('Rust', 'ctermfg=130 guifg=#DE3163', ['rs', 'rust'])
InitColor('Ruby', 'ctermfg=161 guifg=#CC0000', ['rb', 'ruby'])
InitColor('PHP', 'ctermfg=135 guifg=#A569BD', ['php'])
InitColor('Swift', 'ctermfg=211 guifg=#FF9F1C', ['swift'])
InitColor('Kotlin', 'ctermfg=131 guifg=#6C3483', ['kt', 'kotlin'])
InitColor('Python', 'ctermfg=166 guifg=#F39C12', ['py', 'python'])
InitColor('SQL', 'ctermfg=cyan guifg=#00FFFF', ['sql'])
InitColor('Perl', 'ctermfg=magenta guifg=#FF00FF', ['pl', 'perl'])
InitColor('Scala', 'ctermfg=red guifg=#DC322F', ['scala', 'sc'])
InitColor('Dart', 'ctermfg=cyan guifg=#00B4AB', ['dart'])
InitColor('YAML', 'ctermfg=yellow guifg=#FFD700', ['yaml', 'yml'])
InitColor('Dockerfile', 'ctermfg=blue guifg=#1D8IDA', ['dockerfile'])
InitColor('GraphQL', 'ctermfg=magenta guifg=#E10098', ['graphql', 'gql'])
InitColor('Makefile', 'ctermfg=red guifg=#E24044', ['Makefile', 'mk', '.gitignore', 'git'])
