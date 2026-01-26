vim9script

export def TextCompletion()
    prop_remove({type: 'ghost_text', all: true})

   	const info = complete_info(['selected', 'items', 'preinserted_text'])
	echom pum_getpos() 

    if info.selected == -1 || empty(info.items)
        return
    endif

    const full_word = info.items[info.selected].word

    var suffix = ""

    if !empty(info.preinserted_text)
        if stridx(full_word, info.preinserted_text) == 0
            suffix = strpart(full_word, len(info.preinserted_text))
        endif
    else
        const cur_line = getline('.')
        const cur_col = col('.')
        for i in range(1, min([len(full_word), cur_col - 1]) + 1)
            var fragment = strpart(cur_line, cur_col - 1 - i, i)
            if strpart(full_word, 0, i) ==# fragment
                suffix = strpart(full_word, i)
            endif
        endfor
    endif

    if !empty(suffix)
        prop_add(line('.'), col('.'), {
            type: 'ghost_text',
            text: suffix,
            priority: 9999
        })
    endif
enddef
