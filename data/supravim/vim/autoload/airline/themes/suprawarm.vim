vim9script

# --- Palette ---

final bg0     = '#2c2d30'
final panel_b = '#3e4045'
final panel_c = '#242628'
final fg      = '#b1b4b9'
final grey    = '#646568'
final blue    = '#68aee8'
final green   = '#99bc80'
final yellow  = '#dfbe81'
final orange  = '#c99a6e'
final red     = '#e16d77'
final cyan    = '#5fafb9'
final purple  = '#c27fd7'
final accent_fg = '#2c2d30'
final warning = '#dfbe81'
final error   = '#e16d77'

# --- Airline ---
g:airline#themes#suprawarm#palette = {}

final airline_info       = [fg, panel_b, 1, 2]
final airline_statusline = [fg, panel_c, 1, 2]

def Suprawarm_color(accent: string): any
	var m = airline#themes#generate_color_map([accent_fg, accent, 1, 2], airline_info, airline_statusline)
	return extend(m, {airline_warning: [bg0, warning, 1, 2], airline_error: [bg0, error, 1, 2]})
enddef

g:airline#themes#suprawarm#palette = {
	normal:   Suprawarm_color(blue),
	insert:   Suprawarm_color(green),
	replace:  Suprawarm_color(red),
	visual:   Suprawarm_color(yellow),
	terminal: Suprawarm_color(cyan),
	inactive: Suprawarm_color(grey),
}
