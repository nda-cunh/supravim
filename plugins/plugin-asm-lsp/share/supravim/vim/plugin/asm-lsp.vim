vim9script

if executable('asm-lsp')
	au User lsp_setup call lsp#register_server({
				\ name: 'asm-lsp',                                              
				\ cmd: (server_info) => ['asm-lsp'],
				\ allowlist: ['s', 'asm', 'nasm'],
				\ })
endif
