# 6.7.2
- Add g:sp_symbol_sign for Hint And Info LSP signs (for lua-language-server)
- Load the clipboard when starting supravim


# 6.7.1
- Ft_count_line remove all prop_text, now it remove only ft_count_line props
- Fix Visual highlight in markdown files or ctrl+Space popup

# 6.7
- Add ChangeLog for each version in the CHANGELOG.md file
- Add a new Notification for printing the changelog after an update
- Fix Copy/Paste bug only if the vim support clipboard

# 6.6.2

- Remove the jump to the next curly braces when a '}' is writed
- Fix the bug with plugin-norminette with the new version of norminette
  color like "\033[0;32m" are now supported
- When an error is detected by the supravim-gui, it's now catched and 
  displayed in the error window instead of crashing the plugin

# 6.6.1

- Fix supravim.cfg is not found when added a plugin for the first time
- Add Catpuccin theme
- Update FuzzBox package

# 6.6.0
- Add a new Ascii art when updating supravim

# 6.5.1
- supravim-server closing when discord is not running is now fixed

# 6.5
- Add Discord Rich Presence support
- Add missing import in fuzzyclip.vim

# 6.4.1
- Use a global variable instead register to store the copied text (fuzzyclip)
- Add typescript support for SupraComments
- fix a bug in supravim command when an option in a string writed with single quotes instead of double quotes
  now single quotes are supported

# 6.4
- Add plugin indent-rainbow
- Add Pylance support for Python LSP
- print number option with supravim -s now works
- Add a better zsh completion for supravim command

# 6.3.1
- Fix the ft_count_line and optimize it
- Force remove mkview folder in .vim
- Separate SupraTree, SupraSnake, SupraIcons and SupraPopup in another repository and clone it when supravim is compiled

# 6.3
- Now SupraComment detect if the vim is vim9script or vimscript legacy

# 6.2.6
- Disable Supravim-Welcome

# 6.2.3
- Fix the bad color for EndOfBuffer and SignColumn in supravim theme

# 6.2
- Add SupraSnake
- Rework of SupraComment
- Fix Wayland Copy Paste with fuzzyclip
- Add Comment and Uncomment command (C+\) and (\)
- Connect the option sp_symbol_sign to SupraTree
- SupraTree: Fix bug with a line can be cut with '-' mode


# 6.1
- Add a counter for SupraSearch
- Improve the help of SupraTree
- Add java Lsp support
- move some file to autload folder for optimize the loading time
- improve F2 keybinding to rename symbols with LSP
- Add Cursor Blink in SupraPopup (for suprasearch (ctrl + f))
- Add OmniSharp (C#) LSP support
- Add BluePrint GTK LSP support

# 6.0
- More Language support
- Add SupraWater And SupraTree explorer
- Add SupraSnake game
- Add SupraSearch (Ctrl + F)
- Add FuzzyClip (Ctrl + C / Ctrl + V)
- Change some default keybindings
- Add new supravim's Options
- optimize supravim's theme
- please see the *6_0_CHANGELOG.md* file for the changelog of the 6.0 version
