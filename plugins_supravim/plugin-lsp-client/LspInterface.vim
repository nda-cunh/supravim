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

export def AutoLspHold()
	# var c_pos = getcurpos()
	# var m_pos = getmousepos()
	# var cm = m_pos.column
	# var lm = m_pos.line
	# var cc = c_pos[2]
	# var lc = c_pos[1]
	# if cm == cc && lm == lc
		# var word = expand('<cword>')
		# if word != ''
			# silent! LspHover
		# endif
	# endif
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
