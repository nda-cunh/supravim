vim9script

import autoload 'SupraMake.vim' as M

nnoremap <F5> 	<ScriptCmd>call M.SupraMake("run")<CR>
inoremap <F5>	<ScriptCmd>call M.SupraMake("run")<CR>
nnoremap <F6>	<ScriptCmd>call M.SupraMake("run2")<CR>
inoremap <F6>	<ScriptCmd>call M.SupraMake("run2")<CR>
nnoremap <F7> 	<ScriptCmd>call M.SupraMake("run3")<CR>
inoremap <F7>	<ScriptCmd>call M.SupraMake("run3")<CR>

def g:Make(rule: string)
	M.SupraMake(rule)
enddef

command -nargs=* -complete=customlist,AutoComplete_gMake Make M.MakeSpecial(<f-args>)
