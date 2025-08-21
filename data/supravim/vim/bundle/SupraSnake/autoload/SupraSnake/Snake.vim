vim9script

################################
## Const and Variables
################################

if !exists('g:SUPRA_SNAKE_HIGHSCORE')
	g:SUPRA_SNAKE_HIGHSCORE = 0
endif

# Window size
const width = 80
const height = 30

# Activity states
const MENU = 0
const PLAY = 1
const GAMEOVER = 2

# Sprites
const SP_SNAKE_HEAD = '🟨'
const SP_SNAKE = '🟩'
const SP_WALL = '🟦'
const SP_EMPTY = '  '
const SP_FOOD = '🍎'

# Map constants
const WALL = 1
const EMPTY = 0
const FOOD = 2
const SNAKE = 3
const SNAKE_HEAD = 4

# DIRECTION
const NONE = -1
const UP = 0
const DOWN = 1
const LEFT = 2
const RIGHT = 3

################################
## Game State 
################################

var popup: number
var timer: number

var map: list<list<number>> = []
var snake: list<dict<number>> = []
var direction = NONE 
var activity = MENU 
var score = 0
var highscore = 0


export def Run()
	normal 0
	popup = popup_create([], {
		borderhighlight: ['Normal', 'Normal', 'Normal', 'Normal'],
		borderchars: ['─', '│', '─', '│', '╭', '╮', '╯', '╰'],
		highlight: 'Normal',
		border: [1],
		minwidth: width,
		minheight: height,
		time: -1,
		drag: 1,
		dragall: 1,
		tabpage: -1,
		filter: KeyFilter,
		# title: repeat('─', (width / 2) - 6) .. ' SupraSnake ',
		mapping: 0,
		callback: (wid, _) => {
			if timer != 0
				timer_stop(timer)
				timer = 0
			endif
		}
	})
	const bufnr = winbufnr(popup)

    setwinvar(popup, '&nu', 0)
	setwinvar(popup, '&rnu', 0)
	setwinvar(popup, '&buflisted', 0)
    setwinvar(popup, '&modeline', 0)
    setwinvar(popup, '&swapfile', 0)
    setwinvar(popup, '&undolevels', -1)
    setwinvar(popup, '&modifiable', 1)
    setwinvar(popup, '&nu', 0)
    setwinvar(popup, '&relativenumber', 0)
	setwinvar(popup, "&updatetime", 2500)
    setwinvar(popup, '&signcolumn', 'yes')
    setwinvar(popup, '&wrap', 0)
	setwinvar(popup, '&syntax', 'on')
	setwinvar(popup, '&signcolumn', 'no')
	setbufvar(bufnr, '&filetype', 'suprasnake')
	setbufvar(bufnr, '&cursorline', 1)
	InitGame()

	if timer != 0
		timer_stop(timer)
	endif
	timer = timer_start(50, (_) => {
		if activity == MENU 
			DrawMenu()
		elseif activity == PLAY
			SnakeMove()
			DrawGame()
		elseif activity == GAMEOVER
			DrawGameOver()
		endif
	}, {repeat: -1})
enddef

def KeyFilter(wid: number, key: string): number
	# All Activity 
	if key == 'q' || key == 'Q' || key == "\<esc>"
		popup_close(popup)
		return 1
	endif

	# Menu Activity
	if activity == MENU
		if key ==? "\<Enter>"
			activity = PLAY
		elseif key ==? "\<LeftMouse>" || key ==? "\<2-LeftMouse>" || key ==? "\<3-LeftMouse>" || key ==? "\<4-LeftMouse>" || key ==? "\<5-LeftMouse>"
			var bufnr = winbufnr(wid)
			var pos = getmousepos()
			if pos.winid != wid
				return 0
			endif
			try
			var line = getbufline(bufnr, pos.winrow - 2, pos.winrow + 1)
			for i in line
				if stridx(i, 'Play') != -1
					activity = PLAY
					break
				elseif stridx(i, 'Quit') != -1
					popup_close(popup)
					return 0
				endif
			endfor
			catch
			endtry
			return 1
		endif
	endif

	# Play Activity
	if activity == PLAY
		if key ==? 'w' || key == "\<up>"
			if direction != DOWN
				direction = UP
			endif
			return 1
		elseif key ==? 's' || key == "\<down>"
			if direction != UP
				direction = DOWN
			endif
			return 1
		elseif key ==? 'a' || key == "\<left>"
			if direction != RIGHT && direction != NONE
				direction = LEFT
			endif
			return 1
		elseif key ==? 'd' || key == "\<right>"
			if direction != LEFT
				direction = RIGHT
			endif
			return 1
		endif
	endif

	if activity == GAMEOVER
		if key ==? "\<Enter>"
			InitGame()
			activity = PLAY
			direction = NONE
			DrawGame()
			return 1
		elseif key ==? 'q' || key ==? 'Q' || key ==? "\<esc>"
			popup_close(popup)
			return 0
		elseif key ==? "\<LeftMouse>" || key ==? "\<2-LeftMouse>" || key ==? "\<3-LeftMouse>" || key ==? "\<4-LeftMouse>" || key ==? "\<5-LeftMouse>"
			var bufnr = winbufnr(wid)
			var pos = getmousepos()
			if pos.winid != wid
				return 0
			endif
			try
				var line = getbufline(bufnr, pos.winrow - 2, pos.winrow + 1)
				for i in line
					if stridx(i, 'Retry') != -1
						InitGame()
						activity = PLAY
						direction = NONE
						DrawGame()
						break
					elseif stridx(i, 'Quit') != -1
						popup_close(popup)
						return 0
					endif
				endfor
			catch
			endtry
			return 1
		endif
	endif
	return 1
