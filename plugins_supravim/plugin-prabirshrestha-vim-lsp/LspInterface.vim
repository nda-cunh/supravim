vim9script

import autoload 'SupraPop/Input.vim' as PopupInput

export def AddLspServer(name: string, cmd: list<string>, filetypes: list<string>)
	silent! lsp#register_server({
		name: name,
		cmd: (_) => cmd,
		allowlist: filetypes,
		initialization_options: {
			'ui.semanticTokens': true,
		},
	})
	silent! lsp#activate()
enddef

export def LspServerActivate()
	silent! lsp#activate()
enddef

export def RenameSymbol()
	const bufnr = bufnr('%')
	const position = {line: line('.') - 1, character: strutf16len(strpart(getline('.'), 0, col('.') - 1))}
	const cword = expand('<cword>')
	const servers = lsp#get_allowed_servers()->filter((_, s) => lsp#capabilities#has_rename_provider(s))

	if empty(servers)
		OpenRenamePopup(cword, (name) => RenameInBuffer(cword, name))
		return
	endif

	const server = servers[0]
	if !lsp#capabilities#has_rename_prepare_provider(server)
		OpenRenamePopup(cword, (name) => SendRename(server, bufnr, position, name))
		return
	endif

	lsp#send_request(server, {
		method: 'textDocument/prepareRename',
		params: {
			textDocument: lsp#get_text_document_identifier(bufnr),
			position: position,
		},
		bufnr: bufnr,
		on_notification: (data) => OnPrepareRename(server, bufnr, position, cword, data),
	})
enddef

def OpenRenamePopup(default: string, Callback: func(string))
	var popup = PopupInput.Input.new({width: 16, prompt: '➜ ', title_pos: 'left', title: '󰑕 Rename', line: "cursor-3", col: "cursor+1", moved: 'WORD'})
	popup.SetInput(default)
	popup.AddEventInputEnter((p) => {
		const name = p.GetInput()
		popup.Close()
		if empty(name) || name ==# default
			return
		endif
		Callback(name)
	})
enddef

def RenameInBuffer(old: string, name: string)
	if empty(old)
		return
	endif
	const view = winsaveview()
	silent! execute $'keeppatterns :%s/\V\<{escape(old, '/\')}\>/{escape(name, '/\&~')}/g'
	winrestview(view)
	silent! update
enddef

def ResponseError(data: any): string
	if type(data) != v:t_dict || !has_key(data, 'response')
		return string(data)
	endif
	if lsp#client#is_error(data.response)
		return lsp#client#error_message(data.response)
	endif
	return ''
enddef

def OnPrepareRename(server: string, bufnr: number, position: dict<any>, cword: string, data: any)
	const err = ResponseError(data)
	if !empty(err)
		lsp#utils#error($'Rename: {err}')
		return
	endif

	const result = get(data.response, 'result', v:null)
	if type(result) != v:t_dict || empty(result)
		lsp#utils#warning('Rename: nothing to rename here')
		return
	endif

	var default = cword
	if !empty(get(result, 'placeholder', ''))
		default = result.placeholder
	elseif has_key(result, 'start') || has_key(result, 'range')
		const range = get(result, 'range', result)
		if range.start.line == range.end.line
			const text = get(getbufline(bufnr, range.start.line + 1), 0, '')
			const s = LspCharToByte(text, range.start.character)
			const e = LspCharToByte(text, range.end.character)
			default = strpart(text, s, e - s)
		endif
	endif

	timer_start(0, (_) => OpenRenamePopup(default, (name) => SendRename(server, bufnr, position, name)))
enddef

def SendRename(server: string, bufnr: number, position: dict<any>, name: string)
	lsp#send_request(server, {
		method: 'textDocument/rename',
		params: {
			textDocument: lsp#get_text_document_identifier(bufnr),
			position: position,
			newName: name,
		},
		bufnr: bufnr,
		on_notification: (data) => OnRename(data),
	})
enddef

def OnRename(data: any)
	const err = ResponseError(data)
	if !empty(err)
		lsp#utils#error($'Rename: {err}')
		return
	endif

	const result = get(data.response, 'result', v:null)
	if type(result) != v:t_dict || empty(result)
		lsp#utils#warning('Rename: the server returned no changes')
		return
	endif

	const view = winsaveview()
	const changed = ApplyWorkspaceEdit(result)
	winrestview(view)
	silent! wall
	echo $'Renamed: {changed} file(s) modified'
enddef

