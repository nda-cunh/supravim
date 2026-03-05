vim9script

syntax case match

# --- Mots-clés de base ---
syn keyword goPackage      package
syn keyword goImport       import
syn keyword goVar          var
syn keyword goConst        const
syn keyword goDeclaration  func type

hi def link goPackage      Statement
hi def link goImport       Statement
hi def link goVar          Keyword
hi def link goConst        Keyword
hi def link goDeclaration  Keyword

# --- Contrôle de flux ---
syn keyword goStatement    defer go goto return break continue fallthrough
syn keyword goConditional  if else switch select
syn keyword goLabel        case default
syn keyword goRepeat       for range

hi def link goStatement    Statement
hi def link goConditional  Conditional
hi def link goLabel        Label
hi def link goRepeat       Repeat

# --- Types ---
syn keyword goType         chan map bool string error any comparable
syn keyword goSignedInts   int int8 int16 int32 int64 rune
syn keyword goUnsignedInts byte uint uint8 uint16 uint32 uint64 uintptr
syn keyword goFloats       float32 float64
syn keyword goComplexes    complex64 complex128

hi def link goType         Type
hi def link goSignedInts   Type
hi def link goUnsignedInts Type
hi def link goFloats       Type
hi def link goComplexes    Type

# --- Identifiants prédéfinis ---
syn keyword goBuiltins     append cap close complex copy delete imag len make new panic print println real recover
syn keyword goBoolean      true false
syn keyword goNil          nil iota

hi def link goBuiltins     Identifier
hi def link goBoolean      Boolean
hi def link goNil          Boolean

# --- Commentaires ---
syn keyword goTodo         contained TODO FIXME XXX BUG NOTE
syn region  goComment      start="//" end="$" contains=goTodo,@Spell
syn region  goComment      start="/\*" end="\*/" contains=goTodo,@Spell

hi def link goComment      Comment
hi def link goTodo         Todo

# --- Littéraux (Nombres) ---
syn match goInt            "\<-\=\%(0\|\%(\d\|\d_\d\)\+\)\>"
syn match goHex            "\<-\=0[xX]_\?\%(\x\|\x_\x\)\+\>"
syn match goOctal          "\<-\=0[oO]\?_\?\%(\o\|\o_\o\)\+\>"
syn match goBinary         "\<-\=0[bB]_\?\%([01]\|[01]_[01]\)\+\>"
syn match goFloat          "\<-\=\%(\d\+\.\d*\|\.\d\+\)\%([eE][-+]\=\d\+\)\=i\?\>"

hi def link goInt          Number
hi def link goHex          Number
hi def link goOctal        Number
hi def link goBinary       Number
hi def link goFloat        Float

# --- Chaînes de caractères et Escapes ---
syn match   goEscape       display contained "\\[abfnrtv\\'"]"
syn match   goEscapeU      display contained "\\u\x\{4}\|\\U\x\{8}"
syn region  goString       start=+"+ skip=+\\\\\|\\"+ end=+"+ contains=goEscape,goEscapeU
syn region  goRawString    start=+`+ end=+`+

hi def link goEscape       Special
hi def link goEscapeU      Special
hi def link goString       String
hi def link goRawString    String

# --- Opérateurs ---
syn match goOperator       /[-+%<>!&|^*=]=\?/
syn match goOperator       /\/\%(=\|\ze[^/*]\)/
syn match goOperator       /<<=\?\|>>=\?\|&^=\?/
syn match goOperator       /:=\|||\|<-\|++\|--/
syn match goVarArgs        /\.\.\./

hi def link goOperator     Operator
hi def link goVarArgs      Operator

# --- Fonctions et Champs ---
syn match goFunction       /\w\+\ze(/
syn match goField          /\.\w\+\>/hs=s+1

hi def link goFunction     Function
hi def link goField        Identifier
