vim9script

highlight supravim_on cterm=bold ctermfg=green ctermbg=NONE
highlight supravim_off cterm=bold ctermfg=red ctermbg=NONE
highlight supravim_mode term=reverse cterm=bold ctermbg=NONE
highlight str_comment ctermfg=yellow ctermbg=NONE
highlight str_txt ctermfg=cyan ctermbg=NONE

highlight supravim_1 ctermfg=red ctermbg=NONE # color line 1
highlight supravim_2 ctermfg=yellow ctermbg=NONE # color line 2
highlight supravim_3 ctermfg=green ctermbg=NONE # color line 3
highlight supravim_4 ctermfg=blue ctermbg=NONE # color line 4
highlight supravim_5 ctermfg=magenta ctermbg=NONE # color line 5

syn match supravim_on /\s\zson\ze\s/
syn match supravim_off /\s\zsoff\ze\s/
syn match str_comment /[(]\zs.*\ze[)]/
syn match str_txt /['].*[']/
syn match supravim_mode /--.*--/
syn match supravim_1 /\%1l.*/ 
syn match supravim_1 /\%2l.*/ 
syn match supravim_2 /\%3l.*/ 
syn match supravim_3 /\%4l.*/ 
syn match supravim_4 /\%5l.*/ 
syn match supravim_5 /\%6l.*/ 
syn match supravim_5 /\%7l.*/ 
