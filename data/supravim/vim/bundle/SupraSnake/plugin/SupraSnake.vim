vim9script

import autoload 'SupraSnake/Snake.vim' as SupraSnake

if !exists('g:SUPRA_SNAKE_HIGHSCORE')
	g:SUPRA_SNAKE_HIGHSCORE = 0
endif

command Snake call SupraSnake.Run()
