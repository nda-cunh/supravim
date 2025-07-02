vim9script

export def Infect()
	const lst = substitute(glob(expand("$HOME") .. "/.vim/bundle/*"), "\n", ",", "g")
	execute "set runtimepath+=" .. lst 
enddef
