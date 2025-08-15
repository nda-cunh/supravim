vim9script

import autoload 'SupraPopup.vim' as Popup
import autoload './SupraWater.vim' as Water 

# Simple popup to show help.
export def HelpPreview()
	var popup = Popup.Simple({
		close_key: ["q", "\<UP>", "\<DOWN>", "\<Left>", "\<Right>", "\<esc>", "\<LeftMouse>"],
		scrollbar: 1,
		title: 'Help  '
	})

	const lines = [
		'',
		' • <C-q>                   * Quit',
		' • <C-s>                   * Save',
		' • <BackSpace> / -         * Back',
		' • <Enter> / <Click>       * Enter the folder',
		' • <leader-s>              * Open with Split',
		' • <leader-v>              * Open with Vsplit',
		' • <C-t>                   * Open with a new Tab',
	    ' • <C-p>                   * Preview of the file',
        ' • ~                       * Go to the home directory',
        ' • _                       * Enter the folder and jump'
	]

	var bufnr = winbufnr(popup.wid)
	setbufvar(bufnr, '&filetype', 'markdown')
	Popup.SetText(popup, lines)
	Popup.SetSize(popup, 52, -1)
enddef

# Simple popup to preview a file.
export def Preview()
	const id = bufnr('%')
	const dict = Water.local[id]
	const line = getline('.')

	var file_path = dict.actual_path .. line
	
	if filereadable(file_path) == 0 || isdirectory(file_path)
		echo 'Cannot preview file: ' .. file_path
		return	
	endif

	var buf_to_preview = bufadd(file_path)
	bufload(buf_to_preview)

	var popup = Popup.Simple({
		close_key: ["q", "\<UP>", "\<DOWN>", "\<Left>", "\<Right>", "\<esc>", "\<c-p>", "\<LeftMouse>"],
		scrollbar: 1,
	})

	const lines = getbufline(buf_to_preview, 1, '$')
	Popup.SetText(popup, lines)
	Popup.SetSize(popup, 80, 20)

	popup_setoptions(popup.wid, {
		maxwidth: 80,
		maxheight: 20,
	})

	setwinvar(popup.wid, '&number', 1)
	setwinvar(popup.wid, '&signcolumn', 'no')
	setwinvar(popup.wid, '&numberwidth', 1)
	setwinvar(popup.wid, '&wrap', 0)
	win_execute(popup.wid, 'filetype detect')
    win_execute(popup.wid, 'silent! doautocmd filetypedetect BufNewFile ' .. file_path)
    win_execute(popup.wid, 'silent! setlocal nospell nolist')
enddef
