vim9script

if exists("b:did_indent")
    finish
endif
b:did_indent = 1

setlocal nolisp nosmartindent autoindent
setlocal indentexpr=GetC3Indent()
setlocal indentkeys=0{,0},0),0],!^F,o,O,e,=case,=default,=$case,=$default,=$else,=$endif,=$endfor,=$endforeach,=$endswitch,0=*>

b:undo_indent = "setlocal lisp< smartindent< autoindent< indentexpr< indentkeys<"

const COMMENT = '^c3\%(LineComment\|BlockComment\|DocComment\|DocDelimiter\|Shebang\)$'
const LITERAL = '^c3\%(String\|RawString\|Character\|Bytes\)$'
const IGNORED = '^c3\%(LineComment\|BlockComment\|DocComment\|DocDelimiter\|Shebang\|String\|RawString\|Character\|Bytes\)$'
const CONTROL = '^\s*\%(}\s*\)\=\%(if\|else\|for\|foreach\|foreach_r\|while\|do\)\>'
const CT_CLOSE = '\$\%(else\|endif\|endfor\|endforeach\|endswitch\)$'

def StackHas(lnum: number, col: number, pattern: string): bool
    for id in synstack(lnum, col)
        if synIDattr(id, 'name') =~# pattern
            return true
        endif
    endfor
    return false
enddef

def IsIgnored(): bool
    return StackHas(line('.'), col('.'), IGNORED)
enddef

def EolState(lnum: number): list<string>
    if lnum < 1
        return []
    endif
    return synstack(lnum, strlen(getline(lnum)) + 1)->mapnew((_, id) => synIDattr(id, 'name'))
enddef

def Kind(lnum: number, col: number): number
    var kind = 0
    for id in synstack(lnum, col)
        const name = synIDattr(id, 'name')
        if name =~# COMMENT
            return 2
        elseif name =~# LITERAL
            kind = 1
        endif
    endfor
    return kind
enddef

def StripLine(lnum: number): string
    const text = getline(lnum)
    if text !~ '["`'']\|/[/*]\|<\*\|\*[/>]' && empty(synstack(lnum, 1))
        return text
    endif
    if text !~ '\*[/>]' && StackHas(lnum, 1, '^c3\%(DocComment\|BlockComment\)$')
        return repeat(' ', strlen(text))
    endif
    var result = ''
    var col = 1
    var kind = Kind(lnum, 1)
    var boundary = false
    for ch in split(text, '\zs')
        const size = strlen(ch)
        const structural = ch =~ '[][{}()"`''/*<>]'
        if structural || boundary
            kind = Kind(lnum, col)
        endif
        boundary = structural
        result ..= kind == 2 ? repeat(' ', size) : kind == 1 ? repeat('"', size) : ch
        col += size
    endfor
    return result
enddef

var strip_cache: dict<list<string>> = {}
var strip_key = ''

def Strip(lnum: number): string
    const key = bufnr() .. ':' .. b:changedtick
    if key != strip_key
        strip_key = key
        strip_cache = {}
    endif
    const id = string(lnum)
    const text = getline(lnum)
    if !has_key(strip_cache, id) || strip_cache[id][0] !=# text
        strip_cache[id] = [text, StripLine(lnum)]
    endif
    return strip_cache[id][1]
enddef

def PrevCode(start: number): number
    var lnum = prevnonblank(start)
    while lnum > 0 && Strip(lnum) =~ '^\s*$'
        lnum = prevnonblank(lnum - 1)
    endwhile
    return lnum
enddef

def Balance(text: string): dict<any>
    var opened: list<list<any>> = []
    var closed = 0
    var closed_ch = ''
    var col = 1
    for ch in split(text, '\zs')
        if ch =~ '[{([]'
            opened->add([ch, col])
        elseif ch =~ '[})\]]'
            if empty(opened)
                closed = col
                closed_ch = ch
            else
                opened->remove(-1)
            endif
        endif
        col += strlen(ch)
    endfor
    return {opened: opened, closed: closed, closed_ch: closed_ch}
enddef

def MatchingOpen(lnum: number, col: number, ch: string): number
    const pairs = {'}': ['{', '}'], ')': ['(', ')'], ']': ['\[', '\]']}
    cursor(lnum, col)
    return searchpairpos(pairs[ch][0], '', pairs[ch][1], 'bnW', IsIgnored)[0]
