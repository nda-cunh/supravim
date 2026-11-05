vim9script

import autoload 'supraconfig.vim' as SupraConfig

final asciiart = [
			'        :::      ::::::::',
			'      :+:      :+:    :+:',
			'    +:+ +:+         +:+  ',
			'  +#+  +:+       +#+     ',
			'+#+#+#+#+#+   +#+        ',
			'     #+#    #+#          ',
			'    ###   ########.fr    '
			]

final start = '/*'
final end = '*/'
final fill = '*'
final length = 80
final margin = 5

g:sp_stdheader_refresh = true
var option_user = ''
var option_mail = ''

final types = {
	'\.c$\|\.h$\|\.cc$\|\.hh$\|\.cpp$\|\.hpp$\|\.php|\.vala$\': ['/*', '*/', '*'],
	'\.htm$\|\.html$\|\.xml$': ['<!--', '-->', '*'],
	'\.js$': ['//', '//', '*'],
	'\.tex$': ['%', '%', '*'],
	'\.ml$\|\.mli$\|\.mll$\|\.mly$': ['(*', '*)', '*'],
	'\.vim$\|\vimrc$': ['"', '"', '*'],
	'\.el$\|\emacs$': [';', ';', '*'],
	'\.f90$\|\.f95$\|\.f03$\|\.f$\|\.for$': ['!', '!', '/']
}

def Filetype()
	var f = Filename()

	var _start = '#'
	var _end	= '#'
	var _fill = '*'

	for type in keys(types)
		if f =~ type
			_start = types[type][0]
			_end = types[type][1]
			_fill = types[type][2]
		endif
	endfor
enddef

def Ascii(n: number): string
	return asciiart[n - 3]
enddef

def Textline(left: string, right: string): string
	var _left = strpart(left, 0, length - margin * 2 - strlen(right))

	return start .. repeat(' ', margin - strlen(start)) .. _left .. repeat(' ', length - margin * 2 - strlen(_left) - strlen(right)) .. right .. repeat(' ', margin - strlen(end)) .. end
enddef

def Line(n: number): string
	if n == 1 || n == 11 # top and bottom line
		return start .. ' ' .. repeat(fill, length - strlen(start) - strlen(end) - 2) .. ' ' .. end
	elseif n == 2 || n == 10 # blank line
		return Textline('', '')
	elseif n == 3 || n == 5 || n == 7 # empty with ascii
		return Textline('', Ascii(n))
	elseif n == 4 # filename
		return Textline(Filename(), Ascii(n))
	elseif n == 6 # author
		return Textline("By: " .. User() .. " <" .. Mail() .. ">", Ascii(n))
	elseif n == 8 # created
		return Textline("Created: " .. Date() .. " by " .. User(), Ascii(n))
	elseif n == 9 # updated
		return Textline("Updated: " .. Date() .. " by " .. User(), Ascii(n))
	else
		return ''
	endif
enddef

def User(): string
	if !empty(option_user)
		return option_user
	endif
	if exists('g:user42')
		return g:user42
	endif
	var _user: string = $USER
	if empty(_user)
		_user = "marvin"
	endif
	return _user
enddef

def Mail(): string
	if !empty(option_mail)
		return option_mail
	endif
	if exists('g:mail42')
		return g:mail42
	endif
	var _mail: string = $MAIL
	if empty(_mail)
		_mail = "marvin@d42.fr"
	endif
	return _mail
enddef

def Filename(): string
	var filename = expand("%:t")
	if strlen(filename) == 0
		filename = "< new >"
	endif
	return filename
enddef

def Date(): string
	return strftime("%Y/%m/%d %H:%M:%S")
enddef

def Insert()
	var line = 11

	call append(0, "")

	while line > 0
		call append(0, Line(line))
		line = line - 1
	endwhile
enddef

def Update(is_force: bool = false): bool
	if is_force == false && g:sp_stdheader_refresh == false
		return false
	endif
	call Filetype()
	if getline(9) =~ start .. repeat(' ', margin - strlen(start)) .. "Updated: "
		if &mod || is_force
			call setline(9, Line(9))
		endif
		call setline(4, Line(4))
		return false
	endif
	return true
enddef

def Fix_merge_conflict()
	call Filetype()
	var checkline = start .. repeat(' ', margin - strlen(start)) .. "Updated: "

	# fix conflict on 'Updated:' line
	if getline(9) =~ "<<<<<<<" && getline(11) =~ "=======" && getline(13) =~ ">>>>>>>" && getline(10) =~ checkline
		var line = 9
		while line < 12
			call setline(line, Line(line))
			line = line + 1
		endwhile
		echo "42header conflicts automatically resolved!"
		deletebufline('%', 12, 15)

	# fix conflict on both 'Created:' and 'Updated:' (unlikely, but useful in case)
	elseif getline(8) =~ "<<<<<<<" && getline(11) =~ "=======" && getline(14) =~ ">>>>>>>" && getline(10) =~ checkline
		var line = 8
		while line < 12
			setline(line, Line(line))
			line = line + 1
		endwhile
		echo "42header conflicts automatically resolved!"
		deletebufline('%', 12, 16)
	endif
enddef

def Stdheader()
	if Update(true)
		call Insert()
	else
		Update(true)
	endif
enddef

def InitMe()
	nmap <F1> <ScriptCmd>Stdheader()<CR>
	imap <F1> <ScriptCmd>Stdheader()<CR>
	command! Stdheader call Stdheader()
	if exists('#stdheader')
		autocmd! stdheader
		augroup! stdheader # remove old 42 header
	endif
	var ungrouped = autocmd_get({event: 'BufWritePre'})
		->filter((_, auto) => auto.group == '')
	if ungrouped->indexof((_, auto) => auto.cmd ==# 'call s:update ()') != -1
		autocmd! BufWritePre
		ungrouped->filter((_, auto) => auto.cmd !=# 'call s:update ()')->autocmd_add()
	endif
enddef

augroup stdheader9
	autocmd!
	autocmd BufWritePre * call Update()
	autocmd BufReadPost * call Fix_merge_conflict()
augroup END

autocmd VimEnter * call InitMe()

SupraConfig.RegisterGroup('stdheader', 'Options related to the 42 header')

SupraConfig.RegisterMany([
	{
		id: 'stdheader/refresh',
		type: 'bool',
		default: true,
		lore: 'Update the 42 header when saving (if disabled, only with F1)',
		handler: (v) => {
			g:sp_stdheader_refresh = v
		}
	},
	{
		id: 'stdheader/user',
		type: 'string',
		default: '',
		lore: 'User name of the 42 header (empty: g:user42 or $USER)',
		handler: (v) => {
			option_user = v
		}
	},
	{
		id: 'stdheader/mail',
		type: 'string',
		default: '',
		lore: 'Email of the 42 header (empty: g:mail42 or $MAIL)',
		handler: (v) => {
			option_mail = v
		}
	},
])
