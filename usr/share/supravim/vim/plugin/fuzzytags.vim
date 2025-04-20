vim9script

import autoload 'fuzzyy/utils/selector.vim'

def Select(wid: number, result: list<any>)
	execute "tag " .. result[0] 
enddef

def Items(): list<string>
	var content = system('supratags --print-tags --output=' .. expand("$HOME") .. '/.cache/tags')
	return split(content, '\n') 
enddef

export def Start()
  selector.Start(Items(), {
    select_cb: Select,
    preview: 0,
	xoffset: 0.4,
	width: 0.40,
	title: '────── FuzzyTags ───'
  })
enddef

noremap <space>t <scriptcmd>Start()<cr>

