vim9script

var keepre = &regexpengine
&regexpengine = 1

if exists("b:current_syntax")
  &regexpengine = keepre
  finish
endif

def SearchIdentifierRegex(ident: string): string
  var i = 0
  var result = '\V\C'
  while i < len(ident)
    var c = ident[i]
    var underscore = i < len(ident) - 1 ? '_\?' : ''
    if i == 0 && c =~ '\a'
      result ..= escape(c, '\/ ') .. underscore
    elseif c == '_'
      result ..= ''
    elseif c =~ '\k'
      result ..= '\%(' .. tolower(c) .. '\|' .. toupper(c) .. '\)' .. underscore
    endif
    i += 1
  endwhile
  return result
enddef

const chosen_syntax = get(g:, 'nim_emit_syntax', 'c')
if search('\c\<emit\>\|codegen_\=decl', 'nw') > 0
  if chosen_syntax =~? '^c$'
    syntax include @emitSyntax syntax/c.vim
  elseif chosen_syntax =~? '^\%(cpp\|c++\)$'
    syntax include @emitSyntax syntax/cpp.vim
  elseif chosen_syntax =~? '^\%(js\|javascript\)$'
    syntax include @emitSyntax syntax/javascript.vim
  elseif chosen_syntax =~? '^objc$'
    syntax include @emitSyntax syntax/objc.vim
  else
    execute 'syntax include @emitSyntax ' .. chosen_syntax
  endif
  unlet! b:current_syntax
  syntax sync clear
endif

b:current_syntax = "nim"

# Keyword from the Manual, classified to different categories
syntax keyword nimKeywordOperator addr and as distinct div do in is isnot mod
syntax keyword nimKeywordOperator not notin of or ptr ref shl shr unsafeAddr xor
syntax keyword nimStatement       asm bind block break cast concept const
syntax keyword nimStatement       continue defer discard let mixin return
syntax keyword nimStatement       static type using var yield
syntax keyword nimStatement       converter func iterator macro method nextgroup=nimProcName skipwhite
syntax keyword nimStatement       proc nextgroup=nimProcName skipwhite
syntax keyword nimStatement       template nextgroup=nimProcName skipwhite
syntax keyword nimConditional     case elif else if
syntax keyword nimKeyword         end interface out
syntax keyword nimException       except finally raise try
syntax keyword nimRepeat          for while
syntax keyword nimConstant        nil
syntax keyword nimBoolean         true false
syntax keyword nimBuiltinType     int int8 int16 int32 int64 uint uint8 uint16 uint32 uint64 float float32 float64
syntax keyword nimBuiltinType     bool char string cstring pointer void auto any untyped typed typedesc
syntax keyword nimBuiltinType     seq array openArray set range varargs sink lent owned
syntax keyword nimBuiltin         echo
syntax keyword nimResult          result
syntax keyword nimPreCondit       when
syntax keyword nimInclude         export from import include
syntax keyword nimStructure       enum object tuple

syntax keyword nimPreProcStmt     alignof compiles defined sizeof

syntax cluster nimKeywordGroup contains=nimKeywordOperator,nimStatement,nimConditional,nimKeyword,nimException,nimRepeat,nimConstant,nimBoolean,nimBuiltinType,nimPreCondit,nimInclude,nimStructure,nimPreProcStmt

