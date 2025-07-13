vim9script

import autoload 'SupraPopup.vim' as Popup

var timer_animation: number = 0

export def SupraWelcome()
	highlight on cterm=bold ctermfg=green ctermbg=NONE
	highlight off cterm=bold ctermfg=red ctermbg=NONE
	highlight supravim_mode term=reverse cterm=bold ctermbg=NONE
	highlight str_comment ctermfg=yellow ctermbg=NONE
	highlight str_txt ctermfg=cyan ctermbg=NONE

	highlight supravim_1 ctermfg=red ctermbg=NONE
	highlight supravim_2 ctermfg=yellow ctermbg=NONE
	highlight supravim_3 ctermfg=green ctermbg=NONE
	highlight supravim_4 ctermfg=blue ctermbg=NONE
	highlight supravim_5 ctermfg=magenta ctermbg=NONE

	noremap <buffer><c-@>	<Nop>
	nnoremap <buffer>q	<cmd>q!<CR>
	nnoremap <buffer><Down> <scriptcmd>search('•')<CR>
	nnoremap <buffer><Up> <scriptcmd>search('•', 'b')<CR>
	nnoremap <buffer><RightMouse> <Nop> 
	nnoremap <buffer><2-RightMouse> <Nop> 
	nnoremap <buffer> V <Nop>
	nnoremap <buffer> v <Nop>
	nnoremap <buffer> <C-v> <Nop>	<esc><esc>
	nnoremap <buffer> <Enter>		<ScriptCmd>ChooseAnOption()<CR>

	augroup SupravimWelcome
		autocmd!
		autocmd ModeChanged [vV\x16] * if &filetype == 'supravim_welcome' | feedkeys("\<esc>")| endif
		autocmd BufLeave * if &filetype == 'supravim_welcome' | AirlineToggle | AirlineToggle | endif
		autocmd BufLeave * if &filetype == 'supravim_welcome' | timer_stop(timer_animation) | endif
		autocmd CursorMoved * if &filetype == 'supravim_welcome' | call SupraWelcomeMove() | endif 
	augroup END

	var buf = winbufnr(0)
	if timer_animation != 0
		timer_stop(timer_animation)
		timer_animation = 0
	endif
	var offset = 0
	timer_animation = timer_start(100, (timer) => {
		var str_animation = GenerateUTF8Line(&columns, offset)
		offset += 1
		setbufvar(buf, '&tabline', str_animation)
		setbufvar(buf, '&statusline', str_animation)
	}, {repeat: -1})
	ActualizeWelcome()
	ColorAllText()
enddef

def SelectTheme()
	var pop = Popup.Simple({
		title: 'Select Theme',
		width: 30,
		cursorline: 1,
		height: &lines - 6,
	})

	var buf = winbufnr(pop.wid)
	# setbufvar(buf, '&undolevels', -1)
	# setbufvar(buf, '&swapfile', 0)
	# setbufvar(buf, '&cursorlineopt', 'line')

	Popup.AddEventFilterNoFocus(pop, (popup, wid, key) => {
		if key ==? "\<Up>"
			win_execute(popup.wid, 'norm! k')
			var cursorlinepos = line('.', wid)
			var linetext = getbufline(buf, cursorlinepos, cursorlinepos)[0]
			exec 'colorscheme ' .. linetext
			echo 'line text: ' .. linetext
			term ++close ++rows=1 ++cols=1 pwd
		elseif key ==? "\<Down>"
			win_execute(popup.wid, 'norm! j')
			var cursorlinepos = line('.', wid)
			var linetext = getbufline(buf, cursorlinepos, cursorlinepos)[0]
			exec 'colorscheme ' .. linetext
			echo 'line text: ' .. linetext
			term ++close ++rows=1 ++cols=1 pwd
		endif
		return Popup.BLOCK
	})

	var themes = split(glob($HOME .. '/.vim/colors/*.vim'), '\n')
	# remove prefix 
	var new_themes: list<string> = []
	const len_prefix = len($HOME .. '/.vim/colors/')
	for i in themes
		var t = i[len_prefix : -5]
		add(new_themes, t)
	endfor
	Popup.SetSize(pop, 20, len(new_themes))
	Popup.SetText(pop, new_themes)
	setbufvar(buf, '&cursorline', 1)
enddef

