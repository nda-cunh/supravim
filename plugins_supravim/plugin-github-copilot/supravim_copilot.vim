vim9script

g:sp_copilot = true # Enable github-copilot completion

if g:sp_copilot == false
	autocmd VimEnter * exec ":Copilot disable"
endif

def SimpleSupravimChangeOption()
	if g:supravim_option_changed == 'copilot'
		if g:supravim_option_value == 'true'
			g:sp_copilot = true
			Copilot enable
		else
			g:sp_copilot = false
			Copilot disable
		endif
	endif
enddef

autocmd User SupravimChangeOption call SimpleSupravimChangeOption()
