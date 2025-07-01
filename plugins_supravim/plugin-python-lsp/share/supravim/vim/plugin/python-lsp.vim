vim9script

if executable('pylsp')
	au User lsp_setup call lsp#register_server({
				\ name: 'pylsp',                                              
				\ cmd: (server_info) => ['pylsp'],
				\ allowlist: ['py', 'python'],
				\ })
endif
