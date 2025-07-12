vim9script

g:sp_norme = true # norminette hint, press F3 to switch

highlight DapBreakpoint ctermfg=135
execute 'sign define NormLinter text=' .. g:sp_symbol_signs .. ' texthl=DapBreakpoint'
hi def link NormErrors Underlined

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

var filename_norm: string

def GotOutput(channel: channel, msg: string)
	var filename = filename_norm
	var regex = 'Error: \([A-Z_]*\)\s*(line:\s*\(\d*\), col:\s*\(\d*\)):\t\(.*\)'
	if msg =~# regex
		var groups = matchlist(msg, regex)
		add(g_errors, groups)
		if groups[4] == "Function has more than 25 lines"
			var txt = CountLine(str2nr(groups[2]))
			if txt >= 100
				exe "sign place 2 line=" .. groups[2] .. " name=NormLinter file=" .. filename
			else
				exe "sign define FunctionLines_" .. txt .. " text=" .. txt .. " icon=FunctionLines texthl=DapBreakpoint"
				exe ":sign place 1 line=" .. groups[2] " name=FunctionLines_" .. txt .. " file=" .. filename
			endif
		elseif groups[4] != "Missing or invalid 42 header"
			exe ":sign place 2 line=" .. groups[2] " name=NormLinter file=" .. filename
		endif
	endif
enddef


def HighlightNorm(filename: string)
	g_errors = []
	filename_norm = filename
	sign unplace *
	job_start(["norminette", filename], {
		out_cb: GotOutput,
		out_timeout: 3000
	})
enddef

def DisplayErrorMsg()
	echo ""
	var current_line = line(".")
	for error in g_errors
		if current_line == str2nr(error[2])
			echo "[Norminette]: " .. error[4]
			break
		endif
	endfor
enddef

###########################
# Supravim Settings Block
###########################

command Norm HighlightNorm(expand("%"))

def EnableAugroup()
	augroup Norminette
		autocmd!
		autocmd CursorMoved *.c,*.h DisplayErrorMsg()
		autocmd BufEnter,BufWritePost *.c,*.h Norm
	augroup END
enddef

if g:sp_norme == true
	call EnableAugroup()
endif

inoremap <F3>		<scriptcmd>ToggleNorm()<CR>
noremap <F3>		<scriptcmd>ToggleNorm()<CR>

def DisableNorm()
	sign unplace *
	echo "[SupraNorm disabled]"
	g:sp_norme = false
	auto! Norminette 
enddef

def EnableNorm()
	echo "[SupraNorm enabled]"
	g:sp_norme = true
	call EnableAugroup()
	silent noautocmd w!
	Norm

enddef

def ToggleNorm()
	g:sp_norme = !g:sp_norme
	if g:sp_norme == true
		EnableNorm()
	else
		DisableNorm()
	endif
enddef

def SimpleSupravimChangeOption()
	if g:supravim_option_changed == 'symbol_signs'
		execute 'sign define NormLinter text=' .. g:sp_symbol_signs .. ' texthl=DapBreakpoint'
		return
	if g:supravim_option_changed == 'norme'
		if g:supravim_option_value == 'true'
			EnableNorm()
		else
			DisableNorm()
		endif
	endif
enddef

autocmd User SupravimChangeOption call SimpleSupravimChangeOption()