def ActualizeWelcome()
	const ascii = [
	 " ____                      __     ___",
	 "/ ___| _   _ _ __  _ __ __ \\ \\   / (_)_ __ ___",
	 "\\___ \\| | | | '_ \\| '__/ _` \\ \\ / /| | '_ \\` _ \\",
	 " ___) | |_| | |_) | | | (_| |\\ V / | | | | | | |",
	 "|____/ \\__,_| .__/|_|  \\__,_| \\_/  |_|_| |_| |_|",
	 "            |_|",
	 ]
	job_start(['supravim', '--status'], {
		out_io: 'buffer',
		out_mode: 'raw',
		close_cb: (ch) => {
			var bufnr = ch_getbufnr(ch, "out")
			var lines = getbufline(bufnr, 0, '$')
			lines[1] = substitute(lines[1], "\033\[[0-9;]*m", '', 'g')
			var sp = split(lines[1], '\n')

			var text = []
			var len_max = 0
			for i in sp
				if len(i) > len_max
					len_max = len(i)
				endif
				add(text, i)
			endfor
			var ascii_middle = ["nda-cunh"]
			for i in ascii
				add(ascii_middle, repeat(' ', (&columns / 2) - (52 / 2)) .. i)
			endfor
			var text_middle = []
			for i in text 
				if i == '' 
					add(text_middle, '')
				elseif stridx(i, '--') != 0
					add(text_middle, repeat(' ', (&columns / 2) - (len_max / 2)) .. '• ' .. i)
				else
					add(text_middle, repeat(' ', (&columns / 2) - (len_max / 2)) .. i)
				endif
			endfor

			text = ascii_middle + text_middle
			var buf = winbufnr(0)


			setbufvar(buf, '&modifiable', 1)
			setbufvar(buf, '&buflisted', 0)
			setbufvar(buf, '&modeline', 0)
			setbufvar(buf, '&buftype', 'nofile')
			setbufvar(buf, '&swapfile', 0)
			setbufvar(buf, '&undolevels', -1)
			setbufvar(buf, '&cursorline', 1)
			setbufvar(buf, '&nu', 0)
			setbufline(buf, 1, text)
			setbufvar(buf, '&modifiable', 0)
			search('•', 'cW')
		},
	})
enddef

var all_mid = []
def ColorAllText()
	for mid in all_mid
		call matchdelete(mid)
	endfor
	b:all_mid = []
	add(b:all_mid, matchadd('off', '\s\zsoff\ze\s'))
	add(b:all_mid, matchadd('on', '\s\zson\ze\s'))
	add(b:all_mid, matchadd('Comment', '[(]\zs.*\ze[)]'))
	add(b:all_mid, matchadd('str_txt', "['].*[']"))
	add(b:all_mid, matchadd('supravim_mode', "--.*--"))
	add(b:all_mid, matchaddpos('supravim_5', [1]))
	add(b:all_mid, matchaddpos('supravim_1', [2]))
	add(b:all_mid, matchaddpos('supravim_2', [3]))
	add(b:all_mid, matchaddpos('supravim_3', [4]))
	add(b:all_mid, matchaddpos('supravim_4', [5]))
	add(b:all_mid, matchaddpos('supravim_5', [6]))
	add(b:all_mid, matchaddpos('supravim_5', [7]))
enddef

def ChooseAnOption()
	var option_name = getline('.')
	var idx = stridx(option_name, '•') + 2
	option_name = option_name[idx : ]
	var changed = matchstr(option_name, '\S\+')
	var value = matchstr(option_name, '\S\+\s*\zs.*\ze')
	var idx_end = stridx(option_name, ' ') - 1
	option_name = option_name[0 : idx_end]
	
	if option_name == 'theme'
		SelectTheme()
		return
	endif

	if stridx(value, 'on') == 0 || stridx(value, 'off') == 0
		echo 'Changing ' .. value .. ' to ' .. value
		if stridx(value, 'on') == 0
			system('supravim -d ' .. option_name)
			silent! call g:ChangeOption(option_name, 'false')
		else
			system('supravim -e ' .. option_name)
			silent! call g:ChangeOption(option_name, 'true')
		endif
		execute "g:sp_" .. option_name .. " = !g:sp_" .. option_name
	else 
		echo 'string not supported: ' .. option_name
	endif
	call ActualizeWelcome()
enddef


var supra_pattern = ['', '', '', '']
def GenerateUTF8Line(columns: number, offset: number): string
	if supra_pattern[0] == ''
		const pattern = ['◸', '◿', '◺', '◹' ]
		for off in range(0, 4)
			var line = ''
			var i = 0 
			while i < (columns / 2)
				line = line .. pattern[(i + off) % 4] .. ' '
				i += 1
			endwhile
			supra_pattern[off] = line
		endfor
	endif
    return supra_pattern[(offset % 4)]
enddef

def SupraWelcomeMove()
	var idx = stridx(getline('.'), '•')
	if idx == -1
		call search('•')
	else
		call setcursorcharpos('.', idx + 1) 
	endif
enddef
