vim9script noclear

import autoload '../autoload/supravim/Vsnip.vim' as VSnip

smap <tab> <scriptcmd>call supravim#Vsnip#TabFunc()<cr>
imap <tab> <scriptcmd>call supravim#Vsnip#TabFunc()<cr>
smap <expr> <S-Tab> g:vsnip#jumpable(-1)  ? '<Plug>(vsnip-jump-prev)'      : '<S-Tab>'
imap <expr> <S-Tab> g:vsnip#jumpable(-1)  ? '<Plug>(vsnip-jump-prev)'      : '<S-Tab>'
imap <c-y>	<scriptcmd>VSnip.CtrlYFunc()<cr>

const HOME = expand('~')
g:vsnip_snippet_dirs = [HOME .. '/.cache/supravim/snippets', HOME .. '/.local/share/supravim/data/snippets']
