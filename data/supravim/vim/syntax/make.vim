vim9script

# Vim syntax file
# Language:	Makefile
# Previous Maintainer:	Claudio Fleiner <claudio@fleiner.com>, Roland Hieber <https://github.com/rohieb>
# URL:		https://github.com/vim/vim/blob/master/runtime/syntax/make.vim
# Last Change:	2022 Nov 06

# quit when a syntax file was already loaded
if exists("b:current_syntax")
	finish
endif

# enable GNU extension when b:make_flavor is not set—detection failed or Makefile is POSIX-compliant
var make_flavor = 'gnu'

# some special characters
syn match makeSpecial	"^\s*[@+-]\+"
syn match makeNextLine	"\\\n\s*"

# catch unmatched define/endef keywords.  endef only matches it is by itself on a line, possibly followed by a commend
syn region makeDefine start="^\s*define\s" end="^\s*endef\s*\(#.*\)\?$"
			\ contains=makeStatement,makeAutoVar,makeIdent,makePreCondit,makeDefine,makeComment,makeTargetinDefine

if get(b:, 'make_flavor', make_flavor) == 'microsoft'
	# Microsoft Makefile specials
	syn case ignore
	syn match makeInclude	"^!\s*include\s.*$"
	syn match makePreCondit "^!\s*\(cmdswitches\|error\|message\|include\|if\|ifdef\|ifndef\|else\|else\s*if\|else\s*ifdef\|else\s*ifndef\|endif\|undef\)\>"
	syn case match
endif

# identifiers; treat $$X like $X inside makeDefine
syn match makeIdent	"\$\$\w*"
syn match makeIdent	"\$\$\$\$\w*" containedin=makeDefine
syn match makeIdent	"\$[^({]"
syn match makeIdent	"\$\$[^({]" containedin=makeDefine
if get(b:, 'make_flavor', make_flavor) == 'microsoft'
	syn region makeIdent	start="\$(" end=")" contains=makeStatement,makeAutoVar,makeIdent,makeDString,makeSString
	syn region makeIdent	start="\${" end="}" contains=makeStatement,makeAutoVar,makeIdent,makeDString,makeSString
	syn region makeIdent	start="\$\$(" end=")" containedin=makeDefine contains=makeStatement,makeAutoVar,makeIdent,makeDString,makeSString
	syn region makeIdent	start="\$\${" end="}" containedin=makeDefine contains=makeStatement,makeAutoVar,makeIdent,makeDString,makeSString
else
	syn region makeIdent	start="\$(" skip="\\)\|\\\\" end=")" contains=makeStatement,makeAutoVar,makeIdent,makeDString,makeSString
	syn region makeIdent	start="\${" skip="\\}\|\\\\" end="}" contains=makeStatement,makeAutoVar,makeIdent,makeDString,makeSString
	syn region makeIdent	start="\$\$(" skip="\\)\|\\\\" end=")" containedin=makeDefine contains=makeStatement,makeAutoVar,makeIdent,makeDString,makeSString
	syn region makeIdent	start="\$\${" skip="\\}\|\\\\" end="}" containedin=makeDefine contains=makeStatement,makeAutoVar,makeIdent,makeDString,makeSString
endif
syn match makeIdent	"^ *[^:#= \t]*\s*[:+?!*]="me=e-2 nextgroup=makeAssign
syn match makeIdent	"^ *[^:#= \t]*\s*::="me=e-3 nextgroup=makeAssign
syn match makeIdent	"^ *[^:#= \t]*\s*="me=e-1 nextgroup=makeAssign
syn match makeIdent	"%"
syn match makeAssign	contained "[:+?!*]\{0,3}="
syn match makeAutoVar	"\$[@<^*?+|%]"
syn match makeExportVar	contained "\h[[:alnum:]_.-]*\ze\s*[:+?!]*=" skipwhite nextgroup=makeAssign

# Makefile.in variables
syn match makeConfig "@[A-Za-z0-9_]\+@"

# make targets
syn match makeImplicit		"^\.[A-Za-z0-9_./\t -]\+\s*:$"me=e-1
syn match makeImplicit		"^\.[A-Za-z0-9_./\t -]\+\s*:[^=]"me=e-2

