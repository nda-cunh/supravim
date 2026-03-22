vim9script

import autoload 'SupraPopup.vim' as Popup

export def AddLspServer(name: string, cmd: list<string>, filetypes: list<string>)
	silent! lsp#register_server({
		name: name,
		cmd: (_) => cmd,
		allowlist: filetypes,
	})
	silent! lsp#activate()
enddef

export def LspServerActivate()
	silent! lsp#activate()
enddef

export def RenameSymbol()
	const line_pt = line('.')
	const col_pt = col('.')
	var all_servers = lsp#get_allowed_servers()
	var can_rename_lsp = false
	for server in all_servers
		var value = lsp#capabilities#has_rename_provider(server)
		if value == 1
			can_rename_lsp = true
			break
		endif
	endfor

	var popup = Popup.Input({width: 16, prompt: '➜ ', title_pos: 'left', title: '󰑕 Rename', line: "cursor-3", col: "cursor+1", moved: 'WORD'})
	var cword = expand('<cword>')
	popup->Popup.SetInput(cword)

	if can_rename_lsp == false
		popup->Popup.AddEventInputEnter((line: string) => {
			Popup.Close(popup)
			silent! execute ':%s/' .. cword .. '/' .. line .. '/g'
			w!
		})
		return
	else
		popup->Popup.AddEventInputEnter((line: string) => {
			Popup.Close(popup)
			feedkeys("\<esc>:LspRename\<cr>", "n")
			timer_start(100, (_) => {
				var i = strcharlen(expand('<cword>'))
				for j in range(0, i - 1)
					feedkeys("\<bs>", "n")
				endfor
				feedkeys(line .. "\<cr>", "n")
				timer_start(500, (_) => {
					wall!
				})
			})
		})
	endif
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
        echo "SupraVim: Formatage natif (LSP non supporté)"
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
