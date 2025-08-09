vim9script

#####################################
# Highlighting and properties
#####################################

export var colors: dict<any> = {}

def InitColor(name: string, color: string, lst: list<string>)
	const name_prop = 'suprawaterFile' .. name
	execute 'highlight ' .. name_prop .. ' ' .. color
	call prop_type_add(name_prop, {highlight: name_prop})
	for i in lst
		colors[i] = name_prop
	endfor
enddef

InitColor('Deleted', 'ctermfg=red guifg=#f44444', ['DELETED'])
InitColor('Folder', 'guifg=#f1c058', ['FOLDER'])
InitColor('Vim', 'ctermfg=green guifg=#06923E', ['vim', 'vimrc', '.vimrc'])
InitColor('HPP', 'ctermfg=green guifg=#5CB338', ['hpp', 'h'])
InitColor('C', 'ctermfg=blue guifg=#344CB7', ['c', 'cpp'])
InitColor('Lua', 'ctermfg=blue guifg=#00CAFF', ['lua', 'meson.build'])
InitColor('Vala', 'ctermfg=magenta guifg=#7239b3', ['vala', 'cs'])
InitColor('JavaScript', 'ctermfg=blue guifg=#F1C058', ['js', 'javascript', 'ts'])
InitColor('HTML', 'ctermfg=blue guifg=#F1C058', ['html', 'css'])
InitColor('Markdown', 'ctermfg=blue guifg=#F1C058', ['md', 'markdown'])
InitColor('JSonxml', 'ctermfg=blue guifg=#F1C058', ['json', 'xml', 'toml', 'blp', 'vsupp'])
InitColor('Shell', 'ctermfg=223 guifg=#FDEBD0', ['sh', 'bash', 'zsh'])
InitColor('Java', 'ctermfg=130 guifg=#E84393', ['java'])
InitColor('Go', 'ctermfg=108 guifg=#00B4D8', ['go', 'jpg', 'jpeg', 'png', 'gif', 'webp'])
InitColor('Rust', 'ctermfg=130 guifg=#DE3163', ['rs', 'rust'])
InitColor('Ruby', 'ctermfg=161 guifg=#CC0000', ['rb', 'ruby'])
InitColor('PHP', 'ctermfg=135 guifg=#A569BD', ['php'])
InitColor('Swift', 'ctermfg=211 guifg=#FF9F1C', ['swift'])
InitColor('Kotlin', 'ctermfg=131 guifg=#6C3483', ['kt', 'kotlin'])
InitColor('Python', 'ctermfg=166 guifg=#F39C12', ['py', 'python'])
InitColor('SQL', 'ctermfg=cyan guifg=#00FFFF', ['sql'])
InitColor('Perl', 'ctermfg=magenta guifg=#FF00FF', ['pl', 'perl'])
InitColor('Scala', 'ctermfg=red guifg=#DC322F', ['scala', 'sc'])
InitColor('Dart', 'ctermfg=cyan guifg=#00B4AB', ['dart'])
InitColor('YAML', 'ctermfg=yellow guifg=#FFD700', ['yaml', 'yml'])
InitColor('Dockerfile', 'ctermfg=blue guifg=#1D8IDA', ['dockerfile'])
InitColor('GraphQL', 'ctermfg=magenta guifg=#E10098', ['graphql', 'gql'])
InitColor('Makefile', 'ctermfg=red guifg=#E24044', ['Makefile', 'mk', '.gitignore', 'git'])
