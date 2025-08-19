vim9script

import autoload 'SupraComment.vim' as Comment

noremap <c-_>		<scriptcmd>call Comment.Commentary(false)<CR>
vnoremap <c-_>		<esc><scriptcmd>call Comment.Commentary(true)<CR>gv

noremap	\			<scriptcmd>call Comment.Commentary(false, Comment.FORCE_COMMENT)<CR>
vnoremap \			<esc><scriptcmd>call Comment.Commentary(true, Comment.FORCE_COMMENT)<CR>gv

noremap <c-\>		<scriptcmd>call Comment.Commentary(false, Comment.FORCE_UNCOMMENT)<CR>
vnoremap <c-\>		<esc><scriptcmd>call Comment.Commentary(true, Comment.FORCE_UNCOMMENT)<CR>gv

command -nargs=0 Commentary call Comment.Commentary(false, Comment.NORMAL)
command -nargs=0 Comment call Comment.Commentary(false, Comment.FORCE_COMMENT)
command -nargs=0 UnComment call Comment.Commentary(false, Comment.FORCE_UNCOMMENT)
