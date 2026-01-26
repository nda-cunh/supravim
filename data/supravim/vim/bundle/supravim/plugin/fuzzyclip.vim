vim9script

import autoload 'suprafuzzy/fuzzyclip.vim' as FuzzyClip
import autoload 'SupraNotification.vim' as Notify

command FuzzyClip call FuzzyClip.Start()

if !exists('g:SUPRA_CLIP')
	g:SUPRA_CLIP = []
endif

inoremap <c-v>	<scriptcmd>norm p<cr>
nnoremap <del> i<del><right><esc>
vnoremap <c-c>	y

augroup UpdateYankRegistersGroup
    autocmd!
    autocmd TextYankPost * call FuzzyClip.UpdateYankRegisters()
augroup END

var session_type = expand("$XDG_SESSION_TYPE")

if has('macunix')
    autocmd TextYankPost * call FuzzyClip.SetClipBoardExtern(['pbcopy'])
    autocmd FocusGained,VimEnter * call FuzzyClip.LoadRegisterFromExtern(['pbpaste'])
	command UpdateClipboard call FuzzyClip.SetClipBoardExtern(['pbcopy'])
elseif session_type == 'x11'
	if has('clipboard') && has('X11')
		# Use system clipboard if available
		autocmd TextYankPost * call FuzzyClip.SetClipBoardExtern([])
		autocmd FocusGained,VimEnter * call FuzzyClip.LoadRegisterFromExtern([])
		command UpdateClipboard call FuzzyClip.SetClipBoardExtern([])
	else
		set clipboard=
		if executable('xclip') == 0
			call Notify.Notification(["xclip not found", "Please install xclip for copy/paste support"], {type: 'error'})
		else
			autocmd TextYankPost * call FuzzyClip.SetClipBoardExtern(['xclip', '-i', '-selection', 'clipboard'])
			autocmd FocusGained,VimEnter * call FuzzyClip.LoadRegisterFromExtern(['xclip', '-o', '-selection', 'clipboard'])
			command UpdateClipboard call FuzzyClip.SetClipBoardExtern(['xclip', '-i', '-selection', 'clipboard'])
		endif
	endif
elseif session_type == 'wayland'
	if has('clipboard') && has('wayland_clipboard')
		# Use system clipboard if available
		autocmd TextYankPost * call FuzzyClip.SetClipBoardExtern([])
		autocmd FocusGained,VimEnter * call FuzzyClip.LoadRegisterFromExtern([])
		command UpdateClipboard call FuzzyClip.SetClipBoardExtern([])
	elseif expand("$XDG_SESSION_TYPE") == "wayland"
		set clipboard=
		if executable('wl-copy') == 0
			call Notify.Notification(["wl-copy not found", "Please install wl-clipboard for copy/paste support"], {type: 'error'})
		else
			autocmd TextYankPost * call FuzzyClip.SetClipBoardExtern(['wl-copy', '-n'])
			autocmd FocusGained,VimEnter * call FuzzyClip.LoadRegisterFromExtern(['wl-paste'])
			command UpdateClipboard call FuzzyClip.SetClipBoardExtern(['wl-copy', '-n'])
		endif
	endif
endif
