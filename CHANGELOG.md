# 6.84
- Rework the 42 header: automatically resolve header merge conflicts and remove the old 42 plugin cleanly
- Add `stdheader/refresh`, `stdheader/user` and `stdheader/mail` options
- The 42 header is now updated on save by default (disable it with `stdheader/refresh`)
- Fix the 42 header comment style: it now follows the file type instead of always using `/* */`
- Support more file types in the 42 header (`.tpp`, `.ipp`, `.cxx`, `.go`, `.rs`, `.java`, `.kt`, `.kts`, `.css`, `.scss`, `.ts`, `.asm`, `.nasm`, `.s`)
- Fix `<C-F5>` (Termdebug): no more startup failure or duplicate gdb session
- Rename the dvd.vim `:Stop` command to `:DvDStop` to avoid a conflict with Termdebug
- Show the count line next to the closing `}` of the function
- Fix the count line ignoring functions with a multi-line signature
- Fix the count line missing when the closing `}` is on the first visible line
- Fix the count line resetting the cursor column when moving vertically
- Fix the count line not working after being disabled then re-enabled
- Optimize the count line: skip the update when the buffer and the view have not changed
- Fix C/C++ syntax: highlight functions with a multi-line signature or call
- Fix C/C++ syntax: `a>b` no longer colors `a` as an operator and `>>` is fully highlighted
- Fix C/C++ syntax: `x=(a + b)` is no longer highlighted as a function, and `table[(i)]` no longer shows a false error
- Fix C++ syntax: comparisons like `a < b && b > (c)` are no longer highlighted as template calls
- Fix C++ syntax: support nested templates like `foo<std::vector<int>>(x)`
- Fix C++ syntax: `static_cast` and other casts are now highlighted as casts
- Improve C++ syntax: highlight type names after `class`, `struct`, `enum`, `union` and `typename`, reference types like `Foo &x` and templated types like `std::vector<int> v`
- Improve C++ syntax: recognize `operator()`, `operator new` and conversion operators
- Optimize C/C++ syntax highlighting: simplify the operator, number, cast and string patterns
- Add a faster Vim script syntax, rewritten in vim9script: jumping in a Vim9 file is about 4x faster
- Improve Vim script syntax: highlight function names and calls, classes, enums, modules, members, dictionary keys, parameters, constants and `<q-args>`
- Fix Vim script syntax: `s.kind = 1`, `s1 = 2` and `si.x = 3` are no longer highlighted as `:substitute`
- Vim script syntax: only load the embedded Lua and Python highlighting when the file uses them
- Add a Python syntax, rewritten in vim9script: highlight function and method calls, attributes, parameters, class names and constants
- Optimize Python syntax: remove the costly `@` operator patterns, decorators are now only matched at the start of a line
- Add a Makefile syntax, rewritten in vim9script: highlight automatic variables (`$@`, `$<`, `$^`), assignment operators, `export`/`override` variables and recipe commands
- Add a Meson syntax, rewritten in vim9script: highlight function and method calls, keyword arguments, variables, operators, f-strings and `@0@`/`@name@` placeholders
- Add a C3 syntax, written in vim9script: highlight compile-time keywords and identifiers, attributes, macros, builtins, labels, module paths, nested comments, raw strings, byte literals and `<* *>` doc contracts
- Add C3 file type detection for `.c3`, `.c3i` and `.c3t`
- Add C3 indentation: support `$if`/`$else`/`$endif` and other compile-time blocks, `case`/`default`, multi-line signatures and calls, doc comments and raw strings
- Add an HTML syntax, rewritten in vim9script: jumping in a file is about 2x faster, only load the embedded CSS, JavaScript and VBScript highlighting when the file uses them
- Improve HTML syntax: highlight all attributes (`x-custom`, `@click`, `:key`) and tags (`<my-element>`, `<path>`), and `<!DOCTYPE>` is no longer highlighted as a comment
- Add a CSS syntax, rewritten in vim9script: fix wrong colors after a jump in a stylesheet and speed up editing
- Improve CSS syntax: highlight all properties, `@layer`, `@container`, `@property`, `@scope`, `clamp()`, `min()`, `max()`, `color-mix()` and vendor-prefixed properties
- Add a Nim syntax, written in vim9script: about 3x faster, the embedded C highlighting is only loaded when the file uses `emit` or `codegenDecl`
- Improve Nim syntax: highlight the names of `func`, `method`, `iterator`, `template`, `macro` and `converter`, function and method calls, members, types, constants, booleans, `echo` and `result`
- Fix Nim syntax: `nim_emit_syntax` no longer always loads C, `"a\\"` and `\x41` are handled correctly, and `0xFF` is no longer highlighted as a float

# 6.83
- New **Right-Click** Popup Menu
- Fix autopairs
- Fix plugin-norminette (bump to 3.1)
- Add `<leader>fm` keymap for fuzzy marks search (`FuzzyMark`)
- Unmap `a` and `b` in select mode
- Disable the count line feature by default
- Implement workspace rename edits handling in the LSP server
- Update vim-airline repo URL
- Drop unnecessary dependency checks from installer
- Remove obsolete plugin-autobear files
- Consolidate GitLab CI test jobs into a single runner

