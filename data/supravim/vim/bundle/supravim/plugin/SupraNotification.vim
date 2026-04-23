vim9script

import autoload 'SupraNotification.vim' as Notify

autocmd VimResized * call Notify.RepositionNotifications()
# Simple notification global function
def g:SupraNotification(msg: list<string>, opts: dict<any> = {})
	call Notify.Notification(msg, opts)
enddef
