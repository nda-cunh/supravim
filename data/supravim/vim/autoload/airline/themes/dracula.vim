vim9script

# --- Palette ---
final bg0     = '#282a36'
final panel_b = '#282a36'
final panel_c = '#1c1c1c'
final fg      = '#f8f8f2'
final grey    = '#6272a4'
final blue    = '#8be9fd'
final green   = '#50fa7b'
final yellow  = '#f1fa8c'
final orange  = '#ffb86c'
final red     = '#ff5555'
final cyan    = '#80d6e8'
final purple  = '#bd93f9'
final magenta = '#ff79c6'
final accent_fg = '#282a36'
final warning = '#f1fa8c'
final error   = '#ff5555'

# --- Airline ---
g:airline#themes#dracula#palette = {}

final airline_info       = [fg, panel_b, 1, 2]
final airline_statusline = [fg, panel_c, 1, 2]

def Dracula_color(accent: string): any
	var m = airline#themes#generate_color_map([accent_fg, accent, 1, 2], airline_info, airline_statusline)
	return extend(m, {airline_warning: [bg0, warning, 1, 2], airline_error: [bg0, error, 1, 2]})
enddef

g:airline#themes#dracula#palette = {
	normal:   Dracula_color(blue),
	insert:   Dracula_color(green),
	replace:  Dracula_color(red),
	visual:   Dracula_color(yellow),
	terminal: Dracula_color(purple),
	inactive: Dracula_color(grey),
}
