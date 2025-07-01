vim9script

# Palette
final base = '#faf4ed'
final surface = '#fffaf3'
final overlay = '#f2e9e1'
final muted = '#9893a5'
final subtle = '#797593'
final text = '#575279'
final love = '#b4637a'
final gold = '#ea9d34'
final rose = '#d7827e'
final pine = '#286983'
final foam = '#56949f'
final iris = '#907aa9'
final highlight_low = '#f4ede8'
final highlight_med = '#dfdad9'
final highlight_high = '#cecacd'

final warning = gold
final error = '#df444e'

final background = base
final foreground = text
final background_alt = overlay
final background_grey = foam 

# --- Airline ---
g:airline#themes#rosepine_dawn#palette = {}

final airline_info = [base, background_grey, 1, 12]
final airline_statusline = [foreground, background_alt, 1, 2]

def Rosepine_moon_color(bg: string, txt: string): any
	var av1 = airline#themes#generate_color_map([txt, bg, 1, 2], airline_info, airline_statusline)
	return extend(av1, {airline_warning: [surface, warning, 1, 2], airline_error: [surface, error, 1, 2]})
enddef

g:airline#themes#rosepine_dawn#palette = {
	normal: Rosepine_moon_color(rose, surface),
	insert: Rosepine_moon_color(iris, surface),
	replace: Rosepine_moon_color(rose, surface),
	inactive: Rosepine_moon_color(iris, surface),
	visual: Rosepine_moon_color(pine, surface),
	terminal: Rosepine_moon_color(gold, surface),
}
