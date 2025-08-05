vim9script

import autoload 'SupraComment.vim' as Comment

noremap <c-_>	<scriptcmd>call Comment.Commentary(false)<CR>
vnoremap <c-_>	<esc><scriptcmd>call Comment.Commentary(true)<CR>
command -nargs=0 Commentary call Comment.Commentary(false)
