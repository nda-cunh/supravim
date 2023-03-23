vim9script
vnoremap c		:call Commentary()<CR>
noremap c		:call Commentary()<CR>
noremap gcc		:call Commentary()<CR>

def g:Commentary()
	var e = expand('%:e')
	var line = getline('.')

	if e == 'cpp' || e == 'vala'
		if line =~# '^// .*'
			var new_contents = substitute(line, '^// \(.*\)$', '\1', '')
			call setline('.', new_contents)
		else
			setline('.', '// ' .. line)
		endif
	elseif e == ''
		if line =~# '^# .* #$'
			var new_contents = substitute(line, '^# \(.*\) #$', '\1', '')
			call setline('.', new_contents)
		else
			setline('.', '# ' .. line .. ' #')
		endif
	elseif e == 'c'
		if line =~# '^/\* .* \*/$'
			var new_contents = substitute(line, '^/\* \(.*\) \*/$', '\1', '')
			call setline('.', new_contents)
		else
			setline('.', '/* ' .. line .. ' */')
		endif
	else
		if line =~# '^# .* #$'
			var new_contents = substitute(line, '^# \(.*\) #$', '\1', '')
			call setline('.', new_contents)
		else
			setline('.', '# ' .. line .. ' #')
		endif
	endif
enddef