# 6.82
- Fix Scrollbar
- Fix bug airline with vim9script
- Stop build process on clone failure and expand markdown glob support
- Queue LSP requests until vim is ready to prevent race conditions
- Escape Discord activity JSON and bound IPC packet size for security
- Handle non-ASCII file names in command validation
- Escape vim option values and close temp redir file handles to prevent leaks
- Handle spawn failures and validate LSP package config in server
- Handle stdin close and prevent duplicate quit signals
- Forward vim exit status from spawned processes in CLI
- Remove plugin registration when git clone or pull fails
- Move invalid plugin list JSON to corrupt backup for recovery
- Quote install paths and preserve existing vimrc backups during build
- Validate plugin names and replace shell string spawning for security
- Guard against missing LSP install commands and null arguments
- Sanitize command payloads and tighten server message parsing
- Replace suprabear with supramake for project path detection
- Update install script and CI artifacts path for macOS package creation
- Update logo and favicon to new SVG design
- Use workdir for suprapack install and add bootstrap fallback
- Include supravim-gui in package creation
- Remove release workflow (temporarily)
- Switch installer to meson and add dependency checks
- Add suprapack packaging and enable build option
- Simplify suprapack install handling and bump version to 6.81.0
- Refactor package script to use meson install and improve platform checks
- Add workflow to build and publish release packages
- Expand command in runcmd to handle shell variables
- Update fedora install command color

# 6.81
- Add support for MacOS Darwin (Arm64 and x86_64)
- Add suppot for Linux (x86_64 and aarch64)

# 6.80
- SupraMake: builds run asynchronously in a terminal popup, with the output parsed into the quickfix list (gcc/clang/vala)
- SupraMake: full SupraPop panel on `<leader><F5>` — fuzzy rule search, live command preview, per-rule arguments, `--run`/valgrind toggles and a `make -n` dry-run
- SupraMake: second page, Command, to run any shell line instead of a rule (`<C-t>` or a click on the tabs; `:Make !<cmd>`, or `:` to run inside Vim), with a per-project history walked with `↑`/`↓` and `Quickfix`/`Auto-close` options
- SupraMake: named slots — `<F5>`/`<F6>`/`<F7>` each remember their own rule or command per project and replay it, `<leader>` + the same key opens the panel on it, `^S` manages the slots
- FuzzyMake (`<leader>f<F5>`) now lists the slots and their exact command line instead of the rules
- Add the supradracula theme and refresh the dracula palette
- Add a standalone `install` script and improve the dependency checks

# 6.79
- LSP servers are now also loaded from `~/.config/supravim/lsp.d/`
- Fix whisper mappings by going through `keytrans`
- Remove the terminal norminette mapping from `<F3>`
- Update the settings and stats screenshots on the web page

# 6.78
- Add the SupraIndent plugin
- Add a `multiple_choice` option type: several values can be combined and are stored as a comma separated string
- Validate `choice` and `multiple_choice` values on update, and reject unknown ones with an explicit message
- Theme styles (function, type, variable, keyword, comment, string) are now multiple choice and can be combined
- `ChangeColorStyleStatic` now keeps the existing highlight colors instead of clearing them
- Fix the cursor color in the gruvbox, tokyonight and tokyostorm themes

# 6.77
- Add SupraTreeFocus command
- Add options for supranorminette
- fix scrollbar visible when saving in supratree

# 6.76
- Switch the default theme to supradeep
- Add a new supraevening theme and normalize the highlight styles
- Add translations with i18n (gettext) for the user-facing strings
- Add a `:Version` command to show the current version
- Track coding time per language and per project
- Add stats per language and per day
- Whisper: add configurable root mappings for menu navigation
- Discord presence: initialize asynchronously with retry, and update the logo to supravim
- Rename the SupraPacman `strawberry` achievement to `apple`
- Split the immutable stats history into its own file
- Stats: only track real file buffers, and ignore large text changes and transient project directories
- Fix multibyte keys in whisper mappings
- Fix bug with SupraWater
- Require meson 1.11.0 or later to build
- Add yyjson as a wrap dependency
- Add the SupraVim web page and its GitLab Pages deployment

# 6.73
- Add an achievements engine: the server tracks metrics and unlocks 50+ achievements, persisted in `~/.config/supravim/achievements.json`
- Achievements are declared in `achievements.json` and pop a notification when unlocked
- Track typing, motions (dd/ciw/f/./macros/marks), :w/:q, undo/redo, themes, ratio insert/normal, streaks, session length and time of day
- Record per-day stats (chars, words, lines, saves, active coding time) in a `history` map, WakaTime-style, for the GUI to display
- Add an external API so third-party plugins can send metrics without depending on SupraVim: append a line to `~/.config/supravim/achievements.inbox` (drained by the server), or use `supravim --metric NAME[=N]` / `supravim --achievement ID`
- Add SupraPacman achievements (level clear, strawberry, pacifist, glutton, full game) and date easter-eggs (Friday 13th, future-dated file, same-hour streak, session LSP count)

# 6.72
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
