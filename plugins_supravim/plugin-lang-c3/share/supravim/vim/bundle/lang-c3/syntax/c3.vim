vim9script

if exists("b:current_syntax")
  finish
endif

syntax keyword c3Asm asm
syntax keyword c3Assert assert
syntax keyword c3Attribute attribute
syntax keyword c3Bitstruct bitstruct
syntax keyword c3Interface interface
syntax keyword c3FaultDef faultdef
syntax keyword c3Break break
syntax keyword c3Case case
syntax keyword c3Catch catch 
syntax keyword c3Const const 
syntax keyword c3Continue continue 
syntax keyword c3Alias alias
syntax keyword c3Default default
syntax keyword c3Defer defer 
syntax keyword c3Define define 
syntax keyword c3Do do
syntax keyword c3Else else 
syntax keyword c3Enum enum 
syntax keyword c3Extern extern
syntax keyword c3For for
syntax keyword c3Foreach foreach
syntax keyword c3Foreachr foreach_r
syntax keyword c3Fn fn 
syntax keyword c3If if
syntax keyword c3Import import
syntax keyword c3Inline inline
syntax keyword c3Local local
syntax keyword c3Macro macro 
syntax keyword c3Module module
syntax keyword c3Nextcase nextcase
syntax keyword c3Return return
syntax keyword c3Static static
syntax keyword c3Struct struct 
syntax keyword c3Switch switch
syntax keyword c3Tlocal tlocal
syntax keyword c3Try try
syntax keyword c3Union union
syntax keyword c3Var var 
syntax keyword c3Void void 
syntax keyword c3While while 

syntax keyword c3DataType float double char bool byte short ushort int uint long ulong isz usz iptr uptr int128 uint128 float16 float128 typeid any fault
syntax keyword c3Bool true false
syntax keyword c3Null null

syntax match UserTypes "\<\zs[A-Z][a-zA-Za-z0-9_]*[a-z][A-Za-z0-9_]*\ze\>" display
hi UserTypes guifg=#f0aacc

syntax match c3ModulesHead "\zs[a-z][A-Za-z0-9_]*\ze\:\:" display
syntax match c3ModulesTail "\:\:\zs[a-z][A-Za-z0-9_]*\ze" display
syntax match c3ModuleAlone "\<module\>\s\+\zs[a-z][a-zA-Z0-9_]*\ze;" display
syntax match c3ImportAlone "\<import\>\s\+\zs[a-z][a-zA-Z0-9_]*\ze;" display
highlight c3ModulesColor guifg=#ff55cc
highlight link c3ModulesHead c3ModulesColor
highlight link c3ModulesTail c3ModulesColor
highlight link c3ModuleAlone c3ModulesColor
highlight link c3ImportAlone c3ModulesColor

syntax match c3Todo "TODO"
syntax match c3Note "NOTE"
syntax match c3XXX "XXX"
syntax match c3FixMe "FIXME"
syntax match c3Hack "HACK"

syntax region c3RawString start=+`+ end=+`+
syntax region c3Char start=+'+ skip=+\\\\\|\\'+ end=+'+
syntax region c3String start=+"+ skip=+\\\\\|\\'+ end=+"+ contains=c3Escape
syntax match c3Escape display contained /\\\([nrtabe0\\'"]\|x\x\{2}\)/

syntax match c3FunctionDecl "fn\v<\w*>(\s*\s*)@="
syntax match c3FunctionCall "\v\w+\s*(\()@="

syntax match c3TagNote "@\<\w\+\>" display

syntax match c3Constant "\<[A-Z_][A-Z0-9_]*\>" display
syntax match c3Range "\.\." display
syntax match c3TernaryQMark "?" display
syntax match c3DeclAssign "=" display

syntax match c3Integer "\-\?\<\d\+\>" display
syntax match c3Float "\-\?\<[0-9][0-9_]*\%(\.[0-9][0-9_]*\)\%([eE][+-]\=[0-9_]\+\)\=" display
syntax match c3Hex "\<0[xX][0-9A-Fa-f]\+\>" display
syntax match c3Oct "\<0[oO][0-7]\+\>" display
syntax match c3Bin "\<0[bB][01]\+\>" display

syntax match c3AddressOf "&" display
syntax match c3Deref "*" display

syntax match c3Macro "@\<\w\+\>" display

syntax match c3Template "$\<\w\+\>"

syntax match c3CommentNote "@\<\w\+\>" contained display
syntax region c3LineComment start=/\/\// end=/$/  contains=c3CommentNote, c3Todo, c3Note, c3XXX, c3FixMe, c3NoCheckin, c3Hack
syntax region c3BlockComment start=/\v\/\*/ end=/\v\*\// contains=c3BlockComment, c3CommentNote, c3Todo, c3Note, c3XXX, c3FixMe, c3NoCheckin, c3Hack

highlight link c3FaultDef Keyword
highlight link c3Asm Keyword
highlight link c3Assert Keyword
highlight link c3Attribute Keyword
highlight link c3Break Keyword
highlight link c3Case Keyword
highlight link c3Catch Keyword
highlight link c3Const Keyword
highlight link c3Continue Keyword
highlight link c3Default Keyword
highlight link c3Alias Keyword
highlight link c3Defer Keyword
highlight link c3Define Keyword
highlight link c3Distinct Keyword
highlight link c3Do Keyword
highlight link c3Extern Keyword
highlight link c3Fn Keyword
highlight link c3Import Keyword
highlight link c3Interface Keyword
highlight link c3Inline Keyword
highlight link c3Local Keyword
highlight link c3Macro Keyword
highlight link c3Module Keyword
highlight link c3Nextcase Keyword
highlight link c3Return Keyword
highlight link c3Static Keyword
highlight link c3Switch Keyword
highlight link c3Tlocal Keyword
highlight link c3Try Keyword
highlight link c3Var Keyword
highlight link c3Void Keyword
highlight link c3While Keyword

highlight link c3AddressOf Operator
highlight link c3Deref Operator

highlight link c3DeclAssign Operator
highlight link c3Assign Operator
highlight link c3TernaryQMark Operator

highlight link c3String String
highlight link c3RawString String
highlight link c3Char String

highlight link c3Struct Structure
highlight link c3Enum Structure
highlight link c3Fault Structure
highlight link c3Union Structure
highlight link c3Bitstruct Structure

highlight link c3FunctionDecl Function
highlight link c3FunctionCall Function

highlight link c3Macro Macro
highlight link c3If Conditional
highlight link c3Else Conditional
highlight link c3For Repeat
highlight link c3Foreach Repeat
highlight link c3Foreachr Repeat

highlight link c3LineComment Comment
highlight link c3BlockComment Comment
highlight link c3CommentNote Todo

highlight link c3Todo Todo
highlight link c3Note Todo
highlight link c3XXX Todo
highlight link c3FixMe Todo
highlight link c3NoCheckin Todo
highlight link c3Hack Todo

highlight link c3Template Constant

highlight link c3TagNote Identifier
highlight link c3DataType Type
highlight link c3Bool Boolean
highlight link c3Constant Constant
highlight link c3Null Type
highlight link c3Integer Number
highlight link c3Float Float
highlight link c3Hex Number
highlight link c3Oct Number
highlight link c3Bin Number

b:current_syntax = "c3"
