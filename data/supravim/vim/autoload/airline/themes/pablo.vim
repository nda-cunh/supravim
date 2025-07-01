vim9script

# Palette Pablo 

final base = '#000000'
final surface = '#101010'
final overlay = '#2a2a2a'
final muted = '#4b4b4b'
final subtle = '#5a5a5a'
final text = '#d4d4d4'
final red = '#df444e'
final green = '#0f9d58'
final blue = '#0f9df8'
final gold = '#f2d600'
final rose = '#ff2d6f'

final warning = gold
final error = '#df444e'
final background = base 
final foreground = text 
final background_alt = overlay 
final background_grey = surface 

# --- Airline ---
g:airline#themes#pablo#palette = {}

final airline_info = [foreground, background_grey, 1, 2]
final airline_statusline = [foreground, background_alt, 1, 2]

def Rosepine_moon_color(bg: string, txt: string): any
	var av1 = airline#themes#generate_color_map([txt, bg, 1, 2], airline_info, airline_statusline)
	return extend(av1, {airline_warning: [surface, warning, 1, 2], airline_error: [surface, error, 1, 2]})
enddef

g:airline#themes#pablo#palette = {
	normal: Rosepine_moon_color(green, surface),
	insert: Rosepine_moon_color(blue, surface),
	replace: Rosepine_moon_color(rose, surface),
	inactive: Rosepine_moon_color(green, surface),
	visual: Rosepine_moon_color(green, surface),
	terminal: Rosepine_moon_color(gold, surface),
}
