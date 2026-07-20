vim9script

# --- Palette ---

final bg0     = '#1a212e'
final panel_b = '#283347'
final panel_c = '#141b24'
final fg      = '#93a4c3'
final grey    = '#455574'
final blue    = '#41a7fc'
final green   = '#8bcd5b'
final yellow  = '#efbd5d'
final orange  = '#dd9046'
final red     = '#f65866'
final cyan    = '#34bfd0'
final purple  = '#c75ae8'
final accent_fg = '#1a212e'
final warning = '#efbd5d'
final error   = '#f65866'

# --- Airline ---
g:airline#themes#supradeep#palette = {}

final airline_info       = [fg, panel_b, 1, 2]
final airline_statusline = [fg, panel_c, 1, 2]

def Supradeep_color(accent: string): any
	var m = airline#themes#generate_color_map([accent_fg, accent, 1, 2], airline_info, airline_statusline)
	return extend(m, {airline_warning: [bg0, warning, 1, 2], airline_error: [bg0, error, 1, 2]})
enddef

g:airline#themes#supradeep#palette = {
	normal:   Supradeep_color(blue),
	insert:   Supradeep_color(green),
	replace:  Supradeep_color(red),
	visual:   Supradeep_color(yellow),
	terminal: Supradeep_color(cyan),
	inactive: Supradeep_color(grey),
}
