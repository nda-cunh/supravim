vim9script

g:sp_copilot = true # Enable github-copilot completion

if g:sp_copilot == false
	autocmd VimEnter * exec ":Copilot disable"
endif
