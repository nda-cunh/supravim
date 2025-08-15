vim9script

#####################################
# Highlighting and properties
#####################################

export var colors: dict<any> = {}

def InitColor(bg_color: string, name: string, color: string, lst: list<string>)
	const name_prop = 'suprawaterFile' .. name
	execute 'hi clear ' .. name_prop
	execute 'hi ' .. name_prop .. ' ' .. color .. ' guibg=' .. bg_color
	call prop_type_delete(name_prop)
	call prop_type_add(name_prop, {highlight: name_prop})
	for i in lst
		colors[i] = name_prop
	endfor
enddef

export def Create_all_Color(bg_color: string)
	var bg_dir = synIDattr(synIDtrans(hlID('Directory')), 'fg')
	InitColor(bg_color, 'Folder', 'guifg=' .. bg_dir, ['FOLDER'])
	InitColor(bg_color, 'Deleted', 'ctermfg=red guifg=#f44444', ['DELETED'])
	InitColor(bg_color, 'Vim', 'ctermfg=green guifg=#06923E', ['vim', 'vimrc', '.vimrc'])
	InitColor(bg_color, 'HPP', 'ctermfg=green guifg=#5CB338', ['hpp', 'h'])
	InitColor(bg_color, 'C', 'ctermfg=blue guifg=#344CB7', ['c', 'cpp'])
	InitColor(bg_color, 'Lua', 'ctermfg=blue guifg=#00CAFF', ['lua', 'meson.build'])
	InitColor(bg_color, 'Vala', 'ctermfg=magenta guifg=#7239b3', ['vala', 'cs'])
	InitColor(bg_color, 'JavaScript', 'ctermfg=blue guifg=#F1C058', ['js', 'javascript', 'ts'])
	InitColor(bg_color, 'HTML', 'ctermfg=blue guifg=#F1C058', ['html', 'css'])
	InitColor(bg_color, 'Markdown', 'ctermfg=blue guifg=#F1C058', ['md', 'markdown'])
	InitColor(bg_color, 'JSonxml', 'ctermfg=blue guifg=#F1C058', ['json', 'xml', 'toml', 'blp', 'vsupp'])
	InitColor(bg_color, 'Shell', 'ctermfg=223 guifg=#FDEBD0', ['sh', 'bash', 'zsh'])
	InitColor(bg_color, 'Java', 'ctermfg=130 guifg=#E84393', ['java'])
	InitColor(bg_color, 'Go', 'ctermfg=108 guifg=#00B4D8', ['go', 'jpg', 'jpeg', 'png', 'gif', 'webp'])
	InitColor(bg_color, 'Rust', 'ctermfg=130 guifg=#DE3163', ['rs', 'rust'])
	InitColor(bg_color, 'Ruby', 'ctermfg=161 guifg=#CC0000', ['rb', 'ruby'])
	InitColor(bg_color, 'PHP', 'ctermfg=135 guifg=#A569BD', ['php'])
	InitColor(bg_color, 'Swift', 'ctermfg=211 guifg=#FF9F1C', ['swift'])
	InitColor(bg_color, 'Kotlin', 'ctermfg=131 guifg=#6C3483', ['kt', 'kotlin'])
	InitColor(bg_color, 'Python', 'ctermfg=166 guifg=#F39C12', ['py', 'python'])
	InitColor(bg_color, 'SQL', 'ctermfg=cyan guifg=#00FFFF', ['sql'])
	InitColor(bg_color, 'Perl', 'ctermfg=magenta guifg=#FF00FF', ['pl', 'perl'])
	InitColor(bg_color, 'Scala', 'ctermfg=red guifg=#DC322F', ['scala', 'sc'])
	InitColor(bg_color, 'Dart', 'ctermfg=cyan guifg=#00B4AB', ['dart'])
	InitColor(bg_color, 'YAML', 'ctermfg=yellow guifg=#FFD700', ['yaml', 'yml'])
	InitColor(bg_color, 'Dockerfile', 'ctermfg=blue guifg=#1D8IDA', ['dockerfile'])
	InitColor(bg_color, 'GraphQL', 'ctermfg=magenta guifg=#E10098', ['graphql', 'gql'])
	InitColor(bg_color, 'Makefile', 'ctermfg=red guifg=#E24044', ['Makefile', 'mk', '.gitignore', 'git'])
enddef
