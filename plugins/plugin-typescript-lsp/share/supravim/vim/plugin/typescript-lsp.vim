vim9script

if executable('typescript-language-server')
	au User lsp_setup call lsp#register_server({
				\ name: 'typescript-language-server',                                              
				\ cmd: (server_info) => ['typescript-language-server', '--stdio'],
				\ allowlist: ['ts', 'typescript'],
				\ })
endif
