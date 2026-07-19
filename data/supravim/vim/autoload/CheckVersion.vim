vim9script

export def Check()
	var msg = [
		"━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━",
		" ⚠️  " .. gettext("Error: Unsupported Vim Version Detected!", "supravim") .. " ⚠️ ",
		" " .. gettext("SupraVim needs Vim version 9.0 or higher to function properly.", "supravim"),
		"━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
	]

	echohl ErrorMsg
	for line in msg
		echo line
	endfor
	echohl None

	var choice = confirm(
		gettext("Do you want to update Vim now? with suprapack", "supravim"),
		gettext("&Yes", "supravim") .. "\n" .. gettext("&No", "supravim"), 1)

	if choice == 1
		!suprapack add vim
		
		echohl Question
		echo gettext("Installation complete. Please restart Vim.", "supravim")
		echohl None
	else
		echohl WarningMsg
		echo gettext("SupraVim will not be loaded. Falling back to minimal mode.", "supravim")
		echohl None
	endif
enddef
