vim9script
import autoload 'SupraUtils.vim' as Utils

def Test_move_line_down_normal()
	new
	setline(1, ['a', 'b', 'c'])
	cursor(1, 1)
	Utils.MoveLineDown('n')
	assert_equal(['b', 'a', 'c'], getline(1, '$'))
	bwipe!
enddef

def Test_move_line_down_keeps_cursor()
	new
	setline(1, ['a', 'b', 'c'])
	cursor(1, 1)
	Utils.MoveLineDown('n')
	assert_equal(2, line('.'))
	bwipe!
enddef

def Test_move_line_up_normal()
	new
	setline(1, ['a', 'b', 'c'])
	cursor(2, 1)
	Utils.MoveLineUp('n')
	assert_equal(['b', 'a', 'c'], getline(1, '$'))
	bwipe!
enddef

def Test_move_char_right()
	new
	setline(1, 'ab')
	cursor(1, 1)
	Utils.MoveCharRight('n')
	assert_equal('ba', getline(1))
	bwipe!
enddef

def Test_move_char_left()
	new
	setline(1, 'ab')
	cursor(1, 2)
	Utils.MoveCharLeft('n')
	assert_equal('ba', getline(1))
	bwipe!
enddef
