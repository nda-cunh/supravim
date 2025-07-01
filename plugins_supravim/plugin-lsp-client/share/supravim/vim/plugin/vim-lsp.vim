vim9script

import './SupraNotification.vim' as Notify

if executable('lsp_c')
	system('lsp_c --version 1>/dev/null 2> /dev/null')

	if v:shell_error == 42
		call Notify.Notification(['Compiler C not found !', '', 'try install clangd or ccls', 'from your package manager'], {type: 'error'})
	elseif v:shell_error != 0
		call Notify.Notification(['Compiler C crash !', '', 'try install clangd or ccls', 'from your package manager'], {type: 'error'})
	else
		au User lsp_setup call lsp#register_server({
			\ name: 'lsp_c',
			\ cmd: (server_info) => ['lsp_c'],
			\ allowlist: ['cpp', 'c', 'tpp'],
		\ })
	endif
endif

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
g:lsp_diagnostics_signs_error = {'text': '✖'}
g:lsp_diagnostics_signs_warning = {'text': '✖'}
# g:lsp_diagnostics_signs_error = {'text': '┃'}
# g:lsp_diagnostics_signs_warning = {'text': '┃'}

au BufNewFile,BufRead *.s set filetype=asm

var lst = {
	rust: {
		name: 'plugin-rust-lsp',
		binary: 'rust-analyzer',
		help: "SupraVim can\'t found the server !\n~~~\nsuprapack add rust-analyzer\n~~~\n",
	},
	python: {
		name: 'plugin-python-lsp',
		binary: 'pylsp',
		help: "SupraVim can't found the server !\n~~~\npipx install pylsp\n~~~\nuse pipx or pip",
	},
	vala: {
		name: 'plugin-vala-lsp',
		binary: 'vala-language-server',
		help: "SupraVim can't found the server !\n~~~\nsuprapack add vala-language-server\n~~~\n",
	},
	typescript: {
		name: 'plugin-typescript-lsp',
		binary: 'typescript-language-server',
		help: "SupraVim can't found the server !\n~~~\nnpm install -g typescript-language-server typescript"
	},
	meson: {
		name: 'plugin-meson-lsp',
		binary: 'meson-lsp',
		help: "SupraVim can't found the server !\n~~~\nsuprapack add meson-lsp\n~~~\n",
	},
	cs: {
		name: 'plugin-csharp-lsp',
			binary: '',
		help: '',
	},
	asm: {
		name: 'plugin-asm-lsp',
		binary: '',
		help: '',
	},
}
var all_plugin: string = ''

autocmd BufEnter * call HelpPlugin() 
def HelpPlugin()
	if all_plugin == ''
		all_plugin = system("suprapack list 'plugin-.*-lsp'")
	endif
	var type = &filetype
	if has_key(lst, type)
		var plugin = lst[type]
		if stridx(all_plugin, plugin.name) == -1
			call Notify.Notification([plugin.name .. ' not found !', '', 'install with (suprapack add ' .. plugin.name .. ')', 'Or click on me :)'], {
				type: 'package',
				left_click: () => {
					execute ('!suprapack add ' .. plugin.name)
				},
			})
		else
			if plugin.binary == ''
				return
			endif
			if executable(plugin.binary) != 1
				call Notify.Notification(['', '', plugin.help], {type: 'error'})
			endif
		endif
	endif
enddef
