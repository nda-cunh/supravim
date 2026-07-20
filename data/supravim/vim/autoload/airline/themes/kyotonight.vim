vim9script

# --- Palette ---
final bg0     = '#1a1b26'
final panel_b = '#24283b'
final panel_c = '#1a1a24'
final fg      = '#a9b1d6'
final grey    = '#565f89'
final blue    = '#7aa2f7'
final green   = '#b4f9f8'
final yellow  = '#ff9e63'
final orange  = '#ff9e64'
final red     = '#f7768e'
final cyan    = '#07d7ff'
final purple  = '#bb9af7'
final magenta = '#b896f0'
final accent_fg = '#1a1b26'
final warning = '#ff9e63'
final error   = '#f7768e'

# --- Airline ---
g:airline#themes#kyotonight#palette = {}

final airline_info       = [fg, panel_b, 1, 2]
final airline_statusline = [fg, panel_c, 1, 2]

def Kyotonight_color(accent: string): any
	var m = airline#themes#generate_color_map([accent_fg, accent, 1, 2], airline_info, airline_statusline)
	return extend(m, {airline_warning: [bg0, warning, 1, 2], airline_error: [bg0, error, 1, 2]})
enddef

g:airline#themes#kyotonight#palette = {
	normal:   Kyotonight_color(blue),
	insert:   Kyotonight_color(green),
	replace:  Kyotonight_color(red),
	visual:   Kyotonight_color(yellow),
	terminal: Kyotonight_color(purple),
	inactive: Kyotonight_color(grey),
}
