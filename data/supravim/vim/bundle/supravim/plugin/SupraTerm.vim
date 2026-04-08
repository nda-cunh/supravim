vim9script noclear

import autoload 'supravim/SupraTerm.vim' as Mod 

def g:SupraTerm(command: string = null_string)
	Mod.SupraTerm(command)
enddef
