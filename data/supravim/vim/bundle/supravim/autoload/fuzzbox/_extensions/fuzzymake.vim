vim9script

import autoload 'fuzzbox/selector.vim'
import autoload 'SupraMake.vim' as Make
import autoload 'SupraNotification.vim' as Notify

var by_line: dict<string> = {}
var by_name: dict<dict<string>> = {}

def Mark(slot: dict<string>): string
	if slot.value == ''
		return '·'
	endif
	if slot.kind != 'cmd'
		return '⚙'
	endif
	return slot.value =~ '^:' ? ':' : '$'
enddef

def Kind(slot: dict<string>): string
	if slot.value == ''
		return 'empty slot'
	endif
	if slot.kind != 'cmd'
		return 'supramake rule'
	endif
	return slot.value =~ '^:' ? 'Vim command' : 'shell command'
enddef

def Text(slot: dict<string>): string
	return slot.value == '' ? '(nothing yet)' : slot.cmd
enddef

def GetList(): list<string>
	by_line = {}
	by_name = {}
	const slots = Make.Slots()
	var width = 0
	for slot in slots
		width = max([width, strcharlen(slot.name)])
	endfor
	var result: list<string> = []
	for slot in slots
		const pad = repeat(' ', width - strcharlen(slot.name))
		const line = slot.name .. pad .. '   ' .. Mark(slot) .. ' ' .. Text(slot)
		by_line[line] = slot.name
		by_name[slot.name] = slot
		add(result, line)
	endfor
	return result
enddef

def Select(wid: number, result: list<any>)
	const name = by_line->get(result[0], '')
	if name == ''
		return
	endif
	Make.RunSlot(name)
enddef

def Preview(wid: number, result: string)
	win_execute(wid, 'setlocal nonumber')
	const name = by_line->get(result, '')
	if name == '' || !by_name->has_key(name)
		popup_settext(wid, [])
		return
	endif
	const slot = by_name[name]
	popup_settext(wid, [slot.name .. '  —  ' .. Kind(slot), '', Text(slot)])
enddef

export def Start()
	var lst = GetList()
	if empty(lst)
		Notify.Notification(['SupraMake', 'No slot in this project'], {type: 'info'})
		return
	endif
	selector.Start(lst, {
		select_cb: Select,
		preview_cb: Preview,
		height: 0.4,
		width: 0.7,
		preview_ratio: 0.4,
		actions: {
			"\<c-t>": null_function,
			"\<c-v>": null_function,
			"\<c-s>": null_function,
			"\<c-q>": null_function,
		},
		prompt_title: 'SupraMake',
	})
enddef
