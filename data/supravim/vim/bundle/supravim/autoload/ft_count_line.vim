vim9script

const SkipQuotesAndComments = "synIDattr(synID(line('.'), col('.'), 1), 'name') =~? 'string\\|comment'"
var generation = 0

export def Ft_count_line()
	const first = line('w0')
	const last = line('w$')
	const key = [generation, bufnr(), b:changedtick, first, last]
	if get(w:, 'ft_count_line_key', []) == key
		return
	endif
	w:ft_count_line_key = key

	prop_remove({type: 'ft_count_line', all: true}, first, last)
	if last - first < 3
		return
	endif

	const view = winsaveview()
	for lnum in range(first, last)
		if getline(lnum)[0] != '}'
			continue
		endif
		cursor(lnum, 1)
		const open = searchpair('{', '', '}', 'bnW', SkipQuotesAndComments)
		if open == 0
			continue
		endif
		if stridx(getline(open), ')') == -1 && stridx(getline(open - 1), ')') == -1
			continue
		endif
		prop_add(lnum, 0, {text: '---- FUNCTION LINES: ' .. (lnum - open - 1) .. ' ----', type: 'ft_count_line', text_align: 'after', text_padding_left: 1})
	endfor
	winrestview(view)
enddef

export def EnableAugroup()
	augroup Ft_count_line
		autocmd!
		autocmd CursorMovedI,CursorMoved,WinScrolled,VimResized *.vala,*.c,*.h call Ft_count_line()
	augroup END
enddef

export def SimpleSupravimChangeOption(value: bool)
	generation += 1
	if value == true
		hi! Ft_count_line cterm=bold
		if empty(prop_type_get('ft_count_line'))
			prop_type_add('ft_count_line', {highlight: 'Ft_count_line'})
		endif
		Ft_count_line()
		EnableAugroup()
	else
		if exists('#Ft_count_line')
			autocmd! Ft_count_line
		endif
		if empty(prop_type_get('ft_count_line'))
			return
		endif
		for buf in getbufinfo({bufloaded: true})
			prop_remove({type: 'ft_count_line', bufnr: buf.bufnr, all: true})
		endfor
	endif
enddef
