vim9script

if exists("b:did_indent")
    finish
endif
b:did_indent = 1

setlocal indentexpr=GetBlueprintIndent()
setlocal indentkeys=0{,0},0),0],!^F,o,O

def GetBlueprintIndent(): any
    var lnum = prevnonblank(v:lnum - 1)
    if lnum == 0
        return 0
    endif

    var ind = indent(lnum)
    var prevline = getline(lnum)
    var curline = getline(v:lnum)

    if prevline =~ '[{([][^})\]]*$'
        ind += shiftwidth()
    endif

    if curline =~ '^\s*[})\]]'
        ind -= shiftwidth()
    endif

    return ind
enddef
