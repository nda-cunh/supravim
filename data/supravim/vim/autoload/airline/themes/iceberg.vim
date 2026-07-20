vim9script

# --- Palette ---
final bg0     = '#161821'
final panel_b = '#3d425b'
final panel_c = '#14171f'
final fg      = '#c6c8d1'
final grey    = '#6b7089'
final blue    = '#80d6e8'
final green   = '#b4be82'
final yellow  = '#e2a478'
final orange  = '#eac6ad'
final red     = '#e27878'
final cyan    = '#89b8c2'
final purple  = '#7759b4'
final magenta = '#cc517a'
final accent_fg = '#161821'
final warning = '#e2a478'
final error   = '#e27878'

# --- Airline ---
g:airline#themes#iceberg#palette = {}

final airline_info       = [fg, panel_b, 1, 2]
final airline_statusline = [fg, panel_c, 1, 2]

def Iceberg_color(accent: string): any
	var m = airline#themes#generate_color_map([accent_fg, accent, 1, 2], airline_info, airline_statusline)
	return extend(m, {airline_warning: [bg0, warning, 1, 2], airline_error: [bg0, error, 1, 2]})
enddef

g:airline#themes#iceberg#palette = {
	normal:   Iceberg_color(blue),
	insert:   Iceberg_color(green),
	replace:  Iceberg_color(red),
	visual:   Iceberg_color(yellow),
	terminal: Iceberg_color(purple),
	inactive: Iceberg_color(grey),
}
