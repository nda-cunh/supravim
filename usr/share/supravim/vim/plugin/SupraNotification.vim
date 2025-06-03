vim9script

highlight default link SupraNotificationError ErrorMsg
highlight default link SupraNotificationWarning WarningMsg

var popup_wins: dict<any>

def FilterNotification(wid: number, key: string): number
	if key ==? "\<LeftMouse>" || key ==? "\<2-LeftMouse>"
		var pos = getmousepos()
		if pos.winid == wid
			if popup_wins[wid].left_click != null_function
				call popup_wins[wid].left_click()
			endif
			return 1
		else
			return 0
		endif
	endif
	return 0
enddef

def g:SupraNotification(msg: list<string>, opts: dict<any> = {})

	# Get the color options
	var color_popup = 'Normal'

	if (has_key(opts, 'color'))
		if opts.color == 'error'
			color_popup = 'SupraNotificationError'
		elseif opts.color == 'warning'
			color_popup = 'SupraNotificationWarning'
		endif
	endif

	# Create the popup

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
			title: '─ ' .. msg[0] .. ' ─',
			borderhighlight: [color_popup, color_popup, color_popup, color_popup],
			borderchars: ['─', '│', '─', '│', '╭', '╮', '╯', '╰'],
			highlight: color_popup,
			padding: [0, 1, 0, 1],
			maxwidth: 50,
			filter: FilterNotification,
			scrollbar: 1,
		})

	# Center the title in the popup
	var options_of_popup = popup_getpos(popup)
	var title = repeat('─', ((options_of_popup.width / 2) - len(msg[0]) / 2) - 2) .. ' ' .. msg[0] .. ' '

	popup_setoptions(popup, {
		title: title
	})

	# Add the Event handler for left click
	var Leftclick = null_function
	if has_key(opts, 'left_click')
		Leftclick = opts.left_click
	else
		Leftclick = () => {
			popup_close(popup)
		}
	endif

	# Init the map<WID, dict<any>> if it does not exist
	var supradict: dict<any> = {
		wid: popup,
		left_click: Leftclick,
	}
	popup_wins[popup] = supradict

	# Set the first popup to the second line instead of the first
	var all_options = popup_getoptions(popup)
	if all_options.line == 1
		popup_move(popup, {line: 2})
	endif
enddef
