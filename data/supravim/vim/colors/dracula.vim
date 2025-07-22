vim9script

scriptencoding utf8

if v:version > 580
  highlight clear
  if exists('syntax_on')
    syntax reset
  endif
endif

g:colors_name = 'dracula'

if !(has('termguicolors') && &termguicolors) && !has('gui_running') && &t_Co != 256
  finish
endif

if has('terminal')
  g:terminal_ansi_colors = []
  for i in range(16)
    call add(g:terminal_ansi_colors, g:dracula#palette['color_' .. i])
  endfor
endif

if !exists('g:dracula_bold')
  g:dracula_bold = 1
endif

if !exists('g:dracula_italic')
  g:dracula_italic = 1
endif

if !exists('g:dracula_underline')
  g:dracula_underline = 1
endif

if !exists('g:dracula_undercurl')
  g:dracula_undercurl = g:dracula_underline
endif

if !exists('g:dracula_full_special_attrs_support')
  g:dracula_full_special_attrs_support = has('gui_running')
endif

if !exists('g:dracula_inverse')
  g:dracula_inverse = 1
endif

if !exists('g:dracula_colorterm')
  g:dracula_colorterm = 1
endif

set background=dark

hi! link ColorColumn  DraculaBgDark
hi! link CursorColumn CursorLine
hi! link CursorLineNr DraculaYellow
hi! link DiffAdd      DraculaGreen
hi! link DiffAdded    DiffAdd
hi! link DiffChange   DraculaDiffChange
hi! link DiffDelete   DraculaDiffDelete
hi! link DiffRemoved  DiffDelete
hi! link DiffText     DraculaDiffText
hi! link Directory    DraculaPurpleBold
# hi! link ErrorMsg     DraculaRedInverse
hi! link ErrorMsg     DraculaRed
hi! link WarningMsg   DraculaOrange

hi! link Cursor       DraculaOrangeInverse
hi! link FoldColumn   DraculaSubtle
hi! link Folded       DraculaBoundary
hi! link IncSearch    DraculaOrangeInverse
hi! link MoreMsg      DraculaFgBold
hi! link NonText      DraculaSubtle
hi! link Pmenu        DraculaBgDark
hi! link PmenuSbar    DraculaBgDark
hi! link PmenuSel     DraculaSelection
hi! link PmenuThumb   DraculaSelection
hi! link Question     DraculaFgBold
hi! link Search       DraculaSearch
hi! link TabLine      DraculaBoundary
hi! link TabLineFill  DraculaBgDark
hi! link TabLineSel   Normal
hi! link Title        DraculaGreenBold
hi! link VertSplit    DraculaBoundary
hi! link Visual       DraculaSelection
hi! link VisualNOS    Visual
hi! link SpecialKey DraculaPink

hi! link Comment DraculaComment
hi! link Underlined DraculaFgUnderline
hi! link Todo DraculaTodo

hi! link Error DraculaError
hi! link SpellBad DraculaErrorLine
hi! link SpellLocal DraculaWarnLine
hi! link SpellCap DraculaInfoLine
hi! link SpellRare DraculaInfoLine

hi! link Constant DraculaPurple
hi! link String DraculaYellow
hi! link Character DraculaPink
hi! link Number Constant
hi! link Boolean Constant
hi! link Float Constant

hi! link Identifier DraculaFg
hi! link Function DraculaGreen

hi! link Statement DraculaPink
hi! link Conditional DraculaPink
hi! link Repeat DraculaPink
hi! link Label DraculaPink
hi! link Operator DraculaPink
hi! link Keyword DraculaPink
hi! link Exception DraculaPink

hi! link PreProc DraculaPink
hi! link Include DraculaPink
hi! link Define DraculaPink
hi! link Macro DraculaPink
hi! link PreCondit DraculaPink
hi! link StorageClass DraculaPink
hi! link Structure DraculaPink
hi! link Typedef DraculaPink

hi! link Type DraculaCyanItalic

hi! link Delimiter DraculaFg

hi! link Special DraculaPink
hi! link SpecialComment DraculaCyanItalic
hi! link Tag DraculaCyan
hi! link helpHyperTextJump DraculaLink
hi! link helpCommand DraculaPurple
hi! link helpExample DraculaGreen
hi! link helpBacktick Special

hi DraculaBgLight guifg=NONE ctermfg=NONE guibg=#343746 ctermbg=237 gui=NONE cterm=NONE guisp=NONE
hi DraculaBgLighter guifg=NONE ctermfg=NONE guibg=#424450 ctermbg=238 gui=NONE cterm=NONE guisp=NONE
hi DraculaBgDark guifg=NONE ctermfg=NONE guibg=#21222C ctermbg=235 gui=NONE cterm=NONE guisp=NONE
hi DraculaBgDarker guifg=NONE ctermfg=NONE guibg=#191A21 ctermbg=234 gui=NONE cterm=NONE guisp=NONE
hi DraculaFg guifg=#F8F8F2 ctermfg=253 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE guisp=NONE
hi DraculaFgUnderline guifg=#F8F8F2 ctermfg=253 guibg=NONE ctermbg=NONE gui=underline cterm=underline guisp=NONE
hi DraculaFgBold guifg=#F8F8F2 ctermfg=253 guibg=NONE ctermbg=NONE gui=bold cterm=bold guisp=NONE
hi DraculaComment guifg=#6272A4 ctermfg=61 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE guisp=NONE
hi DraculaCommentBold guifg=#6272A4 ctermfg=61 guibg=NONE ctermbg=NONE gui=bold cterm=bold guisp=NONE
hi DraculaSelection guifg=NONE ctermfg=NONE guibg=#44475A ctermbg=239 gui=NONE cterm=NONE guisp=NONE
hi DraculaSubtle guifg=#424450 ctermfg=238 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE guisp=NONE
hi DraculaCyan guifg=#8BE9FD ctermfg=117 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE guisp=NONE
hi DraculaCyanItalic guifg=#8BE9FD ctermfg=117 guibg=NONE ctermbg=NONE gui=italic cterm=italic guisp=NONE
hi DraculaGreen guifg=#50FA7B ctermfg=84 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE guisp=NONE
hi DraculaGreenBold guifg=#50FA7B ctermfg=84 guibg=NONE ctermbg=NONE gui=bold cterm=bold guisp=NONE
hi DraculaGreenItalic guifg=#50FA7B ctermfg=84 guibg=NONE ctermbg=NONE gui=italic cterm=italic guisp=NONE
hi DraculaGreenItalicUnderline guifg=#50FA7B ctermfg=84 guibg=NONE ctermbg=NONE gui=italic,underline cterm=italic,underline guisp=NONE
hi DraculaOrange guifg=#FFB86C ctermfg=215 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE guisp=NONE
hi DraculaOrangeBold guifg=#FFB86C ctermfg=215 guibg=NONE ctermbg=NONE gui=bold cterm=bold guisp=NONE
hi DraculaOrangeItalic guifg=#FFB86C ctermfg=215 guibg=NONE ctermbg=NONE gui=italic cterm=italic guisp=NONE
hi DraculaOrangeBoldItalic guifg=#FFB86C ctermfg=215 guibg=NONE ctermbg=NONE gui=bold,italic cterm=bold,italic guisp=NONE
hi DraculaOrangeInverse guifg=#282A36 ctermfg=236 guibg=#FFB86C ctermbg=215 gui=NONE cterm=NONE guisp=NONE
hi DraculaPink guifg=#FF79C6 ctermfg=212 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE guisp=NONE
hi DraculaPinkItalic guifg=#FF79C6 ctermfg=212 guibg=NONE ctermbg=NONE gui=italic cterm=italic guisp=NONE
hi DraculaPurple guifg=#BD93F9 ctermfg=141 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE guisp=NONE
hi DraculaPurpleBold guifg=#BD93F9 ctermfg=141 guibg=NONE ctermbg=NONE gui=bold cterm=bold guisp=NONE
hi DraculaPurpleItalic guifg=#BD93F9 ctermfg=141 guibg=NONE ctermbg=NONE gui=italic cterm=italic guisp=NONE
hi DraculaRed guifg=#FF5555 ctermfg=203 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE guisp=NONE
hi DraculaRedInverse guifg=#F8F8F2 ctermfg=253 guibg=#FF5555 ctermbg=203 gui=NONE cterm=NONE guisp=NONE
hi DraculaYellow guifg=#F1FA8C ctermfg=228 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE guisp=NONE
hi DraculaYellowItalic guifg=#F1FA8C ctermfg=228 guibg=NONE ctermbg=NONE gui=italic cterm=italic guisp=NONE
hi DraculaError guifg=#FF5555 ctermfg=203 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE guisp=#FF5555
hi DraculaErrorLine guifg=#FF5555 ctermfg=203 guibg=NONE ctermbg=NONE gui=undercurl cterm=undercurl guisp=#FF5555
hi DraculaWarnLine guifg=#FFB86C ctermfg=215 guibg=NONE ctermbg=NONE gui=undercurl cterm=undercurl guisp=#FFB86C
hi DraculaInfoLine guifg=#8BE9FD ctermfg=117 guibg=NONE ctermbg=NONE gui=undercurl cterm=undercurl guisp=#8BE9FD
hi DraculaTodo guifg=#F6DA6C ctermfg=228 guibg=NONE ctermbg=NONE gui=bold cterm=bold guisp=NONE
hi DraculaSearch guifg=#50FA7B ctermfg=84 guibg=NONE ctermbg=NONE gui=inverse cterm=inverse guisp=NONE
hi DraculaBoundary guifg=#6272A4 ctermfg=61 guibg=#21222C ctermbg=235 gui=NONE cterm=NONE guisp=NONE
hi DraculaLink guifg=#8BE9FD ctermfg=117 guibg=NONE ctermbg=NONE gui=underline cterm=underline guisp=NONE
hi DraculaDiffChange guifg=#FFB86C ctermfg=215 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE guisp=NONE
hi DraculaDiffText guifg=#282A36 ctermfg=236 guibg=#FFB86C ctermbg=215 gui=NONE cterm=NONE guisp=NONE
hi DraculaDiffDelete guifg=#FF5555 ctermfg=203 guibg=#21222C ctermbg=235 gui=NONE cterm=NONE guisp=NONE
hi Normal guifg=#F8F8F2 ctermfg=253 guibg=#282A36 ctermbg=236 gui=NONE cterm=NONE guisp=NONE
hi StatusLine guifg=NONE ctermfg=NONE guibg=#424450 ctermbg=238 gui=bold cterm=bold guisp=NONE
hi StatusLineNC guifg=NONE ctermfg=NONE guibg=#343746 ctermbg=237 gui=NONE cterm=NONE guisp=NONE
hi StatusLineTerm guifg=NONE ctermfg=NONE guibg=#424450 ctermbg=238 gui=bold cterm=bold guisp=NONE
hi StatusLineTermNC guifg=NONE ctermfg=NONE guibg=#343746 ctermbg=237 gui=NONE cterm=NONE guisp=NONE
hi WildMenu guifg=#282A36 ctermfg=236 guibg=#BD93F9 ctermbg=141 gui=bold cterm=bold guisp=NONE
hi CursorLine guifg=NONE ctermfg=NONE guibg=#424450 ctermbg=238 gui=NONE cterm=NONE guisp=NONE
hi LineNr guifg=#6272A4 ctermfg=61 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE guisp=NONE
hi SignColumn guifg=#6272A4 ctermfg=61 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE guisp=NONE
hi MatchParen guifg=#50FA7B ctermfg=84 guibg=NONE ctermbg=NONE gui=underline cterm=underline guisp=NONE
hi Conceal guifg=#8BE9FD ctermfg=117 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE guisp=NONE
