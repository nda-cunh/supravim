vim9script

if executable('vala-language-server')
	au User lsp_setup call lsp#register_server({
				\ name: 'vala-language-server',
				\ cmd: (server_info) => ['vala-language-server'],
				\ allowlist: ['vala'],
				\ })
endif
