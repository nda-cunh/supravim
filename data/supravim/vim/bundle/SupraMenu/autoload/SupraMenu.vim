vim9script

export type RowBlock = dict<any>
export type ListRow = list<RowBlock>
export type MenuCallback = func(dict<any>): RowBlock 

var plugins: list<MenuCallback> = []

export def Register(Callback: MenuCallback)
	add(plugins, Callback)
enddef

export def Unregister(Callback: MenuCallback)
	var idx = index(plugins, Callback)
	if idx != -1
		remove(plugins, idx)
	endif
enddef

def Clear()
	silent! aunmenu PopUp
enddef

def Build()
	var context = {
		ft: &filetype,
		word: expand('<cword>'),
		path: expand('%:p'),
		is_git: isdirectory('.git'),
		line: line('.')
	}

	var index_sep: number = 0
	var vneed_sep: bool = false
	var ineed_sep: bool = false
	var nneed_sep: bool = false

	for Pl in plugins
		# Insert separator if needed
		if vneed_sep
			execute 'vmenu PopUp.--sep' .. index_sep .. '--   <Nop>'
			index_sep += 1
			vneed_sep = false
		endif
		if ineed_sep
			execute 'imenu PopUp.--sep' .. index_sep .. '-.   <Nop>'
			index_sep += 1
			ineed_sep = false
		endif
		if nneed_sep
			execute 'nmenu PopUp.--sep' .. index_sep .. '-   <Nop>'
			index_sep += 1
			nneed_sep = false
		endif

		# Get the menu rows
		try
			var value: RowBlock = Pl(context)
			if empty(value)
				continue
			endif
			for action in value.rows
				if action == {}
					continue
				endif
				const label = get(action, 'label', '')
				const cmd = get(action, 'cmd', '')
				const icon = get(action, 'icon', '')
				const type = get(action, 'type', 'a')

				if type == 'v'
					vneed_sep = true
				elseif type == 'n'
					nneed_sep = true
				elseif type == 'i'
					ineed_sep = true
				endif

				var menu_path = ''
				if icon != ''
					menu_path ..= icon .. '\ '
				endif
				menu_path ..= substitute(label, ' ', '\\ ', 'g')

				execute $"{type}menu PopUp.{menu_path}    {cmd}"
			endfor
		catch
			echohl WarningMsg
			echom $"[SupraMenu] Erreur dans le plugin: {v:exception}"
			echohl None
		endtry

	endfor
enddef

export def Open()
	Clear()
	Build()
	feedkeys("\<RightMouse>", 'nt')
enddef
