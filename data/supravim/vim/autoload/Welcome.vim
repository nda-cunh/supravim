vim9script

import autoload 'SupraPopup.vim' as Popup

var timer_animation: number = 0

var activity = 0

def ActualizeActivity()
	if activity == 0
		call ActualizeWelcome()
	elseif activity == 1
		call ActualizePlugin()
	endif
enddef

def ActualizePlugin()
enddef

set shortmess+=I

export def SupraWelcome()
	set filetype=supravim_welcome

	noremap <buffer><c-@>	<Nop>
	noremap <buffer>q	<cmd>q!<CR>
	noremap <buffer>Q	<cmd>q!<CR>
	nnoremap <buffer><Down> <scriptcmd>search('•')<CR>
	nnoremap <buffer><Up> <scriptcmd>search('•', 'b')<CR>
	nnoremap <buffer><RightMouse> <Nop> 
	nnoremap <buffer><2-RightMouse> <Nop> 
	nnoremap <buffer> V <Nop>
	nnoremap <buffer> v <Nop>
	nnoremap <buffer> <C-v> <Nop>	<esc><esc>
	nnoremap <buffer> <Enter>		<ScriptCmd>ChooseAnOption()<CR>
	noremap <buffer> T <ScriptCmd>SelectTheme()<CR>
	noremap <buffer> t <ScriptCmd>SelectTheme()<CR>
	map <buffer> G <ScriptCmd>call g:SettingsSupravim()<CR>
	map <buffer> g <ScriptCmd>call g:SettingsSupravim()<CR>
	map <buffer> p <ScriptCmd>call PluginPage()<CR>
	map <buffer> P <ScriptCmd>call PluginPage()<CR>

	augroup SupravimWelcome
		autocmd!
		autocmd ModeChanged [vV\x16] * if &filetype == 'supravim_welcome' | feedkeys("\<esc>")| endif
		autocmd BufEnter * if &filetype == 'supravim_welcome' | call ActualizeActivity() | endif
		autocmd BufLeave * if &filetype == 'supravim_welcome' | AirlineToggle | AirlineToggle | endif
		autocmd BufLeave * if &filetype == 'supravim_welcome' | timer_stop(timer_animation) | endif
		autocmd CursorMoved */  if &filetype == 'supravim_welcome' | call SupraWelcomeMove() | endif 
		autocmd VimResized * if &filetype == 'supravim_welcome' | call ActualizeActivity() | endif
	augroup END


	var buf = winbufnr(0)
	setbufvar(buf, '&buflisted', 0)
	setbufvar(buf, '&modeline', 0)
	setbufvar(buf, '&buftype', 'nofile')
	setbufvar(buf, '&swapfile', 0)
	setbufvar(buf, '&undolevels', -1)
	setbufvar(buf, '&cursorline', 1)
	setbufvar(buf, '&nu', 0)

	ActualizeActivity()

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
			var ascii_middle = ["By: nda-cunh       (Q) quit     (T) theme   (P) Plugins   (G) GUI-mode"]
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
			setbufline(buf, 1, text)
			setbufvar(buf, '&modifiable', 0)
			search('•', 'cW')
		},
	})
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
			silent! call g:ChangeSupravimOption(option_name, 'false')
			execute("source " .. $HOME .. '/.vim/syntax/supravim_welcome.vim')
		else
			system('supravim -e ' .. option_name)
			silent! call g:ChangeSupravimOption(option_name, 'true')
			execute("source " .. $HOME .. '/.vim/syntax/supravim_welcome.vim')
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

def SelectTheme()
	var themes = split(glob($HOME .. '/.vim/colors/*.vim'), '\n')
	# remove prefix 
	var new_themes: list<string> = []
	const len_prefix = len($HOME .. '/.vim/colors/')
	for i in themes
		var t = i[len_prefix : -5]
		if t == 'rosepine_dawn' || t == 'onelight'
			continue
		endif
		add(new_themes, t)
	endfor
	add(new_themes, 'one-light')
	add(new_themes, 'rosepine_dawn-light')
	add(new_themes, 'iceberg-light')

	var pop = Popup.Selector({
		close_key: ['q', 'Q', "\<Esc>"],
		width: 20,
		line: 0,
		height: float2nr(&lines - 6),
	}, new_themes)

	var main_c = Popup.Simple({
		close_key: ['q', 'Q', "\<Esc>"],
		scrollbar: 0,
	})
	var buf = winbufnr(main_c.wid)
	setbufvar(buf, '&modifiable', 1)
	setbufvar(buf, '&filetype', 'c')

	Popup.SetText(main_c, [
	'#include <stdio.h>',
	'/* This is a simple C program */',
	'int main (int argc, char *argv[]) {',
	'    if (argc < 2) {',
	'        printf("%s <name>\n", argv[0]);',
	'        return 1; // return an error code',
	'    }',
	'    printf("Hello, %s %d!\n", argv[1], 42);',
	'    return 0;',
	'}',
	''])
	Popup.SetSize(main_c, 42, 9)

	Popup.AddEventSelectorSelect(pop, (item) => {
		var theme = item
		var typemode = 'dark'
		if stridx(theme, '-light') != -1
			typemode = 'light'
			theme = substitute(theme, '-light$', '', '')
		endif
		g:ChangeSupravimTheme(theme, typemode)
		execute("source " .. $HOME .. '/.vim/syntax/supravim_welcome.vim')
	})
	

	var pos_theme = Popup.GetPos(pop)
	var pos_main = Popup.GetPos(main_c)
	var size_main = Popup.GetSize(main_c)
	var size_theme = Popup.GetSize(pop)

	var begin_middle = (&columns / 2) - (size_theme[0] / 2) - (size_main[0] / 2) - 1
	begin_middle += size_theme[0] - 3
	# echo begin_middle
	
	Popup.SetPos(pop, begin_middle, 0)
	Popup.SetPos(main_c, begin_middle + size_main[0] + 3, 0)

	# echo size_main
	# echo size_theme
	# echo pos_theme.line
	echo pos_theme.col
enddef
