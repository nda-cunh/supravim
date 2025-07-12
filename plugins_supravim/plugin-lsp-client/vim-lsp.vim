vim9script

au User asyncomplete_setup call asyncomplete#register_source(asyncomplete#sources#file#get_source_options({
    \ name: 'file',
    \ allowlist: ['*'],
    \ priority: 2,
    \ completor: function('asyncomplete#sources#file#completor')
    \ }))

imap <expr> <Tab>   vsnip#jumpable(1)   ? '<Plug>(vsnip-jump-next)'      : '<Tab>'
smap <expr> <Tab>   vsnip#jumpable(1)   ? '<Plug>(vsnip-jump-next)'      : '<Tab>'
imap <expr> <S-Tab> vsnip#jumpable(-1)  ? '<Plug>(vsnip-jump-prev)'      : '<S-Tab>'
smap <expr> <S-Tab> vsnip#jumpable(-1)  ? '<Plug>(vsnip-jump-prev)'      : '<S-Tab>'

g:vsnip_snippet_dir = '$HOME/.local/share/supravim/data/snippets'
g:lsp_log_file = '/tmp/lsp_supravim-' .. expand('$USER') .. '.log'
g:lsp_document_code_action_signs_enabled = 0
g:lsp_diagnostics_echo_cursor = 1
g:lsp_diagnostics_echo_delay = 50
g:lsp_diagnostics_virtual_text_enabled = 0
g:lsp_diagnostics_signs_error = {'text': g:sp_symbol_signs}
g:lsp_diagnostics_signs_warning = {'text': g:sp_symbol_signs}
# g:lsp_diagnostics_signs_error = {'text': '✖'}
# g:lsp_diagnostics_signs_warning = {'text': '✖'}