enddef

def InitGame()
	score = 0
	activity = MENU 
	direction = NONE
	highscore = g:SUPRA_SNAKE_HIGHSCORE
	# initialize the game map with full 0 and 1
	# 1 tile = width / 2 and 1 height
	var width_max = width / 2 # because emojis are 2 characters wide
	var height_max = height
	map = []

	# Init the map with walls and empty spaces
	for i in range(height_max)
		var line = []
		for j in range(width_max)
			if i == 0 || i == height_max - 1 || j == 0 || j == width_max - 1
				add(line, WALL)
			else
				add(line, EMPTY)
			endif
		endfor
		add(map, line)
	endfor
	# Add the snake
	
	var h = height_max / 2
	snake = []
	add(snake, { x: 6, y: h })
	add(snake, { x: 7, y: h })
	add(snake, { x: 8, y: h })
	add(snake, { x: 9, y: h })
	add(snake, { x: 10, y: h }) # head of the snake
	RandomFood()
enddef

def ClearMap()
	var width_max = width / 2 # because emojis are 2 characters wide
	var height_max = height
	# Clear the map with only wall and empty spaces
	for i in range(height_max)
		for j in range(width_max)
			if i == 0 || i == height_max - 1 || j == 0 || j == width_max - 1
				map[i][j] = WALL
			elseif map[i][j] == FOOD
				# Do not clear food, it will be removed when the snake eats it
				map[i][j] = FOOD
			else
				map[i][j] = EMPTY
			endif
		endfor
	endfor
enddef

def SnakeMove()
	if direction == NONE
		# If no direction is set, do not move the snake
		return
	endif
	var head = snake[-1]
	var new_head = { x: head.x, y: head.y }

	# Move the snake in the current direction
	if direction == UP
		new_head.y -= 1
	elseif direction == DOWN
		new_head.y += 1
	elseif direction == LEFT
		new_head.x -= 1
	elseif direction == RIGHT
		new_head.x += 1
	endif

	# Check for collision with walls or itself
	if map[new_head.y][new_head.x] == WALL || map[new_head.y][new_head.x] == SNAKE
		activity = GAMEOVER
		highscore = max([highscore, score])
		g:SUPRA_SNAKE_HIGHSCORE = highscore
		return
	endif

	# Remove the tail of the snake else if there is food
	if map[new_head.y][new_head.x] == FOOD
		# If there is food, do not remove the tail
		map[new_head.y][new_head.x] = EMPTY # Remove food from the map
		score += 1
		RandomFood()
	else
		# If there is no food, remove the tail
		var snake_tail = snake[0]
		map[snake_tail.y][snake_tail.x] = EMPTY
		remove(snake, 0)
	endif

	add(snake, new_head)
	# echom snake
enddef

def RandomFood()
	# Place food in a random empty space
	var empty_spaces = []
	for i in range(len(map))
		for j in range(len(map[i]))
			if map[i][j] == EMPTY
				add(empty_spaces, { x: j, y: i })
			endif
		endfor
	endfor

	if len(empty_spaces) > 0
		var food_pos = empty_spaces[rand() % len(empty_spaces)]
		map[food_pos.y][food_pos.x] = FOOD
	endif
enddef

def DrawMenu()

	const ascii_txt = [
'                                 ░██                 ',
'                                ░██                  ',
'░███████  ░████████   ░██████   ░██    ░██ ░███████  ',
'██        ░██    ░██       ░██  ░██   ░██ ░██    ░██ ',
'░███████  ░██    ░██  ░███████  ░███████  ░█████████ ',
'      ░██ ░██    ░██ ░██   ░██  ░██   ░██ ░██        ',
'░███████  ░██    ░██  ░█████░██ ░██    ░██ ░███████  ',
'']
                                                      
	var str = ['', '']
	# Center it with strcharlen of ascii_txt
	const space_center = repeat(' ', (width / 2) - (strcharlen(ascii_txt[0]) / 2))
	for i in range(len(ascii_txt))
		add(str, space_center .. ascii_txt[i])
	endfor
	add(str, '')
	add(str, '')

	# Create a button Play with ╭ and ╮

	const button_play = [
		'╭────────────────────────────────────╮',
		'│           Play SupraSnake          │',
		'╰────────────────────────────────────╯']
	const button_quit = [
		'╭────────────────────────────────────╮',
		'│                Quit                │',
		'╰────────────────────────────────────╯']
	const space_center_btn = repeat(' ', (width / 2) - (strcharlen(button_play[0]) / 2))

	for i in range(len(button_play))
		add(str, space_center_btn .. button_play[i])
	endfor
	for i in range(len(button_quit))
		add(str, space_center_btn .. button_quit[i])
	endfor

	
	
	popup_settext(popup, str)
