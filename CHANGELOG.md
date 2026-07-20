# 6.76
- Add tranlation with i18n
- Add stats per language and per day
- var Add :Version command to show the version
- Fix bug with SupraWater

# 6.73
- Add an achievements engine: the server tracks metrics and unlocks 50+ achievements, persisted in `~/.config/supravim/achievements.json`
- Achievements are declared in `achievements.json` and pop a notification when unlocked
- Track typing, motions (dd/ciw/f/./macros/marks), :w/:q, undo/redo, themes, ratio insert/normal, streaks, session length and time of day
- Record per-day stats (chars, words, lines, saves, active coding time) in a `history` map, WakaTime-style, for the GUI to display
- Add an external API so third-party plugins can send metrics without depending on SupraVim: append a line to `~/.config/supravim/achievements.inbox` (drained by the server), or use `supravim --metric NAME[=N]` / `supravim --achievement ID`
- Add SupraPacman achievements (level clear, strawberry, pacifist, glutton, full game) and date easter-eggs (Friday 13th, future-dated file, same-hour streak, session LSP count)

# 6.72
- SupraMake: run builds asynchronously in a terminal popup instead of a blocking `:!`
- SupraMake: parse the build output into the quickfix list (gcc/clang/vala)
- SupraMake: add a full SupraPop panel on `<leader><F5>` — fuzzy rule search (focused on open),
  live command preview, per-rule arguments, `--run`/valgrind toggles and a `make -n` dry-run preview
- SupraMake: remember each rule's arguments and options per project
- SupraMake: `<F5>` now replays the last launched rule with its saved arguments
- SupraMake: move the `<F5>`/`<F6>`/`<F7>` mappings to the vimrc
- Add export/import of the SupraVim config as a .supravim archive
- Migrate the supravim json config to a nested directory
- SupraSearch: add ghost completion and search toggles in the popup
- SupraSearch: fix inverted case flag in search patterns
- Add ScrollBar and crumble.vim plugins
- Add scroll wheel focus remapping
- Register the copilot enable option through supraconfig
- Add yaml filetype detection for nested extensions
- Add :ChangeLog command to view the changelog

# 6.70
- Add new SupraSearch
- migrate to suprapop base api
- use unnamed register for yank and paste
- rewrite lsp server docs and loading order

# 6.69
- Rewrite supravim-settings and add supravim-api
- Fix copy/paste bug

# 6.68.4
- Theme: adjust terminal highlight
- Airline: optimize with vim9script
- SupraWater: normalize the path when use '../'
- SupraWater: Fix SupraIcons-palette not applied

# 6.68.3
- fix a bug with ft-count-line
- Add nim language-server
- fix when supravim-server is exited

# 6.67.0
- New Tree
- New Options
- prepare the 7.0 version with a new architecture and a new way to manage plugins

# 6.12.0
- Add Go,Zig,Markdown... LSP support
- Improve Supravim-better-comment to support more languages
- Add a new Popup Menu with Right-Click
- Fix bug with clipboard if vim is compied with +clipboard but not with X11 or Wayland support
- Reset the positon if the suprasearch is cancelled
- Add new syntax theme for C and C++, Vala, Nasm
- Add option in meson.build for disable discord-rich-presence support
- Add Supravim-Options a new plugin to manage supravim's options
- Optimize some themes

# 6.11.0
- Add a new AutoPairs plugin and more options disable FlyMode by default

# 6.10.0
- Rework the F12 options and add VERY VERY VERY MORE OPTIONS
- Add blueprint-gtk support
- Optimize and upgrade SupraComment and optimize atom theme color
- Add FuzzyLspDiag <leader> d to navigate between LSP diagnostics
- Add a real fold support
- Add FloatTerm (<space> tt) to open a terminal in a floating window

# 6.9.0
- add autosave option 
- rework the vimrc

# 6.8.3
- Do not clear the buffer when opening a file with SupraTree
- improve the nobackground mode
- Add FuzzyPrevious (<leader> P) to navigate between previous files with a FuzzyFinder
- Add DesktopEntry for supravim/pacman/snake

# 6.8.2
- Fix bug with Completion Lsp and snippets
- Remove an unnecessary mapping

# 6.8.1
- fix buffer not closing in job_start

# 6.8.0
- Add ':Pacman' Command 󰮯 🔸🔸🔸🔸 🍒 👀 !!!
- Add FuzzyMark (<leader> m) to navigate between marks with a FuzzyFinder
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