def ApplyWorkspaceEdit(edit: dict<any>): number
	var count = 0
	if type(get(edit, 'documentChanges', v:null)) == v:t_list
		for change in edit.documentChanges
			if has_key(change, 'kind')
				lsp#utils#warning($'Rename: resource operation "{change.kind}" ignored')
				continue
			endif
			ApplyTextEdits(change.textDocument.uri, change.edits)
			count += 1
		endfor
	elseif type(get(edit, 'changes', v:null)) == v:t_dict
		for [uri, edits] in items(edit.changes)
			ApplyTextEdits(uri, edits)
			count += 1
		endfor
	endif
	return count
enddef

def LspCharToByte(text: string, character: number): number
	if character <= 0
		return 0
	endif
	const idx = byteidx(text, character, true)
	return idx < 0 ? len(text) : idx
enddef

def ApplyTextEdits(uri: string, edits: list<dict<any>>)
	if empty(edits)
		return
	endif

	const bufnr = bufadd(lsp#utils#uri_to_path(uri))
	bufload(bufnr)
	setbufvar(bufnr, '&buflisted', true)

	const last = len(getbufline(bufnr, 1, '$'))
	var resolved: list<dict<any>> = []
	for edit in edits
		var sl = edit.range.start.line + 1
		var el = edit.range.end.line + 1
		var sline = get(getbufline(bufnr, sl), 0, '')
		var eline = get(getbufline(bufnr, el), 0, '')
		var sc = LspCharToByte(sline, edit.range.start.character)
		var ec = LspCharToByte(eline, edit.range.end.character)
		if el > last
			el = last
			eline = get(getbufline(bufnr, el), 0, '')
			ec = len(eline)
		endif
		if sl > last
			sl = last
			sline = eline
			sc = len(sline)
		endif
		resolved->add({sl: sl, sc: sc, el: el, ec: ec, text: edit.newText})
	endfor

	sort(resolved, (a, b) => a.sl != b.sl ? b.sl - a.sl : b.sc - a.sc)

	for r in resolved
		const prefix = strpart(get(getbufline(bufnr, r.sl), 0, ''), 0, r.sc)
		const suffix = strpart(get(getbufline(bufnr, r.el), 0, ''), r.ec)
		var lines = split(substitute(r.text, "\r\n\\=", "\n", 'g'), "\n", true)
		lines[0] = prefix .. lines[0]
		lines[-1] = lines[-1] .. suffix

		const old_count = r.el - r.sl + 1
		const new_count = len(lines)
		if new_count < old_count
			deletebufline(bufnr, r.sl + new_count, r.el)
		elseif new_count > old_count
			appendbufline(bufnr, r.el, lines[old_count : ])
		endif
		setbufline(bufnr, r.sl, lines[: min([old_count, new_count]) - 1])
	endfor
enddef

# --- Helper internal functions ---
def HasCapability(capability: string): bool
    for server in lsp#get_allowed_servers()
        if lsp#get_server_capabilities(server)[capability]
            return true
        endif
    endfor
    return false
enddef

# --- Navigation ---

export def LspDefinition()
    LspDefinition
enddef

export def LspDeclaration()
    LspDeclaration
enddef

export def LspTypeDefinition()
    LspTypeDefinition
enddef

export def LspReferences()
    LspReferences
enddef

export def LspImplementation()
    LspImplementation
enddef

# --- Help and Documentation ---

export def LspHover()
    LspHover
enddef

export def LspSignatureHelp()
    LspSignatureHelp
enddef

# --- Actions and Correction ---

export def LspCodeAction()
    LspCodeAction
enddef

export def LspFormat()
    if HasCapability('documentFormattingProvider')
        LspDocumentFormatSync
    else
        var view = winsaveview()
        normal! gg=G
        winrestview(view)
        echo "SupraVim: native formatting (LSP not supported)"
    endif
enddef

# --- Diagnostics ---

export def LspNextDiagnostic()
    LspNextDiagnostic
enddef

export def LspPrevDiagnostic()
    LspPreviousDiagnostic
enddef

export def LspShowDiagnostics()
    LspDocumentDiagnostics
enddef

# --- Symboles ---

export def LspDocumentSymbol()
    LspDocumentSymbol
enddef

export def LspWorkspaceSymbol()
    # On demande souvent une recherche via l'argument
    var query = input('Search Workspace Symbol: ')
    if query != ''
        execute 'LspWorkspaceSymbol ' .. query
    endif
enddef

const Markdown = vital#lsp#import('VS.Vim.Syntax.Markdown')
const MarkupContent = vital#lsp#import('VS.LSP.MarkupContent')
const FloatingWindow = vital#lsp#import('VS.Vim.Window.FloatingWindow')
const Window = vital#lsp#import('VS.Vim.Window')
const Buffer = vital#lsp#import('VS.Vim.Buffer')

export def BalloonPopup(): string
	const servers = filter(lsp#get_allowed_servers(), 'lsp#capabilities#has_hover_provider(v:val)')
	const pos = {'character': v:beval_col - 1, 'line': v:beval_lnum - 1}
	const request = {
        'method': 'textDocument/hover',
		'params': {
			'textDocument': lsp#get_text_document_identifier(),
			'position': pos,
		},
	}

	lsp#callbag#pipe(
		lsp#callbag#fromList(servers),
		lsp#callbag#flatMap((server) => {
			return lsp#request(server, request)
		}),
		lsp#callbag#tap((x) => {
		}),
		lsp#callbag#takeUntil(lsp#callbag#pipe(
			lsp#stream(),
			lsp#callbag#filter((x) => has_key(x, 'command'))
		)),
		lsp#callbag#subscribe({
			next: (x) => {
				try
				call Show_hover(x.server_name, x.request, x.response)
				catch
					echo "Error showing hover: " .. v:exception
				endtry
            },
		})
	)
	return '' 
