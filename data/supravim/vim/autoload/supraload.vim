vim9script

export def Infect()
	const lst_glob = glob($HOME .. "/.vim/bundle/*") .. "\n" .. glob(expand("$HOME") .. "/.vim/bundle/*/after")
	const lst = substitute(lst_glob, "\n", ",", "g")
	try 
		const cfg = readfile($HOME .. "/.config/supravim.cfg")
		const split_lst = split(lst, ",")
		var new_lst = []
		var ed = true
		const len_cfg = len(cfg)
		for i in range(len(split_lst))
			for j in range(len_cfg)
				var idx = strridx(cfg[j], ' ')
				const cfg_name = cfg[j][idx + 1 : ]
				if (stridx(cfg[j], 'D') == 0)
					idx = strridx(split_lst[i], '/')
					if (split_lst[i][idx + 1 : ] == cfg_name)
						ed = false
						break
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
	endtry
enddef
