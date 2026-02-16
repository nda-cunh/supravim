vim9script
# Vim syntax file
# Language:     JavaScript
# Maintainer:   vim-javascript community
# URL:          https://github.com/pangloss/vim-javascript

syntax iskeyword @,48-57,_,192-255,$

syntax sync fromstart
syntax case match

syntax match   jsNoise          /[:;]/
syntax match   jsNoise          /,/ skipwhite skipempty nextgroup=@jsExpression
syntax match   jsDot            /\./ skipwhite skipempty nextgroup=jsObjectProp,jsFuncCall,jsPrototype,jsTaggedTemplate
syntax match   jsObjectProp     contained /\<\K\k*/
syntax match   jsFuncCall       /\<\K\k*\ze[\s\n]*(/
syntax match   jsParensError    /[)}\]]/

# Program Keywords
syntax keyword jsStorageClass   const var let skipwhite skipempty nextgroup=jsDestructuringBlock,jsDestructuringArray,jsVariableDef
syntax match   jsVariableDef    contained /\<\K\k*/ skipwhite skipempty nextgroup=jsFlowDefinition
syntax keyword jsOperatorKeyword delete instanceof typeof void new in skipwhite skipempty nextgroup=@jsExpression
syntax keyword jsOf             of skipwhite skipempty nextgroup=@jsExpression
syntax match   jsOperator       "[-!|&+<>=%/*~^]" skipwhite skipempty nextgroup=@jsExpression
syntax match   jsOperator       /::/ skipwhite skipempty nextgroup=@jsExpression
syntax keyword jsBooleanTrue    true
syntax keyword jsBooleanFalse   false

# Modules
syntax keyword jsImport                       import skipwhite skipempty nextgroup=jsModuleAsterisk,jsModuleKeyword,jsModuleGroup,jsFlowImportType
syntax keyword jsExport                       export skipwhite skipempty nextgroup=@jsAll,jsModuleGroup,jsExportDefault,jsModuleAsterisk,jsModuleKeyword,jsFlowTypeStatement
syntax match   jsModuleKeyword      contained /\<\K\k*/ skipwhite skipempty nextgroup=jsModuleAs,jsFrom,jsModuleComma
syntax keyword jsExportDefault      contained default skipwhite skipempty nextgroup=@jsExpression
syntax keyword jsExportDefaultGroup contained default skipwhite skipempty nextgroup=jsModuleAs,jsFrom,jsModuleComma
syntax match   jsModuleAsterisk     contained /\*/ skipwhite skipempty nextgroup=jsModuleKeyword,jsModuleAs,jsFrom
syntax keyword jsModuleAs           contained as skipwhite skipempty nextgroup=jsModuleKeyword,jsExportDefaultGroup
syntax keyword jsFrom               contained from skipwhite skipempty nextgroup=jsString
syntax match   jsModuleComma        contained /,/ skipwhite skipempty nextgroup=jsModuleKeyword,jsModuleAsterisk,jsModuleGroup,jsFlowTypeKeyword

