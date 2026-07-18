vim9script noclear

if exists('g:loaded_whisper') || &compatible
	finish
endif
import autoload 'supravim/Whisper.vim' as Whisper

g:loaded_whisper = 1

g:whisper_desc = get(g:, 'whisper_desc', {})
g:whisper_delay = get(g:, 'whisper_delay', 300)
g:whisper_ignore = get(g:, 'whisper_ignore', [])
g:whisper_width = get(g:, 'whisper_width', 60)
g:whisper_hint = get(g:, 'whisper_hint', true)
g:whisper_roots = get(g:, 'whisper_roots', [])

if empty(prop_type_get('WhisperKey'))
	prop_type_add('WhisperKey', {highlight: 'Special'})
	prop_type_add('WhisperGroup', {highlight: 'Directory'})
	prop_type_add('WhisperDesc', {highlight: 'Comment'})
	prop_type_add('WhisperHint', {highlight: 'NonText'})
endif

def Install()
	if empty(maparg(Whisper.Leader(), 'n'))
		execute printf('nnoremap <silent> %s <scriptcmd>Whisper.Whisper()<cr>', keytrans(Whisper.Leader()))
	endif
	for root in g:whisper_roots
		if empty(maparg(root, 'n'))
			execute printf('nnoremap <silent> %s <scriptcmd>Whisper.Whisper(%s)<cr>', keytrans(root), string(root))
		endif
	endfor
enddef

autocmd VimEnter * ++once Install()
