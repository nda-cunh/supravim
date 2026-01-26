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
    const mouse_pos = getmousepos()
	const context = {
		ft: &filetype,
		bufnr: bufnr('%'),
        word: expand('<cword>'),
        path: expand('%:p'),
        is_git: isdirectory('.git'),
        line: mouse_pos.line,
        col: mouse_pos.column,
        winid: mouse_pos.winid,
        screenrow: mouse_pos.screenrow,
        screencol: mouse_pos.screencol
	}

    var index_sep = 0
    # On sépare les suivis pour éviter que le contenu 'n' déclenche un sep en 'v'
    var has_n = false
    var has_v = false
    var pending_n = false
    var pending_v = false

	var lst: ListRow = []
	for Pl in plugins
		var value: RowBlock
		try | value = Pl(context) | catch | continue | endtry
		if empty(value) || !has_key(value, 'rows') | continue | endif
		add(lst, value)
	endfor

	lst = sort(lst, (a, b) => get(b, 'priority', 0) - get(a, 'priority', 0))

    for Pl in lst 
        var value: RowBlock = Pl

        for action in value.rows
            if empty(action) | continue | endif
            
            var type = get(action, 'type', 'n')
            var label = get(action, 'label', '')

            # 1. Gestion des séparateurs (internes ou inter-plugins)
            if type == 's' || label == '---'
                if has_n | pending_n = true | endif
                if has_v | pending_v = true | endif
                continue
            endif

            # 2. Logique spécifique par mode
            if type == 'n'
                # Si c'est un nouveau plugin (pas le premier), on prépare un sep
                if has_n && label != '' && index_sep == 0 # Simplifié pour l'exemple
                    pending_n = true 
                endif

                if pending_n
                    execute $'nmenu PopUp.--sep{index_sep}-- <Nop>'
                    index_sep += 1
                    pending_n = false
                endif
                # ... execute nmenu ...
                has_n = true

            elseif type == 'v'
                # On ne met le sep QUE si le mode visuel a déjà eu un item
                if pending_v
                    execute $'vmenu PopUp.--sep{index_sep}-- <Nop>'
                    index_sep += 1
                    pending_v = false
                endif
                # ... execute vmenu ...
                has_v = true
            endif
            
            # (Appliquer le même pattern pour 'i' si nécessaire)
            
            var cmd = get(action, 'cmd', '')
            var icon = get(action, 'icon', '')
            var menu_path = (icon != '' ? icon .. '\ ' : '') .. substitute(label, ' ', '\\ ', 'g')
            execute $'{type}menu PopUp.{menu_path} {cmd}'
        endfor
        
        # À la fin de chaque plugin, on prépare le terrain pour le suivant
        if has_n | pending_n = true | endif
        if has_v | pending_v = true | endif
    endfor
enddef



export def Open()
	const pos = getmousepos()
	const cursor_pos = getpos('.')
	call setpos('.', [0, pos.line, pos.column, 0])
	Clear()
	Build()
	feedkeys("\<RightMouse>", 'nt')
	call setpos('.', cursor_pos)
enddef
