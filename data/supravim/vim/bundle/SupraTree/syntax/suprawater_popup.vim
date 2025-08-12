vim9script

highlight supratitle ctermfg=blue ctermbg=NONE
highlight delete ctermfg=red ctermbg=NONE
highlight rename ctermfg=yellow ctermbg=NONE
highlight newfile ctermfg=green ctermbg=NONE
highlight yes ctermfg=green ctermbg=NONE
highlight no ctermfg=red ctermbg=NONE
highlight supracancel ctermfg=yellow ctermbg=NONE

syn match supratitle /Modified Files/
syn match rename /^\[Rename\]/ 
syn match delete /^\[Deleted File\]/ 
syn match delete /^\[Deleted Dir\]/ 
syn match delete /^\[Deleted\]/ 
syn match newfile /^\[New File\]/ 
syn match yes '\[(Y)es\]'
syn match no '\[(N)o\]'
syn match supracancel '\[(C)ancel\]'
syn match supracancel '\[Any key for continue\]' 
