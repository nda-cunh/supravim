vim9script

import './utils.vim'
import '../minifuzzy.vim'
import './callbacks.vim'

const InitFuzzyFind = minifuzzy.InitFuzzyFind

export def GitFiles()
    InitFuzzyFind(systemlist('git ls-files'), { title: $'GIT: {utils.GetCurrentDirectory()}/' })
enddef

export def MRU()
    InitFuzzyFind(utils.GetMRU(10), { title: 'MRU' })
enddef

# Command functions
export def Find(directory: string)
    const root = directory == '' ? '.' : directory
    const files = systemlist(utils.BuildFindCommand(root))
    InitFuzzyFind(files, { title: $'{utils.GetCurrentDirectory()}/' })
enddef

export def Buffers()
    const buffers = getcompletion('', 'buffer')->filter((_, val) => bufnr(val) != bufnr())
    InitFuzzyFind(buffers, {
        exec_cb: (s) => execute($"buffer {s}"),
        ctrl_x_cb: (s) => execute($"sp | buffer {s}"),
        ctrl_v_cb: (s) => execute($"vs | buffer {s}"),
        title: 'Buffers' })
enddef

export def Lines()
    InitFuzzyFind(range(1, line('$'))->map((_, v) => string(v)), {
        exec_cb: callbacks.GotoLineNumberArg, 
        ctrl_x_cb: callbacks.SplitLineNumberArg,
        ctrl_v_cb: callbacks.VsplitLineNumberArg,
        format_cb: callbacks.GetBufLineByNumber,
        filetype: &filetype,
        title: $'Lines: {expand("%:t")}' })
enddef

var old_cmd_line = ''
export def StoreOldCmd(): string
    old_cmd_line = getcmdline()
    return ''
enddef
export def Command(ValueGenerator: func: list<string> = null_function)
    const Exec_cb = (s: string): string => {
        var list = old_cmd_line->split(' ')
        if list->len() == 0
            list = ['']
        endif
        const last_index = old_cmd_line->len() - 1
        if old_cmd_line[last_index] == ' '
            list->add(s)
        else
            list[-1] = s
        endif
        const final_cmd = list->join(" ")
        feedkeys($':{final_cmd}')
        return ''
    }
    const Cancel_cb = () => {
        feedkeys($":{old_cmd_line}")
    }
    const values = ValueGenerator == null_function ? getcompletion(old_cmd_line, 'cmdline') : ValueGenerator()

    InitFuzzyFind(values->len() == 0 ? [''] : values, { 
        exec_cb: Exec_cb,
        cancel_cb: Cancel_cb,
        filetype: 'vim',
    })
enddef
