vim9script

final bg0     = '#323237'
final panel_b = '#45454d'
final panel_c = '#2a2a2f'
final fg      = '#dcdfe8'
final grey    = '#7183bd'
final blue    = '#80a0ff'
final green   = '#7ce08a'
final yellow  = '#f2e86e'
final orange  = '#f2b45f'
final red     = '#f2606e'
final cyan    = '#5ad4e6'
final pink    = '#e88ae8'
final accent_fg = '#323237'
final warning = '#f2e86e'
final error   = '#f2606e'

g:airline#themes#supraevening#palette = {}

final airline_info       = [fg, panel_b, 1, 2]
final airline_statusline = [fg, panel_c, 1, 2]

def Supraevening_color(accent: string): any
	var m = airline#themes#generate_color_map([accent_fg, accent, 1, 2], airline_info, airline_statusline)
	return extend(m, {airline_warning: [bg0, warning, 1, 2], airline_error: [bg0, error, 1, 2]})
enddef

g:airline#themes#supraevening#palette = {
	normal:   Supraevening_color(yellow),
	insert:   Supraevening_color(green),
	replace:  Supraevening_color(red),
	visual:   Supraevening_color(blue),
	terminal: Supraevening_color(cyan),
	inactive: Supraevening_color(grey),
}
