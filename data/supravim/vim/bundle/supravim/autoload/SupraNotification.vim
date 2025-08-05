vim9script

highlight default link SupraNotificationError ErrorMsg
highlight default link SupraNotificationWarning WarningMsg
highlight default link SupraNotificationPackage Type
highlight SupraNotificationSuccess cterm=bold ctermfg=green guifg=#16B84E gui=bold

# All Notifications
var popup_wins: dict<any>

# Callback for notification popups
def FilterNotification(wid: number, key: string): number
	if key ==? "\<LeftMouse>" || key ==? "\<2-LeftMouse>"
		var pos = getmousepos()
		if pos.winid == wid
			if popup_wins[wid].left_click != null_function
				call popup_wins[wid].left_click(wid)
			endif
			return 1
		else
			return 0
		endif
	endif
	return 0
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
			if supraline == 2
				timer_stop(timer)
				return
			endif
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
			var wid = OpenNotification(lst_notification[0].msg, lst_notification[0])
			if lst_notification[0].cb_get_id != null_function
				call lst_notification[0].cb_get_id(wid)
			endif
			remove(lst_notification, 0)
			if len(lst_notification) == 0
				timer_pause(id, 1)
			endif
		endif
	endif
enddef

var lst_notification_open: list<any> = []

# Asynchronous notification function
export def Notification(msg: list<string>, opts: dict<any> = {})
	opts.msg = msg
	if !has_key(opts, 'cb_get_id')
		opts.cb_get_id = null_function 
	endif
	if !has_key(opts, 'timeout')
		opts.timeout = 7000
	endif
	add(lst_notification, opts)
	if timer_notification == 0
		timer_notification = timer_start(100, CheckDisplayNotifications, {repeat: -1})
	endif
	timer_pause(timer_notification, 0)
enddef



###########################################################################
# Notification function with a popup
###########################################################################

