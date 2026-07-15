vim9script

# navarasu/onedark.nvim · darker — thème airline pour le colorscheme supraonedark

# --- Palette ---
final bg0     = '#1f2329'
final panel_b = '#30363f'
final panel_c = '#181b20'
final fg      = '#a0a8b7'
final grey    = '#535965'
final blue    = '#4fa6ed'
final green   = '#8ebd6b'
final yellow  = '#e2b86b'
final orange  = '#cc9057'
final red     = '#e55561'
final cyan    = '#48b0bd'
final purple  = '#bf68d9'
final accent_fg = '#1f2329'
final warning = '#e2b86b'
final error   = '#e55561'

# --- Airline ---
g:airline#themes#supraonedark#palette = {}

final airline_info       = [fg, panel_b, 1, 2]
final airline_statusline = [fg, panel_c, 1, 2]

def Supraonedark_color(accent: string): any
	var m = airline#themes#generate_color_map([accent_fg, accent, 1, 2], airline_info, airline_statusline)
	return extend(m, {airline_warning: [bg0, warning, 1, 2], airline_error: [bg0, error, 1, 2]})
enddef

g:airline#themes#supraonedark#palette = {
	normal:   Supraonedark_color(blue),
	insert:   Supraonedark_color(green),
	replace:  Supraonedark_color(red),
	visual:   Supraonedark_color(yellow),
	terminal: Supraonedark_color(cyan),
	inactive: Supraonedark_color(grey),
}
