vim9script

import autoload 'SupraMake.vim' as M

def g:Make(rule: string)
	M.SupraMake(rule)
enddef

command -nargs=* -complete=customlist,M.AutoComplete_gMake Make M.MakeSpecial(<q-args>)
