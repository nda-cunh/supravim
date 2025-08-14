vim9script

export def GetIcon(name: string, type: number = -1): string
	if name[-1] == '/'
		return g:WebDevIconsGetFileTypeSymbol(name, 1)
	endif
	return g:WebDevIconsGetFileTypeSymbol(name, type)
enddef

export def GetStrPopup(modified_file: dict<any>): list<string>
	var lines: list<string> = [] 
	for i in modified_file.rename
		var sp = split(i, ' -> ')
		var str1 = sp[0]
		var str2 = sp[1]
		add(lines, '[Rename]       ' .. GetIcon(str1) .. ' ' .. str1 .. '  →  ' .. GetIcon(str2) .. ' ' .. str2)
	endfor
	for i in modified_file.deleted
		var str = i
		if str[-1] == '/'
			add(lines, '[Deleted Dir]  ' .. GetIcon(str, 1) .. ' ' .. str)
		else
			add(lines, '[Deleted File] ' .. GetIcon(str) .. ' ' .. str)
		endif
	endfor
	for i in modified_file.new_file
		var str = i
		if str[-1] == '/'
			add(lines, '[New Dir]      ' .. GetIcon(str, 1) .. ' ' .. str)
		else
			add(lines, '[New File]     ' .. GetIcon(str) .. ' ' .. str)
		endif
	endfor
	for i in modified_file.all_copy
		var sp = split(i, ' -> ')
		var str1 = sp[0]
		var str2 = sp[1]
		if str1[-1] == '/'
			add(lines, '[Copy Dir]     ' .. GetIcon(str1, 1) .. ' ' .. str1 .. '  →  ' .. GetIcon(str2, 1) .. ' ' .. str2)
		else
			add(lines, '[Copy File]    ' .. GetIcon(str1) .. ' ' .. str1 .. '  →  ' .. GetIcon(str2) .. ' ' .. str2)
		endif
	endfor
	return lines 
enddef

export def CancelMoveOneLine()
	if (line('.') == 1)
		normal! j
		return
	endif
enddef

export def DestroyBuffer(id: number)
	var file_name = bufname(id)
	delete(file_name)
	silent! execute 'bdelete! ' .. id
	silent! set wincolor=Normal
enddef


export def LeftPath(str: string): string
	var path = str 
	if len(path) > 1
		path = fnamemodify(path[0 : -2], ':h')
	endif
	return path
enddef

export def IsBinary(path: string): bool
    # NUL byte check for binary files, used to avoid showing preview
    # Assumes a file encoding that does not allow NUL bytes, so will
    # generate false positives for UTF-16 and UTF-32, but the preview
    # window doesn't work for these encodings anyway, even with a BOM
    if !has('patch-9.0.0810')
        # Workaround for earlier versions of Vim with limited readblob()
        # Option to read only part of file finalised in patch 9.0.0810
        return match(readfile(path, '', 10), '\%x00') != -1
    endif
    return IsBinaryBlob(path)
enddef

# Note: use of legacy function a workaround for compilation failing when
# readblob() would be called with invalid args on earlier Vim versions
function IsBinaryBlob(path)
    for byte in readblob(a:path, 0, 128)
        if byte == 0 | return v:true | endif
    endfor
    return v:false
endfunction
