vim9script

if exists("b:current_syntax")
	finish
endif

var cpo_save = &cpo
set cpo&vim

syntax case match

syn keyword c3Statement     return break continue defer assert asm
syn keyword c3Conditional   if else switch nextcase
syn keyword c3Label         case default
syn keyword c3Repeat        do for foreach foreach_r while
syn keyword c3Exception     try catch
syn keyword c3Keyword       fn macro var lengthof
syn keyword c3Structure     struct union enum cenum bitstruct interface typedef distinct alias
syn keyword c3Structure     faultdef faultset excuse constdef constset attrdef attrmacro
syn keyword c3StorageClass  const extern inline static tlocal
syn keyword c3Boolean       true false
syn keyword c3Null          null

syn keyword c3Type          void bool char ichar short ushort int uint long ulong int128 uint128
syn keyword c3Type          float double float16 bfloat float128 iptr uptr isz sz usz fault any typeid untypedlist

syn match c3Operator        "[-+*/%&|^!~<>=?.:]"
syn match c3Delimiter       "[][(),;{}]"
syn match c3Delimiter       "::\|\[<\|>\]"

syn match c3Number          "\<\%(0[xX]\x\%(_\=\x\)*\|0[oO]\o\%(_\=\o\)*\|0[bB][01]\%(_\=[01]\)*\|\d\%(_\=\d\)*\)\%([uU][lL]\{,2}\|[lL]\{1,2}\)\=\>"
syn match c3Float           "\<\d[0-9_]*[fFdD]\>"
syn match c3Float           "\<\d[0-9_]*\.\.\@!\%(\d[0-9_]*\)\=\%([eE][-+]\=\d\+\)\=[fFdD]\=\w\@!"
syn match c3Float           "\<\d[0-9_]*[eE][-+]\=\d\+[fFdD]\=\>"
syn match c3Float           "\<0[xX]\x[0-9a-fA-F_]*\%(\.\.\@!\%(\x[0-9a-fA-F_]*\)\=\)\=[pP][-+]\=\d\+[fFdD]\=\>"

syn match c3TypeName        "\<_*\u[A-Z0-9_]*\l\w*\>"
syn match c3Constant        "\<_*\u[A-Z0-9_]*\>"
syn match c3Member          "\%(\.\.\)\@2<!\.\@1<=\<_*\l\w*\>"
syn match c3Module          "\<_*\l\w*\ze\s*::"
syn match c3Function        "\<_*\l\w*\ze\s*("
syn match c3Function        "\<_*\l\w*\ze\s*{[^{}]*}\s*("

syn match c3UserLabel       "\%(\<\%(if\|switch\|for\|foreach\|foreach_r\|while\|do\)\s\+\)\@<=_*\u[A-Z0-9_]*\ze\s*:"
syn match c3UserLabel       "\%(\<\%(break\|continue\)\s\+\)\@<=_*\u[A-Z0-9_]*\>"
syn match c3UserLabel       "\%(\<nextcase\s\+\)\@<=_*\u[A-Z0-9_]*\ze\s*:"

syn match c3Attribute       "@\h\w*"
syn match c3Function        "@_*\l\w*\ze\s*("
syn match c3Attribute       "@\%(align\|allow_deprecated\|benchmark\|bigendian\|builtin\|callconv\|cname\|compact\|const\|constinit\|deprecated\|dynamic\|export\|extern\|feat\|finalizer\|format\|if\|init\|inline\|jump\|link\|littleendian\|local\|maydiscard\|mustinit\|naked\|noalias\|nodiscard\|noinit\|noinline\|nopadding\|norecurse\|noredzone\|noreturn\|nosanitize\|nostackprobe\|nostackprotector\|nostrip\|obfuscate\|operator\|operator_r\|operator_s\|optional\|overlap\|packed\|private\|public\|pure\|reflect\|safeinfer\|safemacro\|section\|simd\|stackprobe\|stackprotector\|structlike\|tag\|test\|unused\|used\|wasm\|weak\|weaklink\|winmain\)\>"
syn match c3HashIdent      "#_*\l\w*"
syn match c3CtIdent         "\$_*\l\w*"
syn match c3CtConstant      "\$_*\u[A-Z0-9_]*\>"
syn match c3TypeName        "\$_*\u[A-Z0-9_]*\l\w*"
syn match c3CtKeyword       "\$\%(alignof\|assert\|assignable\|case\|default\|defined\|echo\|else\|embed\|endfor\|endforeach\|endif\|endswitch\|error\|eval\|evaltype\|exec\|expand\|extnameof\|feat\|feature\|for\|foreach\|if\|include\|is_const\|nameof\|offsetof\|qnameof\|reflect\|sizeof\|stringify\|switch\|typefrom\|Typefrom\|typeof\|Typeof\|vaarg\|vacount\|vaconst\|vaexpr\|vasplat\|vatype\)\>"
syn match c3Builtin         "\$\$_*\l\w*"
syn match c3BuiltinConstant "\$\$_*\u[A-Z0-9_]*\>"