syn region makeTargetinDefine transparent matchgroup=makeTargetinDefine
			\ start="^[~A-Za-z0-9_./$(){}%-][A-Za-z0-9_./\t ${}()%-]*&\?:\?:\{1,2}[^:=]"rs=e-1
			\ end="[^\\]$"
			\ keepend
syn match makeTargetinDefine           "^[~A-Za-z0-9_./$(){}%*@-][A-Za-z0-9_./\t $(){}%*@-]*&\?::\=\s*$"
			\ contains=makeIdent,makeSpecTarget,makeComment

syn region makeTarget transparent matchgroup=makeTarget
			\ start="^[~A-Za-z0-9_./$(){}%-][A-Za-z0-9_./\t ${}()%-]*&\?:\?:\{1,2}[^:=]"rs=e-1
			\ end="[^\\]$"
			\ keepend contains=makeAutoVar,makeIdent,makeSpecTarget,makeNextLine,makeComment,makeDString
			\ skipnl nextGroup=makeCommands
syn match makeTarget           "^[~A-Za-z0-9_./$(){}%*@-][A-Za-z0-9_./\t $(){}%*@-]*&\?::\=\s*$"
			\ contains=makeIdent,makeSpecTarget,makeComment
			\ skipnl nextgroup=makeCommands,makeCommandError

syn region makeSpecTarget	transparent matchgroup=makeSpecTarget
			\ start="^\.\(SUFFIXES\|PHONY\|DEFAULT\|PRECIOUS\|IGNORE\|SILENT\|NOTPARALLEL\|POSIX\)\>\s*:\{1,2}[^:=]"rs=e-1
			\ end="[^\\]$" keepend
			\ contains=makeIdent,makeSpecTarget,makeNextLine,makeComment skipnl nextGroup=makeCommands
syn match makeSpecTarget	"^\.\(SUFFIXES\|PHONY\|DEFAULT\|PRECIOUS\|IGNORE\|SILENT\|NOTPARALLEL\|POSIX\)\>\s*::\=\s*$"
			\ contains=makeIdent,makeComment
			\ skipnl nextgroup=makeCommands,makeCommandError

if get(b:, 'make_flavor', make_flavor) == 'bsd'
	syn region makeSpecTarget	transparent matchgroup=makeSpecTarget
				\ start="^\.DELETE_ON_ERROR\>\s*:\{1,2}[^:=]"rs=e-1
				\ end="[^\\]$" keepend
				\ contains=makeIdent,makeSpecTarget,makeNextLine,makeComment skipnl nextGroup=makeCommands
	syn match makeSpecTarget	"^\.DELETE_ON_ERROR\>\s*::\=\s*$"
				\ contains=makeIdent,makeComment
				\ skipnl nextgroup=makeCommands,makeCommandError
elseif get(b:, 'make_flavor', make_flavor) == 'gnu'
	syn region makeSpecTarget	transparent matchgroup=makeSpecTarget
				\ start="^\.\(EXPORT_ALL_VARIABLES\|DELETE_ON_ERROR\|INTERMEDIATE\|KEEP_STATE\|LIBPATTERNS\|ONESHELL\|SECONDARY\)\>\s*:\{1,2}[^:=]"rs=e-1
				\ end="[^\\]$" keepend
				\ contains=makeIdent,makeSpecTarget,makeNextLine,makeComment skipnl nextGroup=makeCommands
	syn match makeSpecTarget	"^\.\(EXPORT_ALL_VARIABLES\|DELETE_ON_ERROR\|INTERMEDIATE\|KEEP_STATE\|LIBPATTERNS\|ONESHELL\|SECONDARY\)\>\s*::\=\s*$"
				\ contains=makeIdent,makeComment
				\ skipnl nextgroup=makeCommands,makeCommandError
endif

