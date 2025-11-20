vim9script

au User asyncomplete_setup call asyncomplete#register_source(asyncomplete#sources#file#get_source_options({
    \ name: 'file',
    \ allowlist: ['*'],
    \ priority: 4,
    \ completor: function('asyncomplete#sources#file#completor')
    \ }))
smap <expr> <Tab>   vsnip#jumpable(1)   ? '<Plug>(vsnip-jump-next)'      : '<Tab>'
smap <expr> <S-Tab> vsnip#jumpable(-1)  ? '<Plug>(vsnip-jump-prev)'      : '<S-Tab>'
imap <expr> <S-Tab> vsnip#jumpable(-1)  ? '<Plug>(vsnip-jump-prev)'      : '<S-Tab>'

imap <c-y>	<scriptcmd>CtrlYFunc()<cr>
imap <tab>	<scriptcmd>call g:TabFunc()<cr>

def g:TabFunc()
	const info = complete_info()
	if info.pum_visible
		echom info.selected
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
		echom info.selected
		if info.selected == -1
			feedkeys("\<down>", 'n')
		endif
		feedkeys("\<cr>", 'n')
	endif
enddef

g:vsnip_snippet_dir = '$HOME/.local/share/supravim/data/snippets'
# g:lsp_log_file = '/tmp/lsp_supravim-' .. expand('$USER') .. '.log'
g:lsp_document_code_action_signs_enabled = 0
g:lsp_diagnostics_echo_cursor = 1
g:lsp_diagnostics_echo_delay = 50
g:lsp_diagnostics_virtual_text_enabled = 0
g:lsp_diagnostics_signs_error = {'text': g:sp_symbol_signs}
g:lsp_diagnostics_signs_warning = {'text': g:sp_symbol_signs}
g:lsp_diagnostics_signs_information = {'text': g:sp_symbol_signs}
g:lsp_diagnostics_signs_hint = {'text': g:sp_symbol_signs}