enddef

var id_popup: number = -1

def Show_hover(server_name: string, request: dict<any>, response: dict<any>)
    if !has_key(response, 'result') || empty(response.result) || empty(response.result.contents)
        return
    endif

    var contents = GetContents(response.result.contents)

    if empty(contents)
        return
    endif

    var lines = lsp#utils#_split_by_eol(join(contents, "\n\n"))

    if id_popup > 0 && popup_getoptions(id_popup) != {}
        popup_close(id_popup)
    endif

	var maxwidth: number
    if g:lsp_float_max_width >= 1
        maxwidth = g:lsp_float_max_width
    elseif g:lsp_float_max_width == 0
        maxwidth = &columns
    else
        maxwidth = float2nr(&columns * 0.4)
    endif
    var maxheight = float2nr(&lines * 0.4)

	var spos = screenpos(v:beval_winid, v:beval_lnum, v:beval_col)
	var show_above = spos.row > (&lines / 2)
	var target_col = spos.col
    if (target_col + maxwidth) > &columns
        target_col = &columns - maxwidth - 2
	endif

    id_popup = popup_create(lines, {
		line: show_above ? spos.row - 1 : spos.row + 1,
        col: target_col,
		maxwidth: maxwidth,
		maxheight: maxheight,
        padding: [0, 0, 0, 0],
        border: [1],
        borderchars: ['─', '│', '─', '│', '╭', '╮', '╯', '╰'],
        zindex: 300,
        wrap: 1,
        fixed: 1,
        mousemoved: [v:beval_lnum, v:beval_col, v:beval_col],
    })

	# close the popup if mode changed 
	augroup SupraLspHoverPopup
		autocmd! * <buffer>
		autocmd ModeChanged <buffer> if mode() !=# 'n' | silent! call popup_close(id_popup) | endif
		autocmd CursorMoved <buffer> silent! call popup_close(id_popup)
	augroup END

    if id_popup > 0
        var bnr = winbufnr(id_popup)

        setbufvar(bnr, '&buftype', 'nofile')
        setbufvar(bnr, '&bufhidden', 'hide')
        setbufvar(bnr, '&bufhidden', 'hide')

        Window.do(id_popup, () => {
			Markdown.apply()
			setlocal conceallevel=3
			setlocal concealcursor=niv
        })

		setwinvar(id_popup, '&textwidth', 80)
        Window.do(id_popup, () => {
			silent! :global/^/normal! gqgq
			silent normal! gg
        })
    endif
enddef

def GetContents(contents: any): list<string> 
    if type(contents) == type('')
        return [contents]
    elseif type(contents) == type([])
        var result = []
        for content in contents
            result += GetContents(content)
        endfor
        return result
    elseif type(contents) == type({})
        if has_key(contents, 'value')
            if has_key(contents, 'kind')
                if contents['kind'] ==? 'markdown'
                    const detail = MarkupContent.normalize(contents['value'], {
						'compact': !g:lsp_preview_fixup_conceal
                    })
                    return [detail]
                else
                    return [contents['value']]
                endif
            elseif has_key(contents, 'language')
                const detail = MarkupContent.normalize(contents, {
					'compact': !g:lsp_preview_fixup_conceal
                })
                return [detail]
            else
                return ['']
            endif
        else
            return ['']
        endif
    else
        return ['']
    endif
enddef
