vim9script

inoremap <F3>		<scriptcmd>tabnext<CR>i
nnoremap <F3>		<scriptcmd>tabnext<CR>

highlight DapBreakpoint ctermfg=135
sign define NormLinter text=✖ texthl=DapBreakpoint
g:sp_norme = true # norminette hint, press F3 to switch

def ToggleNorm()
	g:sp_norme = !g:sp_norme
	sign unplace *
	silent w!
	if g:sp_norme == true
		silent! echo ""
		echo "[SupraNorm enabled]"
	else
		silent! echo ""
		echo "[SupraNorm disabled]"
	endif
enddef

def GetErrors(filename: string): list<any>
	var retsys = system("timeout 1s norminette \"" .. filename .. "\"")
	if v:shell_error == 124
		echo "[Norminette] -- timeout --"
		return []
	endif
	var norm_errors = retsys->split("\n")
	var regex = 'Error: \([A-Z_]*\)\s*(line:\s*\(\d*\), col:\s*\(\d*\)):\t\(.*\)'
	var errors = []
	for s in norm_errors
		if s =~# regex
			var groups = matchlist(s, regex)
			groups = [groups[1], groups[2], groups[3], groups[4]]
			add(errors, groups)
		endif
	endfor
	return errors
enddef

var g_errors: list<list<string>> = []

def CountLine(linenb: number): number
	var start = linenb
	var i = linenb
	while i > 0
		if getline(i) =~# '^{'
			break
		endif
		i -= 1
	endwhile
	return start - i - 1
enddef

def HighlightNorm(filename: string)
	if g:sp_norme == false
		return
	endif
	g_errors = GetErrors(filename)
	hi def link NormErrors Underlined
	sign unplace *
	if g:sp_norme == true
		for error in g_errors
			if error[3] == "Missing or invalid 42 header"
				continue
			endif
			if error[3] == "Function has more than 25 lines"
				var txt = CountLine(str2nr(error[1]))
				exec "sign define FunctionLines_" .. txt .. " text=" .. txt .. " icon=FunctionLines texthl=DapBreakpoint"
				exe ":sign place 1 line=" .. error[1] " name=FunctionLines_" .. txt .. " file=" .. filename
			else
				exe ":sign place 2 line=" .. error[1] " name=NormLinter file=" .. filename
			endif
		endfor
	endif
enddef

def DisplayErrorMsg()
	if g:sp_norme == true
		for error in g_errors
			if line(".") == str2nr(error[1])
				echo "[Norminette]: " .. error[3]
				break
			else
				echo ""
			endif
		endfor
	endif
enddef

def GetErrorDict(filename: string): list<string>
	var errors = GetErrors(filename)
	var error_dict = {}
	for error in errors
		eval error_dict->extend({error[1] : error[3]})
	endfor
	return errors
enddef

command Norm HighlightNorm(expand("%"))
autocmd CursorMoved *.c,*.h DisplayErrorMsg()
autocmd BufEnter,BufWritePost *.c,*.h Norm

def SimpleSupravimChangeOption()
	if g:supravim_option_changed == 'norme'
		sign unplace *
		if g:supravim_option_value == 'true'
			g:sp_norme = true
			Norm
		else
			g:sp_norme = false
		endif
		silent w!
	endif
enddef

autocmd User SupravimChangeOption call SimpleSupravimChangeOption()
