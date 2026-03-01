vim9script

var registry: dict<any> = {}
var current_values: dict<any> = {}
var user_settings: any = null # Initialisé à null pour savoir s'il faut lire le fichier
var group_registry: dict<string> = {}

# Documentation des options
# -----------------------------------------
# {
#   id: string,       # L'identifiant unique (doit matcher la clé du JSON)
#   type: string,     # 'bool', 'string', 'number', 'choice' (pour ton CLI)
#   lore: string,     # La description affichée à l'utilisateur
#   default: any,     # La valeur par défaut si absente du JSON
#   handler: func,    # La fonction exécutée : (val) => { ... }
# }

####################
# PUBLIC FUNCTIONS #
####################

########  Registers  ########
export def Register(option: dict<any>)
    if !has_key(option, 'id')
		!has_key(option, 'handler') 
		return
	endif

    if user_settings == null
		InitCache()
	endif
    
	registry[option.id] = option
	var val_to_apply: any = get(user_settings, option.id, get(option, 'default', ''))
	try
		if !has_key(option, 'spawn') || option.spawn == true
			Apply(option.id, val_to_apply)
		else
			current_values[option.id] = val_to_apply
		endif
	catch
		echom "Error applying option '" v:exception .. "'"
	endtry
enddef

export def RegisterMany(options: list<dict<any>>)
    for opt in options
		Register(opt)
	endfor
enddef

########  Groups  ########

export def RegisterGroup(name: string, lore: string)
    group_registry[name] = lore
enddef


########  Modifiers  ########

export def Apply(id: string, value: any)
    if has_key(registry, id)
        current_values[id] = value
        var val_str = (type(value) == v:t_bool ? $'{value}' : value)
        registry[id].handler(value)
    endif
enddef

export def Update(id: string, value: any)
    if has_key(registry, id)
        Apply(id, value)
        Save()
    endif
enddef

export def UpdateWithString(id: string, value: string)
	if has_key(registry, id)
		var opt_type = registry[id].type
		var parsed_value: any = value

		if opt_type == 'bool'
			Update(id, value ==# 'true')
		elseif opt_type == 'number'
			Update(id, str2nr(value))
		else
			Update(id, value)
		endif
	endif
enddef

export def UpdateWithoutApply(id: string, value: any)
	if has_key(registry, id)
		current_values[id] = value
		Save()
	endif
enddef

export def UpdateWithStringWithoutApply(id: string, value: string)
	if has_key(registry, id)
		var opt_type = registry[id].type
		var parsed_value: any = value

		if opt_type == 'bool'
			UpdateWithoutApply(id, value ==# 'true')
		elseif opt_type == 'number'
			UpdateWithoutApply(id, str2nr(value))
		else
			UpdateWithoutApply(id, value)
		endif
	endif
enddef

export def Reset(id: string)
    if has_key(registry, id) && has_key(registry[id], 'default')
        Update(id, registry[id].default)
    endif
enddef

########  Print  ########

export def PrintRegister()
    var options_map = {}
    for [id, opt] in items(registry)
        options_map[id] = {
            id: opt.id,
            lore: opt.lore,
            type: opt.type,
            default: opt.default,
            current: get(current_values, id, opt.default)
        }
    endfor

    # ON EMBALLE TOUT DANS UN SEUL PAQUET
    var package = {
        options: options_map,
        groups: group_registry
    }

    echo json_encode(package)
enddef

########  Cache  ########

def InitCache()
    user_settings = {} # On initialise comme un dict vide par défaut
    const state_path = expand('~/.config/supravim/state.json')
    
    if filereadable(state_path)
        var lines = readfile(state_path)
        if !empty(lines)
            try
                var full_state = json_decode(lines[0])
                user_settings = get(full_state, 'options', {})
            catch /E1161/
                # JSON corrompu
            endtry
        endif
    endif
enddef

def Save()
    const state_path = expand('~/.config/supravim/state.json')
    var to_save = {options: {}}
    
    for [id, val] in items(current_values)
        if has_key(registry, id) && val != registry[id].default
            to_save.options[id] = val
        endif
    endfor

    # On ne crée le dossier/fichier que s'il y a quelque chose à sauver
    if !empty(to_save.options)
        const dir = fnamemodify(state_path, ':h')
        if !isdirectory(dir) | mkdir(dir, 'p') | endif
        writefile([json_encode(to_save)], state_path)
    elseif filereadable(state_path)
        # Si tout est redevenu par défaut, on peut supprimer le fichier
        delete(state_path)
    endif
enddef
