vim9script

export def Infect()
	const lst_glob = glob($HOME .. "/.vim/bundle/*") .. "\n" .. glob($HOME .. "/.vim/bundle/*/after")
	const lst = substitute(lst_glob, "\n", ",", "g")
	try
		const json_raw = join(readfile($HOME .. "/.config/supravim.json"), "\n")
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
	catch
		execute "set runtimepath+=" .. lst
	endtry
	runtime! ftdetect/*.vim
enddef
