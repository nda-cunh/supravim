vim9script

import autoload 'SupraMake.vim' as Make
import autoload 'SupraNotification.vim' as Notify

var supravim_server: job 

export def RunServer(project_root: string)
	if executable('supravim-server')
		supravim_server = job_start(["supravim-server", project_root], {
			out_cb: GotOutputSupravimServer,
			in_mode: 'raw',
			in_io: 'pipe'
		})

		augroup SupravimServer
			autocmd!
			au BufEnter * OpenNewFile()
			au User LspIsReady call ReadySupravimServer()
		augroup END
	endif
enddef

def OpenNewFile()
	var filetype = &filetype
	if filetype == ''
		filetype = expand('%:e')
	endif
	ch_sendraw(supravim_server, "OpenFile: " .. filetype ..  "|" .. expand('%:p:t') .. "\n")
enddef

def ReadySupravimServer()
	ch_sendraw(supravim_server, "LspReady\n")
enddef





# ------ Running Supravim-Server ------"
def GotOutputSupravimServer(channel: channel, msg: string)
	if (stridx(msg, 'refresh') == 0)
		if Make.is_supramake == false
			doautocmd User RefreshTree
		endif
	elseif (stridx(msg, 'LoadBundle: ') == 0)
		var sp = split(msg, ' ')
		var bundle = sp[1] 
		var ft = sp[2]
		execute ("set filetype=" .. ft)
		var lst = glob($HOME .. "/.vim/bundle/" .. bundle .. '/**/*.vim', 0, 1)
		for file in lst
			if filereadable(file)
				exec 'source ' .. file
			endif
		endfor
	elseif (stridx(msg, 'LspGetServer') == 0)
		var sp = split(msg, '@#@')
		const cmds = split(sp[2], ',')
		const filetypes = split(sp[3], ',')
		g:AddLspServer(sp[1], cmds, filetypes)
	elseif (stridx(msg, 'LspServerError:') == 0)
		var new_msg = msg[15 : ]
		new_msg = substitute(new_msg, '\r', '\n', 'g')
		call Notify.Notification(["Error", new_msg], {type: 'error'})
	# Used to display the list of LSPs available for installation
	# format: LspInstall: <message>@#@<lsp1>[@#@<lsp2>...]@#@
	elseif (stridx(msg, 'LspInstall: ') == 0)
		var idx = stridx(msg, ': ')
		var new_msg = msg[idx + 2 : ]
		var sp = split(new_msg, '@#@')
		new_msg = substitute(sp[0], '\r', '\n', 'g')
		const items = sp[1 : ]
		var package_name = ''
		var items_copy = []
		for i in items
			if stridx(i, 'plugin-lang') != 0
				new_msg = new_msg .. "\n • " .. i
				add(items_copy, i)
			else
				package_name = i
			endif
		endfor
		call Notify.Notification(['SupraPack', new_msg], {type: 'package', left_click: (wid) => {
			if len(items_copy) == 0
				call GetChoice('', package_name)
			elseif len(items_copy) == 1
				call GetChoice(items_copy[0], package_name)
			else
				call OpenPopupChoice(items_copy, package_name)
			endif
			Notify.Close(wid)
		}})
	elseif (stridx(msg, 'FinishInstall') == 0)
		call FinishInstall(true)
	elseif (stridx(msg, 'InstallError') == 0)
		call FinishInstall(false, msg[14 : ])
	endif
enddef

var notification_timer: number
var notification_id: number

def FinishInstall(success: bool, error_text: string = '')
	# Vala is too speedy, so we need to wait a bit
	if notification_timer == 0
		timer_start(100, (_) => {
			FinishInstall(success, error_text)
		})
		return
	endif
	timer_stop(notification_timer)
	if success
		Notify.SetText(notification_id, ["Installation finished successfully!"])
		Notify.ChangeType(notification_id, 'success')
		timer_start(2000, (_) => {
			Notify.Close(notification_id)
			g:LspServerActivate()
		})
	else
		var error_msg = "Installation failed: " .. error_text
		error_msg = substitute(error_msg, '\r', '\n', 'g')
		Notify.SetText(notification_id, [error_msg])
		Notify.ChangeType(notification_id, 'error')
		timer_start(8000, (_) => {
			Notify.Close(notification_id)
		})
	endif
enddef

def GetChoice(choice: string, package_name: string = '')
	const loading = "⢿⣻⣽⣾⣷⣯⣟⡿"
	Notify.Notification([], {
		icon: '⮋',
		type: 'package',
		timeout: -1,
		left_click: (_) => {
		},
		cb_get_id: (wid) => {
			notification_id = wid
			var i = 0
			notification_timer = timer_start(100, (_) => {
				i = i + 1
				if i >= 8
					i = 0
				endif
				var text = " Installing: "
				if choice != ''
					text ..= choice .. " "
				endif
				if package_name != ''
					text ..= package_name .. " "
				endif
				Notify.SetText(notification_id, [loading[i] .. text])
			}, {'repeat': -1})
		},
	})
	var filetype = &filetype
	if filetype == ''
		filetype = expand('%:e')
	endif

	var c1: string
	var c2: string
	if package_name == ''
		c2 = 'null'
	else
		c2 = package_name
	endif
	if choice == ''
		c1 = 'null'
	else
		c1 = choice
	endif
	ch_sendraw(supravim_server, "Install: " .. c1 .. " " .. c2 .. "\n")
enddef

def OpenPopupChoice(items: list<string>, package_name: string = '')
	var width = 50
	const title = '─ Which Lsp to choose? '
	var popup = popup_create([], {
		title: repeat('─', (width / 2) - (len(title) / 2) + 2) .. ' Which Lsp to choose? ',
		minwidth: 50,
		minheight: 5,
		tabpage: -1,
		borderhighlight: ['Normal', 'Normal', 'Normal', 'Normal'],
		borderchars: ['─', '│', '─', '│', '╭', '╮', '╯', '╰'],
		highlight: 'Normal',
		border: [1],
		padding: [0, 1, 0, 1],
		cursorline: 1,
		mapping: false,
		callback: (wid, data) => {
			if data == []
				return
			endif
			call GetChoice(data[0], package_name)
		},
		filter: (wid: number, key: string) => {
			var bufnr = winbufnr(wid)
			var cursorlinepos = line('.', wid)
			if key == "\<Esc>"
				popup_close(wid)
				return 0
			elseif key == "\<Up>"
				win_execute(wid, 'norm! k')
			elseif key == "\<Down>"
				win_execute(wid, 'norm! j')
			elseif key ==? "\<LeftMouse>"
				var pos = getmousepos()
				if pos.winid != wid
					return 0
				endif
				win_execute(wid, 'norm! ' .. pos.line .. 'G')
			elseif key ==? "\<2-LeftMouse>"
				var pos = getmousepos()
				if pos.winid != wid
					return 0
				endif
				win_execute(wid, 'norm! ' .. pos.line .. 'G')
				var linetext = getbufline(bufnr, pos.line, pos.line)[0]
				if linetext == ''
					popup_close(wid)
				else
					popup_close(wid, [linetext])
				endif
			elseif key == "\<CR>"
				var linetext = getbufline(bufnr, cursorlinepos, cursorlinepos)[0]
				if linetext == ''
					popup_close(wid)
				else
					popup_close(wid, [linetext])
				endif
			else
				return 0
			endif
			return 1
		},
	}
	)
	popup_settext(popup, items)
enddef
