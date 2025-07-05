vim9script

export def Infect()
	var lst_glob = glob(expand("$HOME") .. "/.vim/bundle/*") .. "\n" .. glob(expand("$HOME") .. "/.vim/bundle/*/after")
	const lst = substitute(lst_glob, "\n", ",", "g")
	execute "set runtimepath+=" .. lst 
enddef
