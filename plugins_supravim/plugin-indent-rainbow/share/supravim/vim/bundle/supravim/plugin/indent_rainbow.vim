vim9script

import autoload 'indent_rainbow.vim' as Rainbow

g:sp_indent_rainbow_color_1 = "FFFF40"	# the first color for indent_rainbow
g:sp_indent_rainbow_color_2 = "7FFF7F"	# the second color for indent_rainbow
g:sp_indent_rainbow_color_3 = "FF7FFF"	# the third color for indent_rainbow
g:sp_indent_rainbow_color_4 = "4FECEC"	# the fourth color for indent_rainbow
g:sp_indent_rainbow_opacity = 7	# the opacity of indent_rainbow, from 0 to 100

def RainbowChangeOption()
	if g:supravim_option_changed->stridx('indent_rainbow') != -1
		Rainbow.GenerateRainbow()
	endif
enddef

Rainbow.GenerateRainbow()

autocmd Colorscheme * call Rainbow.GenerateRainbow()
autocmd User SupravimChangeOption call RainbowChangeOption()
