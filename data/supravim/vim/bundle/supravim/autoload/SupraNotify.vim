vim9script

export class Notification
	public var popup: number
	var icon: string
	var title: string = ''
	var text: list<string>
	var color_popup: string = 'Normal'
	var timeout: number = 3000 # TODO 7000

	##########################################################################
	# Constructor
	# text is string or list<string>
	# if string is given, title is empty and text is a list with one element
	# if list<string> is given, title is first element and text is the rest
	# type is one of 'error', 'warning', 'package', 'success'
	##########################################################################
	def new(text: any, type: string = 'info', dict: dict<any> = {})
		const type_of_param = type(text)
		if type_of_param == v:t_string
			this.title = ''
			this.text = [text]
		elseif type_of_param == v:t_list
			if len(text) > 0
				this.title = text[0]
				this.text = text[1 : ]
			else
				this.title = ''
			endif
		else
			throw 'Notification: text must be string or list<string>'
		endif
		###  Initialize the Popup
		this.InitializePopup()

		# Set content and type
		this.SetType(type)	
		this.SetText(this.text)

		###  Run the Closing Timer
		if this.timeout != -1
			timer_start(this.timeout, (_) => {
				this.Close()
			})
		endif

		###  Show the Popup with Animation
		this.AnimationOpenSlide()
		###  Add to the list of popups
		const groups = GetGroups()
		groups.popups += [this]
	enddef

	def AnimationOpenSlide()
		const groups = GetGroups()
		const popup = this.popup
		var pos = popup_getpos(popup)
		groups.actual_line += pos.height

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

	# Close function, just close
	def AnimationCloseSlide()
		const popup = this.popup
		var pos = popup_getpos(popup)
		var width = pos.width
		var new_title = popup_getoptions(popup).title
		var timer: any
		timer = timer_start(7, (_) => {
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

	##########################################################################
	# Initialize the popup
	##########################################################################
	def InitializePopup()
		const groups = GetGroups()
		# Create the popup
		const popup = popup_create([],
			{
				col: &columns,
				line: groups.actual_line,
				pos: 'topright',
				time: 90000,
				tabpage: -1,
				zindex: 300,
				drag: 1,
				wrap: 0,
				border: [1],
				borderhighlight: [this.color_popup, this.color_popup, this.color_popup, this.color_popup],
				borderchars: ['─', '│', '─', '│', '╭', '╮', '╯', '╰'],
				highlight: this.color_popup,
				padding: [0, 1, 0, 1],
				maxwidth: groups.max_width,
				minwidth: 50,
				filter: this.FilterNotification,
				fixed: 1,
				scrollbar: 1,
				hidden: 1,
				callback: (wid, _) => {
					var _pos = popup_getpos(wid)
					groups.actual_line -= _pos.height
					groups.RemoveNotification(this)
					groups.MoveUpAllPopups(_pos.height)
				},
			}
		)
		const buf = winbufnr(popup)
		setbufvar(buf, '&buflisted', 0)
		setbufvar(buf, '&modeline', 0)
		setbufvar(buf, '&buftype', 'nofile')
		setbufvar(buf, '&swapfile', 0)
		setbufvar(buf, '&undolevels', -1)
		setbufvar(buf, '&filetype', 'markdown')
		this.popup = popup
	enddef

	def SetTitle(title: string)
		const popup = this.popup
		const icon = this.icon
		const pos = popup_getpos(popup)

		# Center the title of the popup
		const len_title = len(title)
		var new_title: string
		if len_title != 0
			var dashes = repeat('─', (pos.width / 2) - (len_title / 2) - 6)
			new_title =  $' {icon} {dashes} {title} '
		else
			new_title = $' {icon}  '
		endif
		popup_setoptions(popup, {title: new_title})
	enddef


	def SetText(text: list<string>)
		const wid = this.popup
		
		# if line contains a newline, split in multiple lines
		var text_without_nl = text
			->mapnew((_, v) => split(v, "\n"))
			->flattennew()
			->filter((_, v) => v != '')

		var pos = popup_getpos(wid)
		if pos == {} # TODO || this.closed == true
			return
		endif
		# if this.is_closed == true
			# return
		# endif

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
				# if stridx('~~~', str) == 0
					# str = repeat('━', width)
				# elseif str[0] == '~'
					# str = repeat(' ', (width / 2) - strcharlen(str) / 2) .. str[1 : ]
				# endif
				add(new_msg, str)
			endwhile
			if copy_line != ''
				var str = copy_line
				# if stridx('~~~', str) == 0
					# str = repeat('━', width)
				# elseif str[0] == '~'
					# str = repeat(' ', (width / 2) - strcharlen(str) / 2) .. str[1 : ]
				# endif
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
		this.SetTitle(this.title)
	enddef

	##########################################################################
	# Filter function for popup
	# Handles left mouse click
	##########################################################################
	def FilterNotification(wid: number, key: string): number
		const groups = GetGroups()
		if key ==? "\<LeftMouse>" || key ==? "\<2-LeftMouse>"
			var pos = getmousepos()
			if pos.winid == wid
				# if popup_wins[wid].left_click != null_function
					# call popup_wins[wid].left_click(wid)
				# endif
				return 1
			else
				return 0
			endif
		endif
		return 0
	enddef

	##########################################################################
	# Set the type of notification
	# 'error', 'warning', 'package', 'success'
	##########################################################################
	def SetType(type: string)
		if type == 'error'
			this.color_popup = 'SupraNotificationError'
			this.icon = '🞮'
		elseif type == 'warning'
			this.color_popup = 'SupraNotificationWarning'
			this.icon = ''
		elseif type == 'package' # like lsp notifications -> blue
			this.color_popup = 'SupraNotificationPackage'
			this.icon = ''
		elseif type == 'success'
			this.color_popup = 'SupraNotificationSuccess'
			this.icon = '✔'
		else
			this.color_popup = 'Normal'
			this.icon = '🛈'
		endif
	enddef


	def Close()
		const groups = GetGroups()
		# popup_close(this.popup)
		this.AnimationCloseSlide()
	enddef

endclass



##########################################################################
# Singleton by tab
# All Notifications
##########################################################################
class Groups
	public var actual_line: number = 2
	public var max_width: number = 80
	public var popups: list<Notification> = []

	def RemoveNotification(notif: Notification)
		const l: number = index(this.popups, notif)
		if l >= 0
			remove(this.popups, l)
		endif
	enddef

	def MoveUpAllPopups(repeat_pixel: number)
		for p in this.popups
			var wid = p.popup
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
			}, {repeat: repeat_pixel})
		endfor
	enddef
endclass

def GetGroups(): Groups
	if exists('t:instance')
		return t:instance
	endif
	t:instance = Groups.new()
	return t:instance
enddef


export def Test()
	disassemble Notification.new
enddef

