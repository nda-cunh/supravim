vim9script

import autoload 'suprafuzzy/fuzzyclip.vim' as FuzzyClip

command FuzzyClip call FuzzyClip.Start()

inoremap <c-v>	<scriptcmd>norm p<cr>
nnoremap <del> i<del><right><esc>
vnoremap <c-c>	y

augroup UpdateYankRegistersGroup
    autocmd!
    autocmd TextYankPost * call FuzzyClip.UpdateYankRegisters()
augroup END

if has('macunix')
    autocmd TextYankPost * call FuzzyClip.SetClipBoardExtern(['pbcopy'])
    autocmd FocusGained * call FuzzyClip.LoadRegisterFromExtern(['pbpaste'])
	command UpdateClipboard call FuzzyClip.SetClipBoardExtern(['pbcopy'])
elseif expand("$XDG_SESSION_TYPE") == "wayland"
	if executable('wl-copy') == 0
		call Notify.Notification(["wl-copy not found", "Please install wl-clipboard for copy/paste support"], {type: 'error'})
	else
		autocmd TextYankPost * call FuzzyClip.SetClipBoardExtern(['wl-copy', '-n'])
		autocmd FocusGained * call FuzzyClip.LoadRegisterFromExtern(['wl-paste'])
		command UpdateClipboard call FuzzyClip.SetClipBoardExtern(['wl-copy', '-n'])
	endif
elseif expand("$XDG_SESSION_TYPE") == "x11"
	if executable('xclip') == 0
		call Notify.Notification(["xclip not found", "Please install xclip for copy/paste support"], {type: 'error'})
	else
		autocmd TextYankPost * call FuzzyClip.SetClipBoardExtern(['xclip', '-i', '-selection', 'clipboard'])
		autocmd FocusGained,VimEnter * call FuzzyClip.LoadRegisterFromExtern(['xclip', '-o', '-selection', 'clipboard'])
		command UpdateClipboard call FuzzyClip.SetClipBoardExtern(['xclip', '-i', '-selection', 'clipboard'])
	endif
endif
