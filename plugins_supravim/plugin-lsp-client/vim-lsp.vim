vim9script

au User asyncomplete_setup call asyncomplete#register_source(asyncomplete#sources#file#get_source_options({
    \ name: 'file',
    \ allowlist: ['*'],
    \ priority: 4,
    \ completor: function('asyncomplete#sources#file#completor')
    \ }))

smap <tab>	<scriptcmd>call g:TabFunc()<cr>
imap <tab>	<scriptcmd>call g:TabFunc()<cr>
smap <expr> <S-Tab> vsnip#jumpable(-1)  ? '<Plug>(vsnip-jump-prev)'      : '<S-Tab>'
imap <expr> <S-Tab> vsnip#jumpable(-1)  ? '<Plug>(vsnip-jump-prev)'      : '<S-Tab>'

imap <c-y>	<scriptcmd>CtrlYFunc()<cr>

def g:TabFunc()
	const info = complete_info()
	if info.pum_visible
		if info.selected == -1
			feedkeys("\<c-i>", 'n')
		else
			feedkeys("\<cr>")
		endif
	else
		if vsnip#jumpable(1)
			feedkeys("\<Plug>(vsnip-jump-next)")
		else
			feedkeys("\<c-i>", 'n')
		endif
	endif
enddef

def CtrlYFunc()
	const info = complete_info()
	if info.pum_visible
		if info.selected == -1
			feedkeys("\<down>", 'n')
		endif
		feedkeys("\<cr>", 'n')
	endif
enddef


g:vsnip_snippet_dir = '$HOME/.local/share/supravim/data/snippets'
# g:lsp_log_file = '/tmp/lsp_supravim-' .. expand('$USER') .. '.log'


# Supravim LSP settings
g:sp_vim_lsp_enable = true	# enable or disable vim-lsp
g:sp_vim_lsp_code_action = false # enable or disable vim-lsp
g:sp_vim_lsp_inlay_hints_enabled = false # enable or disable inlay hints
g:sp_vim_lsp_inlay_hints_delay = 350 # delay in ms before showing inlay hints
g:sp_vim_lsp_echo_cursor_enabled = true	# enable or disable echoing diagnostics under cursor
g:sp_vim_lsp_echo_cursor_delay = 50 # enable or disable echoing diagnostics under cursor
g:sp_vim_lsp_float_cursor_enabled = false	# enable or disable floating window for diagnostics under cursor
g:sp_vim_lsp_virtual_text_enabled = false	# enable or disable virtual text for diagnostics
g:sp_vim_lsp_virtual_text_align = "below"	# can be 'after', 'right', 'below', 'above'
g:sp_vim_lsp_virtual_text_wrap = true	# wrap virtual text if too long
g:sp_vim_lsp_folding_enabled = false # enable or disable folding based on LSP

if g:sp_vim_lsp_folding_enabled
	g:lsp_fold_enabled = true
	set foldmethod=expr
	set foldexpr=lsp#ui#vim#folding#foldexpr()
	set foldtext=lsp#ui#vim#folding#foldtext()
	set nofoldenable
else
	g:lsp_fold_enabled = false 
	set foldmethod=manual
endif


def ActualizeOption()
	echom "SupraInfo: Actualizing option " .. g:supravim_option_changed .. " to " .. g:supravim_option_value
	if g:supravim_option_changed == 'vim_lsp_enable'
		if g:supravim_option_value == 'true'
			call lsp#enable()
		else
			call lsp#disable()
		endif
	endif
enddef

autocmd User SupravimChangeOption call ActualizeOption()

g:lsp_inlay_hints_enabled = g:sp_vim_lsp_inlay_hints_enabled
g:lsp_inlay_hints_delay = g:sp_vim_lsp_inlay_hints_delay

g:lsp_document_code_action_signs_enabled = g:sp_vim_lsp_code_action
g:lsp_document_code_action_signs_delay = 13
g:lsp_diagnostics_echo_cursor = g:sp_vim_lsp_echo_cursor_enabled
g:lsp_diagnostics_echo_delay = g:sp_vim_lsp_echo_cursor_delay

# test if virtual text aline is valid
if g:sp_vim_lsp_virtual_text_align != 'after' && g:sp_vim_lsp_virtual_text_align != 'right' && g:sp_vim_lsp_virtual_text_align != 'below' && g:sp_vim_lsp_virtual_text_align != 'above'
	g:sp_vim_lsp_virtual_text_align = 'below'
endif
g:lsp_diagnostics_virtual_text_align = g:sp_vim_lsp_virtual_text_align
if g:sp_vim_lsp_virtual_text_wrap
	g:lsp_diagnostics_virtual_text_wrap = "wrap"
else
	g:lsp_diagnostics_virtual_text_wrap = "truncate"
endif

g:lsp_diagnostics_virtual_text_enabled = g:sp_vim_lsp_virtual_text_enabled
g:lsp_diagnostics_signs_error = {'text': g:sp_symbol_signs}
g:lsp_diagnostics_signs_warning = {'text': g:sp_symbol_signs}
g:lsp_diagnostics_signs_information = {'text': g:sp_symbol_signs}
g:lsp_diagnostics_signs_hint = {'text': g:sp_symbol_signs}

