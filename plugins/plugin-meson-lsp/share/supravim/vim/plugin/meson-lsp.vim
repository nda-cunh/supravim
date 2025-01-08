vim9script

if executable('meson-lsp')
	au User lsp_setup call lsp#register_server({
				\ name: 'meson-lsp',                                              
				\ cmd: (server_info) => ['meson-lsp', '--lsp'],
				\ allowlist: ['meson', 'build'],
				\ })
endif
