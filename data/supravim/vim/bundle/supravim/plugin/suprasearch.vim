vim9script

import autoload 'suprasearch.vim' as Search

nnoremap <c-f> 		<scriptcmd>call Search.SupraSearch(false)<cr>
inoremap <c-f> 		<scriptcmd>call Search.SupraSearch(false)<cr>
nnoremap <leader>r	<scriptcmd>call Search.SupraSearch(false, expand("<cword>"))<cr>
vnoremap <c-f> 		<esc><scriptcmd>call Search.SupraSearch(true)<cr>
