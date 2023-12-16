if !has('vim9script') || v:version < 802
    finish
endif

vim9script

import autoload "../autoload/minifuzzy/finders.vim"

command! -nargs=* -complete=dir MinifuzzyFind finders.Find(<q-args>)
command! MinifuzzyBuffers                     finders.Buffers()
command! MinifuzzyMRU                         finders.MRU()
command! MinifuzzyLines                       finders.Lines()
command! MinifuzzyGitFiles                    finders.GitFiles()
command! MinifuzzyCommand                     finders.Command()

nnoremap <leader>ff <Cmd>MinifuzzyFind<CR>
nnoremap <C-p>      <Cmd>MinifuzzyFind<CR>
nnoremap <leader>fb <Cmd>MinifuzzyBuffers<CR>
nnoremap <leader>fm <Cmd>MinifuzzyMRU<CR>
nnoremap <leader>fl <Cmd>MinifuzzyLines<CR>
nnoremap <leader>fg <Cmd>MinifuzzyGitFiles<CR>

cnoremap <silent> <C-b>   <C-\>eminifuzzy#finders#StoreOldCmd()<CR><ESC>:MinifuzzyCommand<CR>
cnoremap <silent> <C-Tab> <C-\>eminifuzzy#finders#StoreOldCmd()<CR><ESC>:MinifuzzyCommand<CR>
