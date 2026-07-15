vim9script

# navarasu/onedark.nvim · warmer — thème airline pour le colorscheme suprawarmer

# --- Palette ---
final bg0     = '#232326'
final panel_b = '#35363b'
final panel_c = '#1b1c1e'
final fg      = '#a7aab0'
final grey    = '#5a5b5e'
final blue    = '#57a5e5'
final green   = '#8fb573'
final yellow  = '#dbb671'
final orange  = '#c49060'
final red     = '#de5d68'
final cyan    = '#51a8b3'
final purple  = '#bb70d2'
final accent_fg = '#232326'
final warning = '#dbb671'
final error   = '#de5d68'

# --- Airline ---
g:airline#themes#suprawarmer#palette = {}

final airline_info       = [fg, panel_b, 1, 2]
final airline_statusline = [fg, panel_c, 1, 2]

def Suprawarmer_color(accent: string): any
	var m = airline#themes#generate_color_map([accent_fg, accent, 1, 2], airline_info, airline_statusline)
	return extend(m, {airline_warning: [bg0, warning, 1, 2], airline_error: [bg0, error, 1, 2]})
enddef

g:airline#themes#suprawarmer#palette = {
	normal:   Suprawarmer_color(blue),
	insert:   Suprawarmer_color(green),
	replace:  Suprawarmer_color(red),
	visual:   Suprawarmer_color(yellow),
	terminal: Suprawarmer_color(cyan),
	inactive: Suprawarmer_color(grey),
}
