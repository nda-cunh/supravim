vim9script

export def Enable()
	augroup AutoBear
		autocmd!
		autocmd VimEnter * call GenerateBearFile()
		autocmd BufWritePost Makefile call GenerateBearFile()
	augroup END
enddef

export def Disable()
	augroup AutoBear
		autocmd!
	augroup END
enddef

def GenerateBearFile()
	if expand('%:t') == '.gitignore'
        return
    endif
	job_start(["suprabear", "-g", "-s"])
	redraw!
enddef
