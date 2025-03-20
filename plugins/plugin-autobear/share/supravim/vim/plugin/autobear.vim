vim9script

g:sp_autobear = true # auto generation of compile_commands.json file

if g:sp_autobear
	autocmd VimEnter * call GenerateBearFile()
	autocmd BufWritePost Makefile call GenerateBearFile()
endif

def GenerateBearFile()
	if expand('%:t') == '.gitignore'
        return
    endif
	job_start(["suprabear", "-g", "-s"])
	redraw!
enddef
