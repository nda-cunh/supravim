vim9script

highlight default link SupraNotificationError ErrorMsg
highlight default link SupraNotificationWarning WarningMsg
highlight default link SupraNotificationPackage Type

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
	call Notification(msg, opts)
enddef

export def Notification(msg: list<string>, opts: dict<any> = {})
	var icon = ''
	# Get the color options
	var color_popup = 'Normal'

	if (has_key(opts, 'type'))
		if opts.type == 'error'
			color_popup = 'SupraNotificationError'
			icon = '🞮'
		elseif opts.type == 'warning'
			color_popup = 'SupraNotificationWarning'
			icon = ''
		elseif opts.type == 'package' # like lsp notifications -> blue
			color_popup = 'SupraNotificationPackage'
			icon = ''
		endif
	endif

	if (has_key(opts, 'icon'))
		icon = opts.icon
	endif
	# Create the popup

	var popup = popup_notification(
		msg[1 : ],
		{
			col: &columns,
			pos: 'topright',
			time: 90000,
			tabpage: -1,
			zindex: 300,
			drag: 1,
			wrap: 0,
			border: [1],
			title: '─ ' .. msg[0] .. ' ─',
			borderhighlight: [color_popup, color_popup, color_popup, color_popup],
			borderchars: ['─', '│', '─', '│', '╭', '╮', '╯', '╰'],
			highlight: color_popup,
			padding: [0, 1, 0, 1],
			maxwidth: 50,
			filter: FilterNotification,
			fixed: 1,
			scrollbar: 1,
			callback: (wid, _) => {
				popup_move(wid, {col: 1})
			},
		})
	var pos = popup_getpos(popup)


	var width = pos.width
	const max_width = 50
	var new_msg = []

	var msg_without_newline = []

	# if line contains a newline, split in multiple lines
	for line in msg[1 : ]
		var parts = split(line, '\n')
		for part in parts
			if part != ''
				add(msg_without_newline, part)
			endif
		endfor
	endfor

	for line in msg_without_newline 
		var copy_line = line
		while strcharlen(copy_line) > max_width
			# search an space to split the line if possible
			var part = copy_line[0 : max_width - 1]
			var space_index = strridx(part, ' ')
			if space_index == -1
				# no space found, just split at max_width
				space_index = max_width - 1
			endif
			copy_line = copy_line[space_index + 1 : ]
			var str = part[0 : space_index]
			if stridx('~~~', str) == 0
				str = repeat('─', width)
			elseif str[0] == '~'
				echon 'centering: ' .. str
				str = repeat(' ', (width / 2) - strcharlen(str) / 2) .. str[1 : ] 
			endif
			add(new_msg, str)
		endwhile
		if copy_line != ''
			var str = copy_line
			if stridx('~~~', str) == 0
				str = repeat('─', width)
			elseif str[0] == '~'
				echon 'centering: ' .. str
				str = repeat(' ', (width / 2) - strcharlen(str) / 2) .. str[1 : ] 
			endif
			add(new_msg, str)
		endif
	endfor

	call popup_settext(popup, new_msg)


	popup_move(popup, {maxwidth: pos.width})
	var timer: any 
	const len_title = len(msg[0])
	const width_base = pos.width

	var options_of_popup = popup_getpos(popup)
	var new_title: string
	if len_title != 0
		new_title =  ' ' .. icon .. '  ' .. repeat('─', ((options_of_popup.width / 2) - len_title / 2) - 6) .. ' ' .. msg[0] .. ' '
	else
		new_title = ' ' .. icon .. '  '
	endif
	popup_setoptions(popup, {title: new_title})

	timer_start(6500, (_) => {
		timer = timer_start(9, (_) => {
			popup_move(popup, {maxwidth: width, width: width})
			width = width - 1
			if width < len(new_title)
				var title = new_title[0 : width - 1]
				popup_setoptions(popup, {title: title})
			endif
			
			if width == -1
				timer_stop(timer)
				popup_close(popup)
			endif
		}, {repeat: 9999})
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
