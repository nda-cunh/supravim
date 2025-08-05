vim9script

import autoload 'SupraPopup.vim' as Popup
import autoload 'YankHigh.vim' as Yank

augroup HighlightYanked
    autocmd!
    autocmd TextYankPost * if !v:event.visual && v:event.operator == 'y' && !empty(v:event.regtype) | Yank.Yank() | endif
augroup END
