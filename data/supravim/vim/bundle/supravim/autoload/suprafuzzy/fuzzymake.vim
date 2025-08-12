vim9script

import autoload 'fuzzbox/utils/selector.vim'

def Select(wid: number, result: list<any>)
	call g:Make(result[0])
enddef

def Items(): list<string>
	const content = system("supramake --print-rules")
	const lines = split(content, '\n')
	return lines
enddef

export def Start()
  selector.Start(Items(), {
    select_cb: Select,
    preview: false,
	width: 0.20,
	menu_title: 'FuzzyMake'
  })
enddef
