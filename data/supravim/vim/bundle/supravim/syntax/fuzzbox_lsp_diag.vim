vim9script

hi LspDiagHint guifg=#2f87ff ctermfg=111
hi link LspDiagWarning WarningMsg 
hi link LspDiagError ErrorMsg

syntax match LspDiagError '│ E.*$'
syntax match LspDiagWarning '│ W.*$'
syntax match LspDiagHint '│ H.*$'
syntax match Directory '\zs[^│]*\ze │'
