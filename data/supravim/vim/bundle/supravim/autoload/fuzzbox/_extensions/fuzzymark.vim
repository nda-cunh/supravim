vim9script

import autoload 'fuzzbox/selector.vim'

def Select(wid: number, result: list<any>)
	execute 'normal ' .. result[0]
	execute('norm! zz')
	popup_close(wid)
enddef

def CloseTab(wid: number, result: list<any>)
	execute 'tabnew ' .. expand('%:p')
	execute 'normal ' .. result[0]
	execute('norm! zz')
	popup_close(wid)
enddef

def CloseVSplit(wid: number, result: list<any>)
	execute 'vsplit ' .. expand('%:p')
	execute 'normal ' .. result[0]
	execute('norm! zz')
	popup_close(wid)
enddef

def CloseSplit(wid: number, result: list<any>)
	execute 'split ' .. expand('%:p')
	execute 'normal ' .. result[0]
	execute('norm! zz')
	popup_close(wid)
enddef

def Preview(wid: number, result: string)
	var lst_marks = getmarklist(bufnr('.'))

	var file: string = expand('%:p')
	var pos: list<number>

	for i in lst_marks
		if i.mark == result
			pos = i.pos
			break
		endif
	endfor
	if empty(pos)
		popup_settext(wid, 'Mark not found')
		return
	endif

    win_execute(wid, 'syntax clear')
    if !filereadable(file)
		popup_settext(wid, file .. ' not found')
        return
    endif
    var content = readfile(file)
    popup_settext(wid, content)
    setwinvar(wid, '&filetype', '')
    win_execute(wid, 'silent! doautocmd filetypedetect BufNewFile ' .. file)
    win_execute(wid, 'silent! setlocal nospell nolist')
	# Jump to the mark position
	win_execute(wid, "silent! cursor(" .. pos[1] .. ", " .. pos[2] .. ")")
	win_execute(wid, 'norm! zz')
enddef

export def Start()
	var content: list<string> = []
	var lst_marks = getmarklist(bufnr('.'))
	for i in lst_marks
		add(content, i.mark)
	endfor


	selector.Start(content, {
		select_cb: Select,
		preview_cb: Preview,
		xoffset: 0.1,
		width: 0.80,
		prompt_title: 'FuzzyMark',
		actions: {
			"\<c-t>": function('CloseTab'),
			"\<c-v>": function('CloseVSplit'),
			"\<c-s>": function('CloseSplit'),
			"\<c-q>": null_function,
		}
	})
enddef
