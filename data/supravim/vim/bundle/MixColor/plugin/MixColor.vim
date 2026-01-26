vim9script noclear

if exists('g:loaded_MixColor')
	finish
endif

g:loaded_MixColor = 1

import autoload 'MixColor/MixColor.vim' as MixColor

au User SupraMenuLoaded MixColor.InitMenuColor()

def g:MixChangeColor(lnum: number, col: number)
	MixColor.MixChangeColor(lnum, col)
enddef

augroup SupraColors
    autocmd!
    autocmd BufReadPost * MixColor.InitColorListener()
augroup END
