vim9script

export def TabFunc()
	const info = complete_info()
	if info.pum_visible
		if info.selected == -1
			if vsnip#jumpable(1)
				feedkeys("\<Plug>(vsnip-jump-next)")
			else
				feedkeys("\<c-i>", 'n')
			endif
		else
			feedkeys("\<cr>")
		endif
	else
		if vsnip#jumpable(1)
			feedkeys("\<Plug>(vsnip-jump-next)")
		else
			feedkeys("\<c-i>", 'n')
		endif
	endif
enddef

export def CtrlYFunc()
	const info = complete_info()
	if info.pum_visible
		if info.selected == -1
			feedkeys("\<down>", 'n')
		endif
		feedkeys("\<cr>", 'n')
	endif
enddef
