vim9script

import './SupraNotification.vim' as Notify

if executable('vala-language-server')
	system('vala-language-server --version > /dev/null 2>&1')
	if v:shell_error == 1
		au User lsp_setup call lsp#register_server({
					\ name: 'vala-language-server',
					\ cmd: (server_info) => ['vala-language-server'],
					\ allowlist: ['vala'],
					\ })
	else
		call Notify.Notification(['vala-language-server', 'Please install vala-language-server', '', 'Click on me for install it'], {type: 'error', left_click: () => {
			!suprapack add vala-language-server
		}})
	endif
endif
