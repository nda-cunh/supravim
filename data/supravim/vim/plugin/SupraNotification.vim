vim9script

highlight default link SupraNotificationError ErrorMsg
highlight default link SupraNotificationWarning WarningMsg
highlight default link SupraNotificationPackage Type

# All Notifications
var popup_wins: dict<any>

# Callback for notification popups
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

# Simple notification global function
def g:SupraNotification(msg: list<string>, opts: dict<any> = {})
	call Notification(msg, opts)
enddef

# This function is call for moving up all popups 
def MoveUpAllPopups(repeat_nb: number)
	for p in keys(popup_wins)
		var wid = popup_wins[p].wid
		var timer: any
		timer = timer_start(30, (_) => {
			if popup_getoptions(wid) == {}
				timer_stop(timer)
				return
			endif
			var pos = popup_getpos(wid)
			var supraline = pos.line
			popup_move(wid, {line: float2nr(supraline - 1)})
		}, {repeat: repeat_nb})
	endfor
enddef

# Stack of notifications for Asynchronous notifications
var lst_notification: list<any> = []
var timer_notification: number 
# the actual line where the next notification will be displayed
var actual_line = 2

# Timer Asynchronous notification display function (check if there is a notification to display)
def CheckDisplayNotifications(id: number)
	if exists('lst_notification') && len(lst_notification) != 0 
		if actual_line <= &lines - 6
			call NNotification(lst_notification[0].msg, lst_notification[0])
			remove(lst_notification, 0)
			if len(lst_notification) == 0
				timer_pause(id, 1)
			endif
		endif
	endif
enddef


# Asynchronous notification function
export def Notification(msg: list<string>, opts: dict<any> = {})
	opts.msg = msg
	add(lst_notification, opts)
	if timer_notification == 0
		timer_notification = timer_start(100, CheckDisplayNotifications, {repeat: -1})
	endif
	timer_pause(timer_notification, 0)
enddef



###########################################################################
# Notification function with a popup
###########################################################################

def NNotification(msg: list<string>, opts: dict<any> = {})
	const max_width = 50

	var icon = ''
	# Get the color options
	var color_popup = 'Normal'


	# Simple Default type for the popup
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
	var popup: number 
	popup = popup_create(
		msg[1 : ],
		{
			col: &columns,
			line: actual_line,
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
			maxwidth: max_width,
			filter: FilterNotification,
			fixed: 1,
			scrollbar: 1,
			hidden: 1,
			callback: (wid, _) => {
				var _pos = popup_getpos(popup)
				remove(popup_wins, popup)
				actual_line -= _pos.height
				call MoveUpAllPopups(_pos.height)
			},
		}
	)
	var dico = {
		close: 'click',
		borderhighlight: [color_popup, color_popup, color_popup, color_popup],
		border: [1],
		borderchars: ['─', '│', '─', '│', '╭', '╮', '╯', '╰'],
		highlight: color_popup,
		padding: [1, 1, 1, 1],
		zindex: 3000,
	}
	
	# Add the Event handler for left click
	var Leftclick = null_function
	if has_key(opts, 'left_click')
		Leftclick = opts.left_click
	else
		Leftclick = () => {
			var buf = winbufnr(popup)
			var txt = getbufline(buf, 0, '$')
			var new_pop = popup_create(txt, dico)
			# popup_close(popup)
		}
	endif


	# if line contains a newline, split in multiple lines
	var msg_without_newline = []
	for line in msg[1 : ]
		var parts = split(line, '\n')
		for part in parts
			if part != ''
				add(msg_without_newline, part)
			endif
		endfor
	endfor



	########################################################################
	# Split the lines if they are too long
	# '~' at the beginning of a line will center the line
	# '~~~' at the beginning of a line will create a line of the border
	########################################################################
	var pos = popup_getpos(popup)
	var new_msg = []
	var width = pos.width
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
				str = repeat('━', width)
			elseif str[0] == '~'
				str = repeat(' ', (width / 2) - strcharlen(str) / 2) .. str[1 : ] 
			endif
			add(new_msg, str)
		endwhile
		if copy_line != ''
			var str = copy_line
			if stridx('~~~', str) == 0
				str = repeat('━', width)
			elseif str[0] == '~'
				str = repeat(' ', (width / 2) - strcharlen(str) / 2) .. str[1 : ] 
			endif
			add(new_msg, str)
		endif
	endfor

	call popup_settext(popup, new_msg)



	# Center the title of the popup
	const len_title = len(msg[0])
	var new_title: string
	if len_title != 0
		new_title =  ' ' .. icon .. '  ' .. repeat('─', ((pos.width / 2) - len_title / 2) - 6) .. ' ' .. msg[0] .. ' '
	else
		new_title = ' ' .. icon .. '  '
	endif
	popup_setoptions(popup, {title: new_title})


	# Set the position of the popup
	pos = popup_getpos(popup)
	actual_line += pos.height


	var actual_width = pos.width
	width = 1
	popup_show(popup)
	timer_start(9, (timer) => {
		popup_move(popup, {maxwidth: width, width: width})
		width = width + 1
		if width < len(new_title)
			var title = new_title[0 : width - 1]
			popup_setoptions(popup, {title: title})
		endif
		
		if width == actual_width
			timer_stop(timer)
		endif
	}, {repeat: 9999})

	# The timer to close the popup 
	var timer: any 
	timer_start(7000, (_) => {
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

	# Init the map<WID, dict<any>> if it does not exist
	var supradict: dict<any> = {
		wid: popup,
		left_click: Leftclick,
	}
	popup_wins[popup] = supradict
enddef