# Strings, Templates, Numbers
syntax region  jsString           start=+\z(["']\)+  skip=+\\\%(\z1\|$\)+  end=+\z1+ end=+$+  contains=jsSpecial extend
syntax region  jsTemplateString   start=+`+  skip=+\\`+  end=+`+     contains=jsTemplateExpression,jsSpecial extend
syntax match   jsTaggedTemplate   /\<\K\k*\ze`/ nextgroup=jsTemplateString
syntax match   jsNumber           /\c\<\%(\d\+\%(e[+-]\=\d\+\)\=\|0b[01]\+\|0o\o\+\|0x\%(\x\|_\)\+\)n\=\>/
syntax keyword jsNumber           Infinity
syntax match   jsFloat            /\c\<\%(\d\+\.\d\+\|\d\+\.\|\.\d\+\)\%(e[+-]\=\d\+\)\=\>/

# Regular Expressions
syntax match   jsSpecial            contained "\v\\%(x\x\x|u%(\x{4}|\{\x{4,5}})|c\u|.)"
syntax region  jsTemplateExpression contained matchgroup=jsTemplateBraces start=+${+ end=+}+ contains=@jsExpression keepend
syntax region  jsRegexpCharClass    contained start=+\[+ skip=+\\.+ end=+\]+ contains=jsSpecial extend
syntax match   jsRegexpBoundary     contained "\v\c[$^]|\\b"
syntax match   jsRegexpBackRef      contained "\v\\[1-9]\d*"
syntax match   jsRegexpQuantifier   contained "\v[^\\]%([?*+]|\{\d+%(,\d*)?})\??"lc=1
syntax match   jsRegexpOr           contained "|"
syntax match   jsRegexpMod          contained "\v\(\?[:=!>]"lc=1
syntax region  jsRegexpGroup        contained start="[^\\]("lc=1 skip="\\.\|\[\(\\.\|[^]]\+\)\]" end=")" contains=jsRegexpCharClass,@jsRegexpSpecial keepend
syntax region  jsRegexpString   start=+\%(\%(\<return\|\<typeof\|\_[^)\]'"[:blank:][:alnum:]_$]\)\s*\)\@<=/\ze[^*/]+ skip=+\\.\|\[[^]]\{1,}\]+ end=+/[gimyus]\{,6}+ contains=jsRegexpCharClass,jsRegexpGroup,@jsRegexpSpecial oneline keepend extend
syntax cluster jsRegexpSpecial    contains=jsSpecial,jsRegexpBoundary,jsRegexpBackRef,jsRegexpQuantifier,jsRegexpOr,jsRegexpMod

# Objects
syntax match   jsObjectShorthandProp contained /\<\k*\ze\s*/ skipwhite skipempty nextgroup=jsObjectSeparator
syntax match   jsObjectKey         contained /\<\k*\ze\s*:/ contains=jsFunctionKey skipwhite skipempty nextgroup=jsObjectValue
syntax region  jsObjectKeyString   contained start=+\z(["']\)+  skip=+\\\%(\z1\|$\)+  end=+\z1\|$+  contains=jsSpecial skipwhite skipempty nextgroup=jsObjectValue
syntax region  jsObjectKeyComputed contained matchgroup=jsBrackets start=/\[/ end=/]/ contains=@jsExpression skipwhite skipempty nextgroup=jsObjectValue,jsFuncArgs extend
syntax match   jsObjectSeparator   contained /,/
syntax region  jsObjectValue       contained matchgroup=jsObjectColon start=/:/ end=/[,}]\@=/ contains=@jsExpression extend
syntax match   jsObjectFuncName    contained /\<\K\k*\ze\_s*(/ skipwhite skipempty nextgroup=jsFuncArgs
syntax match   jsFunctionKey       contained /\<\K\k*\ze\s*:\s*function\>/
syntax match   jsObjectMethodType  contained /\<[gs]et\ze\s\+\K\k*/ skipwhite skipempty nextgroup=jsObjectFuncName
syntax region  jsObjectStringKey   contained start=+\z(["']\)+  skip=+\\\%(\z1\|$\)+  end=+\z1\|$+  contains=jsSpecial extend skipwhite skipempty nextgroup=jsFuncArgs,jsObjectValue

exe 'syntax keyword jsNull      null             ' .. (exists('g:javascript_conceal_null')      ? 'conceal cchar=' .. g:javascript_conceal_null       : '')
exe 'syntax keyword jsReturn    return contained ' .. (exists('g:javascript_conceal_return')    ? 'conceal cchar=' .. g:javascript_conceal_return     : '') .. ' skipwhite nextgroup=@jsExpression'
exe 'syntax keyword jsUndefined undefined        ' .. (exists('g:javascript_conceal_undefined') ? 'conceal cchar=' .. g:javascript_conceal_undefined  : '')
exe 'syntax keyword jsNan       NaN              ' .. (exists('g:javascript_conceal_NaN')       ? 'conceal cchar=' .. g:javascript_conceal_NaN        : '')
exe 'syntax keyword jsPrototype prototype        ' .. (exists('g:javascript_conceal_prototype') ? 'conceal cchar=' .. g:javascript_conceal_prototype  : '')
exe 'syntax keyword jsThis      this             ' .. (exists('g:javascript_conceal_this')      ? 'conceal cchar=' .. g:javascript_conceal_this       : '')
exe 'syntax keyword jsSuper     super  contained ' .. (exists('g:javascript_conceal_super')     ? 'conceal cchar=' .. g:javascript_conceal_super      : '')

# Statement Keywords
syntax match   jsBlockLabel              /\<\K\k*\s*::\@!/    contains=jsNoise skipwhite skipempty nextgroup=jsBlock
syntax match   jsBlockLabelKey contained /\<\K\k*\ze\s*\_[;]/
syntax keyword jsStatement     contained with yield debugger
syntax keyword jsStatement     contained break continue skipwhite skipempty nextgroup=jsBlockLabelKey
syntax keyword jsConditional            if              skipwhite skipempty nextgroup=jsParenIfElse
syntax keyword jsConditional            else            skipwhite skipempty nextgroup=jsCommentIfElse,jsIfElseBlock
syntax keyword jsConditional            switch          skipwhite skipempty nextgroup=jsParenSwitch
syntax keyword jsWhile                  while           skipwhite skipempty nextgroup=jsParenWhile
syntax keyword jsFor                    for             skipwhite skipempty nextgroup=jsParenFor,jsForAwait
syntax keyword jsDo                     do              skipwhite skipempty nextgroup=jsRepeatBlock
syntax region  jsSwitchCase   contained matchgroup=jsLabel start=/\<\%(case\|default\)\>/ end=/:\@=/ contains=@jsExpression,jsLabel skipwhite skipempty nextgroup=jsSwitchColon keepend
syntax keyword jsTry                    try             skipwhite skipempty nextgroup=jsTryCatchBlock
syntax keyword jsFinally      contained finally         skipwhite skipempty nextgroup=jsFinallyBlock
syntax keyword jsCatch        contained catch           skipwhite skipempty nextgroup=jsParenCatch,jsTryCatchBlock
syntax keyword jsException              throw
syntax keyword jsAsyncKeyword           async await
syntax match   jsSwitchColon   contained /::\@!/        skipwhite skipempty nextgroup=jsSwitchBlock

# Keywords
syntax keyword jsGlobalObjects     ArrayBuffer Array BigInt BigInt64Array BigUint64Array Float32Array Float64Array Int16Array Int32Array Int8Array Uint16Array Uint32Array Uint8Array Uint8ClampedArray Boolean Buffer Collator DataView Date DateTimeFormat Function Intl Iterator JSON Map Set WeakMap WeakRef WeakSet Math Number NumberFormat Object ParallelArray Promise Proxy Reflect RegExp String Symbol Uint8ClampedArray WebAssembly console document fetch window
syntax keyword jsGlobalNodeObjects  module exports global process __dirname __filename
syntax match   jsGlobalNodeObjects  /\<require\>/ containedin=jsFuncCall
syntax keyword jsExceptions         Error EvalError InternalError RangeError ReferenceError StopIteration SyntaxError TypeError URIError
syntax keyword jsBuiltins           decodeURI decodeURIComponent encodeURI encodeURIComponent eval isFinite isNaN parseFloat parseInt uneval
# DISCUSS: How imporant is this, really? Perhaps it should be linked to an error because I assume the keywords are reserved?
syntax keyword jsFutureKeys         abstract enum int short boolean interface byte long char final native synchronized float package throws goto private transient implements protected volatile double public

# DISCUSS: Should we really be matching stuff like this?
# DOM2 Objects
syntax keyword jsGlobalObjects  DOMImplementation DocumentFragment Document Node NodeList NamedNodeMap CharacterData Attr Element Text Comment CDATASection DocumentType Notation Entity EntityReference ProcessingInstruction
syntax keyword jsExceptions     DOMException

# DISCUSS: Should we really be matching stuff like this?
# DOM2 CONSTANT
syntax keyword jsDomErrNo       INDEX_SIZE_ERR DOMSTRING_SIZE_ERR HIERARCHY_REQUEST_ERR WRONG_DOCUMENT_ERR INVALID_CHARACTER_ERR NO_DATA_ALLOWED_ERR NO_MODIFICATION_ALLOWED_ERR NOT_FOUND_ERR NOT_SUPPORTED_ERR INUSE_ATTRIBUTE_ERR INVALID_STATE_ERR SYNTAX_ERR INVALID_MODIFICATION_ERR NAMESPACE_ERR INVALID_ACCESS_ERR
syntax keyword jsDomNodeConsts  ELEMENT_NODE ATTRIBUTE_NODE TEXT_NODE CDATA_SECTION_NODE ENTITY_REFERENCE_NODE ENTITY_NODE PROCESSING_INSTRUCTION_NODE COMMENT_NODE DOCUMENT_NODE DOCUMENT_TYPE_NODE DOCUMENT_FRAGMENT_NODE NOTATION_NODE

# DISCUSS: Should we really be special matching on these props?
# HTML events and internal variables
syntax keyword jsHtmlEvents     onblur onclick oncontextmenu ondblclick onfocus onkeydown onkeypress onkeyup onmousedown onmousemove onmouseout onmouseover onmouseup onresize

# Code blocks
syntax region  jsBracket                      matchgroup=jsBrackets            start=/\[/ end=/\]/ contains=@jsExpression,jsSpreadExpression extend fold
syntax region  jsParen                        matchgroup=jsParens              start=/(/  end=/)/  contains=@jsExpression extend fold nextgroup=jsFlowDefinition
syntax region  jsParenDecorator     contained matchgroup=jsParensDecorator     start=/(/  end=/)/  contains=@jsExpression extend fold
syntax region  jsParenIfElse        contained matchgroup=jsParensIfElse        start=/(/  end=/)/  contains=@jsExpression skipwhite skipempty nextgroup=jsCommentIfElse,jsIfElseBlock,jsReturn extend fold
syntax region  jsParenWhile         contained matchgroup=jsParensWhile         start=/(/  end=/)/  contains=@jsExpression skipwhite skipempty nextgroup=jsCommentRepeat,jsRepeatBlock,jsReturn extend fold
syntax region  jsParenFor           contained matchgroup=jsParensFor           start=/(/  end=/)/  contains=@jsExpression,jsStorageClass,jsOf skipwhite skipempty nextgroup=jsCommentRepeat,jsRepeatBlock,jsReturn extend fold
syntax region  jsParenSwitch        contained matchgroup=jsParensSwitch        start=/(/  end=/)/  contains=@jsExpression skipwhite skipempty nextgroup=jsSwitchBlock extend fold
syntax region  jsParenCatch         contained matchgroup=jsParensCatch         start=/(/  end=/)/  skipwhite skipempty nextgroup=jsTryCatchBlock extend fold
syntax region  jsFuncArgs           contained matchgroup=jsFuncParens          start=/(/  end=/)/  contains=jsFuncArgCommas,jsComment,jsFuncArgExpression,jsDestructuringBlock,jsDestructuringArray,jsRestExpression,jsFlowArgumentDef skipwhite skipempty nextgroup=jsCommentFunction,jsFuncBlock,jsFlowReturn extend fold
syntax region  jsClassBlock         contained matchgroup=jsClassBraces         start=/{/  end=/}/  contains=jsClassFuncName,jsClassMethodType,jsArrowFunction,jsArrowFuncArgs,jsComment,jsGenerator,jsDecorator,jsClassProperty,jsClassPropertyComputed,jsClassStringKey,jsAsyncKeyword,jsNoise extend fold
syntax region  jsFuncBlock          contained matchgroup=jsFuncBraces          start=/{/  end=/}/  contains=@jsAll extend fold
syntax region  jsIfElseBlock        contained matchgroup=jsIfElseBraces        start=/{/  end=/}/  contains=@jsAll extend fold
syntax region  jsTryCatchBlock      contained matchgroup=jsTryCatchBraces      start=/{/  end=/}/  contains=@jsAll skipwhite skipempty nextgroup=jsCatch,jsFinally extend fold
syntax region  jsFinallyBlock       contained matchgroup=jsFinallyBraces       start=/{/  end=/}/  contains=@jsAll extend fold
syntax region  jsSwitchBlock        contained matchgroup=jsSwitchBraces        start=/{/  end=/}/  contains=@jsAll,jsSwitchCase extend fold
syntax region  jsRepeatBlock        contained matchgroup=jsRepeatBraces        start=/{/  end=/}/  contains=@jsAll extend fold
syntax region  jsDestructuringBlock contained matchgroup=jsDestructuringBraces start=/{/  end=/}/  contains=jsDestructuringProperty,jsDestructuringAssignment,jsDestructuringNoise,jsDestructuringPropertyComputed,jsSpreadExpression,jsComment nextgroup=jsFlowDefinition extend fold
syntax region  jsDestructuringArray contained matchgroup=jsDestructuringBraces start=/\[/ end=/\]/ contains=jsDestructuringPropertyValue,jsDestructuringNoise,jsDestructuringProperty,jsSpreadExpression,jsDestructuringBlock,jsDestructuringArray,jsComment nextgroup=jsFlowDefinition extend fold
syntax region  jsObject             contained matchgroup=jsObjectBraces        start=/{/  end=/}/  contains=jsObjectKey,jsObjectKeyString,jsObjectKeyComputed,jsObjectShorthandProp,jsObjectSeparator,jsObjectFuncName,jsObjectMethodType,jsGenerator,jsComment,jsObjectStringKey,jsSpreadExpression,jsDecorator,jsAsyncKeyword,jsTemplateString extend fold
syntax region  jsBlock                        matchgroup=jsBraces              start=/{/  end=/}/  contains=@jsAll,jsSpreadExpression extend fold
syntax region  jsModuleGroup        contained matchgroup=jsModuleBraces        start=/{/ end=/}/   contains=jsModuleKeyword,jsModuleComma,jsModuleAs,jsComment,jsFlowTypeKeyword skipwhite skipempty nextgroup=jsFrom fold
syntax region  jsSpreadExpression   contained matchgroup=jsSpreadOperator      start=/\.\.\./ end=/[,}\]]\@=/ contains=@jsExpression
syntax region  jsRestExpression     contained matchgroup=jsRestOperator        start=/\.\.\./ end=/[,)]\@=/
syntax region  jsTernaryIf                    matchgroup=jsTernaryIfOperator   start=/?:\@!/  end=/\%(:\|}\@=\)/  contains=@jsExpression extend skipwhite skipempty nextgroup=@jsExpression
# These must occur here or they will be override by jsTernaryIf
syntax match   jsOperator           /?\.\ze\_D/
syntax match   jsOperator           /??/ skipwhite skipempty nextgroup=@jsExpression

syntax match   jsGenerator            contained /\*/ skipwhite skipempty nextgroup=jsFuncName,jsFuncArgs,jsFlowFunctionGroup
syntax match   jsFuncName             contained /\<\K\k*/ skipwhite skipempty nextgroup=jsFuncArgs,jsFlowFunctionGroup
syntax region  jsFuncArgExpression    contained matchgroup=jsFuncArgOperator start=/=/ end=/[,)]\@=/ contains=@jsExpression extend
syntax match   jsFuncArgCommas        contained ','
syntax keyword jsArguments            contained arguments
syntax keyword jsForAwait             contained await skipwhite skipempty nextgroup=jsParenFor

# Matches a single keyword argument with no parens
syntax match   jsArrowFuncArgs  /\<\K\k*\ze\s*=>/ skipwhite contains=jsFuncArgs skipwhite skipempty nextgroup=jsArrowFunction extend
# Matches a series of arguments surrounded in parens
syntax match   jsArrowFuncArgs  /([^()]*)\ze\s*=>/ contains=jsFuncArgs skipempty skipwhite nextgroup=jsArrowFunction extend

exe 'syntax match jsFunction /\<function\>/      skipwhite skipempty nextgroup=jsGenerator,jsFuncName,jsFuncArgs,jsFlowFunctionGroup skipwhite ' .. (exists('g:javascript_conceal_function') ? 'conceal cchar=' .. g:javascript_conceal_function : '')
exe 'syntax match jsArrowFunction /=>/           skipwhite skipempty nextgroup=jsFuncBlock,jsCommentFunction ' .. (exists('g:javascript_conceal_arrow_function') ? 'conceal cchar=' .. g:javascript_conceal_arrow_function : '')
exe 'syntax match jsArrowFunction /()\ze\s*=>/   skipwhite skipempty nextgroup=jsArrowFunction ' .. (exists('g:javascript_conceal_noarg_arrow_function') ? 'conceal cchar=' .. g:javascript_conceal_noarg_arrow_function : '')
exe 'syntax match jsArrowFunction /_\ze\s*=>/    skipwhite skipempty nextgroup=jsArrowFunction ' .. (exists('g:javascript_conceal_underscore_arrow_function') ? 'conceal cchar=' .. g:javascript_conceal_underscore_arrow_function : '')

# Classes
syntax keyword jsClassKeyword           contained class
syntax keyword jsExtendsKeyword         contained extends skipwhite skipempty nextgroup=@jsExpression
syntax match   jsClassNoise             contained /\./
syntax match   jsClassFuncName          contained /\<\K\k*\ze\s*[(<]/ skipwhite skipempty nextgroup=jsFuncArgs,jsFlowClassFunctionGroup
syntax match   jsClassMethodType        contained /\<\%([gs]et\|static\)\ze\s\+\K\k*/ skipwhite skipempty nextgroup=jsAsyncKeyword,jsClassFuncName,jsClassProperty
syntax region  jsClassDefinition                  start=/\<class\>/ end=/\(\<extends\>\s\+\)\@<!{\@=/ contains=jsClassKeyword,jsExtendsKeyword,jsClassNoise,@jsExpression,jsFlowClassGroup skipwhite skipempty nextgroup=jsCommentClass,jsClassBlock,jsFlowClassGroup
syntax match   jsClassProperty          contained /\<\K\k*\ze\s*[=;]/ skipwhite skipempty nextgroup=jsClassValue,jsFlowClassDef
syntax region  jsClassValue             contained start=/=/ end=/\_[;}]\@=/ contains=@jsExpression
syntax region  jsClassPropertyComputed  contained matchgroup=jsBrackets start=/\[/ end=/]/ contains=@jsExpression skipwhite skipempty nextgroup=jsFuncArgs,jsClassValue extend
syntax region  jsClassStringKey         contained start=+\z(["']\)+  skip=+\\\%(\z1\|$\)+  end=+\z1\|$+  contains=jsSpecial extend skipwhite skipempty nextgroup=jsFuncArgs

# Destructuring
syntax match   jsDestructuringPropertyValue     contained /\k\+/
syntax match   jsDestructuringProperty          contained /\k\+\ze\s*=/ skipwhite skipempty nextgroup=jsDestructuringValue
syntax match   jsDestructuringAssignment        contained /\k\+\ze\s*:/ skipwhite skipempty nextgroup=jsDestructuringValueAssignment
syntax region  jsDestructuringValue             contained start=/=/ end=/[,}\]]\@=/ contains=@jsExpression extend
syntax region  jsDestructuringValueAssignment   contained start=/:/ end=/[,}=]\@=/ contains=jsDestructuringPropertyValue,jsDestructuringBlock,jsNoise,jsDestructuringNoise skipwhite skipempty nextgroup=jsDestructuringValue extend
syntax match   jsDestructuringNoise             contained /[,[\]]/
syntax region  jsDestructuringPropertyComputed  contained matchgroup=jsDestructuringBraces start=/\[/ end=/]/ contains=@jsExpression skipwhite skipempty nextgroup=jsDestructuringValue,jsDestructuringValueAssignment,jsDestructuringNoise extend fold

# Comments
syntax keyword jsCommentTodo    contained TODO FIXME XXX TBD NOTE
syntax region  jsComment        start=+//+ end=/$/ contains=jsCommentTodo,@Spell extend keepend
syntax region  jsComment        start=+/\*+  end=+\*/+ contains=jsCommentTodo,@Spell fold extend keepend
syntax region  jsEnvComment     start=/\%^#!/ end=/$/ display

# Specialized Comments - These are special comment regexes that are used in
# odd places that maintain the proper nextgroup functionality. It sucks we
# can't make jsComment a skippable type of group for nextgroup
syntax region  jsCommentFunction    contained start=+//+ end=/$/    contains=jsCommentTodo,@Spell skipwhite skipempty nextgroup=jsFuncBlock,jsFlowReturn extend keepend
syntax region  jsCommentFunction    contained start=+/\*+ end=+\*/+ contains=jsCommentTodo,@Spell skipwhite skipempty nextgroup=jsFuncBlock,jsFlowReturn fold extend keepend
syntax region  jsCommentClass       contained start=+//+ end=/$/    contains=jsCommentTodo,@Spell skipwhite skipempty nextgroup=jsClassBlock,jsFlowClassGroup extend keepend
syntax region  jsCommentClass       contained start=+/\*+ end=+\*/+ contains=jsCommentTodo,@Spell skipwhite skipempty nextgroup=jsClassBlock,jsFlowClassGroup fold extend keepend
syntax region  jsCommentIfElse      contained start=+//+ end=/$/    contains=jsCommentTodo,@Spell skipwhite skipempty nextgroup=jsIfElseBlock extend keepend
syntax region  jsCommentIfElse      contained start=+/\*+ end=+\*/+ contains=jsCommentTodo,@Spell skipwhite skipempty nextgroup=jsIfElseBlock fold extend keepend
syntax region  jsCommentRepeat      contained start=+//+ end=/$/    contains=jsCommentTodo,@Spell skipwhite skipempty nextgroup=jsRepeatBlock extend keepend
syntax region  jsCommentRepeat      contained start=+/\*+ end=+\*/+ contains=jsCommentTodo,@Spell skipwhite skipempty nextgroup=jsRepeatBlock fold extend keepend

# Decorators
syntax match   jsDecorator                    /^\s*@/ nextgroup=jsDecoratorFunction
syntax match   jsDecoratorFunction  contained /\h[a-zA-Z0-9_.]*/ nextgroup=jsParenDecorator

if exists("javascript_plugin_jsdoc")
	runtime extras/jsdoc.vim
	# NGDoc requires JSDoc
	if exists("javascript_plugin_ngdoc")
		runtime extras/ngdoc.vim
	endif
endif

if exists("javascript_plugin_flow")
	runtime extras/flow.vim
endif

syntax cluster jsExpression  contains=jsBracket,jsParen,jsObject,jsTernaryIf,jsTaggedTemplate,jsTemplateString,jsString,jsRegexpString,jsNumber,jsFloat,jsOperator,jsOperatorKeyword,jsBooleanTrue,jsBooleanFalse,jsNull,jsFunction,jsArrowFunction,jsGlobalObjects,jsExceptions,jsFutureKeys,jsDomErrNo,jsDomNodeConsts,jsHtmlEvents,jsFuncCall,jsUndefined,jsNan,jsPrototype,jsBuiltins,jsNoise,jsClassDefinition,jsArrowFunction,jsArrowFuncArgs,jsParensError,jsComment,jsArguments,jsThis,jsSuper,jsDo,jsForAwait,jsAsyncKeyword,jsStatement,jsDot
syntax cluster jsAll         contains=@jsExpression,jsStorageClass,jsConditional,jsWhile,jsFor,jsReturn,jsException,jsTry,jsNoise,jsBlockLabel,jsBlock

# Define the default highlighting.
# For version 5.7 and earlier: only when not done already
hi link jsComment              Comment
hi link jsEnvComment           PreProc
hi link jsParensIfElse         jsParens
hi link jsParensWhile          jsParensRepeat
hi link jsParensFor            jsParensRepeat
hi link jsParensRepeat         jsParens
hi link jsParensSwitch         jsParens
hi link jsParensCatch          jsParens
hi link jsCommentTodo          Todo
hi link jsString               String
hi link jsObjectKeyString      String
hi link jsTemplateString       String
hi link jsObjectStringKey      String
hi link jsClassStringKey       String
hi link jsTaggedTemplate       StorageClass
hi link jsTernaryIfOperator    Operator
hi link jsRegexpString         String
hi link jsRegexpBoundary       SpecialChar
hi link jsRegexpQuantifier     SpecialChar
hi link jsRegexpOr             Conditional
hi link jsRegexpMod            SpecialChar
hi link jsRegexpBackRef        SpecialChar
hi link jsRegexpGroup          jsRegexpString
hi link jsRegexpCharClass      Character
hi link jsCharacter            Character
hi link jsPrototype            Special
hi link jsConditional          Conditional
hi link jsBranch               Conditional
hi link jsLabel                Label
hi link jsReturn               Statement
hi link jsWhile                jsRepeat
hi link jsFor                  jsRepeat
hi link jsRepeat               Repeat
hi link jsDo                   Repeat
hi link jsStatement            Statement
hi link jsException            Exception
hi link jsTry                  Exception
hi link jsFinally              Exception
hi link jsCatch                Exception
hi link jsAsyncKeyword         Keyword
hi link jsForAwait             Keyword
hi link jsArrowFunction        Type
hi link jsFunction             Type
hi link jsGenerator            jsFunction
hi link jsArrowFuncArgs        jsFuncArgs
hi link jsFuncName             Function
hi link jsFuncCall             Function
hi link jsClassFuncName        jsFuncName
hi link jsObjectFuncName       Function
hi link jsArguments            Special
hi link jsError                Error
hi link jsParensError          Error
hi link jsOperatorKeyword      jsOperator
hi link jsOperator             Operator
hi link jsOf                   Operator
hi link jsStorageClass         StorageClass
hi link jsClassKeyword         Keyword
hi link jsExtendsKeyword       Keyword
hi link jsThis                 Special
hi link jsSuper                Constant
hi link jsNan                  Number
hi link jsNull                 Type
hi link jsUndefined            Type
hi link jsNumber               Number
hi link jsFloat                Float
hi link jsBooleanTrue          Boolean
hi link jsBooleanFalse         Boolean
hi link jsObjectColon          jsNoise
hi link jsNoise                Noise
hi link jsDot                  Noise
hi link jsBrackets             Noise
hi link jsParens               Noise
hi link jsBraces               Noise
hi link jsFuncBraces           Noise
hi link jsFuncParens           Noise
hi link jsClassBraces          Noise
hi link jsClassNoise           Noise
hi link jsIfElseBraces         Noise
hi link jsTryCatchBraces       Noise
hi link jsModuleBraces         Noise
hi link jsObjectBraces         Noise
hi link jsObjectSeparator      Noise
hi link jsFinallyBraces        Noise
hi link jsRepeatBraces         Noise
hi link jsSwitchBraces         Noise
hi link jsSpecial              Special
hi link jsTemplateBraces       Noise
hi link jsGlobalObjects        Constant
hi link jsGlobalNodeObjects    Constant
hi link jsExceptions           Constant
hi link jsBuiltins             Constant
hi link jsImport               Include
hi link jsExport               Include
hi link jsExportDefault        StorageClass
hi link jsExportDefaultGroup   jsExportDefault
hi link jsModuleAs             Include
hi link jsModuleComma          jsNoise
hi link jsModuleAsterisk       Noise
hi link jsFrom                 Include
hi link jsDecorator            Special
hi link jsDecoratorFunction    Function
hi link jsParensDecorator      jsParens
hi link jsFuncArgOperator      jsFuncArgs
hi link jsClassProperty        jsObjectKey
hi link jsObjectShorthandProp  jsObjectKey
hi link jsSpreadOperator       Operator
hi link jsRestOperator         Operator
hi link jsRestExpression       jsFuncArgs
hi link jsSwitchColon          Noise
hi link jsClassMethodType      Type
hi link jsObjectMethodType     Type
hi link jsClassDefinition      jsFuncName
hi link jsBlockLabel           Identifier
hi link jsBlockLabelKey        jsBlockLabel

hi link jsDestructuringBraces     Noise
hi link jsDestructuringProperty   jsFuncArgs
hi link jsDestructuringAssignment jsObjectKey
hi link jsDestructuringNoise      Noise

hi link jsCommentFunction      jsComment
hi link jsCommentClass         jsComment
hi link jsCommentIfElse        jsComment
hi link jsCommentRepeat        jsComment

hi link jsDomErrNo             Constant
hi link jsDomNodeConsts        Constant
hi link jsDomElemAttrs         Label
hi link jsDomElemFuncs         PreProc

hi link jsHtmlEvents           Special
hi link jsHtmlElemAttrs        Label
hi link jsHtmlElemFuncs        PreProc

hi link jsCssStyles            Label

syntax cluster  htmlJavaScript       contains=@jsAll,jsImport,jsExport
syntax cluster  javaScriptExpression contains=@jsAll
hi! def link javaScript              NONE
b:current_syntax = "javascript"
