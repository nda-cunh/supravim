vim9script noclear

if exists('g:loaded_supra_norminette')
  finish
endif
g:loaded_supra_norminette = 1

import autoload 'norminette/SupraNorminette.vim' as Supra

## Highlight groups
hi def SupraNormPoint ctermfg=135 guifg=#a750ff

# Sign definition
if exists('g:sp_symbol_signs')
	execute 'sign define NormLinter text=' .. g:sp_symbol_signs .. ' texthl=SupraNormPoint'
else
	sign define NormLinter text=✗ texthl=SupraNormPoint
endif

# Commands
command -nargs=0 Norm Supra.HighlightNorm(expand("%"))

# Keymaps
noremap <unique> <Plug>SupraToggleNorm <scriptcmd>Supra.ToggleNorm()<CR>
if !hasmapto('<Plug>SupraToggleNorm') && mapcheck("<leader><F3>", "n") == ""
    nmap <leader><F3> <Plug>SupraToggleNorm
endif

g:supranorminette_enabled = get(g:, 'supranorminette_enabled', true)

if g:supranorminette_enabled == true
	autocmd VimEnter,WinEnter,BufEnter *.c,*.h ++once call Supra.EnableAugroup()
endif
