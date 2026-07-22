vim9script
# supra-gui: background=#1c1c1c include=#db6bab stdio=#f0fa8a typedef=#db6bab struct=#db6bab type_s=#ffffff scope=#ffffff float=#80d6e8 function=#ffffff format=#db6bab text=#f0fa8a integer=#ba91f7

scriptencoding utf8

highlight clear
if exists('syntax_on')
	syntax reset
endif

g:colors_name = 'dracula'

if has('terminal')
	g:terminal_ansi_colors = []
	for i in range(16)
		call add(g:terminal_ansi_colors, g:dracula#palette['color_' .. i])
	endfor
endif

set background=dark

# Background	#282A36
# Current Line	#6272A4
# Selection	#44475A
# Foreground	#F8F8F2
# Comment	#6272A4
# Red	#FF5555
# Orange	#FFB86C
# Yellow	#F1FA8C
# Green	#50FA7B
# Cyan	#8BE9FD
# Purple	#BD93F9
# Pink	#FF79C6


# use the dracula palette
hi Cursor guibg=#FFB86C
hi Normal guibg=#282A36 guifg=#F8F8F2
hi Variable guifg=#F8F8F2
hi Comment guifg=#6272A4 gui=NONE
hi Constant guifg=#FF79C6
hi Special guifg=#FF79C6
hi Identifier guifg=#FFB86C
hi Statement guifg=#FF79C6
hi PreProc guifg=#FFB86C
hi Type guifg=#8BE9FD
hi Underlined guifg=#50FA7B gui=NONE
hi Ignore guifg=#44475A
hi Error guifg=#FF5555 guibg=#282A36 gui=NONE
hi Todo guifg=#F1FA8C guibg=#44475A gui=NONE
hi String guifg=#F1FA8C
hi Character guifg=#F1FA8C
hi Number guifg=#BD93F9
hi Boolean guifg=#FF79C6
hi Float guifg=#BD93F9
hi Function guifg=#50FA7B
hi Conditional guifg=#FF79C6
hi Repeat guifg=#FF79C6
hi Label guifg=#FF5555
hi Operator guifg=#FF79C6
hi Keyword guifg=#BD93F9
hi Exception guifg=#FF5555
hi Include guifg=#FFB86C
hi Define guifg=#FFB86C
hi NormalDefine guifg=#FFB86C
hi Macro guifg=#FFB86C
hi PreCondition guifg=#FFB86C
hi StorageClass guifg=#8BE9FD
hi Structure guifg=#FF79C6
hi Typedef guifg=#8BE9FD
hi Tag guifg=#8BE9FD
hi SpecialChar guifg=#F1FA8C
hi Delimiter guifg=#F8F8F2
hi SpecialComment guifg=#6272A4 gui=NONE
hi Debug guifg=#FF5555


hi CursorLine guibg=#44475A gui=NONE cterm=NONE
hi ColorColumn guibg=#44475A gui=NONE cterm=NONE
hi CursorColumn guibg=#44475A gui=NONE cterm=NONE
hi CursorLineNr guifg=#F8F8F2 guibg=#44475A gui=NONE cterm=NONE
hi DiffAdd guibg=#50FA7B guifg=#282A36
hi DiffAdded guibg=#50FA7B guifg=#282A36
hi DiffChange guibg=#BD93F9 guifg=#282A36
hi DiffDelete guibg=#FF5555 guifg=#282A36
hi DiffRemoved guibg=#FF5555 guifg=#282A36
hi DiffText guibg=#FFB86C guifg=#282A36
hi Directory guifg=#FF79C6
hi ErrorMsg guifg=#FF5555 guibg=#282A36 gui=NONE
hi FoldColumn guifg=#F8F8F2 guibg=#282A36
hi Folded guifg=#6272A4 guibg=#282A36 gui=NONE
hi IncSearch guibg=#FFB86C guifg=#282A36
hi LineNr guifg=#6272A4 guibg=#282A36
hi MoreMsg guifg=#50FA7B guibg=#282A36 gui=NONE
hi NonText guifg=#44475A
hi Pmenu guifg=#F8F8F2 guibg=#282A36
hi PmenuSbar guibg=#44475A
hi PmenuSel guibg=#44475A guifg=#F8F8F2
hi PmenuThumb guibg=#6272A4
hi PmenuMatch guifg=#FFB86C gui=NONE
hi PmenuMatchSel guifg=#FFB86C guibg=#44475A gui=NONE
hi PmenuKind guifg=#8BE9FD
hi Question guifg=#FFB86C guibg=#282A36 gui=NONE
hi Search guibg=#FFB86C guifg=#282A36
hi SignColumn guibg=#282A36 guifg=#FF79C6
hi TabLine  guibg=#44475A guifg=#F8F8F2
hi TabLineFill guibg=#282A36 guifg=#44475A
hi TabLineSel guibg=#50FA7B guifg=#282A36 gui=NONE
hi Title guifg=#FF79C6 gui=NONE
hi VertSplit guifg=#44475A cterm=NONE
hi Visual guibg=#44475A gui=NONE cterm=NONE guifg=NONE
hi VisualNOS guibg=#44475A gui=NONE cterm=NONE guifg=NONE
hi Terminal guibg=#282A36 guifg=#F8F8F2
hi WarningMsg guifg=#FF5555 guibg=#282A36 gui=NONE
