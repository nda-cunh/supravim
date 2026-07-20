vim9script

# --- Palette ---
final bg0     = '#24273a'
final panel_b = '#363a4f'
final panel_c = '#24273a'
final fg      = '#cad3f5'
final grey    = '#6e738d'
final blue    = '#8aadf4'
final green   = '#a6da95'
final yellow  = '#eed49f'
final orange  = '#f5a97f'
final red     = '#ed8796'
final cyan    = '#91d7e3'
final purple  = '#c6a0f6'
final magenta = '#c6a0f6'
final accent_fg = '#24273a'
final warning = '#eed49f'
final error   = '#ed8796'

# --- Airline ---
g:airline#themes#catppuccin_macchiato#palette = {}

final airline_info       = [fg, panel_b, 1, 2]
final airline_statusline = [fg, panel_c, 1, 2]

def Catppuccin_color(accent: string): any
	var m = airline#themes#generate_color_map([accent_fg, accent, 1, 2], airline_info, airline_statusline)
	return extend(m, {airline_warning: [bg0, warning, 1, 2], airline_error: [bg0, error, 1, 2]})
enddef

g:airline#themes#catppuccin_macchiato#palette = {
	normal:   Catppuccin_color(blue),
	insert:   Catppuccin_color(green),
	replace:  Catppuccin_color(red),
	visual:   Catppuccin_color(yellow),
	terminal: Catppuccin_color(purple),
	inactive: Catppuccin_color(grey),
}
