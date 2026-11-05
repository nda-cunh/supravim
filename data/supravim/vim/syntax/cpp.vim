vim9script

if exists("b:current_syntax")
	finish
endif

b:filetype_in_cpp_family = 1

runtime! syntax/c.vim

syntax keyword cppStatement	new delete this friend using
syntax keyword cppAccess		public protected private
syntax keyword cppModifier		inline virtual explicit export
syntax keyword cppType		bool wchar_t
syntax keyword cppExceptions	throw try catch
syntax keyword cppOperator		typeid
syntax keyword cppOperator		and bitor or xor compl bitand and_eq or_eq xor_eq not not_eq
syntax keyword cppStorageClass	mutable
syntax keyword cppStructure	namespace
syntax keyword cppStructure	template nextgroup=cppTemplateOpen
syntax match cppTemplateOpen contained "<"
syntax keyword cppStructure	class typename struct union enum nextgroup=cppTypeName skipwhite
syntax match cppTypeName contained "\<\%(class\>\|struct\>\|__attribute__\>\|alignas\>\)\@!\h\w*\>\%(::\)\@!"
syntax cluster cParenGroup add=cppTypeName,cppTemplateOpen
syntax cluster cPreProcGroup add=cppTypeName,cppTemplateOpen
syntax cluster cMultiGroup add=cppTypeName,cppTemplateOpen
syntax keyword cppBoolean		true false
syntax keyword cppConstant		__cplusplus

if !exists("cpp_no_cpp11")
	syntax keyword cppModifier	override final
	syntax keyword cppType		nullptr_t auto
	syntax keyword cppExceptions	noexcept
	syntax keyword cppStorageClass	constexpr decltype thread_local
	syntax keyword cppConstant	nullptr
	syntax keyword cppConstant	ATOMIC_FLAG_INIT ATOMIC_VAR_INIT
	syntax keyword cppConstant	ATOMIC_BOOL_LOCK_FREE ATOMIC_CHAR_LOCK_FREE
	syntax keyword cppConstant	ATOMIC_CHAR16_T_LOCK_FREE ATOMIC_CHAR32_T_LOCK_FREE
	syntax keyword cppConstant	ATOMIC_WCHAR_T_LOCK_FREE ATOMIC_SHORT_LOCK_FREE
	syntax keyword cppConstant	ATOMIC_INT_LOCK_FREE ATOMIC_LONG_LOCK_FREE
	syntax keyword cppConstant	ATOMIC_LLONG_LOCK_FREE ATOMIC_POINTER_LOCK_FREE
	syntax region cppRawString	matchgroup=cppRawStringDelimiter start=+\<\%(u8\|[uLU]\)\=R"\z([[:alnum:]_{}[\]#<>%:;.?*\+\-/\^&|~!=,"']\{,16}\)(+ end=+)\z1"\(sv\|s\|_[_a-zA-Z][_a-zA-Z0-9]*\)\=+ contains=@Spell
endif

if !exists("cpp_no_cpp14")
	syntax match cppNumbers		display transparent "\<\d\|\.\d" contains=cppNumber,cppFloat
	var int_suffix = '[Uu]\=\%([Ll]\|LL\|ll\)\|\%([Ll]\|LL\|ll\)\=[Uu]\|i[fl]\=\|h\|min\|s\|ms\|us\|ns\|_\i*'
	if !exists("cpp_no_cpp20")
		int_suffix ..= '\|y\|d'
	endif
	execute 'syntax match cppNumber display contained "\<\%(0\|[1-9]\%(''\=\d\+\)*\|0\o\+\|0b[01]\%(''\=[01]\+\)*\|0x\x\%(''\=\x\+\)*\)\%(' .. int_suffix .. '\)\=\>"'
	syntax match cppFloat		display contained "\<\d\+\.\d*\(e[-+]\=\d\+\)\=\([FfLl]\|i[fl]\=\|h\|min\|s\|ms\|us\|ns\|_\i*\)\=\>"
	syntax match cppFloat		display contained "\<\.\d\+\(e[-+]\=\d\+\)\=\([FfLl]\|i[fl]\=\|h\|min\|s\|ms\|us\|ns\|_\i*\)\=\>"
	syntax match cppFloat		display contained "\<\d\+e[-+]\=\d\+\([FfLl]\|i[fl]\=\|h\|min\|s\|ms\|us\|ns\|_\i*\)\=\>"
	syntax clear cString cCppString
	syntax region cCppString	contained start=+\%(L\|u8\=\|U\)\="+ skip=+\\\\\|\\"\|\\$+ excludenl end=+"+ end='$' contains=cSpecial,cFormat,@Spell
	syntax region cppString		start=+\%(L\|u8\=\|U\)\="+ skip=+\\\\\|\\"\|\\$+ excludenl end=+"\(sv\|s\|_\i*\)\=+ end='$' contains=cSpecial,cFormat,@Spell
