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

	var sp = result->split(' ', )
	var name = sp[0]
	var id = str2nr(sp[1])

	var lst = taglist(name)
	var tagname: string
	var path: string
	var excmd: string


	if empty(name) || empty(lst)
		return
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

    if !has_key(opts.win_opts.partids, 'preview')
        return
    endif

    var preview_wid = opts.win_opts.partids['preview']
    if name == ''
        popup_settext(preview_wid, '')
        return
    endif

    win_execute(preview_wid, 'syntax clear')
    if !filereadable(path)
        if name != ''
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

def GotExit(channel: any, code: number)
	selector.Start(lst_items, {
		select_cb: Select,
		preview_cb: function('Preview'),
		# preview: 0,
		xoffset: 0.1,
		width: 0.80,
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

