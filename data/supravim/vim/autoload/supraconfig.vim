vim9script

var registry: dict<any> = {}
var current_values: dict<any> = {}
var user_settings: any = null # Initialized to null to know whether the file must be read
var group_registry: dict<string> = {}

# Options documentation
# -----------------------------------------
# {
#   id: string,       # The unique identifier (must match the JSON key)
#   type: string,     # 'bool', 'string', 'number', 'choice', 'multiple_choice' (for your CLI)
#   choice: list<string>, # Required when type is 'choice'/'multiple_choice': the allowed values
#                         # 'multiple_choice' values are stored as a comma separated string
#   lore: string,     # The description shown to the user
#   default: any,     # The default value when absent from the JSON
#   spawn: func,      # (optional) Function run only once, but does not call handler() at startup
#   handler: func,    # The function run: (val) => { ... }
# }

####################
# MULTIPLE CHOICE  #
####################

def SplitChoices(value: any): list<string>
	if type(value) == v:t_list
		return copy(value)
	endif
	return filter(map(split($'{value}', ','), (_, v) => trim(v)), (_, v) => !empty(v))
enddef

def JoinChoices(values: list<string>): string
	return join(values, ',')
enddef

####################
# PUBLIC FUNCTIONS #
####################

########  Registers  ########
export def Register(option: dict<any>)
    if !has_key(option, 'id')
		!has_key(option, 'handler') 
		return
	endif

	var opt_type = get(option, 'type', '')
	if opt_type == 'choice' || opt_type == 'multiple_choice'
		var opts = get(option, 'choice', [])
		if type(opts) != v:t_list || empty(opts)
			echom printf(gettext("Option '%s' of type '%s' requires a non-empty 'choice' list", "supravim"), option.id, opt_type)
			return
		endif
	endif

    if user_settings == null
		InitCache()
	endif

	registry[option.id] = option
	var val_to_apply: any = get(user_settings, option.id, get(option, 'default', ''))
	if opt_type == 'choice' && index(option.choice, val_to_apply) == -1
		val_to_apply = get(option, 'default', option.choice[0])
	elseif opt_type == 'multiple_choice'
		val_to_apply = JoinChoices(filter(SplitChoices(val_to_apply), (_, v) => index(option.choice, v) != -1))
	endif
	try
		current_values[option.id] = val_to_apply
		if has_key(option, 'spawn')
			SpawnFunction(option.id, val_to_apply)
		else
			Apply(option.id, val_to_apply)
		endif
	catch
		echom printf(gettext("Error applying option '%s'", "supravim"), v:exception)
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

def SpawnFunction(id: string, value: any)
    if has_key(registry, id)
        current_values[id] = value
        var val_str = (type(value) == v:t_bool ? $'{value}' : value)
        registry[id].spawn(value)
    endif
enddef

def IsAllowed(id: string, value: any): bool
	var opt_type = get(registry[id], 'type', '')
	if opt_type == 'multiple_choice'
		for part in SplitChoices(value)
			if index(registry[id].choice, part) == -1
				echom printf(gettext("Invalid value '%s', expected one of: %s", "supravim"),
					part, join(registry[id].choice, ', '))
				return false
			endif
		endfor
		return true
	endif
	if opt_type != 'choice'
		return true
	endif
	if index(registry[id].choice, value) == -1
		echom printf(gettext("Invalid value '%s', expected one of: %s", "supravim"),
			value, join(registry[id].choice, ', '))
		return false
	endif
	return true
enddef

def Normalize(id: string, value: any): any
	if get(registry[id], 'type', '') == 'multiple_choice'
		return JoinChoices(SplitChoices(value))
	endif
	return value
enddef

export def Update(id: string, value: any)
    if has_key(registry, id) && IsAllowed(id, value)
        Apply(id, Normalize(id, value))
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
	if has_key(registry, id) && IsAllowed(id, value)
		current_values[id] = Normalize(id, value)
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
        if opt.type == 'choice' || opt.type == 'multiple_choice'
            options_map[id].choice = opt.choice
        endif
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
    user_settings = {} # Initialize as an empty dict by default
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

    # Only create the directory/file if there is something to save
    if !empty(to_save.options)
        const dir = fnamemodify(state_path, ':h')
        if !isdirectory(dir) | mkdir(dir, 'p') | endif
        writefile([json_encode(to_save)], state_path)
    elseif filereadable(state_path)
        # If everything is back to default, the file can be removed
        delete(state_path)
    endif
enddef
