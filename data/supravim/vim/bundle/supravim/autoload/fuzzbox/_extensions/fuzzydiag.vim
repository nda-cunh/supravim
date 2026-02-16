vim9script

import autoload 'fuzzbox/internal/actions.vim'
import autoload 'fuzzbox/selector.vim'

def Truc(): list<dict<any>>
   if !g:lsp_diagnostics_enabled
        call lsp#utils#error(':LspDocumentDiagnostics g:lsp_diagnostics_enabled must be enabled')
        return []
    endif

	var filtered_diagnostics = lsp#internal#diagnostics#state#_get_all_diagnostics_grouped_by_uri_and_server()

    var result = []
    for [uri, value] in items(filtered_diagnostics)
        if lsp#internal#diagnostics#state#_is_enabled_for_buffer(bufnr(lsp#utils#uri_to_path(uri)))
            for diagnostics in values(value)
                result += lsp#ui#vim#utils#diagnostics_to_loc_list({ 'response': diagnostics })
            endfor
        endif
    endfor
	return result
enddef

def CloseTab(wid: number, result: string)
	var idx = str2nr(result)
	var file = t:fuzzydiag_lst[idx].filename
	var pos = [t:fuzzydiag_lst[idx].lnum, t:fuzzydiag_lst[idx].col]
	execute 'tabedit ' .. fnameescape(file)
	cursor(pos[0], pos[1])
enddef

def CloseVSplit(wid: number, result: string)
	var idx = str2nr(result)
	var file = t:fuzzydiag_lst[idx].filename
	var pos = [t:fuzzydiag_lst[idx].lnum, t:fuzzydiag_lst[idx].col]
	execute 'vsplit ' .. fnameescape(file)
	cursor(pos[0], pos[1])
enddef

def CloseSplit(wid: number, result: string)
	var idx = str2nr(result)
	var file = t:fuzzydiag_lst[idx].filename
	var pos = [t:fuzzydiag_lst[idx].lnum, t:fuzzydiag_lst[idx].col]
	execute 'split ' .. fnameescape(file)
	cursor(pos[0], pos[1])
enddef

def Select(wid: number, result: string)
	var idx = str2nr(result)
	var file = t:fuzzydiag_lst[idx].filename
	var pos = [t:fuzzydiag_lst[idx].lnum, t:fuzzydiag_lst[idx].col]
	execute 'edit ' .. fnameescape(file)
	cursor(pos[0], pos[1])
enddef

def Preview(wid: number, result: string, opts: dict<any>)
	var idx = str2nr(result)
	var file = t:fuzzydiag_lst[idx].filename
	var pos = [t:fuzzydiag_lst[idx].lnum, t:fuzzydiag_lst[idx].col]
    actions.PreviewFile(wid, file, opts)
	clearmatches(wid)
	win_execute(wid, "silent! matchaddpos('Error', [" .. pos[0] .. ", " .. pos[1] .. "])")
	win_execute(wid, "silent! cursor(" .. pos[0] .. ", " .. pos[1] .. ")")
	win_execute(wid, 'norm! zz')
enddef


export def Start()
	var content: list<string> = []
	t:fuzzydiag_lst = Truc()

	const len_of_lst = len(t:fuzzydiag_lst) 
	if len_of_lst == 0
		echo 'No diagnostics found.'
		return
	endif
	var index = 0
	for i in t:fuzzydiag_lst
		if !filereadable(i.filename)
			continue
		endif
		const text = matchstr(i.text, '[^:]*$')
		const str = printf('%-*s│ %s:%d │ %s %s', len_of_lst / 10 + 2, index, fnamemodify(i.filename, ':t'), i.lnum, i.type, text)
		add(content, str)
		index += 1
	endfor


	var dic = selector.Start(content, {
		select_cb: Select,
		preview_cb: Preview,
		close_cb: (_) => {
			unlet t:fuzzydiag_lst
		},
		xoffset: 0.1,
		width: 0.80,
		prompt_title: 'FuzzyDiag',
		actions: {
			"\<c-t>": function('CloseTab'),
			"\<c-v>": function('CloseVSplit'),
			"\<c-s>": function('CloseSplit'),
			"\<c-q>": null_function,
		}
	})
	win_execute(dic.menu, 'setlocal syntax=fuzzbox_lsp_diag')
	hi LspDiagInfo guifg=#00afff ctermfg=75
	hi LspDiagHint guifg=#5f87ff ctermfg=111
	hi link LspDiagWarning WarningMsg 
	hi link LspDiagError ErrorMsg
	call matchadd('LspDiagError', '│ E.*$', 10000, -1, {'window': dic.menu})
	call matchadd('LspDiagWarning', '│ W.*$', 10000, -1, {'window': dic.menu})
	call matchadd('LspDiagInfo', '│ I.*$', 10000, -1, {'window': dic.menu})
	call matchadd('LspDiagHint', '│ H.*$', 10000, -1, {'window': dic.menu})

	call matchadd('Directory', '\zs[^│]*\ze │', 10000, -1, {'window': dic.menu})

enddef
