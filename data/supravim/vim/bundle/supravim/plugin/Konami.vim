vim9script

var konami_index: number = 0

const sequence: list<number> = [
    1, 1, 2, 2, 
    3, 4, 3, 4, 
    5, 6
]

def Konami(key: number)
    if key == sequence[konami_index]
        konami_index += 1
    else
        konami_index = 0
    endif

    if konami_index == len(sequence)
		:Crumble make_it_rain
		g:SupraAchEvent('konami')
        konami_index = 0
    endif
enddef

noremap <expr> <up>    Konami(1) ?? '<up>'
noremap <expr> <down>  Konami(2) ?? '<down>'
noremap <expr> <left>  Konami(3) ?? '<left>'
noremap <expr> <right> Konami(4) ?? '<right>'
noremap <expr> b       Konami(5) ?? 'b'
noremap <expr> a       Konami(6) ?? 'a'
