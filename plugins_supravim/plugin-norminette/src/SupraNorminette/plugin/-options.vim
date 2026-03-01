vim9script noclear


if !exists('*supraconfig#RegisterMany')
    finish
endif

import autoload '../autoload/norminette/SupraNorminette.vim' as NNorme

supraconfig#RegisterMany([
    {
        id: 'norminette',
        type: 'bool',
        default: true,
        lore: 'Enable norminette',
        spawn: false,
        handler: (v) => {
            if $"v" == 'true'
                NNorme.EnableNorm()
            else
                NNorme.DisableNorm()
            endif
        }
    },
])
