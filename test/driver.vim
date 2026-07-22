
var __names: list<string> = []
for __line in split(execute('function /Test_'), "\n")
	var __n = matchstr(__line, '<SNR>\d\+_Test_\w\+')
	if __n != ''
		add(__names, __n)
	endif
endfor
sort(__names)

var __report: list<string> = []
for __name in __names
	var __short = substitute(__name, '^<SNR>\d\+_', '', '')
	v:errors = []
	try
		call(__name, [])
	catch
		add(v:errors, 'exception: ' .. v:exception .. ' @ ' .. v:throwpoint)
	endtry
	if empty(v:errors)
		add(__report, 'PASS ' .. __short)
	else
		add(__report, 'FAIL ' .. __short)
		for __e in v:errors
			add(__report, '    ' .. substitute(__e, "\n", ' ', 'g'))
		endfor
	endif
endfor

if empty(__names)
	add(__report, 'FAIL <aucune fonction Test_ trouvee>')
endif

writefile(__report, $SUPRAVIM_TEST_REPORT)