def OpenNotification(msg: list<string>, opts: dict<any> = {}): number
	const max_width = 50

	var icon = ''
	# Get the color options
	var color_popup = 'Normal'
	var title_popup: string

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
		elseif opts.type == 'success'
			color_popup = 'SupraNotificationSuccess'
			icon = '✔'
		endif
	endif

	if (has_key(opts, 'icon'))
		icon = opts.icon
	endif
	
	if len(msg) == 0
		title_popup = ""
	else
		title_popup = msg[0]
	endif

	# Create the popup
	var popup: number 
	popup = popup_create([],
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
			borderhighlight: [color_popup, color_popup, color_popup, color_popup],
			borderchars: ['─', '│', '─', '│', '╭', '╮', '╯', '╰'],
			highlight: color_popup,
			padding: [0, 1, 0, 1],
			maxwidth: max_width,
			minwidth: 50,
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
	var buf = winbufnr(popup)
	setbufvar(buf, '&buflisted', 0)
    setbufvar(buf, '&modeline', 0)
    setbufvar(buf, '&buftype', 'nofile')
    setbufvar(buf, '&swapfile', 0)
    setbufvar(buf, '&undolevels', -1)
	setbufvar(buf, '&filetype', 'markdown')
	
	# Add the Event handler for left click
	var Leftclick = null_function
	if has_key(opts, 'left_click')
		Leftclick = opts.left_click
	else
		Leftclick = SimpleLeftClick
	endif

	# Init the map<WID, dict<any>> if it does not exist
	var supradict: dict<any> = {
		wid: popup,
		left_click: Leftclick,
		icon: icon,
		is_closed: false,
		title: title_popup,
	}
	popup_wins[popup] = supradict

	SetText(popup, msg[1 : ])

	SetTitle(popup, title_popup)
	
	AnimationOpenSlide(popup)


	# The timer to close the popup 
	if opts.timeout != -1 
		timer_start(opts.timeout, (_) => {
			Close(popup)
		})
	endif

	return popup
enddef

def AnimationOpenSlide(popup: number)
	if !has_key(popup_wins, popup)
		return
	endif
	var pos = popup_getpos(popup)
	actual_line += pos.height

	var actual_width = pos.width
	var width = 1
	popup_move(popup, {maxwidth: width, width: width})
	popup_show(popup)
	var new_title = popup_getoptions(popup).title
	timer_start(9, (timer) => {
		popup_move(popup, {maxwidth: width, width: width})
		width = width + 1
		# to remove TODO
		if width < len(new_title)
			var title = new_title[0 : width - 1]
			popup_setoptions(popup, {title: title})
		endif
		
		if width == actual_width
			timer_stop(timer)
		endif
	}, {repeat: 9999})
enddef

def SimpleLeftClick(wid: number)
	var dico = {
		close: 'click',
		borderhighlight: ['Normal', 'Normal', 'Normal', 'Normal'],
		border: [1],
		borderchars: ['─', '│', '─', '│', '╭', '╮', '╯', '╰'],
		highlight: 'Normal',
		padding: [1, 1, 1, 1],
		zindex: 3000,
	}
	var buf = winbufnr(wid)
	var txt = getbufline(buf, 0, '$')
	var new_pop = popup_create(txt, dico)
	call Close(wid)
enddef

export def SetText(wid: number, text: list<string>)
	if !has_key(popup_wins, wid)
		return
	endif
	
	# if line contains a newline, split in multiple lines
	var text_without_nl = []
	for line in text 
		var parts = split(line, '\n')
		for part in parts
			if part != ''
				add(text_without_nl, part)
			endif
		endfor
	endfor

	var pos = popup_getpos(wid)
	if pos == {}
		return
	endif
	if popup_wins[wid].is_closed == true
		return
	endif

	const max_width = 50
	var new_msg = []
	var width = pos.width
	for line in text_without_nl
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
	var futur_width = 30
	for line in new_msg 
		if strcharlen(line) > futur_width
			futur_width = strcharlen(line)
		endif
	endfor
	popup_setoptions(wid, {maxwidth: futur_width, width: futur_width, minwidth: futur_width})
	call popup_settext(wid, new_msg)
enddef



export def SetTitle(popup: number, title: string)
	if !has_key(popup_wins, popup)
		return
	endif
	const icon = popup_wins[popup].icon
	const pos = popup_getpos(popup)

	# Center the title of the popup
	const len_title = len(title)
	var new_title: string
	if len_title != 0
		new_title =  ' ' .. icon .. '  ' .. repeat('─', ((pos.width / 2) - len_title / 2) - 6) .. ' ' .. title .. ' '
	else
		new_title = ' ' .. icon .. '  '
	endif
	popup_setoptions(popup, {title: new_title})
enddef


export def ChangeType(popup: number, type: string)
	if !has_key(popup_wins, popup)
		return
	endif
	var icon: string
	var color_popup = 'Normal'
	if type == 'error'
		color_popup = 'SupraNotificationError'
		icon = '🞮'
	elseif type == 'warning'
		color_popup = 'SupraNotificationWarning'
		icon = ''
	elseif type == 'package' # like lsp notifications -> blue
		color_popup = 'SupraNotificationPackage'
		icon = ''
	elseif type == 'success'
		color_popup = 'SupraNotificationSuccess'
		icon = '✔'
	endif
	popup_setoptions(popup, {highlight: color_popup, borderhighlight: [color_popup, color_popup, color_popup, color_popup]})
	popup_wins[popup].icon = icon
	SetTitle(popup, popup_wins[popup].title)
enddef

# Close function, just close  
export def Close(popup: number)
	if !has_key(popup_wins, popup)
		return
	endif
	popup_wins[popup].is_closed = true
	var pos = popup_getpos(popup)
	var width = pos.width
	var new_title = popup_getoptions(popup).title
	var timer: any 
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
enddef
