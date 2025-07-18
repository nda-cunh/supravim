vim9script

highlight SupraWaterPath cterm=bold guifg=#f1c058
highlight SupraWaterSort guifg=#00CAFF
highlight link SupraWaterFolder vimmark

call prop_type_add("suprawaterpath", {highlight: "SupraWaterPath"})
call prop_type_add("suprawatersort", {highlight: "SupraWaterSort"})
call prop_type_add("suprawaterfolder", {highlight: "SupraWaterFolder"})
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

InitColor('Vim', 'ctermfg=green guifg=#06923E', ['vim'])
InitColor('HPP', 'ctermfg=green guifg=#5CB338', ['hpp', 'h'])
InitColor('C', 'ctermfg=blue guifg=#344CB7', ['c', 'cpp'])
InitColor('Lua', 'ctermfg=blue guifg=#00CAFF', ['lua'])
InitColor('Vala', 'ctermfg=magenta guifg=#7239b3', ['vala'])
InitColor('JavaScript', 'ctermfg=blue guifg=#F1C058', ['js', 'javascript'])
InitColor('HTML', 'ctermfg=blue guifg=#F1C058', ['html'])
InitColor('CSS', 'ctermfg=blue guifg=#F1C058', ['css'])
InitColor('Markdown', 'ctermfg=blue guifg=#F1C058', ['md', 'markdown'])
InitColor('JSON', 'ctermfg=blue guifg=#F1C058', ['json'])
InitColor('XML', 'ctermfg=blue guifg=#F1C058', ['xml'])
InitColor('Shell', 'ctermfg=223 guifg=#FDEBD0', ['sh', 'bash', 'zsh'])
InitColor('Java', 'ctermfg=130 guifg=#E84393', ['java'])
InitColor('Go', 'ctermfg=108 guifg=#00B4D8', ['go'])
InitColor('Rust', 'ctermfg=130 guifg=#DE3163', ['rs', 'rust'])
InitColor('Ruby', 'ctermfg=161 guifg=#CC0000', ['rb', 'ruby'])
InitColor('PHP', 'ctermfg=135 guifg=#A569BD', ['php'])
InitColor('Swift', 'ctermfg=211 guifg=#FF9F1C', ['swift'])
InitColor('Kotlin', 'ctermfg=131 guifg=#6C3483', ['kt', 'kotlin'])
InitColor('Python', 'ctermfg=166 guifg=#F39C12', ['py', 'python'])

map - <scriptcmd>:call g:Water()<CR>

var last_buffer = bufnr()
var actual_path: string 
var cursor_pos: dict<any>
var suprabuf: number

def Actualize()
	prop_clear(1, line('$'))
	prop_add(1, 0, {text: actual_path .. ' (S) sort  ', type: 'suprawaterpath', text_align: 'above'})
	prop_add(1, 0, {text: 'Sort by name ▲   |   Show .hidden', type: 'suprawatersort', text_align: 'above'})
	var result = getbufline(suprabuf, 1, '$')
	for i in range(1, len(result) - 1)
		if result[i] == ''
			continue
		endif
		if isdirectory(actual_path .. '/' .. result[i])
			call prop_add(i + 1, 1, {text: g:WebDevIconsGetFileTypeSymbol(result[i], 1) .. '  ', type: 'suprawaterfolder'})
		else
			var sym = g:WebDevIconsGetFileTypeSymbol(result[i], 0)
			var ext = fnamemodify(result[i], ':e')
			if has_key(all_colors, ext)
				var color = all_colors[ext]
				call prop_add(i + 1, 1, {text: sym .. '  ', type: color})
			else
				call prop_add(i + 1, 1, {text: sym .. '  ', type: 'suprawater'})
			endif
		endif
	endfor
enddef


####################################
# Draw the 'ls' command 
####################################
def DrawPath(path: string)
	actual_path = path
	var lines = system('ls -a ' .. path .. ' 2> /dev/null')

	# clear the buffer
	execute ':%d'
	var result = [' ']
	var sp = split(lines, '\n')
	for i in range(len(sp))
		if (sp[i] == '.' || sp[i] == '..' || sp[i] == '')
			continue
		endif
		if isdirectory(actual_path .. '/' .. sp[i]) == 0
			add(result, sp[i])
		else
			add(result, sp[i] .. '/')
		endif
	endfor
	setbufline(bufnr(), 1, result)
	normal j
	Actualize()
enddef

###################
#  Back function
###################
def Back()
	if actual_path == '/'
		return
	endif
	var jump = actual_path
	# echom 'Saving cursor position of: ' .. actual_path
	cursor_pos[actual_path] = getcurpos()
	actual_path = LeftPath()
	echom 'Back to: ' .. actual_path
	if actual_path == '/'
		call DrawPath(actual_path)
	else
		call DrawPath(actual_path .. '/')
	endif
	if jump != ''
		var folder_name = jump[len(actual_path) : ] 
		var lines = getbufline(suprabuf, 0, '$')
		for i in range(len(lines))
			if stridx(lines[i], folder_name) == 0 
				call cursor(i + 1, 0)
				break
			endif
		endfor
	endif
enddef

def LeftPath(): string
	var path = actual_path
	if len(path) > 1
		path = fnamemodify(path[0 : -2], ':h')
	endif
	return path
enddef


###################
#  Enter function
###################
def EnterFolder()
	var line = getline('.')
	if line == ''
		return
	endif

	var path = actual_path .. line
	EnterWithPath(path)
	# echom 'Restore maybe of :' .. path
	if has_key(cursor_pos, path)
		echom 'Restore cursor position of: ' .. path
		call setpos('.', cursor_pos[path])
	endif
enddef

def EnterWithPath(path: string)
	if isdirectory(path)
		DrawPath(path)
	else
		execute 'e ' .. path 
		silent! loadview
	endif
enddef

# path = curpos()

def Quit()
	:b!#
	set eventignore=ExitPre
enddef

def g:Water()
	mkview
	actual_path = expand('%:p:h')
	suprabuf = bufadd('suprawater_vim')
	var folder_name = expand("%:t")
	# echom 'suprabuf: ' .. suprabuf
	execute "b! " .. suprabuf 
	set filetype=suprawater
	setbufvar(suprabuf, '&buflisted', 0)
    setbufvar(suprabuf, '&modeline', 0)
    setbufvar(suprabuf, '&buftype', 'nofile')
    setbufvar(suprabuf, '&swapfile', 0)
    setbufvar(suprabuf, '&undolevels', -1)
    setbufvar(suprabuf, '&modifiable', 1)
    setbufvar(suprabuf, '&nu', 0)
    setbufvar(suprabuf, '&signcolumn', 'yes')

	# mapclear <buffer>
	nnoremap <buffer><c-q>			<scriptcmd>Quit()<cr>
	nnoremap <buffer>-				<scriptcmd>call Back()<cr>
	nnoremap <buffer><bs>			<scriptcmd>call Back()<cr>
	nnoremap <buffer><cr>			<scriptcmd>call EnterFolder()<cr>
	nnoremap <buffer><2-LeftMouse>	<LeftMouse><scriptcmd>call EnterFolder()<cr>

	augroup SupraWater
		autocmd!
		autocmd ModeChanged <buffer> call Actualize()
		autocmd QuitPre <buffer> call Quit()
	augroup END

	var jump = actual_path
	call EnterWithPath(actual_path .. '/')
	if jump != ''
		var lines = getbufline(suprabuf, 0, '$')
		for i in range(len(lines))
			if stridx(lines[i], folder_name) == 0 
				call cursor(i + 1, 0)
				break
			endif
		endfor
	endif
enddef
