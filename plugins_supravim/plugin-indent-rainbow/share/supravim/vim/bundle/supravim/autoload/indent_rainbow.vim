vim9script

var ident_rainbow_is_load = false
var indent_match_id = []

def CreateRainbowHighlight(hex: string, index: number)
	# get the Normal Bg for simulate the alpha
	var normal_bg = synIDattr(synIDtrans(hlID('Normal')), 'bg')
	if normal_bg == ''
		normal_bg = '#000000'
	endif
	var r1 = str2nr(normal_bg[1 : 2], 16)
	var g1 = str2nr(normal_bg[3 : 4], 16)
	var b1 = str2nr(normal_bg[5 : 6], 16)
	var alpha = g:sp_indent_rainbow_opacity / 100.0
	var red = str2nr(hex[0 : 1], 16)
	var green = str2nr(hex[2 : 3], 16)
	var blue = str2nr(hex[4 : 5], 16)
	var r2 = float2nr((red * alpha) + (r1 * (1 - alpha)))
	var g2 = float2nr((green * alpha) + (g1 * (1 - alpha)))
	var b2 = float2nr((blue * alpha) + (b1 * (1 - alpha)))
	var hexcolor = '#' .. printf('%02x', r2) .. printf('%02x', g2) .. printf('%02x', b2)
	exec 'highlight Rainbow' .. index .. ' guibg=' .. hexcolor .. ' ctermbg=yellow'
enddef

export def GenerateRainbow()
	if g:sp_indent_rainbow_opacity <= 0
		# clear the highlights
		silent! highlight clear Rainbow1
		silent! highlight clear Rainbow2
		silent! highlight clear Rainbow3
		silent! highlight clear Rainbow4
		# clear the matches
		for i in indent_match_id
			call matchdelete(i)
			indent_match_id = []
		endfor
		ident_rainbow_is_load = false
		return
	endif
	# create the highlights
	CreateRainbowHighlight(g:sp_indent_rainbow_color_1, 1)
	CreateRainbowHighlight(g:sp_indent_rainbow_color_2, 2)
	CreateRainbowHighlight(g:sp_indent_rainbow_color_3, 3)
	CreateRainbowHighlight(g:sp_indent_rainbow_color_4, 4)
	if ident_rainbow_is_load == true 
		return
	endif
	ident_rainbow_is_load = true

	var tabstop = &tabstop
	var i = 0
	while i <= 100
		var nb_tab = i / tabstop
		const pattern = '^ \{' .. i .. '}\zs\s\{' .. tabstop .. '}'
		const pattern2 = '^\t\{' .. nb_tab .. '}\zs\t'
		var color_index = (i / tabstop) % 4 + 1
		indent_match_id->add(matchadd('Rainbow' .. color_index, pattern))
		indent_match_id->add(matchadd('Rainbow' .. color_index, pattern2))
		i = i + tabstop
	endwhile
enddef
