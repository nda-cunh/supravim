vim9script

export def Check()
	var msg = [
		"━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━",
		" ⚠️  Error: Unsupported Vim Version Detected! ⚠️ ",
		" SupraVim needs Vim version 9.0 or higher to function properly.",
		"━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
	]

	echohl ErrorMsg
	for line in msg
		echo line
	endfor
	echohl None

	var choice = confirm("Do you want to update Vim now? with suprapack", "&Yes\n&No", 1)

	if choice == 1
		!suprapack add vim
		
		echohl Question
		echo "Installation terminée. Veuillez redémarrer Vim."
		echohl None
	else
		echohl WarningMsg
		echo "SupraVim ne sera pas chargé. Passage en mode minimal."
		echohl None
	endif
enddef
