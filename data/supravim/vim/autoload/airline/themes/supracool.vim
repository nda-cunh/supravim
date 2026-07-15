vim9script

# navarasu/onedark.nvim · cool — thème airline pour le colorscheme supracool

# --- Palette ---
final bg0     = '#242b38'
final panel_b = '#343e4f'
final panel_c = '#1e242e'
final fg      = '#a5b0c5'
final grey    = '#546178'
final blue    = '#5ab0f6'
final green   = '#97ca72'
final yellow  = '#ebc275'
final orange  = '#d99a5e'
final red     = '#ef5f6b'
final cyan    = '#4dbdcb'
final purple  = '#ca72e4'
final accent_fg = '#242b38'
final warning = '#ebc275'
final error   = '#ef5f6b'

# --- Airline ---
g:airline#themes#supracool#palette = {}

final airline_info       = [fg, panel_b, 1, 2]
final airline_statusline = [fg, panel_c, 1, 2]

def Supracool_color(accent: string): any
	var m = airline#themes#generate_color_map([accent_fg, accent, 1, 2], airline_info, airline_statusline)
	return extend(m, {airline_warning: [bg0, warning, 1, 2], airline_error: [bg0, error, 1, 2]})
enddef

g:airline#themes#supracool#palette = {
	normal:   Supracool_color(blue),
	insert:   Supracool_color(green),
	replace:  Supracool_color(red),
	visual:   Supracool_color(yellow),
	terminal: Supracool_color(cyan),
	inactive: Supracool_color(grey),
}
