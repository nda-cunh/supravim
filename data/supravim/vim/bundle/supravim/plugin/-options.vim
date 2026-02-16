vim9script noclear

if !exists('*supraconfig#RegisterMany')
	finish
endif

import autoload 'ft_count_line.vim' as Ft_count_line
import autoload 'supravim/autobear.vim' as Autobear

supraconfig#RegisterMany([
	{
		id: 'ft_count_line',
		type: 'bool',
		default: true,
		lore: 'Enable the count line feature',
		handler: (v) => {
			Ft_count_line.SimpleSupravimChangeOption(v == 'true')
		}
	},
	{
		id: 'autobear',
		type: 'bool',
		default: true,
		lore: 'Automatically generate the compile_commands.json file for Makefile projects',
		handler: (v) => {
			if v == 'true'
				Autobear.Enable()
			else
				Autobear.Disable()
			endif
		}
	},
])
