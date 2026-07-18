vim9script

# thème airline pour le colorscheme gruvbox

# --- Palette ---
final bg0     = '#282828'
final panel_b = '#504945'
final panel_c = '#262626'
final fg      = '#ebdbb2'
final grey    = '#928374'
final blue    = '#80d6e8'
final green   = '#8cbf7a'
final yellow  = '#fabd2f'
final orange  = '#fe8019'
final red     = '#fb4934'
final cyan    = '#80d6e8'
final purple  = '#d3869b'
final magenta = '#db6bab'
final accent_fg = '#282828'
final warning = '#fabd2f'
final error   = '#fb4934'

# --- Airline ---
g:airline#themes#gruvbox#palette = {}

final airline_info       = [fg, panel_b, 1, 2]
final airline_statusline = [fg, panel_c, 1, 2]

def Gruvbox_color(accent: string): any
	var m = airline#themes#generate_color_map([accent_fg, accent, 1, 2], airline_info, airline_statusline)
	return extend(m, {airline_warning: [bg0, warning, 1, 2], airline_error: [bg0, error, 1, 2]})
enddef

g:airline#themes#gruvbox#palette = {
	normal:   Gruvbox_color(blue),
	insert:   Gruvbox_color(green),
	replace:  Gruvbox_color(red),
	visual:   Gruvbox_color(yellow),
	terminal: Gruvbox_color(purple),
	inactive: Gruvbox_color(grey),
}
