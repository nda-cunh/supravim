vim9script

# Palette Atom

final base = '#1a1b26'
final surface = '#2a2e3e'
final overlay = '#1d2f3f'
final muted = '#6b7089'
final subtle = '#4f5666'
final text = '#d9e2e9'
final red = '#e27878'
final green = '#98f379'
final gold = '#c67832'
final rose = '#c678dd'

final warning = gold
final error = '#df444e'
final background = base 
final foreground = text 
final background_alt = overlay 
final background_grey = surface 

# --- Airline ---
g:airline#themes#atom#palette = {}

final airline_info = [foreground, background_grey, 1, 2]
final airline_statusline = [foreground, background_alt, 1, 2]

def Rosepine_moon_color(bg: string, txt: string): any
	var av1 = airline#themes#generate_color_map([txt, bg, 1, 2], airline_info, airline_statusline)
	return extend(av1, {airline_warning: [surface, warning, 1, 2], airline_error: [surface, error, 1, 2]})
enddef

g:airline#themes#atom#palette = {
	normal: Rosepine_moon_color(green, surface),
	insert: Rosepine_moon_color(gold, surface),
	replace: Rosepine_moon_color(rose, surface),
	inactive: Rosepine_moon_color(green, surface),
	visual: Rosepine_moon_color(green, surface),
	terminal: Rosepine_moon_color(gold, surface),
}
