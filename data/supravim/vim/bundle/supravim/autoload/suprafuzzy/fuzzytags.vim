vim9script

import autoload 'fuzzbox/utils/selector.vim'

def Select(wid: number, result: list<any>)
	var res = result[0]
	if empty(res)
		return
	endif
	var sp = res->split(' ')
	var nb = str2nr(sp[1]) + 1
	execute ":" .. nb .. "tag " .. sp[0]
enddef

def EscQuotes(str: string): string
	return substitute(str, "'", "''", 'g')
enddef

def Preview(wid: number, result: string)
	var lst = ParseResult(result)
	if empty(lst)
		return
	endif

	var tagname: string = lst[0]
	var path: string = lst[1]
	var excmd: string = lst[2]

    if tagname == ''
        popup_settext(wid, '')
        return
    endif

    win_execute(wid, 'syntax clear')
    if !filereadable(path)
        if tagname != ''
            popup_settext(wid, path .. ' not found')
        endif
        return
    endif
    var content = readfile(path)
    popup_settext(wid, content)
    setwinvar(wid, '&filetype', '')
    win_execute(wid, 'silent! doautocmd filetypedetect BufNewFile ' .. path)
    win_execute(wid, 'silent! setlocal nospell nolist')

	if trim(excmd) =~ '^\d\+$'
		win_execute(wid, "silent! cursor(" .. excmd .. ", 1)")
	else
		var pattern = excmd->substitute('^\/', '', '')->substitute('\M\/;\?"\?$', '', '')
		var pattern_esc = EscQuotes(pattern)
		win_execute(wid, "silent! search('\\M" .. pattern_esc .. "', 'cw')")
		clearmatches(wid)
		win_execute(wid, "silent! matchadd('fuzzyyPreviewMatch', '\\M" .. pattern_esc .. "')")
	endif
    win_execute(wid, 'norm! zz')
enddef

var lst_items: list<string>

def GotOutput(channel: channel, msg: string)
	add(lst_items, msg)
enddef

def ParseResult(result: string): list<any>
	var sp = result->split(' ')
	if empty(sp)
		return [] 
	endif
	var name = sp[0]
	var id = str2nr(sp[1])
	var lst = taglist(name)
	var tagname: string
	var path: string
	var excmd: string

	if empty(name) || empty(lst)
		return []
	endif
	var _id = 0
	for i in lst
		if i.name == name 
			if _id == id
				tagname = i.name
				path = i.filename
				excmd = i.cmd
				break
			else
				_id += 1
				continue
			endif
		endif
	endfor
	return [tagname, path, excmd]
enddef

def JumpToSymbol(excmd: string)
	if trim(excmd) =~ '^\d\+$'
		silent! cursor(" .. excmd .. ", 1)
	else
		var pattern = excmd->substitute('^\/', '', '')->substitute('\M\/;\?"\?$', '', '')
		exec "silent! search('\\M" .. EscQuotes(pattern) .. "', 'cw')"
	endif
enddef

def CloseTab(wid: number)
	var result = selector.GetCursorItem()
	var lst = ParseResult(result)
	if empty(lst)
		return
	endif
	var path = lst[1]

	popup_close(wid)
	exe 'tabnew ' .. lst[1]
	JumpToSymbol(lst[2])
enddef

def CloseSplit(wid: number)
	var result = selector.GetCursorItem()
	var lst = ParseResult(result)
	if empty(lst)
		return
	endif
	var path = lst[1]

	popup_close(wid)
	exe 'split ' .. lst[1]
	JumpToSymbol(lst[2])
enddef

def CloseVSplit(wid: number)
	var result = selector.GetCursorItem()
	var lst = ParseResult(result)
	if empty(lst)
		return
	endif
	var path = lst[1]

	popup_close(wid)
	exe 'vsplit ' .. lst[1]
	JumpToSymbol(lst[2])
enddef

def GotExit(ch: channel)
	const buffer = ch->ch_getbufnr('out')
	const content = getbufline(buffer, 0, '$')

	selector.Start(content[0]->split('\n'), {
		select_cb: Select,
		preview_cb: Preview,
		xoffset: 0.1,
		width: 0.80,
		prompt_title: 'FuzzyTags',
		actions: {
			"\<c-t>": function('CloseTab'), 
			"\<c-v>": function('CloseVSplit'),
			"\<c-s>": function('CloseSplit'),
			"\<c-q>": null_function,
		}
	})
enddef

export def Start()
	lst_items = []
	job_start(["supratags", "--print-tags", "--output=" .. expand("$HOME") .. "/.cache/tags"], {
		out_io: 'buffer',
		out_msg: 0,
		out_mode: 'raw',
		close_cb: GotExit,
		timeout: 10000,
	})
enddef
