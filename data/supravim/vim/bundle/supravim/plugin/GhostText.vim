vim9script noclear

import autoload 'supravim/GhostText.vim' as Ghost

if exists('g:loaded_ghost_text')
	finish
endif

g:loaded_ghost_text = 1

if prop_type_get('ghost_text') == {}
    prop_type_add('ghost_text', {highlight: 'Comment'})
endif

augroup GhostTextLSP
    autocmd!
    autocmd CompleteChanged * Ghost.TextCompletion()
    autocmd CompleteDone,InsertLeave * prop_remove({type: 'ghost_text', all: true})
augroup END
