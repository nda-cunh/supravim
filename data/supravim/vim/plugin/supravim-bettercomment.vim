vim9script

highlight PerfComment guifg=#61afef
highlight HackComment guifg=#ee6666
highlight TodoComment guifg=#c678dd
highlight WarningComment guifg=#e5c07b
highlight NoteComment guifg=#98c379
highlight FixComment guifg=#e06c75

autocmd WinEnter,VimEnter,BufEnter,BufWinEnter * call SupraHighlight()

const SLASH_COMMENT = 1

const comment_style: dict<number> = {
	c: SLASH_COMMENT,
	cs: SLASH_COMMENT,
	cpp: SLASH_COMMENT,
	java: SLASH_COMMENT,
	javascript: SLASH_COMMENT,
	typescript: SLASH_COMMENT,
	rust: SLASH_COMMENT,
	vala: SLASH_COMMENT,
}

def SupraHighlight()
	if exists("w:SupraHightLight")
		return
	endif
	w:SupraHightLight = true
	const filetype = &filetype

	if has_key(comment_style, filetype)
		const style = comment_style[filetype]
		if style == SLASH_COMMENT
			call HightLightSlashComments()
		endif
	else
		call HightLightDieseComments()
	endif
enddef

def HightLightSlashComments()
	matchadd('WarningComment', '//\s*WARN\(ING\)\?\W.*$')
	matchadd('NoteComment', '//\s*NOTE\W.*$')
	matchadd('FixComment', '//\s*FIX\(ME\)\?\W.*$')
	matchadd('TodoComment', '//\s*TODO\W.*$')
	matchadd('HackComment', '//\s*HACK\W.*$')
	matchadd('PerfComment', '//\s*PERF\W.*$')
	matchadd('PerfComment', '//\s*\(OPTIMIZE\|PERF\)\W.*$')
enddef

def HightLightDieseComments()
	matchadd('WarningComment', '#\s*WARN\(ING\)\?\W.*$')
	matchadd('NoteComment', '#\s*NOTE\W.*$')
	matchadd('FixComment', '#\s*FIX\(ME\)\?\W.*$')
	matchadd('TodoComment', '#\s*TODO\W.*$')
	matchadd('HackComment', '#\s*HACK\W.*$')
	matchadd('PerfComment', '#\s*\(PERF\|OPTIMIZE\)\W.*$')
enddef
