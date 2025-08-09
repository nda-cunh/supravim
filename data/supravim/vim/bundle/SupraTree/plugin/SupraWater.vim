vim9script

import autoload 'SupraWater.vim' as SupraWater

nnoremap - <scriptcmd>call SupraWater.Water()<CR>

var local: dict<any> = {}

autocmd VimEnter,BufEnter * if isdirectory(@%) | execute 'SupraWater.Water()' | endif

highlight SupraWaterPath cterm=bold guifg=#f1c058
highlight SupraWaterSort guifg=#00CAFF
highlight link SupraWaterSign Error

# Virtual Text for icons
call prop_type_add("suprawatersigns", {highlight: "SupraWaterSign"})
call prop_type_add("suprawaterpath", {highlight: "SupraWaterPath"})
call prop_type_add("suprawatersort", {highlight: "SupraWaterSort"})
call prop_type_add("suprawater", {})
 
def g:SupraCopyFile(src: string, dest: string)
	# keep chmod
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

highlight link SupraWaterErrorSign Error
if exists('g:sp_symbol_signs')
	execute 'sign define SupraWaterSign text=' .. g:sp_symbol_signs .. ' texthl=SupraWaterErrorSign'
else
	execute 'sign define SupraWaterSign text=✖ texthl=SupraWaterErrorSign'
endif
