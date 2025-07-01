vim9script

setlocal nosmartindent
setlocal nolisp
setlocal autoindent

setlocal indentexpr=GetC3Indent(v:lnum)

def GetC3Indent(lnum: number): number
	var prv = prevnonblank(lnum - 1)

	if prv == 0
		return 0
	endif

	var prevline = getline(prv)
	var line = getline(lnum)
	var ind = indent(prv)
	if prevline =~ '[({]\s*$'
		ind += &sw
	endif
	
	if line =~ '^\s*[)}]'
		ind -= &sw
	endif
	
	return ind
enddef
