vim9script

augroup CustomC3Filetype
    autocmd!
    autocmd BufRead,BufNewFile *.c3,*.c3i,*.c3t setfiletype c3
augroup END
