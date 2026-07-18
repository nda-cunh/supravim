vim9script

# thème airline pour le colorscheme catppuccin_frappe

# --- Palette ---
final bg0     = '#303446'
final panel_b = '#414559'
final panel_c = '#303446'
final fg      = '#c6d0f5'
final grey    = '#737994'
final blue    = '#8caaee'
final green   = '#a6d189'
final yellow  = '#e5c890'
final orange  = '#ef9f76'
final red     = '#e78284'
final cyan    = '#99d1db'
final purple  = '#ca9ee6'
final magenta = '#f4b8e4'
final accent_fg = '#303446'
final warning = '#e5c890'
final error   = '#e78284'

# --- Airline ---
g:airline#themes#catppuccin_frappe#palette = {}

final airline_info       = [fg, panel_b, 1, 2]
final airline_statusline = [fg, panel_c, 1, 2]

def Catppuccin_color(accent: string): any
	var m = airline#themes#generate_color_map([accent_fg, accent, 1, 2], airline_info, airline_statusline)
	return extend(m, {airline_warning: [bg0, warning, 1, 2], airline_error: [bg0, error, 1, 2]})
enddef

g:airline#themes#catppuccin_frappe#palette = {
	normal:   Catppuccin_color(blue),
	insert:   Catppuccin_color(green),
	replace:  Catppuccin_color(red),
	visual:   Catppuccin_color(yellow),
	terminal: Catppuccin_color(purple),
	inactive: Catppuccin_color(grey),
}
