vim9script

import autoload '../autoload/SupraNotification.vim' as Notify
import autoload '../autoload/SupraCopy.vim' as SupraCopy 

if !exists('g:SUPRA_CLIP')
	g:SUPRA_CLIP = []
endif

inoremap <c-v>	<C-R>+
nnoremap <del>  "_x
vnoremap <del> "_d
vnoremap <c-c>	y

augroup UpdateYankRegistersGroup
    autocmd!
    autocmd TextYankPost * call SupraCopy.UpdateYankRegisters()
augroup END

var session_type = expand("$XDG_SESSION_TYPE")

if has('macunix')
    autocmd TextYankPost * call SupraCopy.SetClipBoardExtern(['pbcopy'])
    autocmd FocusGained,VimEnter * call SupraCopy.LoadRegisterFromExtern(['pbpaste'])
	command UpdateClipboard call SupraCopy.SetClipBoardExtern(['pbcopy'])
elseif session_type == 'x11'
	if has('clipboard') && has('X11')
		# Use system clipboard if available
		autocmd TextYankPost * call SupraCopy.SetClipBoardExtern([])
		autocmd FocusGained,VimEnter * call SupraCopy.LoadRegisterFromExtern([])
		command UpdateClipboard call SupraCopy.SetClipBoardExtern([])
	else
		set clipboard=
		if executable('xclip') == 0
			call Notify.Notification(["xclip not found", "Please install xclip for copy/paste support"], {type: 'error'})
		else
			autocmd TextYankPost * call SupraCopy.SetClipBoardExtern(['xclip', '-i', '-selection', 'clipboard'])
			autocmd FocusGained,VimEnter * call SupraCopy.LoadRegisterFromExtern(['xclip', '-o', '-selection', 'clipboard'])
			command UpdateClipboard call SupraCopy.SetClipBoardExtern(['xclip', '-i', '-selection', 'clipboard'])
		endif
	endif
elseif session_type == 'wayland'
	if has('clipboard') && has('wayland_clipboard')
		# Use system clipboard if available
		autocmd TextYankPost * call SupraCopy.SetClipBoardExtern([])
		autocmd FocusGained,VimEnter * call SupraCopy.LoadRegisterFromExtern([])
		command UpdateClipboard call SupraCopy.SetClipBoardExtern([])
	else
		set clipboard=
		if executable('wl-copy') == 0
			call Notify.Notification(["wl-copy not found", "Please install wl-clipboard for copy/paste support"], {type: 'error'})
		else
			autocmd TextYankPost * call SupraCopy.SetClipBoardExtern(['wl-copy', '-n'])
			autocmd FocusGained,VimEnter * call SupraCopy.LoadRegisterFromExtern(['wl-paste'])
			command UpdateClipboard call SupraCopy.SetClipBoardExtern(['wl-copy', '-n'])
		endif
	endif
endif
