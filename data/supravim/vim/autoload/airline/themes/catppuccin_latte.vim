vim9script

# --- Palette ---
final bg0     = '#eff1f5'
final panel_b = '#ccd0da'
final panel_c = '#eff1f5'
final fg      = '#4c4f69'
final grey    = '#9ca0b0'
final blue    = '#1e66f5'
final green   = '#40a02b'
final yellow  = '#fe640b'
final orange  = '#df8e1d'
final red     = '#d20f39'
final cyan    = '#04a5e5'
final purple  = '#8839ef'
final magenta = '#8839ef'
final accent_fg = '#eff1f5'
final warning = '#fe640b'
final error   = '#d20f39'

# --- Airline ---
g:airline#themes#catppuccin_latte#palette = {}

final airline_info       = [fg, panel_b, 1, 2]
final airline_statusline = [fg, panel_c, 1, 2]

def Catppuccin_color(accent: string): any
	var m = airline#themes#generate_color_map([accent_fg, accent, 1, 2], airline_info, airline_statusline)
	return extend(m, {airline_warning: [bg0, warning, 1, 2], airline_error: [bg0, error, 1, 2]})
enddef

g:airline#themes#catppuccin_latte#palette = {
	normal:   Catppuccin_color(blue),
	insert:   Catppuccin_color(green),
	replace:  Catppuccin_color(red),
	visual:   Catppuccin_color(yellow),
	terminal: Catppuccin_color(purple),
	inactive: Catppuccin_color(grey),
}