syntax match nimProcName /\w\+\|`[^`]\+`/ contained
highlight default link nimProcName Function

syntax match nimComment      "#.*$" contains=nimTodo,@Spell
syntax region nimLongDocComment start='##\[' end=']##' contains=nimTodo,nimLongDocComment,@Spell
syntax region nimLongComment start='#\[' end=']#' contains=nimTodo,nimLongComment,nimLongDocComment,@Spell
syntax keyword nimTodo       FIXME NOTE NOTES TODO XXX contained

syntax cluster nimCommentGroup contains=nimComment,nimLongDocComment,nimLongComment

syntax region nimEscapedSymbol
      \ matchgroup=nimBacktick
      \ start='`' end='`'
      \ contains=@nimCommentGroup
      \ oneline

syntax region nimString
      \ matchgroup=nimQuote
      \ start=+"+ skip=+\\\\\|\\"+ end=+"+
      \ contains=nimEscapeStr,nimEscapeChar,nimEscapeQuote,@Spell
      \ oneline
syntax region nimRawString
      \ matchgroup=nimQuote
      \ start='\<\K\k*"' end='"'
      \ contains=@Spell
      \ oneline
syntax region nimRawString
      \ matchgroup=nimTripleQuote
      \ start='\%(\<\K\k*\)\?"""' end='"*\zs"""'
      \ contains=@Spell
syntax match nimCharacter +'\%(\\\%([rcnlftv\\"'abe]\|x\x\{2}\|\d\+\)\|.\)'+ contains=nimEscapeChar,nimEscapeQuote

syntax match nimEscapeChar  +\\[rcnlftv\\'abe]+ contained
syntax match nimEscapeChar  "\\\d\+" contained
syntax match nimEscapeChar  "\\x\x\{2}" contained
syntax match nimEscapeQuote +\\"+ contained
syntax match nimEscapeStr   "\\p" contained
syntax match nimEscapeStr   "\\u\%(\x\{4}\|{\x\+}\)" contained

const nimDec = '\d\+\%(_\d\+\)*'
const nimHex = '0[xX]\x\+\%(_\x\+\)*'
const nimOct = '0o\o\+\%(_\o\+\)*'
const nimBin = '0[bB][01]\+\%(_[01]\+\)*'

const nimDecFloat = nimDec .. '\.' .. nimDec
const nimExpSuffix = '[eE][+-]\=' .. nimDec

const nimIntSuffix = '''\=[iIuU]\%(8\|16\|32\|64\)'
const nimFloatSuffix = '''\=\%([fF]\%(32\|64\|128\)\=\|[dD]\)'
const nimCustomSuffix = '''\K\+\k*'

const nimInt = '\%(' .. nimHex .. '\|' .. nimOct .. '\|' .. nimBin .. '\|' .. nimDec .. '\)'
const nimFloatBody = '\%(' .. nimDecFloat .. '\%(' .. nimExpSuffix .. '\)\=\|' .. nimDec .. nimExpSuffix .. '\)'
const nimNumPrefix = '\%(\<\|\%(\s\+\zs\|^\)\-\)'

execute 'syntax match nimNumber display "' .. nimNumPrefix .. nimInt .. '\%(' .. nimIntSuffix .. '\)\=\>"'
execute 'syntax match nimFloat display "' .. nimNumPrefix .. '\%(\%(' .. nimOct .. '\|' .. nimBin .. '\|' .. nimDec .. '\)' .. nimFloatSuffix .. '\|' .. nimHex .. '''' .. nimFloatSuffix .. '\|' .. nimFloatBody .. '\%(' .. nimFloatSuffix .. '\)\=\)\>"'
execute 'syntax match nimCustomNumber display "' .. nimNumPrefix .. '\%(' .. nimInt .. '\|' .. nimFloatBody .. '\)' .. nimCustomSuffix .. '\>"'

syntax cluster nimLiteralGroup contains=nimString,nimRawString,nimCharacter,nimNumber,nimFloat,nimCustomNumber

# pragmas in Nim are matched style-insensitively, so we need to create custom
# matches for them.
def MatchPragmas(pragmas: list<string>)
  const alternatives = pragmas->mapnew((_, p) => SearchIdentifierRegex(p))->join('\|')
  execute 'syntax match nimPragma contained display ''\<\%(' .. alternatives .. '\)\>'''
enddef
# builtins pragma, these are not processed by nimsuggest highlighter
MatchPragmas(['deprecated', 'noSideEffect', 'compileTime', 'noReturn',
'acyclic', 'final', 'shallow', 'pure', 'asmNoStackFrame',
'error', 'fatal', 'warning', 'hint', 'line', 'linearScanEnd',
'computedGoto', 'unroll', 'checks', 'boundChecks',
'overflowChecks', 'nilChecks', 'assertions', 'warnings',
'hints', 'optimization', 'patterns', 'callconv', 'push',
'pop', 'register', 'global', 'pragma', 'used',
'experimental', 'bitsize', 'volatile', 'nodecl', 'header',
'incompletestruct', 'compile', 'link', 'passC', 'passL',
'emit', 'importcpp', 'importobjc', 'codegendecl',
'injectstmt', 'intdefine', 'strdefine', 'cdecl', 'importc',
'exportc', 'extern', 'bycopy', 'byref', 'varargs', 'union',
'packed', 'dynlib', 'threadvar', 'gcsafe', 'locks', 'guard',
'inline', 'borrow', 'booldefine', 'discardable', 'noInit',
'requiresInit', 'closure', 'nimcall', 'stdcall', 'safecall',
'fastcall', 'syscall', 'noconv', 'nanChecks', 'infChecks',
'floatChecks', 'size', 'base', 'raises', 'tags', 'effects',
'inject', 'gensym', 'explain', 'noRewrite', 'package',
'inheritable', 'constructor'])

syntax region nimEmitString
      \ matchgroup=nimQuote
      \ start=+"+ skip=+\\\\\|\\"+ end=+"+
      \ contains=@emitSyntax,nimEscapeStr,nimEscapeChar,nimEscapeQuote
      \ oneline
      \ contained
      \ keepend
syntax region nimEmitRawString
      \ matchgroup=nimQuote
      \ start='\<\K\k*"' end='"'
      \ contains=@emitSyntax
      \ oneline
      \ contained
      \ keepend
syntax region nimEmitRawString
      \ matchgroup=nimTripleQuote
      \ start='\%(\<\K\k*\)\?"""' end='"*\zs"""'
      \ contains=@emitSyntax
      \ contained
      \ keepend

syntax region nimEmitArray
      \ start='\[' end=']'
      \ contains=@nimKeywordGroup,@nimLiteralGroup,@nimCommentGroup,nimEmitString,nimEmitRawString
      \ contained

execute 'syntax region nimEmit ' ..
      \ 'start=+\<\%(' .. SearchIdentifierRegex('emit') .. '\|' .. SearchIdentifierRegex('codegendecl') .. '\)\m\s*:+ ' ..
      \ 'end=+\ze\%(,\|\.\?}\)+ ' ..
      \ 'contains=@nimKeywordGroup,@nimLiteralGroup,@nimCommentGroup,nimPragma,nimEmit.\+ ' ..
      \ 'contained'

syntax region nimPragmaList
      \ start=+{\.+ end=+\.\?}+
      \ contains=@nimKeywordGroup,@nimLiteralGroup,@nimCommentGroup,nimPragma,nimEmit

syntax match nimCall display "\<\h\w*\ze\s*("
syntax match nimMember display "\.\@1<=\h\w*\>"
syntax match nimMethodCall display "\.\@1<=\h\w*\ze\s*("
syntax match nimTypeName display "\<\u\w*\l\w*\>"
syntax match nimConstName display "\<\u[A-Z0-9_]\+\>"

# sync at the beginning of functions definition
syntax sync match nimSync grouphere NONE "^\%(proc\|func\|iterator\|method\)\s\+\a\w*\s*[(:=]"
# sync at some special places
syntax sync match nimSync grouphere NONE "^\%(discard\|let\|var\|const\|type\)"
# sync at long string start
syntax sync match nimSyncString grouphere nimRawString "^\%(discard\|asm\)\s\+\"\{3}"
syntax sync match nimSyncString grouphere nimRawString "r\"\{3}"

highlight default link nimKeywordOperator Operator
highlight default link nimStatement       Statement
highlight default link nimConditional     Conditional
highlight default link nimKeyword         Keyword
highlight default link nimException       Exception
highlight default link nimRepeat          Repeat
highlight default link nimConstant        Constant
highlight default link nimBoolean         Boolean
highlight default link nimBuiltinType     Type
highlight default link nimBuiltin         Function
highlight default link nimResult          Special
highlight default link nimCall            Function
highlight default link nimMember          Identifier
highlight default link nimMethodCall      Function
highlight default link nimTypeName        Type
highlight default link nimConstName       Constant
highlight default link nimPreCondit       PreCondit
highlight default link nimInclude         Include
highlight default link nimStructure       Structure
highlight default link nimPreProcStmt     Macro
highlight default link nimComment         Comment
highlight default link nimTodo            Todo
highlight default link nimLongDocComment  Comment
highlight default link nimLongComment     Comment
highlight default link nimString          String
highlight default link nimEscapeStr       SpecialChar
highlight default link nimEscapeChar      SpecialChar
highlight default link nimEscapeQuote     SpecialChar
highlight default link nimRawString       String
highlight default link nimQuote           String
highlight default link nimTripleQuote     nimQuote
highlight default link nimCharacter       Character
highlight default link nimNumber          Number
highlight default link nimFloat           Float
highlight default link nimCustomNumber    Number
highlight default link nimPragma          PreProc

highlight default link nimSugUnknown      Error
highlight default link nimSugParam        Identifier
highlight default link nimSugModule       Identifier
highlight default link nimSugType         Type
highlight default link nimSugGenericParam Type
highlight default link nimSugVar          Identifier
highlight default link nimSugGlobalVar    Identifier
highlight default link nimSugLet          Identifier
highlight default link nimSugGlobalLet    Identifier
highlight default link nimSugConst        Constant
highlight default link nimSugResult       Special
highlight default link nimSugProc         Function
highlight default link nimSugFunc         Function
highlight default link nimSugMethod       Function
highlight default link nimSugIterator     Function
highlight default link nimSugConverter    Macro
highlight default link nimSugMacro        Macro
highlight default link nimSugTemplate     Macro
highlight default link nimSugField        Identifier
highlight default link nimSugEnumField    Constant
highlight default link nimSugForVar       Identifier
highlight default link nimSugLabel        Identifier

&regexpengine = keepre
