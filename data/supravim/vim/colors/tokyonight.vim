vim9script
# supra-gui: background=#212130 include=#ed7087 stdio=#bd945c typedef=#78a1f5 struct=#78a1f5 type_s=#7096e6 scope=#a8b0d4 float=#ab8ce6 function=#a8b0d4 format=#9e82d4 text=#d6a863 integer=#ab8ce6

hi clear

if exists("syntax_on")
  syntax reset
endif

set t_Co=256

g:colors_name = "tokyonight"

hi SpecialKey guifg=#3b3d57 guibg=NONE guisp=NONE gui=NONE ctermfg=237 ctermbg=NONE cterm=NONE
hi EndOfBuffer guifg=#1a1b26 guibg=#1a1b26 guisp=NONE gui=NONE ctermfg=235 ctermbg=235 cterm=NONE
hi NonText guifg=#3b3d57 guibg=NONE guisp=NONE gui=NONE ctermfg=237 ctermbg=NONE cterm=NONE
hi Directory guifg=#9ECE6A guibg=NONE guisp=NONE gui=NONE ctermfg=107 ctermbg=NONE cterm=NONE
hi ErrorMsg guifg=#F7768E guibg=NONE guisp=NONE gui=NONE ctermfg=203 ctermbg=NONE cterm=NONE
hi IncSearch guifg=#1a1b26 guibg=#ff7a93 guisp=NONE gui=NONE ctermfg=235 ctermbg=203 cterm=NONE
hi Search guifg=#1a1b26 guibg=#b9f27c guisp=NONE gui=NONE ctermfg=235 ctermbg=107 cterm=NONE
hi MoreMsg guifg=#7AA2F7 guibg=NONE guisp=NONE gui=NONE ctermfg=110 ctermbg=NONE cterm=NONE
hi ModeMsg guifg=#a9b1d6 guibg=NONE guisp=NONE gui=NONE ctermfg=250 ctermbg=NONE cterm=NONE
hi LineNr guifg=#444B6A guibg=NONE guisp=NONE gui=NONE ctermfg=246 ctermbg=NONE cterm=NONE
hi CursorLineNr guifg=#a9b1d6 guibg=#232433 guisp=NONE gui=NONE ctermfg=250 ctermbg=236 cterm=NONE
hi Question guifg=#E0AF68 guibg=NONE guisp=NONE gui=NONE ctermfg=179 ctermbg=NONE cterm=NONE
hi StatusLine guifg=#a9b1d6 guibg=#32344a guisp=NONE gui=NONE ctermfg=250 ctermbg=237 cterm=NONE
hi StatusLineNC guifg=#444B6A guibg=#232433 guisp=NONE gui=NONE ctermfg=246 ctermbg=236 cterm=NONE
hi VertSplit guifg=#06080a guibg=NONE guisp=NONE gui=NONE ctermfg=237 ctermbg=NONE cterm=NONE
hi Title guifg=#F7768E guibg=NONE guisp=NONE gui=NONE ctermfg=203 ctermbg=NONE cterm=NONE
hi Visual guifg=NONE guibg=#32344a guisp=NONE gui=NONE ctermfg=NONE ctermbg=237 cterm=NONE
hi VisualNOS guifg=NONE guibg=#32344a guisp=NONE gui=NONE ctermfg=NONE ctermbg=237 cterm=NONE
hi WarningMsg guifg=#E0AF68 guibg=NONE guisp=NONE gui=NONE ctermfg=179 ctermbg=NONE cterm=NONE
hi WildMenu guifg=#1a1b26 guibg=#b9f27c guisp=NONE gui=NONE ctermfg=235 ctermbg=107 cterm=NONE
hi Folded guifg=#444B6A guibg=#232433 guisp=NONE gui=NONE ctermfg=246 ctermbg=236 cterm=NONE
hi FoldColumn guifg=#444B6A guibg=#232433 guisp=NONE gui=NONE ctermfg=246 ctermbg=236 cterm=NONE
hi DiffAdd guifg=NONE guibg=#618041 guisp=NONE gui=NONE ctermfg=NONE ctermbg=22 cterm=NONE
hi DiffChange guifg=NONE guibg=#3e5380 guisp=NONE gui=NONE ctermfg=NONE ctermbg=17 cterm=NONE
hi DiffDelete guifg=NONE guibg=#803d49 guisp=NONE gui=NONE ctermfg=NONE ctermbg=52 cterm=NONE
hi DiffText guifg=NONE guibg=NONE guisp=NONE gui=NONE ctermfg=NONE ctermbg=NONE cterm=NONE
hi SignColumn guifg=#a9b1d6 guibg=#232433 guisp=NONE gui=NONE ctermfg=250 ctermbg=236 cterm=NONE
hi Conceal guifg=#444B6A guibg=NONE guisp=NONE gui=NONE ctermfg=246 ctermbg=NONE cterm=NONE
hi SpellBad guifg=#F7768E guibg=NONE guisp=NONE gui=NONE ctermfg=203 ctermbg=NONE cterm=NONE
hi SpellCap guifg=#E0AF68 guibg=NONE guisp=NONE gui=NONE ctermfg=179 ctermbg=NONE cterm=NONE
hi SpellRare guifg=#ad8ee6 guibg=NONE guisp=NONE gui=NONE ctermfg=176 ctermbg=NONE cterm=NONE
hi SpellLocal guifg=#7AA2F7 guibg=NONE guisp=NONE gui=NONE ctermfg=110 ctermbg=NONE cterm=NONE
hi Pmenu guifg=#a9b1d6 guibg=#2a2b3d guisp=NONE gui=NONE ctermfg=250 ctermbg=236 cterm=NONE
hi PmenuSel guifg=#1a1b26 guibg=#b9f27c guisp=NONE gui=NONE ctermfg=235 ctermbg=107 cterm=NONE
hi PmenuMatch guifg=#29c94d guibg=NONE guisp=NONE gui=NONE ctermfg=NONE ctermbg=NONE cterm=NONE
hi PmenuKind guifg=#ffaf00 guibg=NONE guisp=NONE gui=NONE ctermfg=NONE ctermbg=NONE cterm=NONE
hi PmenuSbar guifg=NONE guibg=#2a2b3d guisp=NONE gui=NONE ctermfg=NONE ctermbg=236 cterm=NONE
hi PmenuThumb guifg=NONE guibg=#444B6A guisp=NONE gui=NONE ctermfg=NONE ctermbg=246 cterm=NONE
hi PmenuShadow guifg=DarkGrey guibg=Black guisp=NONE gui=NONE ctermfg=242 ctermbg=0 cterm=NONE
hi TabLine guifg=#a9b1d6 guibg=#3b3d57 guisp=NONE gui=NONE ctermfg=250 ctermbg=237 cterm=NONE
hi TabLineSel guifg=#1a1b26 guibg=#ff7a93 guisp=NONE gui=NONE ctermfg=235 ctermbg=203 cterm=NONE
hi TabLineFill guifg=#444B6A guibg=#232433 guisp=NONE gui=NONE ctermfg=246 ctermbg=236 cterm=NONE
hi CursorColumn guifg=NONE guibg=#232433 guisp=NONE gui=NONE ctermfg=NONE ctermbg=236 cterm=NONE
hi CursorLine guifg=NONE guibg=#232433 guisp=NONE gui=NONE ctermfg=NONE ctermbg=236 cterm=NONE
hi ColorColumn guifg=NONE guibg=#232433 guisp=NONE gui=NONE ctermfg=NONE ctermbg=236 cterm=NONE
hi QuickFixLine guifg=#7AA2F7 guibg=NONE guisp=NONE gui=NONE ctermfg=110 ctermbg=NONE cterm=NONE
hi StatusLineTerm guifg=#a9b1d6 guibg=#32344a guisp=NONE gui=NONE ctermfg=250 ctermbg=237 cterm=NONE
hi StatusLineTermNC guifg=#444B6A guibg=#232433 guisp=NONE gui=NONE ctermfg=246 ctermbg=236 cterm=NONE
hi Normal guifg=#a9b1d6 guibg=#1a1b26 guisp=NONE gui=NONE ctermfg=250 ctermbg=235 cterm=NONE
hi MatchParen guifg=NONE guibg=#3b3d57 guisp=NONE gui=NONE ctermfg=NONE ctermbg=237 cterm=NONE
hi ToolbarLine guifg=#a9b1d6 guibg=#2a2b3d guisp=NONE gui=NONE ctermfg=250 ctermbg=236 cterm=NONE
hi ToolbarButton guifg=#1a1b26 guibg=#7da6ff guisp=NONE gui=NONE ctermfg=235 ctermbg=110 cterm=NONE
hi Terminal guifg=#a9b1d6 guibg=#1a1b26 guisp=NONE gui=NONE ctermfg=250 ctermbg=235 cterm=NONE
hi Cursor guifg=NONE guibg=NONE guisp=NONE gui=NONE ctermfg=NONE ctermbg=NONE cterm=NONE
hi Whitespace guifg=#3b3d57 guibg=NONE guisp=NONE gui=NONE ctermfg=237 ctermbg=NONE cterm=NONE
hi Debug guifg=#E0AF68 guibg=NONE guisp=NONE gui=NONE ctermfg=179 ctermbg=NONE cterm=NONE
hi debugPC guifg=#1a1b26 guibg=#9ECE6A guisp=NONE gui=NONE ctermfg=235 ctermbg=107 cterm=NONE
hi debugBreakpoint guifg=#1a1b26 guibg=#F7768E guisp=NONE gui=NONE ctermfg=235 ctermbg=203 cterm=NONE
hi Type guifg=#7AA2F7 guibg=NONE guisp=NONE gui=NONE ctermfg=110 ctermbg=NONE cterm=NONE
hi Structure guifg=#7AA2F7 guibg=NONE guisp=NONE gui=NONE ctermfg=110 ctermbg=NONE cterm=NONE
hi StorageClass guifg=#7AA2F7 guibg=NONE guisp=NONE gui=NONE ctermfg=110 ctermbg=NONE cterm=NONE
hi Identifier guifg=#FF9E64 guibg=NONE guisp=NONE gui=NONE ctermfg=215 ctermbg=NONE cterm=NONE
hi Constant guifg=#FF9E64 guibg=NONE guisp=NONE gui=NONE ctermfg=215 ctermbg=NONE cterm=NONE
hi PreProc guifg=#F7768E guibg=NONE guisp=NONE gui=NONE ctermfg=203 ctermbg=NONE cterm=NONE
hi PreCondit guifg=#F7768E guibg=NONE guisp=NONE gui=NONE ctermfg=203 ctermbg=NONE cterm=NONE
hi Include guifg=#F7768E guibg=NONE guisp=NONE gui=NONE ctermfg=203 ctermbg=NONE cterm=NONE
hi Keyword guifg=#F7768E guibg=NONE guisp=NONE gui=NONE ctermfg=203 ctermbg=NONE cterm=NONE
hi Define guifg=#F7768E guibg=NONE guisp=NONE gui=NONE ctermfg=203 ctermbg=NONE cterm=NONE
hi Typedef guifg=#F7768E guibg=NONE guisp=NONE gui=NONE ctermfg=203 ctermbg=NONE cterm=NONE
hi Exception guifg=#F7768E guibg=NONE guisp=NONE gui=NONE ctermfg=203 ctermbg=NONE cterm=NONE
hi Conditional guifg=#F7768E guibg=NONE guisp=NONE gui=NONE ctermfg=203 ctermbg=NONE cterm=NONE
hi Repeat guifg=#F7768E guibg=NONE guisp=NONE gui=NONE ctermfg=203 ctermbg=NONE cterm=NONE
hi Statement guifg=#F7768E guibg=NONE guisp=NONE gui=NONE ctermfg=203 ctermbg=NONE cterm=NONE
hi Macro guifg=#ad8ee6 guibg=NONE guisp=NONE gui=NONE ctermfg=176 ctermbg=NONE cterm=NONE
hi Error guifg=#F7768E guibg=NONE guisp=NONE gui=NONE ctermfg=203 ctermbg=NONE cterm=NONE
hi Label guifg=#ad8ee6 guibg=NONE guisp=NONE gui=NONE ctermfg=176 ctermbg=NONE cterm=NONE
hi Special guifg=#ad8ee6 guibg=NONE guisp=NONE gui=NONE ctermfg=176 ctermbg=NONE cterm=NONE
hi SpecialChar guifg=#ad8ee6 guibg=NONE guisp=NONE gui=NONE ctermfg=176 ctermbg=NONE cterm=NONE
hi Boolean guifg=#ad8ee6 guibg=NONE guisp=NONE gui=NONE ctermfg=176 ctermbg=NONE cterm=NONE
hi String guifg=#E0AF68 guibg=NONE guisp=NONE gui=NONE ctermfg=179 ctermbg=NONE cterm=NONE
hi Character guifg=#E0AF68 guibg=NONE guisp=NONE gui=NONE ctermfg=179 ctermbg=NONE cterm=NONE
hi Number guifg=#ad8ee6 guibg=NONE guisp=NONE gui=NONE ctermfg=176 ctermbg=NONE cterm=NONE
hi Float guifg=#ad8ee6 guibg=NONE guisp=NONE gui=NONE ctermfg=176 ctermbg=NONE cterm=NONE
hi Function guifg=#9ECE6A guibg=NONE guisp=NONE gui=NONE ctermfg=107 ctermbg=NONE cterm=NONE
hi Operator guifg=#F7768E guibg=NONE guisp=NONE gui=NONE ctermfg=203 ctermbg=NONE cterm=NONE
hi Tag guifg=#FF9E64 guibg=NONE guisp=NONE gui=NONE ctermfg=215 ctermbg=NONE cterm=NONE
hi Delimiter guifg=#a9b1d6 guibg=NONE guisp=NONE gui=NONE ctermfg=250 ctermbg=NONE cterm=NONE
hi Comment guifg=#444B6A guibg=NONE guisp=NONE gui=NONE ctermfg=246 ctermbg=NONE cterm=NONE
hi SpecialComment guifg=#444B6A guibg=NONE guisp=NONE gui=NONE ctermfg=246 ctermbg=NONE cterm=NONE
hi Todo guifg=#7AA2F7 guibg=NONE guisp=NONE gui=NONE ctermfg=110 ctermbg=NONE cterm=NONE
hi Ignore guifg=#444B6A guibg=NONE guisp=NONE gui=NONE ctermfg=246 ctermbg=NONE cterm=NONE
hi Underlined guifg=NONE guibg=NONE guisp=NONE gui=NONE ctermfg=NONE ctermbg=NONE cterm=NONE
hi Fg guifg=#a9b1d6 guibg=NONE guisp=NONE gui=NONE ctermfg=250 ctermbg=NONE cterm=NONE
hi Grey guifg=#444B6A guibg=NONE guisp=NONE gui=NONE ctermfg=246 ctermbg=NONE cterm=NONE
hi Red guifg=#F7768E guibg=NONE guisp=NONE gui=NONE ctermfg=203 ctermbg=NONE cterm=NONE
hi Orange guifg=#FF9E64 guibg=NONE guisp=NONE gui=NONE ctermfg=215 ctermbg=NONE cterm=NONE
hi Yellow guifg=#E0AF68 guibg=NONE guisp=NONE gui=NONE ctermfg=179 ctermbg=NONE cterm=NONE
hi Green guifg=#9ECE6A guibg=NONE guisp=NONE gui=NONE ctermfg=107 ctermbg=NONE cterm=NONE
hi Blue guifg=#7AA2F7 guibg=NONE guisp=NONE gui=NONE ctermfg=110 ctermbg=NONE cterm=NONE
hi Purple guifg=#ad8ee6 guibg=NONE guisp=NONE gui=NONE ctermfg=176 ctermbg=NONE cterm=NONE
hi RedItalic guifg=#F7768E guibg=NONE guisp=NONE gui=NONE ctermfg=203 ctermbg=NONE cterm=NONE
hi BlueItalic guifg=#7AA2F7 guibg=NONE guisp=NONE gui=NONE ctermfg=110 ctermbg=NONE cterm=NONE
hi OrangeItalic guifg=#FF9E64 guibg=NONE guisp=NONE gui=NONE ctermfg=215 ctermbg=NONE cterm=NONE
hi markdownH1 guifg=#F7768E guibg=NONE guisp=NONE gui=NONE ctermfg=203 ctermbg=NONE cterm=NONE
hi markdownH2 guifg=#FF9E64 guibg=NONE guisp=NONE gui=NONE ctermfg=215 ctermbg=NONE cterm=NONE
hi markdownH3 guifg=#E0AF68 guibg=NONE guisp=NONE gui=NONE ctermfg=179 ctermbg=NONE cterm=NONE
hi markdownH4 guifg=#9ECE6A guibg=NONE guisp=NONE gui=NONE ctermfg=107 ctermbg=NONE cterm=NONE
hi markdownH5 guifg=#7AA2F7 guibg=NONE guisp=NONE gui=NONE ctermfg=110 ctermbg=NONE cterm=NONE
hi markdownH6 guifg=#ad8ee6 guibg=NONE guisp=NONE gui=NONE ctermfg=176 ctermbg=NONE cterm=NONE
hi markdownUrl guifg=#7AA2F7 guibg=NONE guisp=NONE gui=NONE ctermfg=110 ctermbg=NONE cterm=NONE
hi markdownItalic guifg=NONE guibg=NONE guisp=NONE gui=NONE ctermfg=NONE ctermbg=NONE cterm=NONE
hi markdownBold guifg=NONE guibg=NONE guisp=NONE gui=NONE ctermfg=NONE ctermbg=NONE cterm=NONE
hi markdownItalicDelimiter guifg=#444B6A guibg=NONE guisp=NONE gui=NONE ctermfg=246 ctermbg=NONE cterm=NONE
hi mkdURL guifg=#7AA2F7 guibg=NONE guisp=NONE gui=NONE ctermfg=110 ctermbg=NONE cterm=NONE
hi mkdInlineURL guifg=#7AA2F7 guibg=NONE guisp=NONE gui=NONE ctermfg=110 ctermbg=NONE cterm=NONE
hi mkdItalic guifg=#444B6A guibg=NONE guisp=NONE gui=NONE ctermfg=246 ctermbg=NONE cterm=NONE
hi rstStandaloneHyperlink guifg=#7AA2F7 guibg=NONE guisp=NONE gui=NONE ctermfg=110 ctermbg=NONE cterm=NONE
hi rstEmphasis guifg=NONE guibg=NONE guisp=NONE gui=NONE ctermfg=NONE ctermbg=NONE cterm=NONE
hi rstStrongEmphasis guifg=NONE guibg=NONE guisp=NONE gui=NONE ctermfg=NONE ctermbg=NONE cterm=NONE
hi rstHyperlinkTarget guifg=#7AA2F7 guibg=NONE guisp=NONE gui=NONE ctermfg=110 ctermbg=NONE cterm=NONE
hi htmlH1 guifg=#F7768E guibg=NONE guisp=NONE gui=NONE ctermfg=203 ctermbg=NONE cterm=NONE
hi htmlH2 guifg=#FF9E64 guibg=NONE guisp=NONE gui=NONE ctermfg=215 ctermbg=NONE cterm=NONE
hi htmlH3 guifg=#E0AF68 guibg=NONE guisp=NONE gui=NONE ctermfg=179 ctermbg=NONE cterm=NONE
hi htmlH4 guifg=#9ECE6A guibg=NONE guisp=NONE gui=NONE ctermfg=107 ctermbg=NONE cterm=NONE
hi htmlH5 guifg=#7AA2F7 guibg=NONE guisp=NONE gui=NONE ctermfg=110 ctermbg=NONE cterm=NONE
hi htmlH6 guifg=#ad8ee6 guibg=NONE guisp=NONE gui=NONE ctermfg=176 ctermbg=NONE cterm=NONE
hi htmlLink guifg=NONE guibg=NONE guisp=NONE gui=NONE ctermfg=NONE ctermbg=NONE cterm=NONE
hi htmlBold guifg=NONE guibg=NONE guisp=NONE gui=NONE ctermfg=NONE ctermbg=NONE cterm=NONE
hi htmlBoldUnderline guifg=NONE guibg=NONE guisp=NONE gui=NONE ctermfg=NONE ctermbg=NONE cterm=NONE
hi htmlBoldItalic guifg=NONE guibg=NONE guisp=NONE gui=NONE ctermfg=NONE ctermbg=NONE cterm=NONE
hi htmlBoldUnderlineItalic guifg=NONE guibg=NONE guisp=NONE gui=NONE ctermfg=NONE ctermbg=NONE cterm=NONE
hi htmlUnderline guifg=NONE guibg=NONE guisp=NONE gui=NONE ctermfg=NONE ctermbg=NONE cterm=NONE
hi htmlUnderlineItalic guifg=NONE guibg=NONE guisp=NONE gui=NONE ctermfg=NONE ctermbg=NONE cterm=NONE
hi htmlItalic guifg=NONE guibg=NONE guisp=NONE gui=NONE ctermfg=NONE ctermbg=NONE cterm=NONE
hi semshiUnresolved guifg=#FF9E64 guibg=NONE guisp=NONE gui=NONE ctermfg=215 ctermbg=NONE cterm=NONE
hi CocHighlightText guifg=NONE guibg=#232433 guisp=NONE gui=NONE ctermfg=NONE ctermbg=236 cterm=NONE
hi ALEErrorSign guifg=#F7768E guibg=#232433 guisp=NONE gui=NONE ctermfg=203 ctermbg=236 cterm=NONE
hi tomlTable guifg=#ad8ee6 guibg=NONE guisp=NONE gui=NONE ctermfg=176 ctermbg=NONE cterm=NONE
hi dosiniHeader guifg=#F7768E guibg=NONE guisp=NONE gui=NONE ctermfg=203 ctermbg=NONE cterm=NONE
hi helpNote guifg=#ad8ee6 guibg=NONE guisp=NONE gui=NONE ctermfg=176 ctermbg=NONE cterm=NONE
hi helpHeadline guifg=#F7768E guibg=NONE guisp=NONE gui=NONE ctermfg=203 ctermbg=NONE cterm=NONE
hi helpHeader guifg=#FF9E64 guibg=NONE guisp=NONE gui=NONE ctermfg=215 ctermbg=NONE cterm=NONE
hi helpURL guifg=#9ECE6A guibg=NONE guisp=NONE gui=NONE ctermfg=107 ctermbg=NONE cterm=NONE
hi helpHyperTextEntry guifg=#7AA2F7 guibg=NONE guisp=NONE gui=NONE ctermfg=110 ctermbg=NONE cterm=NONE
hi plug1 guifg=#F7768E guibg=NONE guisp=NONE gui=NONE ctermfg=203 ctermbg=NONE cterm=NONE
hi plugNumber guifg=#E0AF68 guibg=NONE guisp=NONE gui=NONE ctermfg=179 ctermbg=NONE cterm=NONE
hi CocHoverRange guifg=NONE guibg=NONE guisp=NONE gui=NONE ctermfg=NONE ctermbg=NONE cterm=NONE
hi CocHintHighlight guifg=NONE guibg=NONE guisp=NONE gui=NONE ctermfg=NONE ctermbg=NONE cterm=NONE
hi CocErrorFloat guifg=#F7768E guibg=#2a2b3d guisp=NONE gui=NONE ctermfg=203 ctermbg=236 cterm=NONE
hi CocWarningFloat guifg=#E0AF68 guibg=#2a2b3d guisp=NONE gui=NONE ctermfg=179 ctermbg=236 cterm=NONE
hi CocInfoFloat guifg=#7AA2F7 guibg=#2a2b3d guisp=NONE gui=NONE ctermfg=110 ctermbg=236 cterm=NONE
hi CocHintFloat guifg=#9ECE6A guibg=#2a2b3d guisp=NONE gui=NONE ctermfg=107 ctermbg=236 cterm=NONE
hi ALEWarningSign guifg=#E0AF68 guibg=#232433 guisp=NONE gui=NONE ctermfg=179 ctermbg=236 cterm=NONE
hi ALEInfoSign guifg=#7AA2F7 guibg=#232433 guisp=NONE gui=NONE ctermfg=110 ctermbg=236 cterm=NONE
hi ALEError guifg=NONE guibg=NONE guisp=NONE gui=NONE ctermfg=NONE ctermbg=NONE cterm=NONE
hi ALEWarning guifg=NONE guibg=NONE guisp=NONE gui=NONE ctermfg=NONE ctermbg=NONE cterm=NONE
hi ALEInfo guifg=NONE guibg=NONE guisp=NONE gui=NONE ctermfg=NONE ctermbg=NONE cterm=NONE
hi GitGutterAdd guifg=#9ECE6A guibg=#232433 guisp=NONE gui=NONE ctermfg=107 ctermbg=236 cterm=NONE
hi GitGutterChangeDelete guifg=#ad8ee6 guibg=#232433 guisp=NONE gui=NONE ctermfg=176 ctermbg=236 cterm=NONE
hi GitGutterChange guifg=#7AA2F7 guibg=#232433 guisp=NONE gui=NONE ctermfg=110 ctermbg=236 cterm=NONE
hi GitGutterDelete guifg=#F7768E guibg=#232433 guisp=NONE gui=NONE ctermfg=203 ctermbg=236 cterm=NONE
hi Lf_hl_match guifg=#9ECE6A guibg=NONE guisp=NONE gui=NONE ctermfg=107 ctermbg=NONE cterm=NONE
hi Lf_hl_match0 guifg=#9ECE6A guibg=NONE guisp=NONE gui=NONE ctermfg=107 ctermbg=NONE cterm=NONE
hi Lf_hl_match1 guifg=#7AA2F7 guibg=NONE guisp=NONE gui=NONE ctermfg=110 ctermbg=NONE cterm=NONE
hi Lf_hl_match2 guifg=#F7768E guibg=NONE guisp=NONE gui=NONE ctermfg=203 ctermbg=NONE cterm=NONE
hi Lf_hl_match3 guifg=#E0AF68 guibg=NONE guisp=NONE gui=NONE ctermfg=179 ctermbg=NONE cterm=NONE
hi Lf_hl_match4 guifg=#ad8ee6 guibg=NONE guisp=NONE gui=NONE ctermfg=176 ctermbg=NONE cterm=NONE
hi Lf_hl_matchRefine guifg=#E0AF68 guibg=NONE guisp=NONE gui=NONE ctermfg=179 ctermbg=NONE cterm=NONE
hi deniteMatchedChar guifg=#9ECE6A guibg=NONE guisp=NONE gui=NONE ctermfg=107 ctermbg=NONE cterm=NONE
hi deniteMatchedRange guifg=#9ECE6A guibg=NONE guisp=NONE gui=NONE ctermfg=107 ctermbg=NONE cterm=NONE
hi deniteInput guifg=#9ECE6A guibg=#232433 guisp=NONE gui=NONE ctermfg=107 ctermbg=236 cterm=NONE
hi deniteStatusLineNumber guifg=#ad8ee6 guibg=#232433 guisp=NONE gui=NONE ctermfg=176 ctermbg=236 cterm=NONE
hi deniteStatusLinePath guifg=#a9b1d6 guibg=#232433 guisp=NONE gui=NONE ctermfg=250 ctermbg=236 cterm=NONE
hi CtrlPMatch guifg=#9ECE6A guibg=NONE guisp=NONE gui=NONE ctermfg=107 ctermbg=NONE cterm=NONE
hi CtrlPPrtBase guifg=#444B6A guibg=NONE guisp=NONE gui=NONE ctermfg=246 ctermbg=NONE cterm=NONE
hi CtrlPLinePre guifg=#444B6A guibg=NONE guisp=NONE gui=NONE ctermfg=246 ctermbg=NONE cterm=NONE
hi CtrlPMode1 guifg=#7AA2F7 guibg=#232433 guisp=NONE gui=NONE ctermfg=110 ctermbg=236 cterm=NONE
hi CtrlPMode2 guifg=#232433 guibg=#7AA2F7 guisp=NONE gui=NONE ctermfg=236 ctermbg=110 cterm=NONE
hi CtrlPStats guifg=#444B6A guibg=#232433 guisp=NONE gui=NONE ctermfg=246 ctermbg=236 cterm=NONE
hi MatchParenCur guifg=NONE guibg=NONE guisp=NONE gui=NONE ctermfg=NONE ctermbg=NONE cterm=NONE
hi MatchWord guifg=NONE guibg=NONE guisp=NONE gui=NONE ctermfg=NONE ctermbg=NONE cterm=NONE
hi MatchWordCur guifg=NONE guibg=NONE guisp=NONE gui=NONE ctermfg=NONE ctermbg=NONE cterm=NONE
hi SignatureMarkText guifg=#7AA2F7 guibg=#232433 guisp=NONE gui=NONE ctermfg=110 ctermbg=236 cterm=NONE
hi SignatureMarkerText guifg=#F7768E guibg=#232433 guisp=NONE gui=NONE ctermfg=203 ctermbg=236 cterm=NONE
hi UndotreeSavedBig guifg=#F7768E guibg=NONE guisp=NONE gui=NONE ctermfg=203 ctermbg=NONE cterm=NONE
hi QuickScopePrimary guifg=#9ECE6A guibg=NONE guisp=NONE gui=NONE ctermfg=107 ctermbg=NONE cterm=NONE
hi QuickScopeSecondary guifg=#7AA2F7 guibg=NONE guisp=NONE gui=NONE ctermfg=110 ctermbg=NONE cterm=NONE
hi! link CurSearch Search
hi! link CursorLineSign SignColumn
hi! link CursorLineFold FoldColumn
hi! link VertSplitNC VertSplit
hi! link DiffTextAdd DiffText
hi! link PmenuMatchSel PmenuSel
hi! link PmenuKindSel PmenuSel
hi! link PmenuExtra Pmenu
hi! link PmenuExtraSel PmenuSel
hi! link PmenuBorder Pmenu
hi! link TabPanel TabLine
hi! link TabPanelSel TabLineSel
hi! link TabPanelFill TabLineFill
hi! link PreInsert Added
hi! link PopupSelected PmenuSel
hi! link MessageWindow WarningMsg
hi! link PopupNotification WarningMsg
hi! link vCursor Cursor
hi! link iCursor Cursor
hi! link lCursor Cursor
hi! link CursorIM Cursor
hi! link markdownCode Green
hi! link markdownCodeBlock Green
hi! link markdownCodeDelimiter Green
hi! link markdownBlockquote Grey
hi! link markdownListMarker Red
hi! link markdownOrderedListMarker Red
hi! link markdownRule Purple
hi! link markdownHeadingRule Grey
hi! link markdownUrlDelimiter Grey
hi! link markdownLinkDelimiter Grey
hi! link markdownLinkTextDelimiter Grey
hi! link markdownHeadingDelimiter Grey
hi! link markdownLinkText Red
hi! link markdownUrlTitleDelimiter Green
hi! link markdownIdDeclaration markdownLinkText
hi! link markdownBoldDelimiter Grey
hi! link markdownId Yellow
hi! link mkdCodeDelimiter Green
hi! link mkdBold Grey
hi! link mkdLink Red
hi! link mkdHeading Grey
hi! link mkdListItem Red
hi! link mkdRule Purple
hi! link mkdDelimiter Grey
hi! link mkdId Yellow
hi! link rstSubstitutionReference Blue
hi! link rstInterpretedTextOrHyperlinkReference Green
hi! link rstTableLines Grey
hi! link rstInlineLiteral Green
hi! link rstLiteralBlock Green
hi! link rstQuotedLiteralBlock Green
hi! link texStatement BlueItalic
hi! link texOnlyMath Grey
hi! link texDefName Yellow
hi! link texNewCmd Orange
hi! link texCmdName Blue
hi! link texBeginEnd Red
hi! link texBeginEndName Green
hi! link texDocType RedItalic
hi! link texDocTypeArgs Orange
hi! link texInputFile Green
hi! link htmlTag Green
hi! link htmlEndTag Blue
hi! link htmlTagN RedItalic
hi! link htmlTagName RedItalic
hi! link htmlArg Blue
hi! link htmlScriptTag Purple
hi! link htmlSpecialTagName RedItalic
hi! link htmlString Green
hi! link xmlTag Green
hi! link xmlEndTag Blue
hi! link xmlTagName RedItalic
hi! link xmlEqual Orange
hi! link xmlAttrib Blue
hi! link xmlEntity Red
hi! link xmlEntityPunct Red
hi! link xmlDocTypeDecl Grey
hi! link xmlDocTypeKeyword RedItalic
hi! link xmlCdataStart Grey
hi! link xmlCdataCdata Purple
hi! link xmlString Green
hi! link cssStringQ Green
hi! link cssStringQQ Green
hi! link cssAttrComma Grey
hi! link cssBraces Grey
hi! link cssTagName Purple
hi! link cssClassNameDot Orange
hi! link cssClassName Red
hi! link cssFunctionName Orange
hi! link cssAttr Green
hi! link cssCommonAttr Green
hi! link cssProp Blue
hi! link cssPseudoClassId Yellow
hi! link cssPseudoClassFn Green
hi! link cssPseudoClass Yellow
hi! link cssImportant Red
hi! link cssSelectorOp Orange
hi! link cssSelectorOp2 Orange
hi! link cssColor Green
hi! link cssUnitDecorators Orange
hi! link cssValueLength Green
hi! link cssValueInteger Green
hi! link cssValueNumber Green
hi! link cssValueAngle Green
hi! link cssValueTime Green
hi! link cssValueFrequency Green
hi! link cssVendor Grey
hi! link cssNoise Grey
hi! link scssMixinName Orange
hi! link scssSelectorChar Orange
hi! link scssSelectorName Red
hi! link scssInterpolationDelimiter Yellow
hi! link scssVariableValue Green
hi! link scssNull Purple
hi! link scssBoolean Purple
hi! link scssVariableAssignment Grey
hi! link scssAttribute Green
hi! link scssFunctionName Orange
hi! link scssVariable Fg
hi! link scssAmpersand Purple
hi! link lessMixinChar Grey
hi! link lessClass Red
hi! link lessFunction Orange
hi! link javaScriptNull OrangeItalic
hi! link javaScriptIdentifier OrangeItalic
hi! link javaScriptParens Fg
hi! link javaScriptBraces Fg
hi! link javaScriptNumber Purple
hi! link javaScriptLabel Purple
hi! link javaScriptGlobal BlueItalic
hi! link javaScriptMessage BlueItalic
hi! link jsNoise Fg
hi! link Noise Fg
hi! link jsParens Fg
hi! link jsBrackets Fg
hi! link jsObjectBraces Fg
hi! link jsThis BlueItalic
hi! link jsUndefined OrangeItalic
hi! link jsNull OrangeItalic
hi! link jsNan OrangeItalic
hi! link jsSuper OrangeItalic
hi! link jsPrototype OrangeItalic
hi! link jsFunction Red
hi! link jsGlobalNodeObjects BlueItalic
hi! link jsGlobalObjects BlueItalic
hi! link jsArrowFunction Red
hi! link jsArrowFuncArgs Fg
hi! link jsFuncArgs Fg
hi! link jsObjectProp Fg
hi! link jsVariableDef Fg
hi! link jsObjectKey Fg
hi! link jsParen Fg
hi! link jsParenIfElse Fg
hi! link jsParenRepeat Fg
hi! link jsParenSwitch Fg
hi! link jsParenCatch Fg
hi! link jsBracket Fg
hi! link jsObjectValue Fg
hi! link jsDestructuringBlock Fg
hi! link jsBlockLabel Purple
hi! link jsFunctionKey Green
hi! link jsClassDefinition BlueItalic
hi! link jsDot Orange
hi! link jsSpreadExpression Purple
hi! link jsSpreadOperator Green
hi! link jsModuleKeyword BlueItalic
hi! link jsTemplateExpression Purple
hi! link jsTemplateBraces Purple
hi! link jsClassMethodType BlueItalic
hi! link jsExceptions BlueItalic
hi! link javascriptOpSymbol Red
hi! link javascriptOpSymbols Red
hi! link javascriptIdentifierName Fg
hi! link javascriptVariable BlueItalic
hi! link javascriptObjectLabel Fg
hi! link javascriptPropertyNameString Fg
hi! link javascriptFuncArg Fg
hi! link javascriptObjectLiteral Green
hi! link javascriptArrowFunc Red
hi! link javascriptTemplate Purple
hi! link javascriptTemplateSubstitution Purple
hi! link javascriptTemplateSB Purple
hi! link javascriptNodeGlobal BlueItalic
hi! link javascriptDocTags RedItalic
hi! link javascriptDocNotation Blue
hi! link javascriptClassSuper OrangeItalic
hi! link javascriptClassName BlueItalic
hi! link javascriptClassSuperName BlueItalic
hi! link javascriptOperator Red
hi! link javascriptBrackets Fg
hi! link javascriptEndColons Grey
hi! link javascriptObjectLabelColon Grey
hi! link javascriptDotNotation Orange
hi! link javascriptGlobalArrayDot Orange
hi! link javascriptGlobalBigIntDot Orange
hi! link javascriptGlobalDateDot Orange
hi! link javascriptGlobalJSONDot Orange
hi! link javascriptGlobalMathDot Orange
hi! link javascriptGlobalNumberDot Orange
hi! link javascriptGlobalObjectDot Orange
hi! link javascriptGlobalPromiseDot Orange
hi! link javascriptGlobalRegExpDot Orange
hi! link javascriptGlobalStringDot Orange
hi! link javascriptGlobalSymbolDot Orange
hi! link javascriptGlobalURLDot Orange
hi! link javascriptMethod Green
hi! link javascriptMethodName Green
hi! link javascriptObjectMethodName Green
hi! link javascriptGlobalMethod Green
hi! link javascriptDOMStorageMethod Green
hi! link javascriptFileMethod Green
hi! link javascriptFileReaderMethod Green
hi! link javascriptFileListMethod Green
hi! link javascriptBlobMethod Green
hi! link javascriptURLStaticMethod Green
hi! link javascriptNumberStaticMethod Green
hi! link javascriptNumberMethod Green
hi! link javascriptDOMNodeMethod Green
hi! link javascriptES6BigIntStaticMethod Green
hi! link javascriptBOMWindowMethod Green
hi! link javascriptHeadersMethod Green
hi! link javascriptRequestMethod Green
hi! link javascriptResponseMethod Green
hi! link javascriptES6SetMethod Green
hi! link javascriptReflectMethod Green
hi! link javascriptPaymentMethod Green
hi! link javascriptPaymentResponseMethod Green
hi! link javascriptTypedArrayStaticMethod Green
hi! link javascriptGeolocationMethod Green
hi! link javascriptES6MapMethod Green
hi! link javascriptServiceWorkerMethod Green
hi! link javascriptCacheMethod Green
hi! link javascriptFunctionMethod Green
hi! link javascriptXHRMethod Green
hi! link javascriptBOMNavigatorMethod Green
hi! link javascriptDOMEventTargetMethod Green
hi! link javascriptDOMEventMethod Green
hi! link javascriptIntlMethod Green
hi! link javascriptDOMDocMethod Green
hi! link javascriptStringStaticMethod Green
hi! link javascriptStringMethod Green
hi! link javascriptSymbolStaticMethod Green
hi! link javascriptRegExpMethod Green
hi! link javascriptObjectStaticMethod Green
hi! link javascriptObjectMethod Green
hi! link javascriptBOMLocationMethod Green
hi! link javascriptJSONStaticMethod Green
hi! link javascriptGeneratorMethod Green
hi! link javascriptEncodingMethod Green
hi! link javascriptPromiseStaticMethod Green
hi! link javascriptPromiseMethod Green
hi! link javascriptBOMHistoryMethod Green
hi! link javascriptDOMFormMethod Green
hi! link javascriptClipboardMethod Green
hi! link javascriptBroadcastMethod Green
hi! link javascriptDateStaticMethod Green
hi! link javascriptDateMethod Green
hi! link javascriptConsoleMethod Green
hi! link javascriptArrayStaticMethod Green
hi! link javascriptArrayMethod Green
hi! link javascriptMathStaticMethod Green
hi! link javascriptSubtleCryptoMethod Green
hi! link javascriptCryptoMethod Green
hi! link javascriptProp Fg
hi! link javascriptBOMWindowProp Fg
hi! link javascriptDOMStorageProp Fg
hi! link javascriptFileReaderProp Fg
hi! link javascriptURLUtilsProp Fg
hi! link javascriptNumberStaticProp Fg
hi! link javascriptDOMNodeProp Fg
hi! link javascriptRequestProp Fg
hi! link javascriptResponseProp Fg
hi! link javascriptES6SetProp Fg
hi! link javascriptPaymentProp Fg
hi! link javascriptPaymentResponseProp Fg
hi! link javascriptPaymentAddressProp Fg
hi! link javascriptPaymentShippingOptionProp Fg
hi! link javascriptTypedArrayStaticProp Fg
hi! link javascriptServiceWorkerProp Fg
hi! link javascriptES6MapProp Fg
hi! link javascriptRegExpStaticProp Fg
hi! link javascriptRegExpProp Fg
hi! link javascriptXHRProp Fg
hi! link javascriptBOMNavigatorProp Green
hi! link javascriptDOMEventProp Fg
hi! link javascriptBOMNetworkProp Fg
hi! link javascriptDOMDocProp Fg
hi! link javascriptSymbolStaticProp Fg
hi! link javascriptSymbolProp Fg
hi! link javascriptBOMLocationProp Fg
hi! link javascriptEncodingProp Fg
hi! link javascriptCryptoProp Fg
hi! link javascriptBOMHistoryProp Fg
hi! link javascriptDOMFormProp Fg
hi! link javascriptDataViewProp Fg
hi! link javascriptBroadcastProp Fg
hi! link javascriptMathStaticProp Fg
hi! link jsxTagName RedItalic
hi! link jsxOpenPunct Green
hi! link jsxClosePunct Blue
hi! link jsxEscapeJs Purple
hi! link jsxAttrib Blue
hi! link typescriptStorageClass Red
hi! link typescriptEndColons Fg
hi! link typescriptSource BlueItalic
hi! link typescriptMessage Green
hi! link typescriptGlobalObjects BlueItalic
hi! link typescriptInterpolation Purple
hi! link typescriptInterpolationDelimiter Purple
hi! link typescriptBraces Fg
hi! link typescriptParens Fg
hi! link typescriptMethodAccessor Red
hi! link typescriptVariable Red
hi! link typescriptVariableDeclaration Fg
hi! link typescriptTypeReference BlueItalic
hi! link typescriptEnumKeyword Red
hi! link typescriptEnum BlueItalic
hi! link typescriptIdentifierName Fg
hi! link typescriptProp Fg
hi! link typescriptCall Fg
hi! link typescriptInterfaceName BlueItalic
hi! link typescriptMember Fg
hi! link typescriptMemberOptionality Red
hi! link typescriptObjectLabel Fg
hi! link typescriptDefaultParam Fg
hi! link typescriptArrowFunc Red
hi! link typescriptAbstract Red
hi! link typescriptObjectColon Grey
hi! link typescriptTypeAnnotation Grey
hi! link typescriptAssign Red
hi! link typescriptBinaryOp Red
hi! link typescriptUnaryOp Red
hi! link typescriptFuncComma Fg
hi! link typescriptClassName BlueItalic
hi! link typescriptClassHeritage BlueItalic
hi! link typescriptInterfaceHeritage BlueItalic
hi! link typescriptIdentifier OrangeItalic
hi! link typescriptGlobal BlueItalic
hi! link typescriptOperator Red
hi! link typescriptNodeGlobal BlueItalic
hi! link typescriptExport Red
hi! link typescriptImport Red
hi! link typescriptTypeParameter BlueItalic
hi! link typescriptReadonlyModifier Red
hi! link typescriptAccessibilityModifier Red
hi! link typescriptAmbientDeclaration Red
hi! link typescriptTemplateSubstitution Purple
hi! link typescriptTemplateSB Purple
hi! link typescriptExceptions Red
hi! link typescriptCastKeyword Red
hi! link typescriptOptionalMark Red
hi! link typescriptNull OrangeItalic
hi! link typescriptMappedIn Red
hi! link typescriptFuncTypeArrow Red
hi! link typescriptTernaryOp Red
hi! link typescriptParenExp Fg
hi! link typescriptIndexExpr Fg
hi! link typescriptDotNotation Orange
hi! link typescriptGlobalNumberDot Orange
hi! link typescriptGlobalStringDot Orange
hi! link typescriptGlobalArrayDot Orange
hi! link typescriptGlobalObjectDot Orange
hi! link typescriptGlobalSymbolDot Orange
hi! link typescriptGlobalMathDot Orange
hi! link typescriptGlobalDateDot Orange
hi! link typescriptGlobalJSONDot Orange
hi! link typescriptGlobalRegExpDot Orange
hi! link typescriptGlobalPromiseDot Orange
hi! link typescriptGlobalURLDot Orange
hi! link typescriptGlobalMethod Green
hi! link typescriptDOMStorageMethod Green
hi! link typescriptFileMethod Green
hi! link typescriptFileReaderMethod Green
hi! link typescriptFileListMethod Green
hi! link typescriptBlobMethod Green
hi! link typescriptURLStaticMethod Green
hi! link typescriptNumberStaticMethod Green
hi! link typescriptNumberMethod Green
hi! link typescriptDOMNodeMethod Green
hi! link typescriptPaymentMethod Green
hi! link typescriptPaymentResponseMethod Green
hi! link typescriptHeadersMethod Green
hi! link typescriptRequestMethod Green
hi! link typescriptResponseMethod Green
hi! link typescriptES6SetMethod Green
hi! link typescriptReflectMethod Green
hi! link typescriptBOMWindowMethod Green
hi! link typescriptGeolocationMethod Green
hi! link typescriptServiceWorkerMethod Green
hi! link typescriptCacheMethod Green
hi! link typescriptES6MapMethod Green
hi! link typescriptFunctionMethod Green
hi! link typescriptRegExpMethod Green
hi! link typescriptXHRMethod Green
hi! link typescriptBOMNavigatorMethod Green
hi! link typescriptIntlMethod Green
hi! link typescriptDOMEventTargetMethod Green
hi! link typescriptDOMEventMethod Green
hi! link typescriptDOMDocMethod Green
hi! link typescriptStringStaticMethod Green
hi! link typescriptStringMethod Green
hi! link typescriptSymbolStaticMethod Green
hi! link typescriptObjectStaticMethod Green
hi! link typescriptObjectMethod Green
hi! link typescriptJSONStaticMethod Green
hi! link typescriptEncodingMethod Green
hi! link typescriptBOMLocationMethod Green
hi! link typescriptPromiseStaticMethod Green
hi! link typescriptPromiseMethod Green
hi! link typescriptSubtleCryptoMethod Green
hi! link typescriptCryptoMethod Green
hi! link typescriptBOMHistoryMethod Green
hi! link typescriptDOMFormMethod Green
hi! link typescriptConsoleMethod Green
hi! link typescriptDateStaticMethod Green
hi! link typescriptDateMethod Green
hi! link typescriptArrayStaticMethod Green
hi! link typescriptArrayMethod Green
hi! link typescriptMathStaticMethod Green
hi! link typescriptStringProperty Fg
hi! link typescriptDOMStorageProp Fg
hi! link typescriptFileReaderProp Fg
hi! link typescriptURLUtilsProp Fg
hi! link typescriptNumberStaticProp Fg
hi! link typescriptDOMNodeProp Fg
hi! link typescriptBOMWindowProp Fg
hi! link typescriptRequestProp Fg
hi! link typescriptResponseProp Fg
hi! link typescriptPaymentProp Fg
hi! link typescriptPaymentResponseProp Fg
hi! link typescriptPaymentAddressProp Fg
hi! link typescriptPaymentShippingOptionProp Fg
hi! link typescriptES6SetProp Fg
hi! link typescriptServiceWorkerProp Fg
hi! link typescriptES6MapProp Fg
hi! link typescriptRegExpStaticProp Fg
hi! link typescriptRegExpProp Fg
hi! link typescriptBOMNavigatorProp Green
hi! link typescriptXHRProp Fg
hi! link typescriptDOMEventProp Fg
hi! link typescriptDOMDocProp Fg
hi! link typescriptBOMNetworkProp Fg
hi! link typescriptSymbolStaticProp Fg
hi! link typescriptEncodingProp Fg
hi! link typescriptBOMLocationProp Fg
hi! link typescriptCryptoProp Fg
hi! link typescriptDOMFormProp Fg
hi! link typescriptBOMHistoryProp Fg
hi! link typescriptMathStaticProp Fg
hi! link dartCoreClasses BlueItalic
hi! link dartTypeName BlueItalic
hi! link dartInterpolation Purple
hi! link dartTypeDef Red
hi! link dartClassDecl Red
hi! link dartLibrary Red
hi! link dartMetadata OrangeItalic
hi! link cLabel Red
hi! link cppSTLnamespace BlueItalic
hi! link cppSTLtype BlueItalic
hi! link cppAccess Red
hi! link cppStructure Red
hi! link cppSTLios BlueItalic
hi! link cppSTLiterator BlueItalic
hi! link cppSTLexception Red
hi! link cppSTLVariable BlueItalic
hi! link Member OrangeItalic
hi! link Variable Fg
hi! link Namespace BlueItalic
hi! link EnumConstant OrangeItalic
hi! link chromaticaException Red
hi! link chromaticaCast Red
hi! link OperatorOverload Red
hi! link AccessQual Red
hi! link Linkage Red
hi! link AutoType BlueItalic
hi! link LspCxxHlSkippedRegion Grey
hi! link LspCxxHlSkippedRegionBeginEnd Red
hi! link LspCxxHlGroupEnumConstant OrangeItalic
hi! link LspCxxHlGroupNamespace BlueItalic
hi! link LspCxxHlGroupMemberVariable OrangeItalic
hi! link objcModuleImport Red
hi! link objcException Red
hi! link objcProtocolList Fg
hi! link objcDirective Red
hi! link objcPropertyAttribute Purple
hi! link objcHiddenArgument Fg
hi! link csUnspecifiedStatement Red
hi! link csStorage Red
hi! link csClass Red
hi! link csNewType BlueItalic
hi! link csContextualStatement Red
hi! link csInterpolationDelimiter Purple
hi! link csInterpolation Purple
hi! link csEndColon Fg
hi! link pythonBuiltin BlueItalic
hi! link pythonExceptions Red
hi! link pythonDecoratorName OrangeItalic
hi! link pythonExClass BlueItalic
hi! link pythonBuiltinType BlueItalic
hi! link pythonBuiltinObj OrangeItalic
hi! link pythonDottedName OrangeItalic
hi! link pythonBuiltinFunc Green
hi! link pythonFunction Green
hi! link pythonDecorator OrangeItalic
hi! link pythonInclude Include
hi! link pythonImport PreProc
hi! link pythonOperator Red
hi! link pythonConditional Red
hi! link pythonRepeat Red
hi! link pythonException Red
hi! link pythonNone OrangeItalic
hi! link pythonCoding Grey
hi! link pythonDot Grey
hi! link semshiImported BlueItalic
hi! link semshiParameter OrangeItalic
hi! link semshiParameterUnused Grey
hi! link semshiSelf BlueItalic
hi! link semshiGlobal Green
hi! link semshiBuiltin Green
hi! link semshiAttribute OrangeItalic
hi! link semshiLocal Red
hi! link semshiFree Red
hi! link semshiSelected CocHighlightText
hi! link semshiErrorSign ALEErrorSign
hi! link semshiErrorChar ALEErrorSign
hi! link luaFunc Green
hi! link luaFunction Red
hi! link luaTable Fg
hi! link luaIn Red
hi! link luaFuncCall Green
hi! link luaLocal Red
hi! link luaSpecialValue Green
hi! link luaBraces Fg
hi! link luaBuiltIn BlueItalic
hi! link luaNoise Grey
hi! link luaLabel Purple
hi! link luaFuncTable BlueItalic
hi! link luaFuncArgName Fg
hi! link luaEllipsis Red
hi! link luaDocTag Green
hi! link javaClassDecl Red
hi! link javaMethodDecl Red
hi! link javaVarArg Fg
hi! link javaAnnotation Purple
hi! link javaUserLabel Purple
hi! link javaTypedef OrangeItalic
hi! link javaParen Fg
hi! link javaParen1 Fg
hi! link javaParen2 Fg
hi! link javaParen3 Fg
hi! link javaParen4 Fg
hi! link javaParen5 Fg
hi! link ktSimpleInterpolation Purple
hi! link ktComplexInterpolation Purple
hi! link ktComplexInterpolationBrace Purple
hi! link ktStructure Red
hi! link ktKeyword OrangeItalic
hi! link scalaNameDefinition Fg
hi! link scalaInterpolationBoundary Purple
hi! link scalaInterpolation Purple
hi! link scalaTypeOperator Red
hi! link scalaOperator Red
hi! link scalaKeywordModifier Red
hi! link goDirective Red
hi! link goConstants OrangeItalic
hi! link goDeclType Red
hi! link goPackage Red
hi! link goImport Red
hi! link goBuiltins Green
hi! link goPredefinedIdentifiers OrangeItalic
hi! link goVar Red
hi! link rustStructure Red
hi! link rustIdentifier OrangeItalic
hi! link rustModPath BlueItalic
hi! link rustModPathSep Grey
hi! link rustSelf OrangeItalic
hi! link rustSuper OrangeItalic
hi! link rustDeriveTrait Purple
hi! link rustEnumVariant Purple
hi! link rustMacroVariable OrangeItalic
hi! link rustAssert Green
hi! link rustPanic Green
hi! link rustPubScopeCrate BlueItalic
hi! link rustAttribute Purple
hi! link swiftInterpolatedWrapper Purple
hi! link swiftInterpolatedString Purple
hi! link swiftProperty Fg
hi! link swiftTypeDeclaration Red
hi! link swiftClosureArgument OrangeItalic
hi! link swiftStructure Red
hi! link phpVarSelector Fg
hi! link phpIdentifier Fg
hi! link phpDefine Green
hi! link phpStructure Red
hi! link phpSpecialFunction Green
hi! link phpInterpSimpleCurly Purple
hi! link phpComparison Red
hi! link phpMethodsVar Fg
hi! link phpInterpVarname Fg
hi! link phpMemberSelector Red
hi! link phpLabel Red
hi! link phpParent Fg
hi! link phpNowDoc Yellow
hi! link phpFunction Green
hi! link phpMethod Green
hi! link phpClass BlueItalic
hi! link phpSuperglobals BlueItalic
hi! link phpNullValue OrangeItalic
hi! link rubyKeywordAsMethod Green
hi! link rubyInterpolation Purple
hi! link rubyInterpolationDelimiter Purple
hi! link rubyStringDelimiter Yellow
hi! link rubyBlockParameterList Fg
hi! link rubyDefine Red
hi! link rubyModuleName Red
hi! link rubyAccess Red
hi! link rubyMacro Red
hi! link rubySymbol Fg
hi! link haskellBrackets Fg
hi! link haskellIdentifier OrangeItalic
hi! link haskellDecl Red
hi! link haskellType BlueItalic
hi! link haskellDeclKeyword Red
hi! link haskellWhere Red
hi! link haskellDeriving Red
hi! link haskellForeignKeywords Red
hi! link perlStatementPackage Red
hi! link perlStatementInclude Red
hi! link perlStatementStorage Red
hi! link perlStatementList Red
hi! link perlMatchStartEnd Red
hi! link perlVarSimpleMemberName Green
hi! link perlVarSimpleMember Fg
hi! link perlMethod Green
hi! link podVerbatimLine Green
hi! link podCmdText Yellow
hi! link perlVarPlain Fg
hi! link perlVarPlain2 Fg
hi! link ocamlArrow Red
hi! link ocamlEqual Red
hi! link ocamlOperator Red
hi! link ocamlKeyChar Red
hi! link ocamlModPath Green
hi! link ocamlFullMod Green
hi! link ocamlModule BlueItalic
hi! link ocamlConstructor Orange
hi! link ocamlModParam Fg
hi! link ocamlModParam1 Fg
hi! link ocamlAnyVar Fg
hi! link ocamlPpxEncl Red
hi! link ocamlPpxIdentifier Fg
hi! link ocamlSigEncl Red
hi! link erlangAtom Fg
hi! link erlangVariable Fg
hi! link erlangLocalFuncRef Green
hi! link erlangLocalFuncCall Green
hi! link erlangGlobalFuncRef Green
hi! link erlangGlobalFuncCall Green
hi! link erlangAttribute BlueItalic
hi! link erlangPipe Red
hi! link elixirStringDelimiter Yellow
hi! link elixirKeyword Red
hi! link elixirInterpolation Purple
hi! link elixirInterpolationDelimiter Purple
hi! link elixirSelf BlueItalic
hi! link elixirPseudoVariable OrangeItalic
hi! link elixirModuleDefine Red
hi! link elixirBlockDefinition Red
hi! link elixirDefine Red
hi! link elixirPrivateDefine Red
hi! link elixirGuard Red
hi! link elixirPrivateGuard Red
hi! link elixirProtocolDefine Red
hi! link elixirImplDefine Red
hi! link elixirRecordDefine Red
hi! link elixirPrivateRecordDefine Red
hi! link elixirMacroDefine Red
hi! link elixirPrivateMacroDefine Red
hi! link elixirDelegateDefine Red
hi! link elixirOverridableDefine Red
hi! link elixirExceptionDefine Red
hi! link elixirCallbackDefine Red
hi! link elixirStructDefine Red
hi! link elixirExUnitMacro Red
hi! link lispAtomMark Purple
hi! link lispKey Orange
hi! link lispFunc Green
hi! link clojureMacro Red
hi! link clojureFunc Green
hi! link clojureConstant OrangeItalic
hi! link clojureSpecial Red
hi! link clojureDefine Red
hi! link clojureKeyword Blue
hi! link clojureVariable Fg
hi! link clojureMeta Purple
hi! link clojureDeref Purple
hi! link matlabSemicolon Fg
hi! link matlabFunction RedItalic
hi! link matlabImplicit Green
hi! link matlabDelimiter Fg
hi! link matlabOperator Green
hi! link matlabArithmeticOperator Red
hi! link matlabRelationalOperator Red
hi! link matlabLogicalOperator Red
hi! link shRange Fg
hi! link shOption Purple
hi! link shQuote Yellow
hi! link shVariable BlueItalic
hi! link shDerefSimple BlueItalic
hi! link shDerefVar BlueItalic
hi! link shDerefSpecial BlueItalic
hi! link shDerefOff BlueItalic
hi! link shVarAssign Red
hi! link shFunctionOne Green
hi! link shFunctionKey Red
hi! link zshOption BlueItalic
hi! link zshSubst Orange
hi! link zshFunction Green
hi! link ps1FunctionInvocation Green
hi! link ps1FunctionDeclaration Green
hi! link ps1InterpolationDelimiter Purple
hi! link ps1BuiltIn BlueItalic
hi! link vimLet Red
hi! link vimFunction Green
hi! link vimIsCommand Fg
hi! link vimUserFunc Green
hi! link vimFuncName Green
hi! link vimMap BlueItalic
hi! link vimNotation Purple
hi! link vimMapLhs Green
hi! link vimMapRhs Green
hi! link vimSetEqual BlueItalic
hi! link vimSetSep Grey
hi! link vimOption BlueItalic
hi! link vimUserAttrbKey BlueItalic
hi! link vimUserAttrb Green
hi! link vimAutoCmdSfxList Orange
hi! link vimSynType Orange
hi! link vimHiBang Orange
hi! link vimSet BlueItalic
hi! link makeIdent Purple
hi! link makeSpecTarget BlueItalic
hi! link makeTarget Orange
hi! link makeCommands Red
hi! link cmakeCommand Red
hi! link cmakeKWconfigure_package_config_file BlueItalic
hi! link cmakeKWwrite_basic_package_version_file BlueItalic
hi! link cmakeKWExternalProject Green
hi! link cmakeKWadd_compile_definitions Green
hi! link cmakeKWadd_compile_options Green
hi! link cmakeKWadd_custom_command Green
hi! link cmakeKWadd_custom_target Green
hi! link cmakeKWadd_definitions Green
hi! link cmakeKWadd_dependencies Green
hi! link cmakeKWadd_executable Green
hi! link cmakeKWadd_library Green
hi! link cmakeKWadd_link_options Green
hi! link cmakeKWadd_subdirectory Green
hi! link cmakeKWadd_test Green
hi! link cmakeKWbuild_command Green
hi! link cmakeKWcmake_host_system_information Green
hi! link cmakeKWcmake_minimum_required Green
hi! link cmakeKWcmake_parse_arguments Green
hi! link cmakeKWcmake_policy Green
hi! link cmakeKWconfigure_file Green
hi! link cmakeKWcreate_test_sourcelist Green
hi! link cmakeKWctest_build Green
hi! link cmakeKWctest_configure Green
hi! link cmakeKWctest_coverage Green
hi! link cmakeKWctest_memcheck Green
hi! link cmakeKWctest_run_script Green
hi! link cmakeKWctest_start Green
hi! link cmakeKWctest_submit Green
hi! link cmakeKWctest_test Green
hi! link cmakeKWctest_update Green
hi! link cmakeKWctest_upload Green
hi! link cmakeKWdefine_property Green
hi! link cmakeKWdoxygen_add_docs Green
hi! link cmakeKWenable_language Green
hi! link cmakeKWenable_testing Green
hi! link cmakeKWexec_program Green
hi! link cmakeKWexecute_process Green
hi! link cmakeKWexport Green
hi! link cmakeKWexport_library_dependencies Green
hi! link cmakeKWfile Green
hi! link cmakeKWfind_file Green
hi! link cmakeKWfind_library Green
hi! link cmakeKWfind_package Green
hi! link cmakeKWfind_path Green
hi! link cmakeKWfind_program Green
hi! link cmakeKWfltk_wrap_ui Green
hi! link cmakeKWforeach Green
hi! link cmakeKWfunction Green
hi! link cmakeKWget_cmake_property Green
hi! link cmakeKWget_directory_property Green
hi! link cmakeKWget_filename_component Green
hi! link cmakeKWget_property Green
hi! link cmakeKWget_source_file_property Green
hi! link cmakeKWget_target_property Green
hi! link cmakeKWget_test_property Green
hi! link cmakeKWif Green
hi! link cmakeKWinclude Green
hi! link cmakeKWinclude_directories Green
hi! link cmakeKWinclude_external_msproject Green
hi! link cmakeKWinclude_guard Green
hi! link cmakeKWinstall Green
hi! link cmakeKWinstall_files Green
hi! link cmakeKWinstall_programs Green
hi! link cmakeKWinstall_targets Green
hi! link cmakeKWlink_directories Green
hi! link cmakeKWlist Green
hi! link cmakeKWload_cache Green
hi! link cmakeKWload_command Green
hi! link cmakeKWmacro Green
hi! link cmakeKWmark_as_advanced Green
hi! link cmakeKWmath Green
hi! link cmakeKWmessage Green
hi! link cmakeKWoption Green
hi! link cmakeKWproject Green
hi! link cmakeKWqt_wrap_cpp Green
hi! link cmakeKWqt_wrap_ui Green
hi! link cmakeKWremove Green
hi! link cmakeKWseparate_arguments Green
hi! link cmakeKWset Green
hi! link cmakeKWset_directory_properties Green
hi! link cmakeKWset_property Green
hi! link cmakeKWset_source_files_properties Green
hi! link cmakeKWset_target_properties Green
hi! link cmakeKWset_tests_properties Green
hi! link cmakeKWsource_group Green
hi! link cmakeKWstring Green
hi! link cmakeKWsubdirs Green
hi! link cmakeKWtarget_compile_definitions Green
hi! link cmakeKWtarget_compile_features Green
hi! link cmakeKWtarget_compile_options Green
hi! link cmakeKWtarget_include_directories Green
hi! link cmakeKWtarget_link_directories Green
hi! link cmakeKWtarget_link_libraries Green
hi! link cmakeKWtarget_link_options Green
hi! link cmakeKWtarget_precompile_headers Green
hi! link cmakeKWtarget_sources Green
hi! link cmakeKWtry_compile Green
hi! link cmakeKWtry_run Green
hi! link cmakeKWunset Green
hi! link cmakeKWuse_mangled_mesa Green
hi! link cmakeKWvariable_requires Green
hi! link cmakeKWvariable_watch Green
hi! link cmakeKWwrite_file Green
hi! link jsonKeyword Red
hi! link jsonString Green
hi! link jsonBoolean Blue
hi! link jsonNoise Grey
hi! link jsonQuote Grey
hi! link jsonBraces Fg
hi! link yamlKey Red
hi! link yamlConstant BlueItalic
hi! link yamlString Green
hi! link tomlKey Red
hi! link tomlBoolean Blue
hi! link tomlString Green
hi! link tomlTableArray tomlTable
hi! link diffAdded Green
hi! link diffRemoved Red
hi! link diffChanged Blue
hi! link diffOldFile Yellow
hi! link diffNewFile Orange
hi! link diffFile Purple
hi! link diffLine Grey
hi! link diffIndexLine Purple
hi! link gitcommitSummary Red
hi! link gitcommitUntracked Grey
hi! link gitcommitDiscarded Grey
hi! link gitcommitSelected Grey
hi! link gitcommitUnmerged Grey
hi! link gitcommitOnBranch Grey
hi! link gitcommitArrow Grey
hi! link gitcommitFile Green
hi! link dosiniLabel Blue
hi! link dosiniValue Green
hi! link dosiniNumber Green
hi! link helpHyperTextJump Blue
hi! link helpCommand Yellow
hi! link helpExample Green
hi! link helpSpecial Purple
hi! link helpSectionDelim Grey
hi! link plug2 Blue
hi! link plugBracket Blue
hi! link plugName Green
hi! link plugDash Red
hi! link plugNotLoaded Grey
hi! link plugH2 Purple
hi! link plugMessage Purple
hi! link plugError Red
hi! link plugRelDate Grey
hi! link plugStar Purple
hi! link plugUpdate Blue
hi! link plugDeleted Grey
hi! link plugEdge Purple
hi! link CocHintSign Label
hi! link CocCodeLens Grey
hi! link CocErrorSign ALEErrorSign
hi! link CocWarningSign ALEWarningSign
hi! link CocInfoSign ALEInfoSign
hi! link CocErrorHighlight ALEError
hi! link CocWarningHighlight ALEWarning
hi! link CocInfoHighlight ALEInfo
hi! link CocWarningVirtualText ALEVirtualTextWarning
hi! link ALEVirtualTextWarning Grey
hi! link CocErrorVirtualText ALEVirtualTextError
hi! link ALEVirtualTextError Grey
hi! link CocInfoVirtualText ALEVirtualTextInfo
hi! link ALEVirtualTextInfo Grey
hi! link CocHintVirtualText ALEVirtualTextInfo
hi! link CocGitAddedSign GitGutterAdd
hi! link CocGitChangeRemovedSign GitGutterChangeDelete
hi! link CocGitChangedSign GitGutterChange
hi! link CocGitRemovedSign GitGutterDelete
hi! link CocGitTopRemovedSign GitGutterDelete
hi! link CocExplorerBufferRoot Red
hi! link CocExplorerBufferExpandIcon Blue
hi! link CocExplorerBufferBufnr Yellow
hi! link CocExplorerBufferModified Red
hi! link CocExplorerBufferBufname Grey
hi! link CocExplorerBufferFullpath Grey
hi! link CocExplorerFileRoot Red
hi! link CocExplorerFileExpandIcon Blue
hi! link CocExplorerFileFullpath Grey
hi! link CocExplorerFileDirectory Green
hi! link CocExplorerFileGitStage Blue
hi! link CocExplorerFileGitUnstage Yellow
hi! link CocExplorerFileSize Blue
hi! link CocExplorerTimeAccessed Purple
hi! link CocExplorerTimeCreated Purple
hi! link CocExplorerTimeModified Purple
hi! link CocExplorerFileRootName Orange
hi! link CocExplorerBufferNameVisible Green
hi! link ALEVirtualTextStyleError ALEVirtualTextError
hi! link ALEVirtualTextStyleWarning ALEVirtualTextWarning
hi! link NeomakeError ALEError
hi! link NeomakeErrorSign ALEErrorSign
hi! link NeomakeWarning ALEWarning
hi! link NeomakeWarningSign ALEWarningSign
hi! link NeomakeInfo ALEInfo
hi! link NeomakeInfoSign ALEInfoSign
hi! link NeomakeMessage ALEInfo
hi! link NeomakeMessageSign CocHintSign
hi! link NeomakeVirtualtextError Grey
hi! link NeomakeVirtualtextWarning Grey
hi! link NeomakeVirtualtextInfo Grey
hi! link NeomakeVirtualtextMessag Grey
hi! link SyntasticError ALEError
hi! link SyntasticWarning ALEWarning
hi! link SyntasticErrorSign ALEErrorSign
hi! link SyntasticWarningSign ALEWarningSign
hi! link Lf_hl_cursorline Fg
hi! link Lf_hl_selection DiffAdd
hi! link Lf_hl_rgHighlight Visual
hi! link Lf_hl_gtagsHighlight Visual
hi! link deniteSelectedLine Green
hi! link CtrlPNoEntries Red
hi! link CtrlPPrtCursor Blue
hi! link TagbarFoldIcon Blue
hi! link TagbarSignature Green
hi! link TagbarKind Red
hi! link TagbarScope Orange
hi! link TagbarNestedKind Blue
hi! link TagbarVisibilityPrivate Red
hi! link TagbarVisibilityPublic Blue
hi! link VistaBracket Grey
hi! link VistaChildrenNr Yellow
hi! link VistaScope Red
hi! link VistaTag Green
hi! link VistaPrefix Grey
hi! link VistaColon Green
hi! link VistaIcon Purple
hi! link VistaLineNr Fg
hi! link SignifySignAdd GitGutterAdd
hi! link SignifySignChange GitGutterChange
hi! link SignifySignDelete GitGutterDelete
hi! link SignifySignChangeDelete GitGutterChangeDelete
hi! link NERDTreeDir Green
hi! link NERDTreeDirSlash Green
hi! link NERDTreeOpenable Blue
hi! link NERDTreeClosable Blue
hi! link NERDTreeFile Fg
hi! link NERDTreeExecFile Red
hi! link NERDTreeUp Grey
hi! link NERDTreeCWD Purple
hi! link NERDTreeHelp Grey
hi! link NERDTreeToggleOn Green
hi! link NERDTreeToggleOff Red
hi! link NERDTreeFlags Blue
hi! link NERDTreeLinkFile Grey
hi! link NERDTreeLinkTarget Green
hi! link DirvishPathTail Blue
hi! link DirvishArg Yellow
hi! link netrwDir Green
hi! link netrwClassify Green
hi! link netrwLink Grey
hi! link netrwSymLink Fg
hi! link netrwExe Red
hi! link netrwComment Grey
hi! link netrwList Yellow
hi! link netrwHelpCmd Blue
hi! link netrwCmdSep Grey
hi! link netrwVersion Purple
hi! link EasyMotionTarget Search
hi! link EasyMotionShade Grey
hi! link Sneak Cursor
hi! link SneakLabel Cursor
hi! link SneakScope DiffAdd
hi! link multiple_cursors_cursor Cursor
hi! link multiple_cursors_visual Visual
hi! link CurrentWord CocHighlightText
hi! link CurrentWordTwins CocHighlightText
hi! link illuminatedWord CocHighlightText
hi! link CursorWord0 CocHighlightText
hi! link CursorWord1 CocHighlightText
hi! link StartifyBracket Grey
hi! link StartifyFile Green
hi! link StartifyNumber Orange
hi! link StartifyPath Grey
hi! link StartifySlash Grey
hi! link StartifySection Blue
hi! link StartifyHeader Red
hi! link StartifySpecial Grey
hi! link BufTabLineCurrent TabLineSel
hi! link BufTabLineActive TabLine
hi! link BufTabLineHidden TabLineFill
hi! link BufTabLineFill TabLineFill
hi! link WhichKey Red
hi! link WhichKeySeperator Green
hi! link WhichKeyGroup Orange
hi! link WhichKeyDesc Blue
hi! link QuickmenuOption Green
hi! link QuickmenuNumber Orange
hi! link QuickmenuBracket Grey
hi! link QuickmenuHelp Blue
hi! link QuickmenuSpecial Grey
hi! link QuickmenuHeader Purple
hi! link UndotreeNode Blue
hi! link UndotreeNodeCurrent Purple
hi! link UndotreeSeq Green
hi! link UndotreeCurrent Blue
hi! link UndotreeNext Yellow
hi! link UndotreeTimeStamp Grey
hi! link UndotreeHead Purple
hi! link UndotreeBranch Blue
hi! link UndotreeSavedSmall Red
hi! link Blamer Grey
hi! link agitTree Grey
hi! link agitDate Green
hi! link agitRemote Red
hi! link agitHead Blue
hi! link agitRef Orange
hi! link agitTag Blue
hi! link agitStatFile Blue
hi! link agitStatRemoved Red
hi! link agitStatAdded Green
hi! link agitStatMessage Orange
hi! link agitDiffRemove diffRemoved
hi! link agitDiffAdd diffAdded
hi! link agitDiffHeader Blue
hi! link agitAuthor Yellow
