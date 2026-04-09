vim9script

au BufRead,BufNewFile *.j2 {
    const virtual_name = expand('%:t')->substitute('\.j2$', '', '')
    const real_name = expand('%')

    execute 'silent! file ' .. fnameescape(virtual_name)
    filetype detect
    execute 'silent! file ' .. fnameescape(real_name)
}
