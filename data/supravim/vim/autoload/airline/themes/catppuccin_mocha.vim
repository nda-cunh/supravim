vim9script

# --- Palette ---
final bg0     = '#1e1e2e'
final panel_b = '#313244'
final panel_c = '#1e1e2e'
final fg      = '#cdd6f4'
final grey    = '#6c7086'
final blue    = '#89b4fa'
final green   = '#a6e3a1'
final yellow  = '#f9e2af'
final orange  = '#fab387'
final red     = '#f38ba8'
final cyan    = '#89dceb'
final purple  = '#cba6f7'
final magenta = '#cba6f7'
final accent_fg = '#1e1e2e'
final warning = '#f9e2af'
final error   = '#f38ba8'

# --- Airline ---
g:airline#themes#catppuccin_mocha#palette = {}

final airline_info       = [fg, panel_b, 1, 2]
final airline_statusline = [fg, panel_c, 1, 2]

def Catppuccin_color(accent: string): any
	var m = airline#themes#generate_color_map([accent_fg, accent, 1, 2], airline_info, airline_statusline)
	return extend(m, {airline_warning: [bg0, warning, 1, 2], airline_error: [bg0, error, 1, 2]})
enddef

g:airline#themes#catppuccin_mocha#palette = {
	normal:   Catppuccin_color(blue),
	insert:   Catppuccin_color(green),
	replace:  Catppuccin_color(red),
	visual:   Catppuccin_color(yellow),
	terminal: Catppuccin_color(purple),
	inactive: Catppuccin_color(grey),
}