endif

if !exists("cpp_no_cpp17")
	syntax match cppFloat		display contained "\<0x\x*\.\x\+p[-+]\=\d\+\([FfLl]\|i[fl]\=\|h\|min\|s\|ms\|us\|ns\|_\i*\)\=\>"
	syntax match cppFloat		display contained "\<0x\x\+\.\=p[-+]\=\d\+\([FfLl]\|i[fl]\=\|h\|min\|s\|ms\|us\|ns\|_\i*\)\=\>"

	# TODO: push this up to c.vim if/when supported in C23
	syntax match cppCharacter	"u8'[^\\]'"
	syntax match cppCharacter	"u8'[^']*'" contains=cSpecial
	if exists("c_gnu")
		syntax match cppSpecialError	  "u8'\\[^'\"?\\abefnrtv]'"
		syntax match cppSpecialCharacter "u8'\\['\"?\\abefnrtv]'"
	else
		syntax match cppSpecialError	  "u8'\\[^'\"?\\abfnrtv]'"
		syntax match cppSpecialCharacter "u8'\\['\"?\\abfnrtv]'"
	endif
	syntax match cppSpecialCharacter display "u8'\\\o\{1,3}'"
	syntax match cppSpecialCharacter display "u8'\\x\x\+'"

endif

if !exists("cpp_no_cpp20")
	syntax keyword cppStatement	co_await co_return co_yield requires
	syntax keyword cppStorageClass	consteval constinit
	syntax keyword cppStructure	concept
	syntax keyword cppType		char8_t
	syntax keyword cppModule		import module export
endif

syntax clear cFunction
syntax match cFunction display "\<\%(\u[A-Z0-9_]*\>\)\@!\h\w*\>\ze\s*("

var tpl_item = '[^<>();|&]\|&\%(&\s*\h\)\@!'
var tpl = '<\%(' .. tpl_item .. '\|<\%(' .. tpl_item .. '\|<\%(' .. tpl_item .. '\)*>\)*>\)*>'

syntax match cppOperator "\<operator\>"
syntax match cppFunction display "\<operator\s*\%(()\|\[\]\|->\*\=\|<=>\|[-+*/%^&|~!=<>,]\+\|new\>\|delete\>\)\%(\s*\[\]\)\=\ze\s*("
execute 'syntax match cppFunction display "\<\h\w*\>\ze' .. tpl .. '\s*("'
execute 'syntax match cppTemplateType display "\w\@1<=' .. tpl .. '"'
var decl_end = '\%(operator\>\|\h\w*\s*[;=({,)]\)'
execute 'syntax match cppUserType display "\<\h\w*\>\ze' .. tpl .. '\%(\s\+\*\=\|\s*&&\=\s*\)' .. decl_end .. '"'
execute 'syntax match cppUserType display "\<\h\w*\>\ze\%(\s\+&&\=\|&&\=\s\+\)' .. decl_end .. '"'
syntax match cppScope "\<\h\w*\ze::" display

syntax match cppCast "\<\%(const\|static\|dynamic\|reinterpret\)_cast\ze\s*\%(<\|$\)"
if !exists("cpp_no_cpp11")
	syntax match cppCast "\<\%(const\|static\|dynamic\)_pointer_cast\ze\s*\%(<\|$\)"
endif
if !exists("cpp_no_cpp17")
	syntax match cppCast "\<reinterpret_pointer_cast\ze\s*\%(<\|$\)"
endif

hi def link cppAccess		cppStatement
hi def link cppCast		cppStatement
hi def link cppExceptions		Exception
hi def link cppOperator		Operator
hi def link cppStatement		Statement
hi def link cppModifier		Type
hi def link cppType		Type
hi def link cppStorageClass	StorageClass
hi def link cppStructure		Structure
hi def link cppBoolean		Boolean
hi def link cppCharacter		cCharacter
hi def link cppSpecialCharacter		cSpecialCharacter
hi def link cppSpecialError		cSpecialError
hi def link cppConstant		Constant
hi def link cppRawStringDelimiter	Delimiter
hi def link cppRawString		String
hi def link cppString		String
hi def link cppNumber		Number
hi def link cppFloat		Number
hi def link cppModule		Include
hi def link cppScope		Identifier
hi def link cppFunction		Function
hi def link cppTemplateType	Type
hi def link cppTypeName		Type
hi def link cppTemplateOpen	Operator
hi def link cppUserType		Type

b:current_syntax = "cpp"