enddef

def IsContinuation(lnum: number): bool
    const text = trim(Strip(lnum), '', 2)
    if text == '' || text =~ '[;{}:,([]$'
        return false
    endif
    return text !~ CT_CLOSE
enddef

def ClosersStart(start: number): number
    var lnum = start
    while lnum > 0
        const balance = Balance(Strip(lnum))
        if balance.closed == 0
            return lnum
        endif
        const open = MatchingOpen(lnum, balance.closed, balance.closed_ch)
        if open == 0 || open == lnum
            return lnum
        endif
        lnum = open
    endwhile
    return start
enddef

def StatementStart(start: number): number
    var lnum = ClosersStart(start)
    while true
        const prev = PrevCode(lnum - 1)
        if prev == 0 || !IsContinuation(prev)
            return lnum
        endif
        lnum = ClosersStart(prev)
    endwhile
    return lnum
enddef

def CtOpener(lnum: number, open: string, close: string): number
    cursor(lnum, 1)
    return searchpairpos(open, '', close, 'bnW', IsIgnored)[0]
enddef

def GetC3Indent(): number
    const lnum = v:lnum
    const text = getline(lnum)
    const state = EolState(lnum - 1)

    cursor(lnum, 1)
    const opener = search('<\*', 'bnW')
    if opener > 0 && opener > search('\*>', 'bnW')
        if text =~ '^\s*\*>'
            return indent(opener)
        endif
        if text =~ '^\s*$'
            const prev = prevnonblank(lnum - 1)
            return prev == opener ? indent(opener) + 1 : indent(prev)
        endif
        return -1
    endif

    if index(state, 'c3BlockComment') >= 0
        return text =~ '^\s*$' ? indent(prevnonblank(lnum - 1)) : -1
    endif

    if index(state, 'c3RawString') >= 0 || index(state, 'c3Bytes') >= 0
        return -1
    endif

    const sw = shiftwidth()
    const cur = trim(Strip(lnum))

    if cur =~ '^[})\]]'
        const col = match(getline(lnum), '\S') + 1
        const open = MatchingOpen(lnum, col, cur[0])
        return open > 0 ? indent(StatementStart(open)) : 0
    endif

    if cur =~ '^\$\%(else\|endif\)\>'
        return indent(CtOpener(lnum, '\$if\>', '\$endif\>'))
    endif
    if cur =~ '^\$endfor\>'
        return indent(CtOpener(lnum, '\$for\>', '\$endfor\>'))
    endif
    if cur =~ '^\$endforeach\>'
        return indent(CtOpener(lnum, '\$foreach\>', '\$endforeach\>'))
    endif
    if cur =~ '^\$endswitch\>'
        return indent(CtOpener(lnum, '\$switch\>', '\$endswitch\>'))
    endif
    if cur =~ '^\$\%(case\|default\)\>'
        return indent(CtOpener(lnum, '\$switch\>', '\$endswitch\>')) + sw
    endif

    if cur =~ '^\%(case\|default\)\>'
        cursor(lnum, 1)
        const open = searchpairpos('{', '', '}', 'bnW', IsIgnored)[0]
        return open > 0 ? indent(StatementStart(open)) + sw : 0
    endif

    const prev = PrevCode(lnum - 1)
    if prev == 0
        return 0
    endif

    const stripped = trim(Strip(prev), '', 2)
    const balance = Balance(stripped)

    if !empty(balance.opened)
        const last = balance.opened[-1]
        if last[1] == strlen(stripped)
            return indent(StatementStart(prev)) + sw
        endif
        return strdisplaywidth(strpart(stripped, 0, matchend(stripped, '\s*', last[1])))
    endif

    if cur =~ '^{' && stripped =~ ':$'
        return indent(prev)
    endif

    if stripped =~ ':$' || stripped =~ '\$else$'
        return indent(ClosersStart(prev)) + sw
    endif

    if IsContinuation(prev)
        const anchor = ClosersStart(prev)
        if cur =~ '^{'
            return anchor != prev || getline(prev) =~ CONTROL
                ? indent(anchor)
                : indent(StatementStart(prev))
        endif
        if anchor != prev || getline(prev) =~ CONTROL
            return indent(anchor) + sw
        endif
        return StatementStart(prev) == prev ? indent(prev) + sw : indent(prev)
    endif

    return indent(StatementStart(prev))
enddef
