vim9script

# Palette
final base = '#232136'
final surface = '#2a273f'
final overlay = '#393552'
final muted = '#6e6a86'
final subtle = '#908caa'
final text = '#e0def4'
final love = '#eb6f92'
final gold = '#f6c177'
final rose = '#ea9a97'
final pine = '#3e8fb0'
final foam = '#9ccfd8'
final iris = '#c4a7e7'
final highlight_low = '#2a283e'
final highlight_med = '#44415a'
final highlight_high = '#56526e'
final warning = gold
final error = '#df444e'

final background = surface
final foreground = text
final background_alt = surface
final background_grey = muted

# --- Airline ---
g:airline#themes#rosepine_moon#palette = {}

final airline_info = [foreground, background_grey, 1, 2]
final airline_statusline = [foreground, background_alt, 1, 2]

def Rosepine_moon_color(bg: string, txt: string): any
	var av1 = airline#themes#generate_color_map([txt, bg, 1, 2], airline_info, airline_statusline)
	return extend(av1, {airline_warning: [surface, warning, 1, 2], airline_error: [surface, error, 1, 2]})
enddef

g:airline#themes#rosepine_moon#palette = {
	normal: Rosepine_moon_color(iris, surface),
	insert: Rosepine_moon_color(gold, surface),
	replace: Rosepine_moon_color(rose, surface),
	inactive: Rosepine_moon_color(foam, surface),
	visual: Rosepine_moon_color(pine, surface),
	terminal: Rosepine_moon_color(gold, surface),
}
