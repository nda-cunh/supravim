vim9script

# navarasu/onedark.nvim · dark — thème airline pour le colorscheme supradark

# --- Palette ---
final bg0     = '#282c34'
final panel_b = '#393f4a'
final panel_c = '#21252b'
final fg      = '#abb2bf'
final grey    = '#5c6370'
final blue    = '#61afef'
final green   = '#98c379'
final yellow  = '#e5c07b'
final orange  = '#d19a66'
final red     = '#e86671'
final cyan    = '#56b6c2'
final purple  = '#c678dd'
final accent_fg = '#282c34'
final warning = '#e5c07b'
final error   = '#e86671'

# --- Airline ---
g:airline#themes#supradark#palette = {}

final airline_info       = [fg, panel_b, 1, 2]
final airline_statusline = [fg, panel_c, 1, 2]

def Supradark_color(accent: string): any
	var m = airline#themes#generate_color_map([accent_fg, accent, 1, 2], airline_info, airline_statusline)
	return extend(m, {airline_warning: [bg0, warning, 1, 2], airline_error: [bg0, error, 1, 2]})
enddef

g:airline#themes#supradark#palette = {
	normal:   Supradark_color(blue),
	insert:   Supradark_color(green),
	replace:  Supradark_color(red),
	visual:   Supradark_color(yellow),
	terminal: Supradark_color(cyan),
	inactive: Supradark_color(grey),
}
