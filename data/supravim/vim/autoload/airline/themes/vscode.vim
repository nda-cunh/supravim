vim9script

# VSCode Dark+ — thème airline pour le colorscheme vscode

# --- Palette ---
final bg0     = '#1e1e1e'
final panel_b = '#37373d'
final panel_c = '#252526'
final fg      = '#d4d4d4'
final grey    = '#858585'
final blue    = '#007acc'
final green   = '#388a34'
final yellow  = '#dcdcaa'
final orange  = '#cc9057'
final red     = '#f44747'
final cyan    = '#4ec9b0'
final purple  = '#68217a'
final accent_fg = '#ffffff'
final warning = '#cca700'
final error   = '#f44747'

# --- Airline ---
g:airline#themes#vscode#palette = {}

final airline_info       = [fg, panel_b, 1, 2]
final airline_statusline = [fg, panel_c, 1, 2]

def Vscode_color(accent: string): any
	var m = airline#themes#generate_color_map([accent_fg, accent, 1, 2], airline_info, airline_statusline)
	return extend(m, {airline_warning: [bg0, warning, 1, 2], airline_error: [bg0, error, 1, 2]})
enddef

g:airline#themes#vscode#palette = {
	normal:   Vscode_color(blue),
	insert:   Vscode_color(green),
	replace:  Vscode_color(red),
	visual:   Vscode_color(yellow),
	terminal: Vscode_color(cyan),
	inactive: Vscode_color(grey),
}
