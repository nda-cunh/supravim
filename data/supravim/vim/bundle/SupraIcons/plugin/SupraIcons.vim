vim9script

##################################
#  All Icons for SupraIcons
##################################

const file_node_extensions = {
	'styl': '',
	'htm': '',
	'html': '',
	'slim': '',
	'ttf': '',
	'otf': '',
	'woff': '',
	'woff2': '',
	'eot': '',
	'haml': '',
	'js': '',
	'mjs': '',
	'ejs': '',
	'cjs': '',
	'css': '',
	'less': '',
	'md': '',
	'mdx': '',
	'markdown': '',
	'rmd': '',
	'json': '',
	'webmanifest': '',
	'zig': '',
	'nim': '',
	'scss': '',
	'sass': '',
	'jsx': '',
	'rb': '',
	'gemspec': '',
	'rake': '',
	'php': '',
	'py': '',
	'pyc': '',
	'pyo': '',
	'pyd': '',
	'coffee': '',
	'mustache': '',
	'hbs': '',
	'conf': '',
	'ini': '',
	'yml': '',
	'yaml': '',
	'toml': '',
	'bat': '',
	'mk': '',
	'svg': '󰜡',
	'svgz': '󰜡',
	'jpg': '',
	'tex': '',
	'latex': '',
	'jpeg': '',
	'bmp': '',
	'png': '',
	'webp': '',
	'gif': '',
	'ico': '',
	'twig': '',
	'svelte': '',
	'cpp': '',
	'c++': '',
	'cxx': '',
	'cc': '',
	'cp': '',
	'c': '',
	'blp': '',
	'cs': '󰌛',
	'h': '',
	'hh': '',
	'hpp': '',
	'hxx': '',
	'hs': '',
	'lhs': '',
	'nix': '',
	'lua': '',
	'java': '',
	'water': '󰥨',
	'vala': '',
	'vapi': '',
	'kt': '',
	'kts': '',
	'ktm': '',
	'ktsm': '',
	'odt': '',
	'ods': '',
	'odp': '',
	'odg': '',
	'odb': '',
	'odf': '',
	'docx': '󱎒',
	'doc': '󱎒',
	'xlsx': '󱎏',
	'xls': '󱎏',
	'pptx': '󱎐',
	'ppt': '󱎐',
	'accdb': '󱎎',
	'mdb': '󱎎',
	'one': '󰝇',
	'pdf': '',
	'zip': '',
	'tar': '',
	'gz': '',
	'7z': '',
	'xz': '',
	'bz2': '',
	'asm': '',
	'cfg': '',
	'deb': '',
	'log': '',
	's': '',
	'bin': '',
	'iso': '',
	'ld': '',
	'mp4': '',
	'mkv': '',
	'avi': '',
	'mov': '',
	'mp3': '',
	'wav': '',
	'flac': '',
	'ogg': '',
	'opus': '',
	'm3u': '',
	'suprapack': '',
	'xml': '󰗀',
	'o': '',
	'sh': '',
	'fish': '',
	'bash': '',
	'zsh': '',
	'ksh': '',
	'csh': '',
	'awk': '',
	'ps1': '',
	'ml': 'λ',
	'mli': 'λ',
	'diff': '',
	'pg': '',
	'db': '',
	'sql': '',
	'dump': '',
	'clj': '',
	'cljc': '',
	'cljs': '',
	'edn': '',
	'scala': '',
	'go': '',
	'dart': '',
	'xul': '',
	'sln': '',
	'suo': '',
	'pl': '',
	'pm': '',
	't': '',
	'rss': '',
	'f#': '',
	'fsscript': '',
	'fsx': '',
	'fs': '',
	'fsi': '',
	'rs': '',
	'rlib': '',
	'd': '',
	'erl': '',
	'hrl': '',
	'ex': '',
	'exs': '',
	'eex': '',
	'leex': '',
	'heex': '',
	'vim': '',
	'ai': '',
	'psd': '',
	'psb': '',
	'ts': '',
	'tsx': '',
	'jl': '',
	'pp': '',
	'vue': '﵂',
	'elm': '',
	'swift': '',
	'xcplayground': '',
	'r': '',
	'rproj': '',
	'sol': '',
	'hx': '',
	'pem': '',
	'gradle': '',
	'so': ''
}

