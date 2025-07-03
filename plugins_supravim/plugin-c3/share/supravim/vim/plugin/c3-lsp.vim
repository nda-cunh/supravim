vim9script

import './SupraNotification.vim' as Notify

if executable('c3lsp')
	system('c3lsp --version > /dev/null 2>&1')
	if v:shell_error == 0
		au User lsp_setup call lsp#register_server({
					\ name: 'c3-lsp',
					\ cmd: (server_info) => ['c3lsp'],
					\ allowlist: ['c3', 'c3i'],
					\ })
	else
		call Notify.Notification(['c3-lsp', 'Please install c3-lsp', '', 'Click on me for install it'], {type: 'error', left_click: () => {
			!suprapack add c3lsp
		}})
	endif
endif

