vim9script

import autoload 'fuzzyy/utils/selector.vim'

def Select(wid: number, result: list<any>)
	execute "tag " .. result[0] 
enddef

var lst_items: list<string>

def GotOutput(channel: channel, msg: string)
	add(lst_items, msg)
enddef

def GotExit(channel: any, code: number)
	selector.Start(lst_items, {
		select_cb: Select,
		preview: 0,
		xoffset: 0.3,
		width: 0.45,
		title: '────── FuzzyTags ───',
	})
enddef

def Start()
	lst_items = []
	job_start(["supratags", "--print-tags", "--output=" .. expand("$HOME") .. "/.cache/tags"], {
		out_cb: GotOutput,
		exit_cb: GotExit,
		timeout: 10000,
	})
enddef

noremap <space>t <scriptcmd>Start()<cr>

