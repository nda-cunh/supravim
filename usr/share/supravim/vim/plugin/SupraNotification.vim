vim9script

highlight default link SupraNotificationError ErrorMsg
highlight default link SupraNotificationWarning WarningMsg

def g:SupraNotification(msg: list<string>, type: string = 'info')

	var color_popup: string

	if type == 'error'
		color_popup = 'SupraNotificationError'
	elseif type == 'warning'
		color_popup = 'SupraNotificationWarning'
	else
		color_popup = 'Normal'
	endif

	var popup = popup_notification(
		msg[1 : ],
		{
			col: 999,
			pos: 'topright',
			time: 8000,
			tabpage: -1,
			zindex: 300,
			drag: 1,
			border: [1],
			close: 'click',
			title: '─ ' .. msg[0] .. ' ─',
			borderhighlight: [color_popup, color_popup, color_popup, color_popup],
			borderchars: ['─', '│', '─', '│', '╭', '╮', '╯', '╰'],
			highlight: color_popup,
			padding: [0, 1, 0, 1],
			maxwidth: 50,
			scrollbar: 1,
		})

	var opts = popup_getoptions(popup)
	if opts.line == 1
		popup_move(popup, {line: 2})
	endif

enddef