syn match c3EscapeError     contained "\\."
syn match c3Escape          contained +\\\%([0abefnrtv'"\\]\|x\x\{2}\|u\x\{4}\|U\x\{8}\)+
syn match c3Format          contained "%[-+#0]*\%(\*\|\d\+\)\=\%(\.\%(\*\|\d\+\)\)\=[sdxXfFcpboeEgGaAhH%]"

syn region c3String         start=+"+ skip=+\\\\\|\\"+ end=+"+ end=+$+ contains=c3EscapeError,c3Escape,c3Format,@Spell
syn region c3RawString      start=+`+ skip=+``+ end=+`+ contains=@Spell
syn region c3Character      start=+'+ skip=+\\\\\|\\'+ end=+'+ end=+$+ contains=c3EscapeError,c3Escape
syn region c3Bytes          start=+\<\%(x\|b64\)"+ end=+"+
syn region c3Bytes          start=+\<\%(x\|b64\)'+ end=+'+
syn region c3Bytes          start=+\<\%(x\|b64\)`+ end=+`+

syn cluster c3Code          contains=c3Statement,c3Conditional,c3Label,c3Repeat,c3Exception,c3Keyword,c3Structure,c3StorageClass,c3Boolean,c3Null,c3Type
syn cluster c3Code          add=c3Operator,c3Delimiter,c3Number,c3Float,c3TypeName,c3Constant,c3Member,c3Module,c3Function
syn cluster c3Code          add=c3Attribute,c3HashIdent,c3CtIdent,c3CtConstant,c3CtKeyword,c3Builtin,c3BuiltinConstant
syn cluster c3Code          add=c3String,c3RawString,c3Character,c3Bytes,c3LineComment,c3BlockComment

syn match c3ModuleName      contained "\<_*\l\w*\>"
syn region c3ModuleDecl     matchgroup=c3Include start="\<\%(module\|import\)\>" matchgroup=c3Delimiter end=";" contains=c3ModuleName,c3Delimiter,c3Operator,c3TypeName,c3Constant,c3Attribute,c3Function,c3String,c3Number,c3LineComment,c3BlockComment

syn region c3Block          matchgroup=c3Delimiter start="{" end="}" transparent fold

syn keyword c3Todo          contained TODO FIXME XXX BUG NOTE HACK
syn region c3LineComment    start="//" end="$" contains=c3Todo,@Spell
syn region c3BlockComment   start="/\*" end="\*/" contains=c3BlockComment,c3Todo,@Spell fold extend
syn match c3Shebang         "\%^#!.*"

syn match c3DocDescriptor   contained "\[&\=\%(in\|out\|inout\|own\|init\|drop\)\]"
syn match c3DocParam        contained "\%(@param\s\+\%(\[&\=\l\+\]\s*\)\=\)\@<=\%([$#]\=\h\w*\|\.\.\.\)"
syn match c3DocTag          contained "\%(^\s*\|<\*\s*\)\@<=@\h\w*"
syn region c3DocContracts   contained start="\%(^\s*\|<\*\s*\)\@<=\ze@\h" end="\*>"me=s-1 contains=@c3Code,c3DocDescriptor,c3DocParam,c3DocTag
syn region c3DocComment     matchgroup=c3DocDelimiter start="<\*" end="\*>" contains=c3DocContracts,c3Todo,@Spell fold

syn sync fromstart

hi def link c3Statement       Statement
hi def link c3Conditional     Conditional
hi def link c3Label           Label
hi def link c3UserLabel       Label
hi def link c3Repeat          Repeat
hi def link c3Exception       Exception
hi def link c3Keyword         Keyword
hi def link c3Structure       Structure
hi def link c3StorageClass    StorageClass
hi def link c3Boolean         Boolean
hi def link c3Null            Constant
hi def link c3Type            Type
hi def link c3TypeName        Type
hi def link c3Constant        Constant
hi def link c3Operator        Operator
hi def link c3Delimiter       Delimiter
hi def link c3Number          Number
hi def link c3Float           Float
hi def link c3Member          Identifier
hi def link c3Module          Identifier
hi def link c3ModuleName      Identifier
hi def link c3Function        Function
hi def link c3Include         Include
hi def link c3Attribute       PreProc
hi def link c3HashIdent       Identifier
hi def link c3CtIdent         Identifier
hi def link c3CtConstant      Constant
hi def link c3CtKeyword       PreProc
hi def link c3Builtin         Function
hi def link c3BuiltinConstant Constant
hi def link c3String          String
hi def link c3RawString       String
hi def link c3Character       Character
hi def link c3Bytes           String
hi def link c3Escape          SpecialChar
hi def link c3Format          SpecialChar
hi def link c3EscapeError     Error
hi def link c3Todo            Todo
hi def link c3LineComment     Comment
hi def link c3BlockComment    Comment
hi def link c3Shebang         Comment
hi def link c3DocComment      Comment
hi def link c3DocDelimiter    Comment
hi def link c3DocTag          Special
hi def link c3DocParam        Identifier
hi def link c3DocDescriptor   Special

b:current_syntax = "c3"

&cpo = cpo_save
