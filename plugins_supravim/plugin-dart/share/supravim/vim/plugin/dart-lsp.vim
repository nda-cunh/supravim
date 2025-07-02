vim9script

if executable('dart')
	au User lsp_setup call lsp#register_server({
				\ name: 'dart',
				\ cmd: (server_info) => ['dart', 'language-server'],
				\ allowlist: ['dart'],
				\ })
endif
