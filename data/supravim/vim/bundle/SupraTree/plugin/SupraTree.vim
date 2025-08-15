vim9script

import autoload 'SupraTree/SupraTree.vim' as SupraTree
import autoload 'SupraTree/SupraWater.vim' as SupraWater

command! SupraTreeToggle call SupraTree.Toggle()
command! SupraTreeOpen call SupraTree.OpenTree()
command! SupraTreeClose call SupraTree.Close()

augroup SupraWater
	autocmd!
	autocmd User RefreshTree call SupraWater.Refresh()
augroup END

augroup SupraNERDTreeTabs
	autocmd!
	autocmd TabEnter * call SupraTree.OnTabEnter()
augroup END

if exists('g:SupraTreeOpenByDefault') == 0
	g:SupraTreeOpenByDefault = false 
endif

if g:SupraTreeOpenByDefault == true 
	autocmd VimEnter * call SupraTree.Open()
endif
