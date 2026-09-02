vim9script
# supra-gui: background=#15161D include=#FF79C6 stdio=#DEE783 typedef=#FF79C6 struct=#FF79C6 type_s=#F2F2EC scope=#F2F2EC float=#86DFF3 function=#F2F2EC format=#FF79C6 text=#DEE783 integer=#C9A6FA

scriptencoding utf8

set background=dark
set t_Co=256

hi clear

if exists('syntax_on')
	syntax reset
endif

g:colors_name = 'supradracula'

# Terminal
g:terminal_ansi_colors = [
    '#15161D', '#FF8989', '#4DEF77', '#DEE783',
    '#C9A6FA', '#FF79C6', '#86DFF3', '#F2F2EC',
    '#9B97D0', '#FFA3A3', '#74F395', '#E5EC9E',
    '#D5BAFB', '#FF96D3', '#A1E6F6', '#FFFFFF'
]

hi DraculaBgLight guifg=NONE guibg=#242633 guisp=NONE gui=NONE ctermfg=NONE ctermbg=235 cterm=NONE
hi DraculaBgLighter guifg=NONE guibg=#2E3040 guisp=NONE gui=NONE ctermfg=NONE ctermbg=236 cterm=NONE
hi DraculaBgDark guifg=NONE guibg=#15161D guisp=NONE gui=NONE ctermfg=NONE ctermbg=233 cterm=NONE
hi DraculaBgDarker guifg=NONE guibg=#101116 guisp=NONE gui=NONE ctermfg=NONE ctermbg=232 cterm=NONE
hi DraculaFg guifg=#F2F2EC guibg=NONE guisp=NONE gui=NONE ctermfg=255 ctermbg=NONE cterm=NONE
hi DraculaFgUnderline guifg=#F2F2EC guibg=NONE guisp=NONE gui=underline ctermfg=255 ctermbg=NONE cterm=underline
hi DraculaFgBold guifg=#F2F2EC guibg=NONE guisp=NONE gui=bold ctermfg=255 ctermbg=NONE cterm=bold
hi DraculaFgStrikethrough guifg=#F2F2EC guibg=NONE guisp=NONE gui=strikethrough ctermfg=255 ctermbg=NONE cterm=strikethrough
hi DraculaComment guifg=#9B97D0 guibg=NONE guisp=NONE gui=NONE ctermfg=104 ctermbg=NONE cterm=NONE
hi DraculaCommentBold guifg=#9B97D0 guibg=NONE guisp=NONE gui=bold ctermfg=104 ctermbg=NONE cterm=bold
hi DraculaSelection guifg=NONE guibg=#3B3E52 guisp=NONE gui=NONE ctermfg=NONE ctermbg=238 cterm=NONE
hi DraculaSubtle guifg=#2E3040 guibg=NONE guisp=NONE gui=NONE ctermfg=236 ctermbg=NONE cterm=NONE
hi DraculaCyan guifg=#86DFF3 guibg=NONE guisp=NONE gui=NONE ctermfg=117 ctermbg=NONE cterm=NONE
hi DraculaCyanItalic guifg=#86DFF3 guibg=NONE guisp=NONE gui=italic ctermfg=117 ctermbg=NONE cterm=italic
hi DraculaCyanInverse guifg=#86DFF3 guibg=#1B1C25 guisp=NONE gui=inverse ctermfg=117 ctermbg=234 cterm=inverse
hi DraculaGreen guifg=#4DEF77 guibg=NONE guisp=NONE gui=NONE ctermfg=84 ctermbg=NONE cterm=NONE
hi DraculaGreenBold guifg=#4DEF77 guibg=NONE guisp=NONE gui=bold ctermfg=84 ctermbg=NONE cterm=bold
hi DraculaGreenItalic guifg=#4DEF77 guibg=NONE guisp=NONE gui=italic ctermfg=84 ctermbg=NONE cterm=italic
hi DraculaGreenItalicUnderline guifg=#4DEF77 guibg=NONE guisp=NONE gui=italic,underline ctermfg=84 ctermbg=NONE cterm=italic,underline
hi DraculaGreenInverse guifg=#4DEF77 guibg=#1B1C25 guisp=NONE gui=inverse ctermfg=84 ctermbg=234 cterm=inverse
hi DraculaOrange guifg=#FFB86C guibg=NONE guisp=NONE gui=NONE ctermfg=215 ctermbg=NONE cterm=NONE
hi DraculaOrangeBold guifg=#FFB86C guibg=NONE guisp=NONE gui=bold ctermfg=215 ctermbg=NONE cterm=bold
hi DraculaOrangeItalic guifg=#FFB86C guibg=NONE guisp=NONE gui=italic ctermfg=215 ctermbg=NONE cterm=italic
hi DraculaOrangeBoldItalic guifg=#FFB86C guibg=NONE guisp=NONE gui=bold,italic ctermfg=215 ctermbg=NONE cterm=bold,italic
hi DraculaOrangeInverse guifg=#FFB86C guibg=#1B1C25 guisp=NONE gui=inverse ctermfg=215 ctermbg=234 cterm=inverse
hi DraculaPink guifg=#FF79C6 guibg=NONE guisp=NONE gui=NONE ctermfg=212 ctermbg=NONE cterm=NONE
hi DraculaPinkItalic guifg=#FF79C6 guibg=NONE guisp=NONE gui=italic ctermfg=212 ctermbg=NONE cterm=italic
hi DraculaPinkInverse guifg=#FF79C6 guibg=#1B1C25 guisp=NONE gui=inverse ctermfg=212 ctermbg=234 cterm=inverse
hi DraculaPurple guifg=#C9A6FA guibg=NONE guisp=NONE gui=NONE ctermfg=183 ctermbg=NONE cterm=NONE
hi DraculaPurpleBold guifg=#C9A6FA guibg=NONE guisp=NONE gui=bold ctermfg=183 ctermbg=NONE cterm=bold
hi DraculaPurpleItalic guifg=#C9A6FA guibg=NONE guisp=NONE gui=italic ctermfg=183 ctermbg=NONE cterm=italic
hi DraculaPurpleInverse guifg=#C9A6FA guibg=#1B1C25 guisp=NONE gui=inverse ctermfg=183 ctermbg=234 cterm=inverse
hi DraculaRed guifg=#FF8989 guibg=NONE guisp=NONE gui=NONE ctermfg=210 ctermbg=NONE cterm=NONE
hi DraculaRedInverse guifg=#FF8989 guibg=#1B1C25 guisp=NONE gui=inverse ctermfg=210 ctermbg=234 cterm=inverse
hi DraculaYellow guifg=#DEE783 guibg=NONE guisp=NONE gui=NONE ctermfg=186 ctermbg=NONE cterm=NONE
hi DraculaYellowItalic guifg=#DEE783 guibg=NONE guisp=NONE gui=italic ctermfg=186 ctermbg=NONE cterm=italic
hi DraculaYellowInverse guifg=#DEE783 guibg=#1B1C25 guisp=NONE gui=inverse ctermfg=186 ctermbg=234 cterm=inverse
hi DraculaError guifg=#FF8989 guibg=NONE guisp=#FF8989 gui=NONE ctermfg=210 ctermbg=NONE cterm=NONE
hi DraculaErrorLine guifg=#FF8989 guibg=NONE guisp=#FF8989 gui=undercurl ctermfg=210 ctermbg=NONE cterm=undercurl
hi DraculaWarnLine guifg=#FFB86C guibg=NONE guisp=#FFB86C gui=undercurl ctermfg=215 ctermbg=NONE cterm=undercurl
hi DraculaInfoLine guifg=#86DFF3 guibg=NONE guisp=#86DFF3 gui=undercurl ctermfg=117 ctermbg=NONE cterm=undercurl
hi DraculaTodo guifg=#86DFF3 guibg=NONE guisp=NONE gui=bold,inverse ctermfg=117 ctermbg=NONE cterm=bold,inverse
hi DraculaBoundary guifg=#9B97D0 guibg=#15161D guisp=NONE gui=NONE ctermfg=104 ctermbg=233 cterm=NONE
hi DraculaWinSeparator guifg=#9B97D0 guibg=#15161D guisp=NONE gui=NONE ctermfg=104 ctermbg=233 cterm=NONE
hi DraculaLink guifg=#86DFF3 guibg=NONE guisp=NONE gui=underline ctermfg=117 ctermbg=NONE cterm=underline
hi DraculaDiffChange guifg=#FFB86C guibg=NONE guisp=NONE gui=NONE ctermfg=215 ctermbg=NONE cterm=NONE
hi DraculaDiffDelete guifg=#FF8989 guibg=#15161D guisp=NONE gui=NONE ctermfg=210 ctermbg=233 cterm=NONE
hi DraculaDiffText guifg=#1B1C25 guibg=#FFB86C guisp=NONE gui=NONE ctermfg=234 ctermbg=215 cterm=NONE
hi DraculaInlayHint guifg=#9B97D0 guibg=#15161D guisp=NONE gui=NONE ctermfg=104 ctermbg=233 cterm=NONE
hi Normal guifg=#F2F2EC guibg=#1B1C25 guisp=NONE gui=NONE ctermfg=255 ctermbg=234 cterm=NONE
hi StatusLine guifg=#F2F2EC guibg=#2E3040 guisp=NONE gui=bold ctermfg=255 ctermbg=236 cterm=bold
hi StatusLineNC guifg=#9B97D0 guibg=#242633 guisp=NONE gui=NONE ctermfg=104 ctermbg=235 cterm=NONE
hi StatusLineTerm guifg=#F2F2EC guibg=#2E3040 guisp=NONE gui=bold ctermfg=255 ctermbg=236 cterm=bold
hi StatusLineTermNC guifg=#9B97D0 guibg=#242633 guisp=NONE gui=NONE ctermfg=104 ctermbg=235 cterm=NONE
hi WildMenu guifg=#1B1C25 guibg=#C9A6FA guisp=NONE gui=bold ctermfg=234 ctermbg=183 cterm=bold
hi CursorLine guifg=NONE guibg=#2E3040 guisp=NONE gui=NONE ctermfg=NONE ctermbg=236 cterm=NONE
hi! link DraculaSearch DraculaGreenInverse
hi! link ColorColumn DraculaBgDark
hi! link CursorColumn CursorLine
hi CursorLineNr guifg=#FFB86C guibg=#2E3040 guisp=NONE gui=bold ctermfg=215 ctermbg=236 cterm=bold
hi! link DiffAdd DraculaGreen
hi! link DiffAdded DraculaGreen
hi! link DiffChange DraculaDiffChange
hi! link DiffDelete DraculaDiffDelete
hi! link DiffRemoved DraculaRed
hi! link DiffText DraculaDiffText
hi Directory guifg=#C9A6FA guibg=NONE guisp=NONE gui=bold ctermfg=183 ctermbg=NONE cterm=bold
hi! link ErrorMsg DraculaRedInverse
hi! link FoldColumn DraculaSubtle
hi! link Folded DraculaBoundary
hi! link IncSearch DraculaOrangeInverse
hi LineNr guifg=#726F99 guibg=NONE guisp=NONE gui=NONE ctermfg=60 ctermbg=NONE cterm=NONE
hi! link MoreMsg DraculaFgBold
hi! link NonText DraculaSubtle
hi Pmenu guifg=NONE guibg=#15161D guisp=NONE gui=NONE ctermfg=NONE ctermbg=233 cterm=NONE
hi! link PmenuSbar DraculaBgDark
hi! link PmenuSel DraculaSelection
hi! link PmenuThumb DraculaSelection
hi PmenuMatch guifg=#86DFF3 guibg=#15161D guisp=NONE gui=NONE ctermfg=117 ctermbg=233 cterm=NONE
hi PmenuMatchSel guifg=#86DFF3 guibg=#3B3E52 guisp=NONE gui=NONE ctermfg=117 ctermbg=238 cterm=NONE
hi! link Question DraculaFgBold
hi Search guifg=#4DEF77 guibg=#1B1C25 guisp=NONE gui=inverse ctermfg=84 ctermbg=234 cterm=inverse
hi SignColumn guifg=#9B97D0 guibg=NONE guisp=NONE gui=NONE ctermfg=104 ctermbg=NONE cterm=NONE
hi! link TabLine DraculaBoundary
hi! link TabLineFill DraculaBgDark
hi! link TabLineSel Normal
hi Title guifg=#4DEF77 guibg=NONE guisp=NONE gui=bold ctermfg=84 ctermbg=NONE cterm=bold
hi! link VertSplit DraculaWinSeparator
hi Visual guifg=NONE guibg=#3B3E52 guisp=NONE gui=NONE ctermfg=NONE ctermbg=238 cterm=NONE
hi! link VisualNOS Visual
hi! link WarningMsg DraculaOrangeInverse
hi MatchParen guifg=#4DEF77 guibg=NONE guisp=NONE gui=underline ctermfg=84 ctermbg=NONE cterm=underline
hi Conceal guifg=#86DFF3 guibg=NONE guisp=NONE gui=NONE ctermfg=117 ctermbg=NONE cterm=NONE
hi! link SpecialKey DraculaPink
hi Comment guifg=#9B97D0 guibg=NONE guisp=NONE gui=NONE ctermfg=104 ctermbg=NONE cterm=NONE
hi Underlined guifg=#F2F2EC guibg=NONE guisp=NONE gui=underline ctermfg=255 ctermbg=NONE cterm=underline
hi Todo guifg=#86DFF3 guibg=NONE guisp=NONE gui=bold,inverse ctermfg=117 ctermbg=NONE cterm=bold,inverse
hi! link Added DiffAdded
hi! link Changed DiffChange
hi! link Removed DiffRemoved
hi Error guifg=#FF8989 guibg=NONE guisp=#FF8989 gui=NONE ctermfg=210 ctermbg=NONE cterm=NONE
hi! link SpellBad DraculaErrorLine
hi! link SpellLocal DraculaWarnLine
hi! link SpellCap DraculaInfoLine
hi! link SpellRare DraculaInfoLine
hi Constant guifg=#C9A6FA guibg=NONE guisp=NONE gui=NONE ctermfg=183 ctermbg=NONE cterm=NONE
hi String guifg=#DEE783 guibg=NONE guisp=NONE gui=NONE ctermfg=186 ctermbg=NONE cterm=NONE
hi Character guifg=#FF79C6 guibg=NONE guisp=NONE gui=NONE ctermfg=212 ctermbg=NONE cterm=NONE
hi Number guifg=#C9A6FA guibg=NONE guisp=NONE gui=NONE ctermfg=183 ctermbg=NONE cterm=NONE
hi Boolean guifg=#C9A6FA guibg=NONE guisp=NONE gui=NONE ctermfg=183 ctermbg=NONE cterm=NONE
hi Float guifg=#C9A6FA guibg=NONE guisp=NONE gui=NONE ctermfg=183 ctermbg=NONE cterm=NONE
hi Identifier guifg=#F2F2EC guibg=NONE guisp=NONE gui=NONE ctermfg=255 ctermbg=NONE cterm=NONE
hi Function guifg=#4DEF77 guibg=NONE guisp=NONE gui=NONE ctermfg=84 ctermbg=NONE cterm=NONE
hi Statement guifg=#FF79C6 guibg=NONE guisp=NONE gui=NONE ctermfg=212 ctermbg=NONE cterm=NONE
hi Conditional guifg=#FF79C6 guibg=NONE guisp=NONE gui=NONE ctermfg=212 ctermbg=NONE cterm=NONE
hi Repeat guifg=#FF79C6 guibg=NONE guisp=NONE gui=NONE ctermfg=212 ctermbg=NONE cterm=NONE
hi Label guifg=#FF79C6 guibg=NONE guisp=NONE gui=NONE ctermfg=212 ctermbg=NONE cterm=NONE
hi Operator guifg=#FF79C6 guibg=NONE guisp=NONE gui=NONE ctermfg=212 ctermbg=NONE cterm=NONE
hi Keyword guifg=#FF79C6 guibg=NONE guisp=NONE gui=NONE ctermfg=212 ctermbg=NONE cterm=NONE
hi Exception guifg=#FF79C6 guibg=NONE guisp=NONE gui=NONE ctermfg=212 ctermbg=NONE cterm=NONE
hi PreProc guifg=#FF79C6 guibg=NONE guisp=NONE gui=NONE ctermfg=212 ctermbg=NONE cterm=NONE
hi Include guifg=#FF79C6 guibg=NONE guisp=NONE gui=NONE ctermfg=212 ctermbg=NONE cterm=NONE
hi Define guifg=#FF79C6 guibg=NONE guisp=NONE gui=NONE ctermfg=212 ctermbg=NONE cterm=NONE
hi Macro guifg=#FF79C6 guibg=NONE guisp=NONE gui=NONE ctermfg=212 ctermbg=NONE cterm=NONE
hi! link PreCondit DraculaPink
hi StorageClass guifg=#FF79C6 guibg=NONE guisp=NONE gui=NONE ctermfg=212 ctermbg=NONE cterm=NONE
hi Structure guifg=#FF79C6 guibg=NONE guisp=NONE gui=NONE ctermfg=212 ctermbg=NONE cterm=NONE
hi Typedef guifg=#FF79C6 guibg=NONE guisp=NONE gui=NONE ctermfg=212 ctermbg=NONE cterm=NONE
hi Type guifg=#86DFF3 guibg=NONE guisp=NONE gui=italic ctermfg=117 ctermbg=NONE cterm=italic
hi! link Delimiter DraculaFg
hi Special guifg=#FF79C6 guibg=NONE guisp=NONE gui=NONE ctermfg=212 ctermbg=NONE cterm=NONE
hi! link SpecialComment DraculaCyanItalic
hi! link Tag DraculaCyan
hi! link helpHyperTextJump DraculaLink
hi! link helpCommand DraculaPurple
hi! link helpExample DraculaGreen
hi! link helpBacktick Special
hi! link cssAttrComma Delimiter
hi! link cssAttrRegion DraculaPink
hi! link cssAttributeSelector DraculaGreenItalic
hi! link cssBraces Delimiter
hi! link cssFunctionComma Delimiter
hi! link cssNoise DraculaPink
hi! link cssProp DraculaCyan
hi! link cssPseudoClass DraculaPink
hi! link cssPseudoClassId DraculaGreenItalic
hi! link cssUnitDecorators DraculaPink
hi! link cssVendor DraculaGreenItalic
hi! link diffFile DraculaGreen
hi! link diffNewFile DraculaRed
hi! link diffAdded DraculaGreen
hi! link diffLine DraculaCyanItalic
hi! link diffRemoved DraculaRed
hi! link htmlTag DraculaFg
hi! link htmlArg DraculaGreenItalic
hi! link htmlTitle DraculaFg
hi! link htmlH1 DraculaPurpleBold
hi! link htmlSpecialChar DraculaPurple
hi! link javaScriptBraces Delimiter
hi! link javaScriptNumber Constant
hi! link javaScriptNull Constant
hi! link javaScriptFunction Keyword
hi! link jsArrowFunction Operator
hi! link jsBuiltins DraculaCyan
hi! link jsClassDefinition DraculaCyan
hi! link jsClassMethodType Keyword
hi! link jsDestructuringAssignment DraculaOrangeItalic
hi! link jsDocParam DraculaOrangeItalic
hi! link jsDocTags Keyword
hi! link jsDocType Type
hi! link jsDocTypeBrackets DraculaCyan
hi! link jsFuncArgOperator Operator
hi! link jsFuncArgs DraculaOrangeItalic
hi! link jsFunction Keyword
hi! link jsNull Constant
hi! link jsObjectColon DraculaPink
hi! link jsSuper DraculaPurpleItalic
hi! link jsTemplateBraces Special
hi! link jsThis DraculaPurpleItalic
hi! link jsUndefined Constant
hi! link jsxTag Keyword
hi! link jsxTagName Keyword
hi! link jsxComponentName Type
hi! link jsxCloseTag Type
hi! link jsxAttrib DraculaGreenItalic
hi! link jsxCloseString Identifier
hi! link jsxOpenPunct Identifier
hi! link jsonKeyword DraculaCyan
hi! link jsonKeywordMatch DraculaPink
hi! link luaFunc DraculaCyan
hi! link luaTable DraculaFg
hi! link luaBraces DraculaFg
hi! link luaBuiltIn Constant
hi! link luaDocTag Keyword
hi! link luaErrHand DraculaCyan
hi! link luaFuncArgName DraculaOrangeItalic
hi! link luaFuncCall Function
hi! link luaLocal Keyword
hi! link luaSpecialTable Constant
hi! link luaSpecialValue DraculaCyan
hi! link markdownBlockquote DraculaCyan
hi! link markdownBold DraculaOrangeBold
hi! link markdownBoldItalic DraculaOrangeBoldItalic
hi! link markdownCodeBlock DraculaGreen
hi! link markdownCode DraculaGreen
hi! link markdownCodeDelimiter DraculaGreen
hi! link markdownH1 DraculaPurpleBold
hi! link markdownH2 markdownH1
hi! link markdownH3 markdownH1
hi! link markdownH4 markdownH1
hi! link markdownH5 markdownH1
hi! link markdownH6 markdownH1
hi! link markdownHeadingDelimiter markdownH1
hi! link markdownHeadingRule markdownH1
hi! link markdownItalic DraculaYellowItalic
hi! link markdownLinkText DraculaPink
hi! link markdownListMarker DraculaCyan
hi! link markdownOrderedListMarker DraculaCyan
hi! link markdownRule DraculaComment
hi! link markdownUrl DraculaLink
hi! link htmlBold DraculaOrangeBold
hi! link htmlBoldItalic DraculaOrangeBoldItalic
hi! link htmlItalic DraculaYellowItalic
hi! link mkdBlockquote DraculaYellowItalic
hi! link mkdBold DraculaOrangeBold
hi! link mkdBoldItalic DraculaOrangeBoldItalic
hi! link mkdCode DraculaGreen
hi! link mkdCodeEnd DraculaGreen
hi! link mkdCodeStart DraculaGreen
hi! link mkdHeading DraculaPurpleBold
hi! link mkdInlineUrl DraculaLink
hi! link mkdItalic DraculaYellowItalic
hi! link mkdLink DraculaPink
hi! link mkdListItem DraculaCyan
hi! link mkdRule DraculaComment
hi! link mkdUrl DraculaLink
hi! link ocamlModule Type
hi! link ocamlModPath Normal
hi! link ocamlLabel DraculaOrangeItalic
hi! link perlMatchStartEnd DraculaRed
hi! link perlOperator DraculaCyan
hi! link perlStatementFiledesc DraculaCyan
hi! link perlStatementFiles DraculaCyan
hi! link perlStatementFlow DraculaCyan
hi! link perlStatementHash DraculaCyan
hi! link perlStatementIOfunc DraculaCyan
hi! link perlStatementIPC DraculaCyan
hi! link perlStatementList DraculaCyan
hi! link perlStatementMisc DraculaCyan
hi! link perlStatementNetwork DraculaCyan
hi! link perlStatementNumeric DraculaCyan
hi! link perlStatementProc DraculaCyan
hi! link perlStatementPword DraculaCyan
hi! link perlStatementRegexp DraculaCyan
hi! link perlStatementScalar DraculaCyan
hi! link perlStatementSocket DraculaCyan
hi! link perlStatementTime DraculaCyan
hi! link perlStatementVector DraculaCyan
hi! link perlSignature DraculaOrangeItalic
hi! link perlSubPrototype DraculaOrangeItalic
hi! link perlVarSimpleMemberName DraculaPurple
hi! link phpClass Type
hi! link phpClasses Type
hi! link phpDocTags DraculaCyanItalic
hi! link phpFunction Function
hi! link phpParent Normal
hi! link phpSpecialFunction DraculaCyan
hi! link plantumlClassPrivate SpecialKey
hi! link plantumlClassProtected DraculaOrange
hi! link plantumlClassPublic Function
hi! link plantumlColonLine String
hi! link plantumlDirectedOrVerticalArrowLR Constant
hi! link plantumlDirectedOrVerticalArrowRL Constant
hi! link plantumlHorizontalArrow Constant
hi! link plantumlSkinParamKeyword DraculaCyan
hi! link plantumlTypeKeyword Keyword
hi! link purescriptModule Type
hi! link purescriptImport DraculaCyan
hi! link purescriptImportAs DraculaCyan
hi! link purescriptOperator Operator
hi! link purescriptBacktick Operator
hi! link pythonBuiltinObj Type
hi! link pythonBuiltinObject Type
hi! link pythonBuiltinType Type
hi! link pythonClassVar DraculaPurpleItalic
hi! link pythonExClass Type
hi! link pythonNone Type
hi! link pythonRun Comment
hi! link rstComment Comment
hi! link rstTransition Comment
hi! link rstCodeBlock DraculaGreen
hi! link rstInlineLiteral DraculaGreen
hi! link rstLiteralBlock DraculaGreen
hi! link rstQuotedLiteralBlock DraculaGreen
hi! link rstStandaloneHyperlink DraculaLink
hi! link rstStrongEmphasis DraculaOrangeBold
hi! link rstSections DraculaPurpleBold
hi! link rstEmphasis DraculaYellowItalic
hi! link rstDirective Keyword
hi! link rstSubstitutionDefinition Keyword
hi! link rstCitation String
hi! link rstExDirective String
hi! link rstFootnote String
hi! link rstCitationReference Tag
hi! link rstFootnoteReference Tag
hi! link rstHyperLinkReference Tag
hi! link rstHyperlinkTarget Tag
hi! link rstInlineInternalTargets Tag
hi! link rstInterpretedTextOrHyperlinkReference Tag
hi! link rstTodo Todo
hi! link rubyBlockArgument DraculaOrangeItalic
hi! link rubyBlockParameter DraculaOrangeItalic
hi! link rubyCurlyBlock DraculaPink
hi! link rubyGlobalVariable DraculaPurple
hi! link rubyInstanceVariable DraculaPurpleItalic
hi! link rubyInterpolationDelimiter DraculaPink
hi! link rubyRegexpDelimiter DraculaRed
hi! link rubyStringDelimiter DraculaYellow
hi! link rustCommentLineDoc Comment
hi! link sassClass cssClassName
hi! link sassClassChar cssClassNameDot
hi! link sassId cssIdentifier
hi! link sassIdChar cssIdentifier
hi! link sassInterpolationDelimiter DraculaPink
hi! link sassMixinName Function
hi! link sassProperty cssProp
hi! link sassVariableAssignment Operator
hi shCommandSub guifg=NONE guibg=NONE guisp=NONE gui=NONE ctermfg=NONE ctermbg=NONE cterm=NONE
hi! link shEscape DraculaRed
hi shParen guifg=NONE guibg=NONE guisp=NONE gui=NONE ctermfg=NONE ctermbg=NONE cterm=NONE
hi shParenError guifg=NONE guibg=NONE guisp=NONE gui=NONE ctermfg=NONE ctermbg=NONE cterm=NONE
hi! link texBeginEndName DraculaOrangeItalic
hi! link texBoldItalStyle DraculaOrangeBoldItalic
hi! link texBoldStyle DraculaOrangeBold
hi! link texInputFile DraculaOrangeItalic
hi! link texItalStyle DraculaYellowItalic
hi! link texLigature DraculaPurple
hi! link texMath DraculaPurple
hi! link texMathMatcher DraculaPurple
hi! link texMathSymbol DraculaPurple
hi! link texSpecialChar DraculaPurple
hi! link texSubscripts DraculaPurple
hi! link texTitle DraculaFgBold
hi! link typescriptAliasDeclaration Type
hi! link typescriptArrayMethod Function
hi! link typescriptArrowFunc Operator
hi! link typescriptArrowFuncArg DraculaOrangeItalic
hi! link typescriptAssign Operator
hi! link typescriptBOMWindowProp Constant
hi! link typescriptBinaryOp Operator
hi! link typescriptBraces Delimiter
hi! link typescriptCall typescriptArrowFuncArg
hi! link typescriptClassHeritage Type
hi! link typescriptClassName Type
hi! link typescriptDateMethod DraculaCyan
hi! link typescriptDateStaticMethod Function
hi! link typescriptDecorator DraculaGreenItalic
hi! link typescriptDefaultParam Operator
hi! link typescriptES6SetMethod DraculaCyan
hi! link typescriptEndColons Delimiter
hi! link typescriptEnum Type
hi! link typescriptEnumKeyword Keyword
hi! link typescriptFuncComma Delimiter
hi! link typescriptFuncKeyword Keyword
hi! link typescriptFuncType DraculaOrangeItalic
hi! link typescriptFuncTypeArrow Operator
hi! link typescriptGlobal Type
hi! link typescriptGlobalMethod DraculaCyan
hi! link typescriptGlobalObjects Type
hi! link typescriptIdentifier DraculaPurpleItalic
hi! link typescriptInterfaceHeritage Type
hi! link typescriptInterfaceName Type
hi! link typescriptInterpolationDelimiter Keyword
hi! link typescriptKeywordOp Keyword
hi! link typescriptLogicSymbols Operator
hi! link typescriptMember Identifier
hi! link typescriptMemberOptionality Special
hi! link typescriptObjectColon Special
hi! link typescriptObjectLabel Identifier
hi! link typescriptObjectSpread Operator
hi! link typescriptOperator Operator
hi! link typescriptParamImpl DraculaOrangeItalic
hi! link typescriptParens Delimiter
hi! link typescriptPredefinedType Type
hi! link typescriptRestOrSpread Operator
hi! link typescriptTernaryOp Operator
hi! link typescriptTypeAnnotation Special
hi! link typescriptTypeCast Operator
hi! link typescriptTypeParameter DraculaOrangeItalic
hi! link typescriptTypeReference Type
hi! link typescriptUnaryOp Operator
hi! link typescriptVariable Keyword
hi! link tsxAttrib DraculaGreenItalic
hi! link tsxEqual Operator
hi! link tsxIntrinsicTagName Keyword
hi! link tsxTagName Type
hi! link vimAutoCmdSfxList Type
hi! link vimAutoEventList Type
hi! link vimEnvVar Constant
hi! link vimFunction Function
hi! link vimHiBang Keyword
hi! link vimOption Type
hi! link vimSetMod Keyword
hi! link vimSetSep Delimiter
hi! link vimUserAttrbCmpltFunc Function
hi! link vimUserFunc Function
hi! link xmlAttrib DraculaGreenItalic
hi! link xmlEqual Operator
hi! link xmlTag Delimiter
hi! link xmlTagName Statement
hi! link yamlAlias DraculaGreenItalicUnderline
hi! link yamlAnchor DraculaPinkItalic
hi! link yamlBlockMappingKey DraculaCyan
hi! link yamlFlowCollection DraculaPink
hi! link yamlFlowIndicator Delimiter
hi! link yamlNodeTag DraculaPink
hi! link yamlPlainScalar DraculaYellow
hi! link ALEError DraculaErrorLine
hi! link ALEWarning DraculaWarnLine
hi! link ALEInfo DraculaInfoLine
hi! link ALEErrorSign DraculaRed
hi! link ALEWarningSign DraculaOrange
hi! link ALEInfoSign DraculaCyan
hi! link ALEVirtualTextError Comment
hi! link ALEVirtualTextWarning Comment
hi! link CtrlPMatch IncSearch
hi! link CtrlPBufferHid Normal
hi! link GitGutterAdd DiffAdd
hi! link GitGutterChange DiffChange
hi! link GitGutterDelete DiffDelete

# SupraVim
hi Cursor guifg=#1B1C25 guibg=#FFB86C guisp=NONE gui=NONE ctermfg=234 ctermbg=215 cterm=NONE
hi Terminal guifg=#F2F2EC guibg=#1B1C25 guisp=NONE gui=NONE ctermfg=255 ctermbg=234 cterm=NONE
hi! link Variable DraculaFg
hi! link WinSeparator DraculaWinSeparator
