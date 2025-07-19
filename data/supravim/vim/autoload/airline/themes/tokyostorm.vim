vim9script

g:airline#themes#tokyostorm#palette = {}

var foreground = ['#a9b1d6', 250]
var background = ['#24283b', 235]
var background_alt = ['#2c3047', 236]
var background_grey = ['#444B6A', 238]
var red = ['#F7768E', 203]
var yellow = ['#E0AF68', 179]
var green = ['#9ECE6A', 107]
var blue = ['#7AA2F7', 110]
var purple = ['#ad8ee6', 176]

var airline_mode_normal = [ background[0], blue[0], background[1], blue[1]]
var airline_mode_insert = [ background[0], green[0], background[1], green[1]]
var airline_mode_replace = [ background[0], yellow[0], background[1], yellow[1]]
var airline_mode_visual = [ background[0], purple[0], background[1], purple[1]]
var airline_mode_inactive = [ foreground[0], background_grey[0], foreground[1], background_grey[1]]

var airline_info = [ foreground[0], background_grey[0], foreground[1], background_grey[1]]
var airline_statusline = [ foreground[0], background_alt[0],  foreground[1], background_alt[1]]

def Tokyonight_color_map(mode: any): dict<list<any>>
	return airline#themes#generate_color_map(mode, airline_info, airline_statusline)
enddef

g:airline#themes#tokyostorm#palette.normal = Tokyonight_color_map(airline_mode_normal)
g:airline#themes#tokyostorm#palette.insert = Tokyonight_color_map(airline_mode_insert)
g:airline#themes#tokyostorm#palette.replace = Tokyonight_color_map(airline_mode_replace)
g:airline#themes#tokyostorm#palette.inactive = Tokyonight_color_map(airline_mode_inactive)
g:airline#themes#tokyostorm#palette.visual = Tokyonight_color_map(airline_mode_visual)
g:airline#themes#tokyostorm#palette.terminal = Tokyonight_color_map(airline_mode_insert)
g:airline#themes#tokyostorm#palette.normal.airline_term = airline_statusline
g:airline#themes#tokyostorm#palette.terminal.airline_term = airline_statusline
g:airline#themes#tokyostorm#palette.visual.airline_term = airline_statusline