const file_node_exact_matches = {
	'a': '󰬈',
	'b': '󰬉',
	'c': '󰬊',
	'd': '󰬋',
	'e': '󰬌',
	'f': '󰬍',
	'x': '󰬟',
	'y': '󰬠',
	'z': '󰬡',
	'info': '',
	'pom.xml': '',
	'meson.build': '',
	'gruntfile.coffee': '',
	'gruntfile.js': '',
	'gruntfile.ls': '',
	'gulpfile.coffee': '',
	'gulpfile.js': '',
	'gulpfile.ls': '',
	'mix.lock': '',
	'dropbox': '',
	'.ds_store': '',
	'.gitconfig': '',
	'LICENSE': '',
	'.gitignore': '',
	'.gitattributes': '',
	'.gitlab-ci.yml': '',
	'.bashrc': '',
	'.zshrc': '',
	'.zshenv': '',
	'.zprofile': '',
	'.vimrc': '',
	'.gvimrc': '',
	'_vimrc': '',
	'_gvimrc': '',
	'.bashprofile': '',
	'favicon.ico': '',
	'license': '',
	'node_modules': '',
	'react.jsx': '',
	'procfile': '',
	'dockerfile': '',
	'docker-compose.yml': '',
	'rakefile': '',
	'config.ru': '',
	'gemfile': '',
	'makefile': '',
	'cmakelists.txt': '',
	'robots.txt': '󰚩',
}

const folder_node_exact_matches = {
	'.git': '',
	'.github': '',
	'node_modules': '',
	'home': '󱂵',
	'pictures': '󰉏',
	'images': '󰉏',
	'music': '󱍙',
	'downloads': '󰉍',
	'favorites': '󰚝',
	'videos': '󱧺',
	'documents': '󰉓',
	'lib': '',
	'desktop': '',
}

const folder_open = ''

g:loaded_webdevicons = 1
g:webdevicons_enable = 1

#####################################
#  Utility Functions
#####################################

def IsDarwin(): bool
	if has('macunix')
		return true 
	endif
	return false 
enddef

def IsBinary(path: string): bool
	return match(readfile(path, '', 10), '\%x00', 0, 1) != -1
enddef

def GetDirectorySymbol(_path: string): string
	var path: string
	if _path[-1] == '/'
		path = substitute(_path, '/\+$', '', '') 
	else
		path = _path
	endif
	const name = tolower(fnamemodify(path, ':t'))
	if has_key(folder_node_exact_matches, name)
		return folder_node_exact_matches[name]
	endif
	if isdirectory(_path)
		# check if we have permission to read the directory
		try 
		if readdir(_path) != []
			return folder_open # Empty directory
		endif
		catch
			return '󱧴'
		endtry
	endif
	return '󰉋' # Default directory icon
enddef

def GetFileSymbol(path: string): string
	const name = tolower(fnamemodify(path, ':t'))
	if has_key(file_node_exact_matches, name)
		return file_node_exact_matches[name]
	endif
	const ext = fnamemodify(name, ':e')
	if has_key(file_node_extensions, ext)
		return file_node_extensions[ext]
	endif
	return '󰈙' # Default file icon
enddef



#######################################
# Public Functions (WebDevIcons)
#######################################

var fileformat: string = ''

def g:WebDevIconsGetFileFormatSymbol(): string
	if fileformat != ''
		return fileformat
	endif
	if &fileformat ==? 'dos'
		fileformat = ''
	elseif &fileformat ==? 'unix'
		fileformat = IsDarwin() ? '' : GetDistro()
	elseif &fileformat ==? 'mac'
		fileformat = ''
	endif
	return fileformat
