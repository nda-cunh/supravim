vim9script

# thème airline pour le colorscheme atom

# --- Palette ---
final bg0     = '#1b1e26'
final panel_b = '#2c2f36'
final panel_c = '#1b1e26'
final fg      = '#c8d0dd'
final grey    = '#565d6b'
final blue    = '#6aa9f0'
final green   = '#8fd08a'
final yellow  = '#e0c986'
final orange  = '#e0a066'
final red     = '#e5717b'
final cyan    = '#5fc9d6'
final purple  = '#b48ef0'
final magenta = '#b48ef0'
final accent_fg = '#1b1e26'
final warning = '#e0c986'
final error   = '#e5717b'

# --- Airline ---
g:airline#themes#atom#palette = {}

final airline_info       = [fg, panel_b, 1, 2]
final airline_statusline = [fg, panel_c, 1, 2]

def Atom_color(accent: string): any
	var m = airline#themes#generate_color_map([accent_fg, accent, 1, 2], airline_info, airline_statusline)
	return extend(m, {airline_warning: [bg0, warning, 1, 2], airline_error: [bg0, error, 1, 2]})
enddef

g:airline#themes#atom#palette = {
	normal:   Atom_color(blue),
	insert:   Atom_color(green),
	replace:  Atom_color(red),
	visual:   Atom_color(yellow),
	terminal: Atom_color(purple),
	inactive: Atom_color(grey),
}
