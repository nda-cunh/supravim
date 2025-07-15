vim9script

export def Infect()
	var lst_glob = glob(expand("$HOME") .. "/.vim/bundle/*") .. "\n" .. glob(expand("$HOME") .. "/.vim/bundle/*/after")
	var lst = substitute(lst_glob, "\n", ",", "g")
	try 
		const cfg = readfile(glob(expand("$HOME") .. "/.config/supravim.cfg"))
		if (cfg == [])
			execute "set runtimepath+=" .. lst 
			return
		endif
		var split_lst = split(lst, ",")
		var new_lst = []
		var ed = true
		for i in range(len(split_lst))
			for j in range(len(cfg))
				var split_cfg = split(cfg[j], " ")
				if (split_cfg[0] == 'D')
					var split_path = split(split_lst[i], "/")
					if (split_path[len(split_path) - 1] == split_cfg[2])
						ed = false
					endif
				endif
			endfor
			if (ed == true)
				new_lst = add(new_lst, split_lst[i])
			endif
			ed = true
		endfor
		execute "set runtimepath+=" .. join(new_lst, ",")
	catch
		execute "set runtimepath+=" .. lst 
		return
	endtry
enddef