syn match makeCommandError "^\s\+\S.*" contained
syn region makeCommands contained start=";"hs=s+1 start="^\t"
			\ end="^[^\t#]"me=e-1,re=e-1 end="^$"
			\ contains=makeCmd,makeAutoVar,makeCmdNextLine,makeSpecial,makeComment,makeIdent,makePreCondit,makeDefine,makeDString,makeSString
			\ nextgroup=makeCommandError
syn match makeCmdNextLine	"\\\n."he=e-1 contained
syn match makeCmd	contained "\%(^\t\+[@+-]*\)\@20<=[[:alnum:]_./-]\+"

# some directives
syn match makeInclude	"^ *[-s]\=include\s.*$"
syn match makeExport    "^ *\(export\|unexport\)\>" skipwhite nextgroup=makeExportVar
if get(b:, 'make_flavor', make_flavor) == 'gnu'
	# Statements / Functions (GNU make)
	syn match makePreCondit	"^ *\(ifn\=\(eq\|def\)\>\|else\(\s\+ifn\=\(eq\|def\)\)\=\>\|endif\>\)"
	syn match makeStatement	"^ *vpath\>"
	syn match makeOverride	"^ *override\>" skipwhite nextgroup=makeExportVar
	syn match makeStatement contained "[({]\(abspath\|addprefix\|addsuffix\|and\|basename\|call\|dir\|error\|eval\|file\|filter-out\|filter\|findstring\|firstword\|flavor\|foreach\|guile\|if\|info\|intcmp\|join\|lastword\|let\|notdir\|or\|origin\|patsubst\|realpath\|shell\|sort\|strip\|subst\|suffix\|value\|warning\|wildcard\|word\|wordlist\|words\)\>"ms=s+1
endif

# Comment
if !exists("g:make_no_comments")
	if get(b:, 'make_flavor', make_flavor) == 'microsoft'
		syn match   makeComment	"#.*" contains=@Spell,makeTodo
	else
		syn region  makeComment	start="#" end="^$" end="[^\\]$" keepend contains=@Spell,makeTodo
		syn match   makeComment	"#$" contains=@Spell
	endif
endif
syn keyword makeTodo TODO FIXME XXX contained

syn match makeEscapedChar	"\\[^$]"

syn region  makeDString start=+\(\\\)\@<!"+  skip=+\\.+  end=+"+  contained contains=makeAutoVar,makeIdent
syn region  makeSString start=+\(\\\)\@<!'+  skip=+\\.+  end=+'+  contained contains=makeAutoVar,makeIdent
syn region  makeBString start=+\(\\\)\@<!`+  skip=+\\.+  end=+`+  contains=makeIdent,makeSString,makeDString,makeNextLine

syn sync minlines=20 maxlines=200

syn sync match makeCommandSync groupthere NONE "^[^\t#]"
syn sync match makeCommandSync groupthere makeCommands "^[A-Za-z0-9_./$()%-][A-Za-z0-9_./\t $()%-]*:\{1,2}[^:=]"
syn sync match makeCommandSync groupthere makeCommands "^[A-Za-z0-9_./$()%-][A-Za-z0-9_./\t $()%-]*:\{1,2}\s*$"

hi def link makeNextLine	makeSpecial
hi def link makeCmdNextLine	makeSpecial
hi def link makeOverride	makeStatement
hi def link makeExport	makeStatement

hi def link makeSpecTarget	Statement
if !exists("g:make_no_commands")
	hi def link makeCommands	Number
endif
hi def link makeImplicit	Function
hi def link makeTarget		Function
hi def link makeTargetinDefine		Function
hi def link makeInclude		Include
hi def link makePreCondit	PreCondit
hi def link makeStatement	Statement
hi def link makeIdent		Identifier
hi def link makeSpecial		Special
hi def link makeComment		Comment
hi def link makeDString		String
hi def link makeSString		String
hi def link makeBString		Function
hi def link makeError		Error
hi def link makeTodo		Todo
hi def link makeDefine		Define
hi def link makeCommandError	Error
hi def link makeConfig		PreCondit
hi def link makeAssign		Operator
hi def link makeAutoVar		Special
hi def link makeExportVar	Identifier
hi def link makeCmd		Statement

b:current_syntax = "make"

# vim: ts=4
