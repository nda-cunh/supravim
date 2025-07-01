vim9script
if executable('blueprint-compiler')
	au User lsp_setup call lsp#register_server({
				\ name: 'blueprint-compiler',                                              
				\ cmd: (server_info) => ['blueprint-compiler', 'lsp'],
				\ allowlist: ['blp', 'bp', 'blueprint'],
				\ })
endif
