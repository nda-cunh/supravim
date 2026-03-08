vim9script noclear

if exists("g:loaded_suprahighlight") | finish | endif
g:loaded_suprahighlight = true

highlight PerfComment guifg=#61afef
highlight HackComment guifg=#ee6666
highlight TodoComment guifg=#c678dd
highlight WarningComment guifg=#e5c07b
highlight NoteComment guifg=#98c379
highlight FixComment guifg=#e06c75

autocmd WinEnter,VimEnter,BufEnter,BufWinEnter * call SupraHighlight()

const SLASH_COMMENT = 1
const DASH_COMMENT = 2
const PERCENT_COMMENT = 3

const comment_style: dict<number> = {
	actionscript: SLASH_COMMENT,
	ada: DASH_COMMENT,
	applescript: DASH_COMMENT,
	blade: SLASH_COMMENT,
	c: SLASH_COMMENT,
	cg: SLASH_COMMENT,
	cpp: SLASH_COMMENT,
	cs: SLASH_COMMENT,
	css: SLASH_COMMENT,
	cuda: SLASH_COMMENT,
	d: SLASH_COMMENT,
	dart: SLASH_COMMENT,
	elm: DASH_COMMENT,
	erlang: PERCENT_COMMENT,
	fsharp: SLASH_COMMENT,
	glsl: SLASH_COMMENT,
	go: SLASH_COMMENT,
	gradle: SLASH_COMMENT,
	groovy: SLASH_COMMENT,
	haskell: DASH_COMMENT,
	haxe: SLASH_COMMENT,
	hcl: SLASH_COMMENT,
	hlsl: SLASH_COMMENT,
	java: SLASH_COMMENT,
	javascript: SLASH_COMMENT,
	javascriptreact: SLASH_COMMENT,
	jenkinsfile: SLASH_COMMENT,
	jinja: SLASH_COMMENT,
	jsonc: SLASH_COMMENT,
	kotlin: SLASH_COMMENT,
	latex: PERCENT_COMMENT,
	less: SLASH_COMMENT,
	lua: DASH_COMMENT,
	matlab: PERCENT_COMMENT,
	mysql: DASH_COMMENT,
	objc: SLASH_COMMENT,
	objcpp: SLASH_COMMENT,
	ocaml: SLASH_COMMENT,
	octave: PERCENT_COMMENT,
	php: SLASH_COMMENT,
	plsql: DASH_COMMENT,
	postgresql: DASH_COMMENT,
	postscr: PERCENT_COMMENT,
	prolog: PERCENT_COMMENT,
	proto: SLASH_COMMENT,
	purs: DASH_COMMENT,
	rust: SLASH_COMMENT,
	sass: SLASH_COMMENT,
	scala: SLASH_COMMENT,
	scss: SLASH_COMMENT,
	solidity: SLASH_COMMENT,
	sql: DASH_COMMENT,
	stylus: SLASH_COMMENT,
	swift: SLASH_COMMENT,
	systemverilog: SLASH_COMMENT,
	terraform: SLASH_COMMENT,
	tex: PERCENT_COMMENT,
	typescript: SLASH_COMMENT,
	typescriptreact: SLASH_COMMENT,
	vala: SLASH_COMMENT,
	verilog: SLASH_COMMENT,
	vhdl: DASH_COMMENT,
	zig: SLASH_COMMENT,
}

def SupraHighlight()
	if exists("w:supra_match_ids")
		for m_id in w:supra_match_ids | silent! matchdelete(m_id) | endfor
	endif
	w:supra_match_ids = []

	const filetype = &filetype
	const style = get(comment_style, filetype, 0)

	if style == SLASH_COMMENT
		AddMatches('//')
	elseif style == DASH_COMMENT
		AddMatches('--')
	elseif style == PERCENT_COMMENT
		AddMatches('%')
	else
		AddMatches('#')
	endif
enddef

def AddMatches(prefix: string)
	add(w:supra_match_ids, matchadd('WarningComment', '\c' .. prefix .. '\s*WARN\(ING\)\?\($\|\W\).*$'))
	add(w:supra_match_ids, matchadd('NoteComment', '\c' .. prefix .. '\s*NOTE\($\|\W\).*$'))
	add(w:supra_match_ids, matchadd('FixComment', '\c' .. prefix .. '\s*FIX\(ME\)\?\($\|\W\).*$'))
	add(w:supra_match_ids, matchadd('TodoComment', '\c' .. prefix .. '\s*TODO\($\|\W\).*$'))
	add(w:supra_match_ids, matchadd('HackComment', '\c' .. prefix .. '\s*HACK\($\|\W\).*$'))
	add(w:supra_match_ids, matchadd('PerfComment', '\c' .. prefix .. '\s*\(PERF\|OPTIMIZE\)\($\|\W\).*$'))
	add(w:supra_match_ids, matchadd('NoteComment', 'https\?://[a-zA-Z0-9./?=_-]\+'))
	add(w:supra_match_ids, matchadd('PerfComment', '\<\d\+\(ms\|s\|fps\)\>'))
enddef
