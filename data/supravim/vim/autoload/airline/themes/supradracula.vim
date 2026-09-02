vim9script

# --- Palette ---
final bg0     = '#1b1c25'
final panel_b = '#3b3e52'
final panel_c = '#15161d'
final fg      = '#f2f2ec'
final grey    = '#9b97d0'
final blue    = '#86dff3'
final green   = '#4def77'
final yellow  = '#dee783'
final orange  = '#ffb86c'
final red     = '#ff8989'
final cyan    = '#86dff3'
final purple  = '#c9a6fa'
final magenta = '#ff79c6'
final accent_fg = '#1b1c25'
final warning = '#dee783'
final error   = '#ff8989'

# --- Airline ---
g:airline#themes#supradracula#palette = {}

final airline_info       = [fg, panel_b, 1, 2]
final airline_statusline = [fg, panel_c, 1, 2]

def Supradracula_color(accent: string): any
	var m = airline#themes#generate_color_map([accent_fg, accent, 1, 2], airline_info, airline_statusline)
	return extend(m, {airline_warning: [bg0, warning, 1, 2], airline_error: [bg0, error, 1, 2]})
enddef

g:airline#themes#supradracula#palette = {
	normal:   Supradracula_color(blue),
	insert:   Supradracula_color(green),
	replace:  Supradracula_color(red),
	visual:   Supradracula_color(yellow),
	terminal: Supradracula_color(purple),
	inactive: Supradracula_color(grey),
}