enddef

def DrawGameOver()
	const ascii_txt = [
'  ░██████                                        ',
' ░██   ░██                                       ',
'░██         ░██████   ░█████████████   ░███████  ',
'░██  █████       ░██  ░██   ░██   ░██ ░██    ░██ ',
'░██     ██  ░███████  ░██   ░██   ░██ ░█████████ ',
' ░██  ░███ ░██   ░██  ░██   ░██   ░██ ░██        ',
'  ░█████░█  ░█████░██ ░██   ░██   ░██  ░███████  ',
'                                                 ',
'        ░████',
'     ░██   ░██',
'    ░██     ░██ ░██    ░██  ░███████  ░██░████',
'    ░██     ░██ ░██    ░██ ░██    ░██ ░███',
'    ░██     ░██  ░██  ░██  ░█████████ ░██',
'     ░██   ░██    ░██░██   ░██        ░██',
'      ░██████      ░███     ░███████  ░██',
'']
	
	const space_center = repeat(' ', (width / 2) - (strcharlen(ascii_txt[0]) / 2))
	var gameover = []

	add(gameover, '')
	for i in range(len(ascii_txt))
		add(gameover, space_center .. ascii_txt[i])
	endfor
	add(gameover, '')

	# Add Retry Button
	const button_retry = [
		'╭────────────────────────────────────╮',
		'│                Retry               │',
		'╰────────────────────────────────────╯']
	const button_quit = [
		'╭────────────────────────────────────╮',
		'│                Quit                │',
		'╰────────────────────────────────────╯']
	const space_center_btn = repeat(' ', (width / 2) - (strcharlen(button_retry[0]) / 2))
	for i in range(len(button_retry))
		add(gameover, space_center_btn .. button_retry[i])
	endfor
	for i in range(len(button_quit))
		add(gameover, space_center_btn .. button_quit[i])
	endfor
	# Print the highscore and Score
	var highscore_str = '🏆 Highscore: ' .. highscore
	var score_str = '🍎 Score: ' .. score
	var txt_len = len(gameover)
	# Add space When the height is atteint
	for i in range(txt_len, height - 2)
		add(gameover, '')
	endfor
	add(gameover, score_str)
	add(gameover, highscore_str)

	popup_settext(popup, gameover)
enddef

def DrawGame()
	ClearMap()
	for i in range(len(snake))
		var s = snake[i]
		if i == len(snake) - 1
			map[s.y][s.x] = SNAKE_HEAD
		else
			map[s.y][s.x] = SNAKE
		endif
	endfor
	var print_map = []
	DrawScore(print_map)
	for i in range(len(map))
		var line = ''
		for j in range(len(map[i]))
			if map[i][j] == WALL
				line ..= SP_WALL
			elseif map[i][j] == EMPTY
				line ..= SP_EMPTY
			elseif map[i][j] == FOOD
				line ..= SP_FOOD
			elseif map[i][j] == SNAKE
				line ..= SP_SNAKE
			elseif map[i][j] == SNAKE_HEAD
				line ..= SP_SNAKE_HEAD
			endif
		endfor
		add(print_map, line)
	endfor
	
	popup_settext(popup, print_map)
enddef

def DrawScore(map_print: list<string>, is_over: bool = 0)
	const string_score = '│  ' .. score .. ' 🍎 │ ' .. len(snake) .. ' 🐍 │ ' .. highscore .. ' 🏆  │'
	const len = strcharlen(string_score)
	const line = '─' .. repeat('─', len - 1) .. '─'
	const begin_block = '╭' .. line .. '╮'
	const end_block = '╰' .. line .. '╯'
	const SupraSnake_block = [
		'╭────────────────────────────────────╮',
		'│            SupraSnake              │',
		'╰────────────────────────────────────╯'
	]
	var space = repeat(' ', (width / 2) - (strcharlen(string_score)) - 1)
	var score_block = [
		begin_block .. space .. SupraSnake_block[0],
		string_score .. space .. SupraSnake_block[1],
		end_block .. space .. SupraSnake_block[2]
	]
	extend(map_print, score_block)
enddef