enddef

def g:WebDevIconsGetFileTypeSymbol(_value: string = '', type_id: number = -1): string
	var value: string
	if _value == ''
		value = expand('%:p')
	else
		value = _value
	endif
	# if number == 0 it's a file 
	if type_id == 0
		return GetFileSymbol(value)
	# if type_id == 1 it's a directory
	elseif type_id >= 1
		return GetDirectorySymbol(value)
	# Check its a file or directory
	else
		const is_dir = isdirectory(value)
		const is_file = filereadable(value)
		# if is not a file or directory return default icon
		# echom is_dir .. ' ' .. is_file 
		if !is_dir && !is_file
			# the path is not valid check if a '/' is at the end 
			if value[-1] == '/'
				return GetDirectorySymbol(value[: -1])
			else
				return GetFileSymbol(value)
			endif
		endif
		if is_dir
			return GetDirectorySymbol(value)
		endif
		if is_file
			var sym = GetFileSymbol(value)
			if sym == '󰈙' && IsBinary(value)
				return ''
			endif
			return GetFileSymbol(value)
		endif
	endif
	return GetFileSymbol(value)
enddef

def GetDistro(): string
	if has('bsd')
		return ''
	elseif has('unix')
		try
			const content = readfile('/etc/lsb-release')
			var idx = 0
			for i in range(len(content))
				if stridx('^DISTRIB_ID=', content[i]) == 0
					idx = i
					break
				endif
			endfor
			if idx == -1
				throw 'Distro not found'
			endif
			const distro = content[idx][11 : -1]
			if distro ==# 'Ubuntu'
				return ''
			elseif distro =~# 'Arch'
				return ''
			elseif distro =~# 'Fedora'
				return ''
			elseif distro =~# 'Gentoo'
				return ''
			elseif distro =~# 'Cent'
				return ''
			elseif distro =~# 'Debian'
				return ''
			elseif distro =~# 'Red Hat'
				return ''
			elseif distro =~# 'SUSE'
				return ''
			elseif distro =~# 'Manjaro'
				return ''
			elseif distro =~# 'Linux Mint'
				return ''
			elseif distro =~# 'Pop'
				return ''
			elseif distro =~# 'Zorin'
				return ''
			elseif distro =~# 'Elementary'
				return ''
			elseif distro =~# 'Dock'
				return ''
			endif
		catch
		endtry
	endif
	return '' # Default to generic Linux icon
enddef

########################################
# Airline Integration
########################################

g:webdevicons_enable_airline_tabline = 1
g:webdevicons_enable_airline_statusline = 1
g:webdevicons_enable_airline_statusline_fileformat_symbols = 1
g:WebDevIconsTabAirLineBeforeGlyphPadding = ' '
g:WebDevIconsTabAirLineAfterGlyphPadding = ''
g:_webdevicons_airline_orig_formatter = get(g:, 'airline#extensions#tabline#formatter', 'default')
g:airline#extensions#tabline#formatter = 'SupraIcon'

def g:AirlineWebDevIcons(...name: list<any>): any
	w:airline_section_x = get(w:, 'airline_section_x', get(g:, 'airline_section_x', ''))
	w:airline_section_x ..= ' %{WebDevIconsGetFileTypeSymbol()} '
	var hasFileFormatEncodingPart = airline#parts#ffenc() !=? ''
	if g:webdevicons_enable_airline_statusline_fileformat_symbols && hasFileFormatEncodingPart
		w:airline_section_y = ' %{&fenc . " " . WebDevIconsGetFileFormatSymbol()} '
	endif
	return 0
enddef

if g:webdevicons_enable == 1 && g:webdevicons_enable_airline_statusline == 1
	airline#add_statusline_func(function('g:AirlineWebDevIcons'))
endif
