vim9script

var queue: list<any>  # Liste pour stocker les éléments de la file

def Enqueue(item: any)
	add(queue, item)
enddef

def QueuePop(): any
	if len(queue) > 0
		return queue[0]
	else
		return 0 
	endif
enddef

def Dequeue()
	if len(queue) > 0
		remove(queue, 0)
	endif
enddef

def Size(): number
	return len(queue)
enddef

def QuitCallback(id: number, idx: number)
	echo "QuitCallback " .. id .. " " .. idx
	Dequeue()
	if Size() > 0
		ShowNotification()
	endif
enddef

def ShowNotification()
	var msg = QueuePop()
	popup_dialog(
		msg[1 : ],
		{
			line: 3, col: 999, pos: 'topright', time: 8000, tabpage: -1, zindex: 300, drag: 1, border: [1],
			close: 'click',
			title: '─ ' .. msg[0] .. ' ─',
			borderhighlight: ['Normal', 'Normal'],
			borderchars: ['─', '│', '─', '│', '╭', '╮', '╯', '╰'],
			highlight: 'Normal',
			padding: [0, 1, 0, 1],
			callback: QuitCallback,
		})
enddef

def g:SupraNotification(msg: list<string>)
	echo Size()
	if Size() == 0
		Enqueue(msg)
		ShowNotification()
	else
		Enqueue(msg)
	endif
enddef
