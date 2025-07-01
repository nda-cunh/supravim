vim9script

g:sp_stdheader_refresh = false # Refresh the header when the file is saved (refresh with F1)

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
	if exists('g:user42')
		return g:user42
	endif
	var _user = $USER
	if strlen(_user) == 0
		_user = "marvin"
	endif
	return _user
enddef

def Mail(): string
	if exists('g:mail42')
		return g:mail42
	endif
	var _mail = $MAIL
	if strlen(_mail) == 0
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
		if &mod
			call setline(9, Line(9))
		endif
		call setline(4, Line(4))
		return false
	endif
	return true
enddef

def Stdheader()
	if Update(true)
		call Insert()
	else
		Update(true)
	endif
enddef

autocmd VimEnter * call InitMe()

def InitMe()
	# Get all the autocmds for BufWritePre
	var lst_auto = autocmd_get({'event': 'BufWritePre'})
	# Remove all autocmds (BufWritePre)
	autocmd! BufWritePre *

	# Create a new list without the autocmd from 42 Paris (stdheadervim8)
	var new_lst: list<any> = []

	for auto in lst_auto
		if auto.cmd ==# 'call s:update ()'
			echo "Removing old autocmd " .. auto.cmd
		else
			add(new_lst, auto)
		endif
	endfor
	# Add the new autocmd
	call autocmd_add(new_lst)

	nmap <F1> <scriptcmd>Stdheader<CR>
	imap <F1> <scriptcmd>Stdheader<CR>
	command! Stdheader call Stdheader()
	autocmd BufWritePre * call Update()
enddef

# SupraVim Part
def SimpleSupravimChangeOption()
	if g:supravim_option_changed == 'stdheader_refresh'
		if g:supravim_option_value == 'false'
			g:sp_stdheader_refresh = false
		else
			g:sp_stdheader_refresh = true
		endif
	endif
enddef

autocmd User SupravimChangeOption call SimpleSupravimChangeOption()
