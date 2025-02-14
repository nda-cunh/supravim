vim9script

import autoload 'fuzzyy/utils/selector.vim'

def Select(wid: number, result: list<any>)
	call g:Make(result[0])
enddef

def Items(): list<string>
	var content = system("grep -o '^[^%$=]*:' $(suprabear -p)/Makefile 2>/dev/null | sed 's/\s*://'")
	var lines = split(content, '\n')
	return lines
enddef

export def Start()
  selector.Start(Items(), {
    select_cb: Select,
    preview: 0,
	xoffset: 0.4,
	width: 0.16,
	title: '── FuzzyMake ─'
  })
enddef

noremap <space><f5> <scriptcmd>Start()<cr>
