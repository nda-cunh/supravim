vim9script

export def GetMRU(limit: number): list<string>
    final recently_used: list<string> = []
    var found = 0
    for path in v:oldfiles
        if found >= limit
            break
        endif
        if match(path, "^/usr/share") < 0 && filereadable(expand(path))
            add(recently_used, path)
            found += 1
        endif 
    endfor
    return recently_used
enddef

# Returns just the cwd last directory name
# i.e. a/b/c => c
export def GetCurrentDirectory(): string
    return getcwd()[strridx(getcwd(), '/') + 1 : ]
enddef

export def BuildFindCommand(root: string): string
    const ignores = &wildignore->split(",")
    final ignore_dirs = ignores->copy()->filter((_, val) => stridx(val, '/') != -1)
    final ignore_files = ignores->copy()->filter((_, val) => stridx(val, '/') == -1)
    ignore_dirs->map((_, val) => $"-path '{val}'")
    ignore_files->map((_, val) => $"-not -name '{val}'")
    const dirs = ignore_dirs->join(" -o ")
    const files = ignore_files->join()
    return $'find {root} -type f -not \( {dirs} \) {files} -print'
enddef
