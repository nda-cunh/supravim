vim9script

export def AutoComplete_gMake(lead: string, cmdline: string, cursorpos: number): list<string>
	var content = system("supramake --print-rules")
	var index = match(cmdline, '\s')
	index = match(cmdline, '\s', index + 1)
	if index == -1
		var res2 = split(content, '\n')
		return res2
    else
        return glob(lead .. '*', 0, 1)
    endif
enddef

export var is_supramake = false

def Make(rules: string)
	w!
	is_supramake = true
	setenv('rulesmake', rules)
	! supramake --run-clean $rulesmake
	is_supramake = false
	redraw!
enddef

export def SupraMake(rules: string)
	call Make(rules)
enddef

export def MakeSpecial(...args: list<string>)
	var length = len(args)
	if length == 0
		call Make('all')
	elseif length == 1
		call Make(args[0])
	else
		var rule = args[0]
		var last_args = $ARGS
		var str = join(args[1 : ], ' ')
		$ARGS = str
		call Make(rule)
		$ARGS = last_args
	endif
enddef
