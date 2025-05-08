vim9script

if executable('rust-analyzer')
	au User lsp_setup call lsp#register_server({
				\ name: 'rust-analyzer',
				\ cmd: (server_info) => ['rust-analyzer'],
				\ allowlist: ['rust', 'rs'],
				\ })
endif
