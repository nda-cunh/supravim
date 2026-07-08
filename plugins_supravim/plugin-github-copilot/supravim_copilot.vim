vim9script

import autoload 'supraconfig.vim' as SupraConfig

SupraConfig.RegisterGroup('copilot', 'Plugin: GitHub Copilot')

SupraConfig.RegisterMany([
    {
        id: 'copilot/enable',
        type: 'bool',
        default: true,
        lore: 'GitHub Copilot completion on startup',
        handler: (v) => {
			if v == true
				autocmd VimEnter * exec ":Copilot enable"
			else
				autocmd VimEnter * exec ":Copilot disable"
			endif
		}
    }
])
