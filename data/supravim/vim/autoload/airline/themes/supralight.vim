vim9script

# navarasu/onedark.nvim · light — thème airline pour le colorscheme supralight

# --- Palette ---
final bg0     = '#fafafa'
final panel_b = '#e6e6e6'
final panel_c = '#c9c9c9'
final fg      = '#383a42'
final grey    = '#a0a1a7'
final blue    = '#4078f2'
final green   = '#50a14f'
final yellow  = '#986801'
final orange  = '#c18401'
final red     = '#e45649'
final cyan    = '#0184bc'
final purple  = '#a626a4'
final accent_fg = '#fafafa'
final warning = '#986801'
final error   = '#e45649'

# --- Airline ---
g:airline#themes#supralight#palette = {}

final airline_info       = [fg, panel_b, 1, 2]
final airline_statusline = [fg, panel_c, 1, 2]

def Supralight_color(accent: string): any
	var m = airline#themes#generate_color_map([accent_fg, accent, 1, 2], airline_info, airline_statusline)
	return extend(m, {airline_warning: [bg0, warning, 1, 2], airline_error: [bg0, error, 1, 2]})
enddef

g:airline#themes#supralight#palette = {
	normal:   Supralight_color(blue),
	insert:   Supralight_color(green),
	replace:  Supralight_color(red),
	visual:   Supralight_color(yellow),
	terminal: Supralight_color(cyan),
	inactive: Supralight_color(grey),
}
