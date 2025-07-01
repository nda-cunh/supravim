vim9script

if exists('g:elevator_loaded')
  finish
endif
g:elevator_loaded = true

import autoload 'elevator.vim'

augroup Elevator
  autocmd WinScrolled * elevator#Show(expand('<amatch>')->str2nr())
  autocmd WinEnter,BufWinEnter * timer_start(0, (_) => elevator#Show(win_getid()))
augroup END

command! -nargs=0 -bar ElevatorToggle elevator#Toggle()
