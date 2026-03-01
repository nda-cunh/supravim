vim9script

export def Gdbf()
    packadd! termdebug
	runtime pack/dist/opt/termdebug/plugin/termdebug.vim
	g:termdebug_wide = 1

    var save_sb = &splitbelow
    var save_sr = &splitright

    set nosplitbelow
    set nosplitright

	if &filetype != 'c' && &filetype != 'cpp' && &filetype != 'vala' && &filetype != 'hpp'
		echo "Tu veux debugger quoi là ?"
	else
		set splitbelow nosplitbelow
		set splitright nosplitright
		SupraTreeClose
		if !filereadable("Makefile")
			exec ":Termdebug -n ./a.out"
		else
			exec ":Termdebug -n"
		endif
	endif

    &splitbelow = save_sb
    &splitright = save_sr
enddef
