vim9script

import autoload 'SupraWater.vim' as SupraWater
import autoload 'Colors.vim' as Colors

nnoremap - <scriptcmd>call SupraWater.Water()<CR>

var local: dict<any> = {}

autocmd VimEnter,BufEnter * if isdirectory(@%) | execute 'SupraWater.Water()' | endif

augroup SupraWater
	autocmd!
	autocmd User RefreshTree call SupraWater.Refresh()
augroup END

highlight link SupraWaterSign Error
autocmd ColorScheme * call Create_HiColor()
highlight link SupraWaterErrorSign Error
if exists('g:sp_symbol_signs')
	execute 'sign define SupraWaterSign text=' .. g:sp_symbol_signs .. ' texthl=SupraWaterErrorSign'
else
	execute 'sign define SupraWaterSign text=✖ texthl=SupraWaterErrorSign'
endif

 
def g:SupraCopyFile(src: string, dest: string)
	var stat = getfperm(src)
	call mkdir(fnamemodify(dest, ':h'), 'p')

	var content = readfile(src, 'b')
	writefile(content, dest, 'b')
	call setfperm(dest, stat)
enddef

def g:SupraMakeTempDir(): string
	var tmpdir = tempname()
	call mkdir(tmpdir, 'p')
	return tmpdir
enddef

def g:SupraCopyDir(src: string, dest: string)
	mkdir(dest, 'p')
	delete(dest, 'rf')
	echom 'cp -r ' .. shellescape(src) .. ' ' .. shellescape(dest)
	system('cp -r ' .. shellescape(src) .. ' ' .. shellescape(dest))
enddef

def Create_HiColor()
	var bgcolor = synIDattr(synIDtrans(hlID('Normal')), 'bg')
	var fgcolor = synIDattr(synIDtrans(hlID('Normal')), 'fg')
	if bgcolor == '' || fgcolor == ''
		bgcolor = '#24272e'
		fgcolor = '#ABB2BF'
	endif
	var darkened_bg = DarkenColor(bgcolor, 15)
	hi! link SignColumn Normal
	hi! link EndOfBuffer Normal
	execute 'hi clear NormalDark'
	execute 'hi clear SupraWaterPath'
	execute 'hi clear SupraWaterSort'
	execute 'hi NormalDark guifg=' .. fgcolor .. ' guibg=' .. darkened_bg
	execute "hi SupraWaterPath cterm=bold guifg=#f1c058 guibg=" .. darkened_bg
	execute "hi SupraWaterSort guifg=#00CAFF guibg=" .. darkened_bg
	call prop_type_delete("suprawater")
	call prop_type_delete("suprawatersigns")
	call prop_type_delete("suprawaterpath")
	call prop_type_delete("suprawatersort")
	call prop_type_add("suprawatersigns", {highlight: "SupraWaterSign"})
	call prop_type_add("suprawaterpath", {highlight: "SupraWaterPath"})
	call prop_type_add("suprawatersort", {highlight: "SupraWaterSort"})
	call prop_type_add("suprawater", {highlight: "NormalDark"})
	Colors.Create_all_Color(darkened_bg)
	SupraWater.Refresh()
enddef

def DarkenColor(_color: string, percent: number): string
	var color = _color
	if color[0] == '#'
		color = color[1 : ]
	endif

    var r: float = str2nr(color[0 : 1], 16) / 255.0
    var g: float = str2nr(color[2 : 3], 16) / 255.0
    var b: float = str2nr(color[4 : 5], 16) / 255.0

	var factor = (100.0 - percent) / 100.0
    r *= factor
    g *= factor
    b *= factor

	return printf('#%02X%02X%02X', float2nr(r * 255), float2nr(g * 255), float2nr(b * 255))
enddef

Create_HiColor()
