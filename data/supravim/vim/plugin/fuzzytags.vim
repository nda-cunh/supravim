vim9script

import autoload 'fuzzyy/utils/selector.vim'

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

def Preview(wid: number, opts: dict<any>)
    var result = opts.cursor_item

	var lst = ParseResult(result)
	if empty(lst)
		return
	endif

	var tagname: string = lst[0]
	var path: string = lst[1]
	var excmd: string = lst[2]

    if !has_key(opts.win_opts.partids, 'preview')
        return
    endif

    var preview_wid = opts.win_opts.partids['preview']
    if tagname == ''
        popup_settext(preview_wid, '')
        return
    endif

    win_execute(preview_wid, 'syntax clear')
    if !filereadable(path)
        if tagname != ''
            popup_settext(preview_wid, path .. ' not found')
        endif
        return
    endif
    var content = readfile(path)
    popup_settext(preview_wid, content)
    setwinvar(preview_wid, '&filetype', '')
    win_execute(preview_wid, 'silent! doautocmd filetypedetect BufNewFile ' .. path)
    win_execute(preview_wid, 'silent! setlocal nospell nolist')

    if empty(getwinvar(preview_wid, '&filetype')) || getwinvar(preview_wid, '&filetype') == 'conf'
        var modelineft = selector.FTDetectModelines(content)
        if !empty(modelineft)
            win_execute(preview_wid, 'set filetype=' .. modelineft)
        endif
    endif

	if trim(excmd) =~ '^\d\+$'
		win_execute(preview_wid, "silent! cursor(" .. excmd .. ", 1)")
	else
		var pattern = excmd->substitute('^\/', '', '')->substitute('\M\/;\?"\?$', '', '')
		var pattern_esc = EscQuotes(pattern)
		win_execute(preview_wid, "silent! search('\\M" .. pattern_esc .. "', 'cw')")
		clearmatches(preview_wid)
		win_execute(preview_wid, "silent! matchadd('fuzzyyPreviewMatch', '\\M" .. pattern_esc .. "')")
	endif
    win_execute(preview_wid, 'norm! zz')
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

def CloseTab(wid: number, opts: dict<any>)
    if !empty(get(opts, 'cursor_item', ''))
    var result = opts.cursor_item
	var lst = ParseResult(result)
	if empty(lst)
		return
	endif
	var path = lst[1]

	exe 'tabnew ' .. lst[1]
	JumpToSymbol(lst[2])
	endif
enddef

def CloseSplit(wid: number, opts: dict<any>)
    if !empty(get(opts, 'cursor_item', ''))
    var result = opts.cursor_item
	var lst = ParseResult(result)
	if empty(lst)
		return
	endif
	var path = lst[1]

	exe 'split ' .. lst[1]
	JumpToSymbol(lst[2])
	endif
enddef

def CloseVSplit(wid: number, opts: dict<any>)
    if !empty(get(opts, 'cursor_item', ''))
    var result = opts.cursor_item
	var lst = ParseResult(result)
	if empty(lst)
		return
	endif
	var path = lst[1]

	exe 'vsplit ' .. lst[1]
	JumpToSymbol(lst[2])
	endif
enddef

def SetVSplitClose()
    selector.ReplaceCloseCb(function('CloseVSplit'))
    selector.Close()
enddef

def SetSplitClose()
    selector.ReplaceCloseCb(function('CloseSplit'))
    selector.Close()
enddef

def SetTabClose()
    selector.ReplaceCloseCb(function('CloseTab'))
    selector.Close()
enddef

def GotExit(channel: any, code: number)
	selector.Start(lst_items, {
		select_cb: Select,
		preview_cb: function('Preview'),
		xoffset: 0.1,
		width: 0.80,
		title: '────── FuzzyTags ───',
		key_callbacks: {
			"\<c-v>": function('SetVSplitClose'),
			"\<c-s>": function('SetSplitClose'),
			"\<c-t>": function('SetTabClose'),
		},
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
