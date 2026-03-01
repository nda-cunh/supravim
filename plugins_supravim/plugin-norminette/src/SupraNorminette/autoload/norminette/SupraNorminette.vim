vim9script

var g_errors: list<list<string>> = []
var filename_norm: string

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
				exe "sign define FunctionLines_" .. txt .. " text=" .. txt .. " icon=FunctionLines texthl=SupraNormPoint"
				exe ":sign place 1 line=" .. groups[2] " name=FunctionLines_" .. txt .. " file=" .. filename
			endif
		elseif groups[4] != "Missing or invalid 42 header"
			exe ":sign place 2 line=" .. groups[2] " name=NormLinter file=" .. filename
		endif
	endif
enddef


export def HighlightNorm(filename: string)
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
			var txt = substitute(error[4], "\033\[[0-9;]*m", '', 'g')
			echo "[Norminette]: " .. txt
			break
		endif
	endfor
enddef

###########################
# Supravim Settings Block
###########################

export def EnableAugroup()
	augroup Norminette
		autocmd!
		autocmd CursorMoved *.c,*.h DisplayErrorMsg()
		autocmd BufEnter,BufWritePost *.c,*.h Norm
	augroup END
	HighlightNorm(expand("%"))
enddef

export def DisableNorm()
	sign unplace *
	echo "[SupraNorm disabled]"
	g:supranorminette_enabled = false
	silent! auto! Norminette 
enddef

export def EnableNorm()
	echo "[SupraNorm enabled]"
	g:supranorminette_enabled = true
	EnableAugroup()
	silent noautocmd w!
	Norm
enddef

export def ToggleNorm()
	g:supranorminette_enabled = !g:supranorminette_enabled 
	if g:supranorminette_enabled == true
		EnableNorm()
	else
		DisableNorm()
	endif
enddef
