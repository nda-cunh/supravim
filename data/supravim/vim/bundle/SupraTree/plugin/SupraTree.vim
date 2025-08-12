vim9script

import autoload 'SupraTree.vim' as SupraTree

command! SupraTreeToggle call SupraTree.Toggle()
command! SupraTreeOpen call SupraTree.OpenTree()
command! SupraTreeClose call SupraTree.Close()

augroup SupraNERDTreeTabs
	autocmd!
	autocmd TabEnter * call SupraTree.OnTabEnter()
augroup END
