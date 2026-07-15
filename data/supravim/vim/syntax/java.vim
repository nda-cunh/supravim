vim9script

# Vim9 syntax file for Java — SupraVim style
# Maintainer: nda-cunh

# Quit when a (custom) syntax file was already loaded
if exists("b:current_syntax")
	finish
endif

var cpo_save = &cpo
set cpo&vim

syntax case match

# Declarations / structure
syn keyword javaPackage     package
syn keyword javaImport      import
syn keyword javaStructure   class interface enum record @interface
syn keyword javaRelation    extends implements permits

hi def link javaPackage     Statement
hi def link javaImport      Include
# class/interface/enum/record: keyword hue, not type hue
hi def link javaStructure   Keyword
hi def link javaRelation    Keyword

# Modifiers
syn keyword javaStorageClass public private protected static final abstract
syn keyword javaStorageClass synchronized volatile transient native strictfp
syn keyword javaStorageClass sealed non-sealed default

# Modifiers: Identifier hue, distinct from 'class' and the type
hi def link javaStorageClass Identifier

# Control flow
syn keyword javaStatement   return throw yield assert
syn keyword javaConditional if else switch
syn keyword javaLabel       case default
syn keyword javaRepeat      while for do
syn keyword javaBranch      break continue
syn keyword javaException   try catch finally throws
syn keyword javaKeyword     new instanceof super this var
syn keyword javaOperatorKw  synchronized

hi def link javaStatement   Statement
hi def link javaConditional Conditional
hi def link javaLabel       Label
hi def link javaRepeat      Repeat
hi def link javaBranch      Statement
hi def link javaException   Exception
hi def link javaKeyword     Keyword
hi def link javaOperatorKw  Operator

# Primitive types
syn keyword javaType        void boolean char byte short int long float double

hi def link javaType        Type

# Special literals
syn keyword javaBoolean     true false
syn keyword javaNull        null

hi def link javaBoolean     Boolean
hi def link javaNull        Boolean

# SupraVim: types, functions, members, constants
# Capitalized identifier = type (Java convention)
syn match javaCustomType display "\<\u\w*\>"
# ALL_CAPS constant (2+ chars) — defined after type to win priority
syn match javaConstant   display "\<\u[A-Z0-9_]*\>"
# Function/method call: name followed by '('
syn match javaFunction   display "\<\h\w*\>\ze\s*("
# Member access: .field / .method
syn match javaMember     display "\.\zs\h\w*\>"

hi def link javaCustomType Type
hi def link javaConstant   Constant
hi def link javaFunction   Function
hi def link javaMember     Identifier

# Annotations
syn match javaAnnotation display "@\h\w*\%(\.\h\w*\)*"

hi def link javaAnnotation PreProc

# Operators
syn match javaOperator display "\%(>>>=\|>>=\|<<=\|>>>\|->\|::\|++\|--\|&&\|||\|==\|!=\|<=\|>=\|+=\|-=\|*=\|/=\|%=\|&=\||=\|\^=\|<<\|>>\|[-+*/%&|^!<>=~?:]\)"

hi def link javaOperator   Operator

# Numbers
# Integer (decimal, '_' separators), long suffix
syn match javaNumber display "\<\d\%(_\?\d\)*[lL]\?\>"
# Hex
syn match javaNumber display "\<0[xX]\x\%(_\?\x\)*[lL]\?\>"
# Binary
syn match javaNumber display "\<0[bB][01]\%(_\?[01]\)*[lL]\?\>"
# Octal
syn match javaNumber display "\<0[0-7]\%(_\?[0-7]\)*[lL]\?\>"
# Float
syn match javaFloat  display "\<\d\%(_\?\d\)*\.\%(\d\%(_\?\d\)*\)\?\%([eE][-+]\?\d\+\)\?[fFdD]\?"
syn match javaFloat  display "\.\d\%(_\?\d\)*\%([eE][-+]\?\d\+\)\?[fFdD]\?"
syn match javaFloat  display "\<\d\%(_\?\d\)*\%([eE][-+]\?\d\+\)[fFdD]\?"
syn match javaFloat  display "\<\d\%(_\?\d\)*[fFdD]\>"

hi def link javaNumber     Number
hi def link javaFloat      Float

# Strings & characters
syn match  javaSpecialChar display contained "\\\%(u\x\{4}\|[0-3]\?\o\{1,2}\|[btnfr\"'\\0]\)"
syn match  javaFormat      display contained "%[-+ #0,(]*\%(\d\+\)\?\%(\.\d\+\)\?[bBhHsScCdoxXeEfgGaAtn%]"
syn region javaString      start=+"+ skip=+\\\\\|\\"+ end=+"+ contains=javaSpecialChar,javaFormat,@Spell
syn region javaTextBlock   start=+"""+ end=+"""+ contains=javaSpecialChar,javaFormat,@Spell keepend
syn match  javaCharacter   "'[^\\]'"
syn match  javaCharacter   "'\\.'"  contains=javaSpecialChar
syn match  javaCharacter   "'\\u\x\{4}'" contains=javaSpecialChar

hi def link javaString       String
hi def link javaTextBlock    String
hi def link javaCharacter    Character
hi def link javaSpecialChar  SpecialChar
hi def link javaFormat       Special

# Comments
syn keyword javaTodo       contained TODO FIXME XXX BUG NOTE HACK
syn match   javaDocTag     contained "@\%(param\|return\|throws\|exception\|see\|since\|author\|version\|deprecated\|link\|linkplain\|code\|literal\|value\|inheritDoc\|serial\|serialField\|serialData\)\>"
syn match   javaDocParam   contained "\%(@param\s\+\)\@<=\h\w*"

syn region javaComment     start="//" end="$"    contains=javaTodo,@Spell keepend
syn region javaComment     start="/\*" end="\*/" contains=javaTodo,@Spell fold
syn region javaDocComment  start="/\*\*" end="\*/" contains=javaTodo,javaDocTag,javaDocParam,@Spell fold keepend

hi def link javaComment     Comment
hi def link javaDocComment  Comment
hi def link javaTodo        Todo
hi def link javaDocTag      Special
hi def link javaDocParam    Identifier

# Sync
syn sync ccomment javaComment minlines=15

b:current_syntax = "java"

&cpo = cpo_save
