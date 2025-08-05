vim9script

import autoload 'NerdTreeTab.vim' as Tree

command NERDTreeTabsOpen call Tree.OpenTreeTabs()
command NERDTreeTabsToggle call Tree.ToggleTreeTabs()
command NERDTreeTabsClose call Tree.CloseTreeTabs()
command NERDTreeTabsRefresh call Tree.NerdTreeRefreshRoot()

augroup nerdtreeconcealbrackets
	autocmd!
	autocmd FileType nerdtree syntax match hideBracketsInNerdTree "\]" contained conceal containedin=ALL
	autocmd FileType nerdtree syntax match hideBracketsInNerdTree "\[" contained conceal containedin=ALL
augroup END

augroup SupraNERDTreeTabs
	autocmd!
	autocmd VimEnter * call Tree.NerdTreeRefreshColor()
	autocmd TabEnter * call Tree.OnTabEnter()
augroup END
