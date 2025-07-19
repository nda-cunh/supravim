vim9script

import autoload 'onedark.vim' as onedark

def Refresh() 
	var colors = onedark.GetColors()
	var term_red: string
	var term_green: string
	var term_yellow: string
	var term_blue: string
	var term_purple: string
	var term_white: string
	var term_cursor_grey: string
	var term_visual_grey: string

	if get(g:, 'onedark_termcolors', 256) == 16
		term_red = colors.red.cterm16
		term_green = colors.green.cterm16
		term_yellow = colors.yellow.cterm16
		term_blue = colors.blue.cterm16
		term_purple = colors.purple.cterm16
		term_white = colors.white.cterm16
		term_cursor_grey = colors.cursor_grey.cterm16
		term_visual_grey = colors.visual_grey.cterm16
	else
		term_red = colors.red.cterm
		term_green = colors.green.cterm
		term_yellow = colors.yellow.cterm
		term_blue = colors.blue.cterm
		term_purple = colors.purple.cterm
		term_white = colors.white.cterm
		term_cursor_grey = colors.cursor_grey.cterm
		term_visual_grey = colors.visual_grey.cterm
	endif

	g:airline#themes#onedark#palette = {}

	g:airline#themes#onedark#palette.accents = {
		red: [ colors.red.gui, '', term_red, 0 ]
	}

var N1 = [ colors.cursor_grey.gui, colors.green.gui, term_cursor_grey, term_green ]
var N2 = [ colors.white.gui, colors.visual_grey.gui, term_white, term_visual_grey ]
var N3 = [ colors.green.gui, colors.cursor_grey.gui, term_green, term_cursor_grey ]
g:airline#themes#onedark#palette.normal = airline#themes#generate_color_map(N1, N2, N3)

var group = airline#themes#get_highlight('vimCommand')
g:airline#themes#onedark#palette.normal_modified = {
\ 'airline_c': [ group[0], '', group[2], '', '' ]
\ }

var I1 = [ colors.cursor_grey.gui, colors.blue.gui, term_cursor_grey, term_blue ]
var I2 = N2
var I3 = [ colors.blue.gui, colors.cursor_grey.gui, term_blue, '' ]
g:airline#themes#onedark#palette.insert = airline#themes#generate_color_map(I1, I2, I3)
g:airline#themes#onedark#palette.insert_modified = g:airline#themes#onedark#palette.normal_modified

var R1 = [ colors.cursor_grey.gui, colors.red.gui, term_cursor_grey, term_red ]
var R2 = N2
var R3 = [ colors.red.gui, colors.cursor_grey.gui, term_red, '' ]
g:airline#themes#onedark#palette.replace = airline#themes#generate_color_map(R1, R2, R3)
g:airline#themes#onedark#palette.replace_modified = g:airline#themes#onedark#palette.normal_modified

var V1 = [ colors.cursor_grey.gui, colors.purple.gui, term_cursor_grey, term_purple ]
var V2 = N2
var V3 = [ colors.purple.gui, colors.cursor_grey.gui, term_purple, '' ]
g:airline#themes#onedark#palette.visual = airline#themes#generate_color_map(V1, V2, V3)
g:airline#themes#onedark#palette.visual_modified = g:airline#themes#onedark#palette.normal_modified

var IA1 = [ colors.cursor_grey.gui, colors.white.gui, term_cursor_grey, term_white ]
var IA2 = [ colors.white.gui, colors.visual_grey.gui, term_white, term_visual_grey ]
var IA3 = N2
g:airline#themes#onedark#palette.inactive = airline#themes#generate_color_map(IA1, IA2, IA3)
g:airline#themes#onedark#palette.inactive_modified = {
'airline_c': [ group[0], '', group[2], '', '' ]
}

var WI = [ colors.cursor_grey.gui, colors.yellow.gui, term_cursor_grey, term_yellow ]
g:airline#themes#onedark#palette.normal.airline_warning = [
WI[0], WI[1], WI[2], WI[3]
]

g:airline#themes#onedark#palette.normal_modified.airline_warning =
g:airline#themes#onedark#palette.normal.airline_warning

g:airline#themes#onedark#palette.insert.airline_warning =
g:airline#themes#onedark#palette.normal.airline_warning

g:airline#themes#onedark#palette.insert_modified.airline_warning =
g:airline#themes#onedark#palette.normal.airline_warning

g:airline#themes#onedark#palette.visual.airline_warning =
g:airline#themes#onedark#palette.normal.airline_warning

g:airline#themes#onedark#palette.visual_modified.airline_warning =
g:airline#themes#onedark#palette.normal.airline_warning

g:airline#themes#onedark#palette.replace.airline_warning =
g:airline#themes#onedark#palette.normal.airline_warning

g:airline#themes#onedark#palette.replace_modified.airline_warning =
g:airline#themes#onedark#palette.normal.airline_warning

var ER = [ colors.cursor_grey.gui, colors.red.gui, term_cursor_grey, term_red ]
g:airline#themes#onedark#palette.normal.airline_error = [
ER[0], ER[1], ER[2], ER[3]
]

g:airline#themes#onedark#palette.normal_modified.airline_error =
g:airline#themes#onedark#palette.normal.airline_error

g:airline#themes#onedark#palette.insert.airline_error =
g:airline#themes#onedark#palette.normal.airline_error

g:airline#themes#onedark#palette.insert_modified.airline_error =
g:airline#themes#onedark#palette.normal.airline_error

g:airline#themes#onedark#palette.visual.airline_error =
g:airline#themes#onedark#palette.normal.airline_error

g:airline#themes#onedark#palette.visual_modified.airline_error =
g:airline#themes#onedark#palette.normal.airline_error

g:airline#themes#onedark#palette.replace.airline_error =
g:airline#themes#onedark#palette.normal.airline_error

g:airline#themes#onedark#palette.replace_modified.airline_error =
g:airline#themes#onedark#palette.normal.airline_error

enddef

Refresh()
