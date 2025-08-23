vim9script

import autoload 'ft_count_line.vim' as Ft_count_line

highlight Ft_count_line cterm=bold
g:sp_count_line = true	# shows how many lines have functions
call prop_type_add("ft_count_line", {highlight: "Ft_count_line"})

if g:sp_count_line == true
	autocmd BufEnter *.c,*.h call Ft_count_line.Ft_count_line()
	call Ft_count_line.EnableAugroup()
endif

autocmd User SupravimChangeOption call Ft_count_line.SimpleSupravimChangeOption()
