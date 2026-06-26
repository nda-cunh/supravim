vim9script

export def Infect()
	const lst_glob = glob($HOME .. "/.vim/bundle/*") .. "\n" .. glob($HOME .. "/.vim/bundle/*/after")
	const lst = substitute(lst_glob, "\n", ",", "g")
	const filename = $HOME .. "/.config/supravim/supravim.json"
	try
		const json_raw = join(readfile(filename), "\n")
		const cfg = json_decode(json_raw)
		var disabled: dict<bool> = {}
		for p in get(cfg, 'plugins', [])
			if !get(p, 'enabled', true)
				disabled[get(p, 'name', '')] = true
			endif
		endfor
		var new_lst: list<string> = []
		for path in split(lst, ",")
			var name = path[strridx(path, '/') + 1 :]
			if name == 'after'
				const parent = path[: strridx(path, '/') - 1]
				name = parent[strridx(parent, '/') + 1 :]
			endif
			if !get(disabled, name, false)
				new_lst->add(path)
			endif
		endfor
		execute "set runtimepath+=" .. join(new_lst, ",")
	catch /E484:/
		# check if the json is here : "~/.config/supravim.json" move it to "~/.config/supravim/supravim.json"
		if filereadable($HOME .. "/.config/supravim.json")
			call rename($HOME .. "/.config/supravim.json", $HOME .. "/.config/supravim/supravim.json")
			call Infect()
		else
			execute "set runtimepath+=" .. lst
		endif
	catch
		execute "set runtimepath+=" .. lst
	endtry
	runtime! ftdetect/*.vim
enddef
