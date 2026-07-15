vim9script
# supra-gui: background=#242628 include=#68aee8 stdio=#99bc80 typedef=#dfbe81 struct=#dfbe81 type_s=#b1b4b9 scope=#ccced2 float=#dfbe81 function=#b1b4b9 format=#c99a6e text=#99bc80 integer=#c99a6e

hi clear

if exists("syntax_on")
  syntax reset
endif

set t_Co=256

g:colors_name = "suprawarm"

if !exists("g:suprawarm_termcolors")
	g:suprawarm_termcolors = 256
endif

if !exists("g:suprawarm_terminal_italics")
	g:suprawarm_terminal_italics = 0
endif

hi Comment guifg=#646568 guibg=NONE guisp=NONE gui=NONE ctermfg=59 ctermbg=NONE cterm=NONE
hi Constant guifg=#5fafb9 guibg=NONE guisp=NONE gui=NONE ctermfg=38 ctermbg=NONE cterm=NONE
hi String guifg=#99bc80 guibg=NONE guisp=NONE gui=NONE ctermfg=114 ctermbg=NONE cterm=NONE
hi Character guifg=#99bc80 guibg=NONE guisp=NONE gui=NONE ctermfg=114 ctermbg=NONE cterm=NONE
hi Number guifg=#c99a6e guibg=NONE guisp=NONE gui=NONE ctermfg=173 ctermbg=NONE cterm=NONE
hi Boolean guifg=#c99a6e guibg=NONE guisp=NONE gui=NONE ctermfg=173 ctermbg=NONE cterm=NONE
hi Float guifg=#c99a6e guibg=NONE guisp=NONE gui=NONE ctermfg=173 ctermbg=NONE cterm=NONE
hi Identifier guifg=#e16d77 guibg=NONE guisp=NONE gui=NONE ctermfg=204 ctermbg=NONE cterm=NONE
hi Function guifg=#68aee8 guibg=NONE guisp=NONE gui=NONE ctermfg=39 ctermbg=NONE cterm=NONE
hi Statement guifg=#c27fd7 guibg=NONE guisp=NONE gui=NONE ctermfg=170 ctermbg=NONE cterm=NONE
hi Conditional guifg=#c27fd7 guibg=NONE guisp=NONE gui=NONE ctermfg=170 ctermbg=NONE cterm=NONE
hi Repeat guifg=#c27fd7 guibg=NONE guisp=NONE gui=NONE ctermfg=170 ctermbg=NONE cterm=NONE
hi Label guifg=#c27fd7 guibg=NONE guisp=NONE gui=NONE ctermfg=170 ctermbg=NONE cterm=NONE
hi Operator guifg=#c27fd7 guibg=NONE guisp=NONE gui=NONE ctermfg=170 ctermbg=NONE cterm=NONE
hi Keyword guifg=#c27fd7 guibg=NONE guisp=NONE gui=NONE ctermfg=170 ctermbg=NONE cterm=NONE
hi Exception guifg=#c27fd7 guibg=NONE guisp=NONE gui=NONE ctermfg=170 ctermbg=NONE cterm=NONE
hi PreProc guifg=#dfbe81 guibg=NONE guisp=NONE gui=NONE ctermfg=180 ctermbg=NONE cterm=NONE
hi Include guifg=#68aee8 guibg=NONE guisp=NONE gui=NONE ctermfg=39 ctermbg=NONE cterm=NONE
hi Define guifg=#c27fd7 guibg=NONE guisp=NONE gui=NONE ctermfg=170 ctermbg=NONE cterm=NONE
hi Macro guifg=#c27fd7 guibg=NONE guisp=NONE gui=NONE ctermfg=170 ctermbg=NONE cterm=NONE
hi PreCondit guifg=#dfbe81 guibg=NONE guisp=NONE gui=NONE ctermfg=180 ctermbg=NONE cterm=NONE
hi Type guifg=#dfbe81 guibg=NONE guisp=NONE gui=NONE ctermfg=180 ctermbg=NONE cterm=NONE
hi StorageClass guifg=#dfbe81 guibg=NONE guisp=NONE gui=NONE ctermfg=180 ctermbg=NONE cterm=NONE
hi Structure guifg=#dfbe81 guibg=NONE guisp=NONE gui=NONE ctermfg=180 ctermbg=NONE cterm=NONE
hi Typedef guifg=#dfbe81 guibg=NONE guisp=NONE gui=NONE ctermfg=180 ctermbg=NONE cterm=NONE
hi Special guifg=#68aee8 guibg=NONE guisp=NONE gui=NONE ctermfg=39 ctermbg=NONE cterm=NONE
hi SpecialChar guifg=#c99a6e guibg=NONE guisp=NONE gui=NONE ctermfg=173 ctermbg=NONE cterm=NONE
hi Tag guifg=NONE guibg=NONE guisp=NONE gui=NONE ctermfg=NONE ctermbg=NONE cterm=NONE
hi Delimiter guifg=NONE guibg=NONE guisp=NONE gui=NONE ctermfg=NONE ctermbg=NONE cterm=NONE
hi SpecialComment guifg=#646568 guibg=NONE guisp=NONE gui=NONE ctermfg=59 ctermbg=NONE cterm=NONE
hi Debug guifg=NONE guibg=NONE guisp=NONE gui=NONE ctermfg=NONE ctermbg=NONE cterm=NONE
hi Underlined guifg=NONE guibg=NONE guisp=NONE gui=NONE ctermfg=NONE ctermbg=NONE cterm=NONE
hi Ignore guifg=NONE guibg=NONE guisp=NONE gui=NONE ctermfg=NONE ctermbg=NONE cterm=NONE
hi Error guifg=#e16d77 guibg=NONE guisp=NONE gui=NONE ctermfg=204 ctermbg=NONE cterm=NONE
hi Todo guifg=#c27fd7 guibg=NONE guisp=NONE gui=NONE ctermfg=170 ctermbg=NONE cterm=NONE
hi ColorColumn guifg=NONE guibg=#35373b guisp=NONE gui=NONE ctermfg=NONE ctermbg=236 cterm=NONE
hi Conceal guifg=NONE guibg=NONE guisp=NONE gui=NONE ctermfg=NONE ctermbg=NONE cterm=NONE
hi Cursor guifg=#2c2d30 guibg=#68aee8 guisp=NONE gui=NONE ctermfg=235 ctermbg=39 cterm=NONE
hi CursorIM guifg=NONE guibg=NONE guisp=NONE gui=NONE ctermfg=NONE ctermbg=NONE cterm=NONE
hi CursorColumn guifg=NONE guibg=#35373b guisp=NONE gui=NONE ctermfg=NONE ctermbg=236 cterm=NONE
hi CursorLine guifg=NONE guibg=#35373b guisp=NONE gui=NONE ctermfg=NONE ctermbg=236 cterm=NONE
hi Directory guifg=#68aee8 guibg=NONE guisp=NONE gui=NONE ctermfg=39 ctermbg=NONE cterm=NONE
hi DiffAdd guifg=#2c2d30 guibg=#99bc80 guisp=NONE gui=NONE ctermfg=235 ctermbg=114 cterm=NONE
hi DiffChange guifg=#dfbe81 guibg=NONE guisp=NONE gui=NONE ctermfg=180 ctermbg=NONE cterm=NONE
hi DiffDelete guifg=#2c2d30 guibg=#e16d77 guisp=NONE gui=NONE ctermfg=235 ctermbg=204 cterm=NONE
hi DiffText guifg=#2c2d30 guibg=#dfbe81 guisp=NONE gui=NONE ctermfg=235 ctermbg=180 cterm=NONE
hi ErrorMsg guifg=#e16d77 guibg=NONE guisp=NONE gui=NONE ctermfg=204 ctermbg=NONE cterm=NONE
hi VertSplit guifg=#404247 guibg=NONE guisp=NONE gui=NONE ctermfg=59 ctermbg=NONE cterm=NONE
hi Folded guifg=#646568 guibg=NONE guisp=NONE gui=NONE ctermfg=59 ctermbg=NONE cterm=NONE
hi FoldColumn guifg=NONE guibg=NONE guisp=NONE gui=NONE ctermfg=NONE ctermbg=NONE cterm=NONE
hi SignColumn guifg=NONE guibg=NONE guisp=NONE gui=NONE ctermfg=NONE ctermbg=NONE cterm=NONE
hi IncSearch guifg=#dfbe81 guibg=#646568 guisp=NONE gui=NONE ctermfg=180 ctermbg=59 cterm=NONE
hi LineNr guifg=#595a5e guibg=NONE guisp=NONE gui=NONE ctermfg=238 ctermbg=NONE cterm=NONE
hi CursorLineNr guifg=#c99a6e guibg=NONE guisp=NONE gui=NONE ctermfg=NONE ctermbg=NONE cterm=NONE
hi MatchParen guifg=#68aee8 guibg=NONE guisp=NONE gui=NONE ctermfg=39 ctermbg=NONE cterm=NONE
hi ModeMsg guifg=NONE guibg=NONE guisp=NONE gui=NONE ctermfg=NONE ctermbg=NONE cterm=NONE
hi MoreMsg guifg=NONE guibg=NONE guisp=NONE gui=NONE ctermfg=NONE ctermbg=NONE cterm=NONE
hi NonText guifg=#3e4045 guibg=NONE guisp=NONE gui=NONE ctermfg=238 ctermbg=NONE cterm=NONE
hi Normal guifg=#b1b4b9 guibg=#2c2d30 guisp=NONE gui=NONE ctermfg=145 ctermbg=235 cterm=NONE
hi Pmenu guifg=#b1b4b9 guibg=#404247 guisp=NONE gui=NONE ctermfg=145 ctermbg=237 cterm=NONE
hi PmenuSel guifg=#35373b guibg=#68aee8 guisp=NONE gui=NONE ctermfg=236 ctermbg=39 cterm=NONE
hi PmenuSbar guifg=NONE guibg=#35373b guisp=NONE gui=NONE ctermfg=NONE ctermbg=236 cterm=NONE
hi PmenuThumb guifg=NONE guibg=#b1b4b9 guisp=NONE gui=NONE ctermfg=NONE ctermbg=145 cterm=NONE
hi Question guifg=#c27fd7 guibg=NONE guisp=NONE gui=NONE ctermfg=170 ctermbg=NONE cterm=NONE
hi QuickFixLine guifg=#2c2d30 guibg=#dfbe81 guisp=NONE gui=NONE ctermfg=235 ctermbg=180 cterm=NONE
hi Search guifg=#2c2d30 guibg=#dfbe81 guisp=NONE gui=NONE ctermfg=235 ctermbg=180 cterm=NONE
hi SpecialKey guifg=#3e4045 guibg=NONE guisp=NONE gui=NONE ctermfg=238 ctermbg=NONE cterm=NONE
hi SpellBad guifg=#e16d77 guibg=NONE guisp=NONE gui=NONE ctermfg=204 ctermbg=NONE cterm=NONE
hi SpellCap guifg=#c99a6e guibg=NONE guisp=NONE gui=NONE ctermfg=173 ctermbg=NONE cterm=NONE
hi SpellLocal guifg=#c99a6e guibg=NONE guisp=NONE gui=NONE ctermfg=173 ctermbg=NONE cterm=NONE
hi SpellRare guifg=#c99a6e guibg=NONE guisp=NONE gui=NONE ctermfg=173 ctermbg=NONE cterm=NONE
hi StatusLine guifg=#b1b4b9 guibg=#35373b guisp=NONE gui=NONE ctermfg=145 ctermbg=236 cterm=NONE
hi StatusLineNC guifg=#646568 guibg=NONE guisp=NONE gui=NONE ctermfg=59 ctermbg=NONE cterm=NONE
hi StatusLineTerm guifg=#b1b4b9 guibg=#35373b guisp=NONE gui=NONE ctermfg=145 ctermbg=236 cterm=NONE
hi StatusLineTermNC guifg=#646568 guibg=NONE guisp=NONE gui=NONE ctermfg=59 ctermbg=NONE cterm=NONE
hi TabLine guifg=#646568 guibg=NONE guisp=NONE gui=NONE ctermfg=59 ctermbg=NONE cterm=NONE
hi TabLineFill guifg=NONE guibg=NONE guisp=NONE gui=NONE ctermfg=NONE ctermbg=NONE cterm=NONE
hi TabLineSel guifg=#b1b4b9 guibg=NONE guisp=NONE gui=NONE ctermfg=145 ctermbg=NONE cterm=NONE
hi Terminal guifg=#b1b4b9 guibg=#2c2d30 guisp=NONE gui=NONE ctermfg=145 ctermbg=235 cterm=NONE
hi Title guifg=#99bc80 guibg=NONE guisp=NONE gui=NONE ctermfg=114 ctermbg=NONE cterm=NONE
hi Visual guifg=NONE guibg=#404247 guisp=NONE gui=NONE ctermfg=NONE ctermbg=237 cterm=NONE
hi VisualNOS guifg=NONE guibg=#404247 guisp=NONE gui=NONE ctermfg=NONE ctermbg=237 cterm=NONE
hi WarningMsg guifg=#dfbe81 guibg=NONE guisp=NONE gui=NONE ctermfg=180 ctermbg=NONE cterm=NONE
hi WildMenu guifg=#2c2d30 guibg=#68aee8 guisp=NONE gui=NONE ctermfg=235 ctermbg=39 cterm=NONE

hi PMenuMatch guifg=#dfbe81 guibg=NONE guisp=NONE gui=NONE ctermfg=180 ctermbg=237 cterm=NONE
hi PMenuKind guifg=#c27fd7 guibg=NONE guisp=NONE cterm=NONE gui=NONE ctermfg=38

hi debugPC guifg=NONE guibg=#3e4045 guisp=NONE gui=NONE ctermfg=NONE ctermbg=238 cterm=NONE
hi debugBreakpoint guifg=#2c2d30 guibg=#e16d77 guisp=NONE gui=NONE ctermfg=235 ctermbg=204 cterm=NONE
hi cssAttrComma guifg=#c27fd7 guibg=NONE guisp=NONE gui=NONE ctermfg=170 ctermbg=NONE cterm=NONE
hi cssAttributeSelector guifg=#99bc80 guibg=NONE guisp=NONE gui=NONE ctermfg=114 ctermbg=NONE cterm=NONE
hi cssBraces guifg=#b1b4b9 guibg=NONE guisp=NONE gui=NONE ctermfg=145 ctermbg=NONE cterm=NONE
hi cssClassName guifg=#c99a6e guibg=NONE guisp=NONE gui=NONE ctermfg=173 ctermbg=NONE cterm=NONE
hi cssClassNameDot guifg=#c99a6e guibg=NONE guisp=NONE gui=NONE ctermfg=173 ctermbg=NONE cterm=NONE
hi cssDefinition guifg=#c27fd7 guibg=NONE guisp=NONE gui=NONE ctermfg=170 ctermbg=NONE cterm=NONE
hi cssFontAttr guifg=#c99a6e guibg=NONE guisp=NONE gui=NONE ctermfg=173 ctermbg=NONE cterm=NONE
hi cssFontDescriptor guifg=#c27fd7 guibg=NONE guisp=NONE gui=NONE ctermfg=170 ctermbg=NONE cterm=NONE
hi cssFunctionName guifg=#68aee8 guibg=NONE guisp=NONE gui=NONE ctermfg=39 ctermbg=NONE cterm=NONE
hi cssIdentifier guifg=#68aee8 guibg=NONE guisp=NONE gui=NONE ctermfg=39 ctermbg=NONE cterm=NONE
hi cssImportant guifg=#c27fd7 guibg=NONE guisp=NONE gui=NONE ctermfg=170 ctermbg=NONE cterm=NONE
hi cssInclude guifg=#b1b4b9 guibg=NONE guisp=NONE gui=NONE ctermfg=145 ctermbg=NONE cterm=NONE
hi cssIncludeKeyword guifg=#c27fd7 guibg=NONE guisp=NONE gui=NONE ctermfg=170 ctermbg=NONE cterm=NONE
hi cssMediaType guifg=#c99a6e guibg=NONE guisp=NONE gui=NONE ctermfg=173 ctermbg=NONE cterm=NONE
hi cssProp guifg=#b1b4b9 guibg=NONE guisp=NONE gui=NONE ctermfg=145 ctermbg=NONE cterm=NONE
hi cssPseudoClassId guifg=#c99a6e guibg=NONE guisp=NONE gui=NONE ctermfg=173 ctermbg=NONE cterm=NONE
hi cssSelectorOp guifg=#c27fd7 guibg=NONE guisp=NONE gui=NONE ctermfg=170 ctermbg=NONE cterm=NONE
hi cssSelectorOp2 guifg=#c27fd7 guibg=NONE guisp=NONE gui=NONE ctermfg=170 ctermbg=NONE cterm=NONE
hi cssTagName guifg=#e16d77 guibg=NONE guisp=NONE gui=NONE ctermfg=204 ctermbg=NONE cterm=NONE
hi fishKeyword guifg=#c27fd7 guibg=NONE guisp=NONE gui=NONE ctermfg=170 ctermbg=NONE cterm=NONE
hi fishConditional guifg=#c27fd7 guibg=NONE guisp=NONE gui=NONE ctermfg=170 ctermbg=NONE cterm=NONE
hi goDeclaration guifg=#c27fd7 guibg=NONE guisp=NONE gui=NONE ctermfg=170 ctermbg=NONE cterm=NONE
hi goBuiltins guifg=#5fafb9 guibg=NONE guisp=NONE gui=NONE ctermfg=38 ctermbg=NONE cterm=NONE
hi goFunctionCall guifg=#68aee8 guibg=NONE guisp=NONE gui=NONE ctermfg=39 ctermbg=NONE cterm=NONE
hi goVarDefs guifg=#e16d77 guibg=NONE guisp=NONE gui=NONE ctermfg=204 ctermbg=NONE cterm=NONE
hi goVarAssign guifg=#e16d77 guibg=NONE guisp=NONE gui=NONE ctermfg=204 ctermbg=NONE cterm=NONE
hi goVar guifg=#c27fd7 guibg=NONE guisp=NONE gui=NONE ctermfg=170 ctermbg=NONE cterm=NONE
hi goConst guifg=#c27fd7 guibg=NONE guisp=NONE gui=NONE ctermfg=170 ctermbg=NONE cterm=NONE
hi goType guifg=#dfbe81 guibg=NONE guisp=NONE gui=NONE ctermfg=180 ctermbg=NONE cterm=NONE
hi goTypeName guifg=#dfbe81 guibg=NONE guisp=NONE gui=NONE ctermfg=180 ctermbg=NONE cterm=NONE
hi goDeclType guifg=#5fafb9 guibg=NONE guisp=NONE gui=NONE ctermfg=38 ctermbg=NONE cterm=NONE
hi goTypeDecl guifg=#c27fd7 guibg=NONE guisp=NONE gui=NONE ctermfg=170 ctermbg=NONE cterm=NONE
hi htmlArg guifg=#c99a6e guibg=NONE guisp=NONE gui=NONE ctermfg=173 ctermbg=NONE cterm=NONE
hi htmlBold guifg=#c99a6e guibg=NONE guisp=NONE gui=NONE ctermfg=173 ctermbg=NONE cterm=NONE
hi htmlBoldItalic guifg=#99bc80 guibg=NONE guisp=NONE gui=NONE ctermfg=114 ctermbg=NONE cterm=NONE
hi htmlEndTag guifg=#b1b4b9 guibg=NONE guisp=NONE gui=NONE ctermfg=145 ctermbg=NONE cterm=NONE
hi htmlH1 guifg=#e16d77 guibg=NONE guisp=NONE gui=NONE ctermfg=204 ctermbg=NONE cterm=NONE
hi htmlH2 guifg=#e16d77 guibg=NONE guisp=NONE gui=NONE ctermfg=204 ctermbg=NONE cterm=NONE
hi htmlH3 guifg=#e16d77 guibg=NONE guisp=NONE gui=NONE ctermfg=204 ctermbg=NONE cterm=NONE
hi htmlH4 guifg=#e16d77 guibg=NONE guisp=NONE gui=NONE ctermfg=204 ctermbg=NONE cterm=NONE
hi htmlH5 guifg=#e16d77 guibg=NONE guisp=NONE gui=NONE ctermfg=204 ctermbg=NONE cterm=NONE
hi htmlH6 guifg=#e16d77 guibg=NONE guisp=NONE gui=NONE ctermfg=204 ctermbg=NONE cterm=NONE
hi htmlItalic guifg=#c27fd7 guibg=NONE guisp=NONE gui=NONE ctermfg=170 ctermbg=NONE cterm=NONE
hi htmlLink guifg=#5fafb9 guibg=NONE guisp=NONE gui=NONE ctermfg=38 ctermbg=NONE cterm=NONE
hi htmlSpecialChar guifg=#c99a6e guibg=NONE guisp=NONE gui=NONE ctermfg=173 ctermbg=NONE cterm=NONE
hi htmlSpecialTagName guifg=#e16d77 guibg=NONE guisp=NONE gui=NONE ctermfg=204 ctermbg=NONE cterm=NONE
hi htmlTag guifg=#b1b4b9 guibg=NONE guisp=NONE gui=NONE ctermfg=145 ctermbg=NONE cterm=NONE
hi htmlTagN guifg=#e16d77 guibg=NONE guisp=NONE gui=NONE ctermfg=204 ctermbg=NONE cterm=NONE
hi htmlTagName guifg=#e16d77 guibg=NONE guisp=NONE gui=NONE ctermfg=204 ctermbg=NONE cterm=NONE
hi htmlTitle guifg=#b1b4b9 guibg=NONE guisp=NONE gui=NONE ctermfg=145 ctermbg=NONE cterm=NONE
hi javaScriptBraces guifg=#b1b4b9 guibg=NONE guisp=NONE gui=NONE ctermfg=145 ctermbg=NONE cterm=NONE
hi javaScriptFunction guifg=#c27fd7 guibg=NONE guisp=NONE gui=NONE ctermfg=170 ctermbg=NONE cterm=NONE
hi javaScriptIdentifier guifg=#c27fd7 guibg=NONE guisp=NONE gui=NONE ctermfg=170 ctermbg=NONE cterm=NONE
hi javaScriptNull guifg=#c99a6e guibg=NONE guisp=NONE gui=NONE ctermfg=173 ctermbg=NONE cterm=NONE
hi javaScriptNumber guifg=#c99a6e guibg=NONE guisp=NONE gui=NONE ctermfg=173 ctermbg=NONE cterm=NONE
hi javaScriptRequire guifg=#5fafb9 guibg=NONE guisp=NONE gui=NONE ctermfg=38 ctermbg=NONE cterm=NONE
hi javaScriptReserved guifg=#c27fd7 guibg=NONE guisp=NONE gui=NONE ctermfg=170 ctermbg=NONE cterm=NONE
hi jsArrowFunction guifg=#c27fd7 guibg=NONE guisp=NONE gui=NONE ctermfg=170 ctermbg=NONE cterm=NONE
hi jsClassKeyword guifg=#c27fd7 guibg=NONE guisp=NONE gui=NONE ctermfg=170 ctermbg=NONE cterm=NONE
hi jsClassMethodType guifg=#c27fd7 guibg=NONE guisp=NONE gui=NONE ctermfg=170 ctermbg=NONE cterm=NONE
hi jsDocParam guifg=#68aee8 guibg=NONE guisp=NONE gui=NONE ctermfg=39 ctermbg=NONE cterm=NONE
hi jsDocTags guifg=#c27fd7 guibg=NONE guisp=NONE gui=NONE ctermfg=170 ctermbg=NONE cterm=NONE
hi jsExport guifg=#c27fd7 guibg=NONE guisp=NONE gui=NONE ctermfg=170 ctermbg=NONE cterm=NONE
hi jsExportDefault guifg=#c27fd7 guibg=NONE guisp=NONE gui=NONE ctermfg=170 ctermbg=NONE cterm=NONE
hi jsExtendsKeyword guifg=#c27fd7 guibg=NONE guisp=NONE gui=NONE ctermfg=170 ctermbg=NONE cterm=NONE
hi jsFrom guifg=#c27fd7 guibg=NONE guisp=NONE gui=NONE ctermfg=170 ctermbg=NONE cterm=NONE
hi jsFuncCall guifg=#68aee8 guibg=NONE guisp=NONE gui=NONE ctermfg=39 ctermbg=NONE cterm=NONE
hi jsFunction guifg=#c27fd7 guibg=NONE guisp=NONE gui=NONE ctermfg=170 ctermbg=NONE cterm=NONE
hi jsGenerator guifg=#dfbe81 guibg=NONE guisp=NONE gui=NONE ctermfg=180 ctermbg=NONE cterm=NONE
hi jsGlobalObjects guifg=#dfbe81 guibg=NONE guisp=NONE gui=NONE ctermfg=180 ctermbg=NONE cterm=NONE
hi jsImport guifg=#c27fd7 guibg=NONE guisp=NONE gui=NONE ctermfg=170 ctermbg=NONE cterm=NONE
hi jsModuleAs guifg=#c27fd7 guibg=NONE guisp=NONE gui=NONE ctermfg=170 ctermbg=NONE cterm=NONE
hi jsModuleWords guifg=#c27fd7 guibg=NONE guisp=NONE gui=NONE ctermfg=170 ctermbg=NONE cterm=NONE
hi jsModules guifg=#c27fd7 guibg=NONE guisp=NONE gui=NONE ctermfg=170 ctermbg=NONE cterm=NONE
hi jsNull guifg=#c99a6e guibg=NONE guisp=NONE gui=NONE ctermfg=173 ctermbg=NONE cterm=NONE
hi jsOperator guifg=#c27fd7 guibg=NONE guisp=NONE gui=NONE ctermfg=170 ctermbg=NONE cterm=NONE
hi jsStorageClass guifg=#c27fd7 guibg=NONE guisp=NONE gui=NONE ctermfg=170 ctermbg=NONE cterm=NONE
hi jsSuper guifg=#e16d77 guibg=NONE guisp=NONE gui=NONE ctermfg=204 ctermbg=NONE cterm=NONE
hi jsTemplateBraces guifg=#914141 guibg=NONE guisp=NONE gui=NONE ctermfg=196 ctermbg=NONE cterm=NONE
hi jsTemplateVar guifg=#99bc80 guibg=NONE guisp=NONE gui=NONE ctermfg=114 ctermbg=NONE cterm=NONE
hi jsThis guifg=#e16d77 guibg=NONE guisp=NONE gui=NONE ctermfg=204 ctermbg=NONE cterm=NONE
hi jsUndefined guifg=#c99a6e guibg=NONE guisp=NONE gui=NONE ctermfg=173 ctermbg=NONE cterm=NONE
hi javascriptArrowFunc guifg=#c27fd7 guibg=NONE guisp=NONE gui=NONE ctermfg=170 ctermbg=NONE cterm=NONE
hi javascriptClassExtends guifg=#c27fd7 guibg=NONE guisp=NONE gui=NONE ctermfg=170 ctermbg=NONE cterm=NONE
hi javascriptClassKeyword guifg=#c27fd7 guibg=NONE guisp=NONE gui=NONE ctermfg=170 ctermbg=NONE cterm=NONE
hi javascriptDocNotation guifg=#c27fd7 guibg=NONE guisp=NONE gui=NONE ctermfg=170 ctermbg=NONE cterm=NONE
hi javascriptDocParamName guifg=#68aee8 guibg=NONE guisp=NONE gui=NONE ctermfg=39 ctermbg=NONE cterm=NONE
hi javascriptDocTags guifg=#c27fd7 guibg=NONE guisp=NONE gui=NONE ctermfg=170 ctermbg=NONE cterm=NONE
hi javascriptEndColons guifg=#b1b4b9 guibg=NONE guisp=NONE gui=NONE ctermfg=145 ctermbg=NONE cterm=NONE
hi javascriptExport guifg=#c27fd7 guibg=NONE guisp=NONE gui=NONE ctermfg=170 ctermbg=NONE cterm=NONE
hi javascriptFuncArg guifg=#b1b4b9 guibg=NONE guisp=NONE gui=NONE ctermfg=145 ctermbg=NONE cterm=NONE
hi javascriptFuncKeyword guifg=#c27fd7 guibg=NONE guisp=NONE gui=NONE ctermfg=170 ctermbg=NONE cterm=NONE
hi javascriptIdentifier guifg=#e16d77 guibg=NONE guisp=NONE gui=NONE ctermfg=204 ctermbg=NONE cterm=NONE
hi javascriptImport guifg=#c27fd7 guibg=NONE guisp=NONE gui=NONE ctermfg=170 ctermbg=NONE cterm=NONE
hi javascriptMethodName guifg=#b1b4b9 guibg=NONE guisp=NONE gui=NONE ctermfg=145 ctermbg=NONE cterm=NONE
hi javascriptObjectLabel guifg=#b1b4b9 guibg=NONE guisp=NONE gui=NONE ctermfg=145 ctermbg=NONE cterm=NONE
hi javascriptOpSymbol guifg=#5fafb9 guibg=NONE guisp=NONE gui=NONE ctermfg=38 ctermbg=NONE cterm=NONE
hi javascriptOpSymbols guifg=#5fafb9 guibg=NONE guisp=NONE gui=NONE ctermfg=38 ctermbg=NONE cterm=NONE
hi javascriptPropertyName guifg=#99bc80 guibg=NONE guisp=NONE gui=NONE ctermfg=114 ctermbg=NONE cterm=NONE
hi javascriptTemplateSB guifg=#914141 guibg=NONE guisp=NONE gui=NONE ctermfg=196 ctermbg=NONE cterm=NONE
hi javascriptVariable guifg=#c27fd7 guibg=NONE guisp=NONE gui=NONE ctermfg=170 ctermbg=NONE cterm=NONE
hi jsonCommentError guifg=#b1b4b9 guibg=NONE guisp=NONE gui=NONE ctermfg=145 ctermbg=NONE cterm=NONE
hi jsonKeyword guifg=#e16d77 guibg=NONE guisp=NONE gui=NONE ctermfg=204 ctermbg=NONE cterm=NONE
hi jsonBoolean guifg=#c99a6e guibg=NONE guisp=NONE gui=NONE ctermfg=173 ctermbg=NONE cterm=NONE
hi jsonNumber guifg=#c99a6e guibg=NONE guisp=NONE gui=NONE ctermfg=173 ctermbg=NONE cterm=NONE
hi jsonQuote guifg=#b1b4b9 guibg=NONE guisp=NONE gui=NONE ctermfg=145 ctermbg=NONE cterm=NONE
hi jsonMissingCommaError guifg=#e16d77 guibg=NONE guisp=NONE gui=NONE ctermfg=204 ctermbg=NONE cterm=NONE
hi jsonNoQuotesError guifg=#e16d77 guibg=NONE guisp=NONE gui=NONE ctermfg=204 ctermbg=NONE cterm=NONE
hi jsonNumError guifg=#e16d77 guibg=NONE guisp=NONE gui=NONE ctermfg=204 ctermbg=NONE cterm=NONE
hi jsonString guifg=#99bc80 guibg=NONE guisp=NONE gui=NONE ctermfg=114 ctermbg=NONE cterm=NONE
hi jsonStringSQError guifg=#e16d77 guibg=NONE guisp=NONE gui=NONE ctermfg=204 ctermbg=NONE cterm=NONE
hi jsonSemicolonError guifg=#e16d77 guibg=NONE guisp=NONE gui=NONE ctermfg=204 ctermbg=NONE cterm=NONE
hi lessVariable guifg=#c27fd7 guibg=NONE guisp=NONE gui=NONE ctermfg=170 ctermbg=NONE cterm=NONE
hi lessAmpersandChar guifg=#b1b4b9 guibg=NONE guisp=NONE gui=NONE ctermfg=145 ctermbg=NONE cterm=NONE
hi lessClass guifg=#c99a6e guibg=NONE guisp=NONE gui=NONE ctermfg=173 ctermbg=NONE cterm=NONE
hi markdownBlockquote guifg=#646568 guibg=NONE guisp=NONE gui=NONE ctermfg=59 ctermbg=NONE cterm=NONE
hi markdownBold guifg=#c99a6e guibg=NONE guisp=NONE gui=NONE ctermfg=173 ctermbg=NONE cterm=NONE
hi markdownBoldItalic guifg=#99bc80 guibg=NONE guisp=NONE gui=NONE ctermfg=114 ctermbg=NONE cterm=NONE
hi markdownCode guifg=#99bc80 guibg=NONE guisp=NONE gui=NONE ctermfg=114 ctermbg=NONE cterm=NONE
hi markdownCodeBlock guifg=#99bc80 guibg=NONE guisp=NONE gui=NONE ctermfg=114 ctermbg=NONE cterm=NONE
hi markdownCodeDelimiter guifg=#99bc80 guibg=NONE guisp=NONE gui=NONE ctermfg=114 ctermbg=NONE cterm=NONE
hi markdownH1 guifg=#e16d77 guibg=NONE guisp=NONE gui=NONE ctermfg=204 ctermbg=NONE cterm=NONE
hi markdownH2 guifg=#e16d77 guibg=NONE guisp=NONE gui=NONE ctermfg=204 ctermbg=NONE cterm=NONE
hi markdownH3 guifg=#e16d77 guibg=NONE guisp=NONE gui=NONE ctermfg=204 ctermbg=NONE cterm=NONE
hi markdownH4 guifg=#e16d77 guibg=NONE guisp=NONE gui=NONE ctermfg=204 ctermbg=NONE cterm=NONE
hi markdownH5 guifg=#e16d77 guibg=NONE guisp=NONE gui=NONE ctermfg=204 ctermbg=NONE cterm=NONE
hi markdownH6 guifg=#e16d77 guibg=NONE guisp=NONE gui=NONE ctermfg=204 ctermbg=NONE cterm=NONE
hi markdownHeadingDelimiter guifg=#e16d77 guibg=NONE guisp=NONE gui=NONE ctermfg=204 ctermbg=NONE cterm=NONE
hi markdownHeadingRule guifg=#646568 guibg=NONE guisp=NONE gui=NONE ctermfg=59 ctermbg=NONE cterm=NONE
hi markdownId guifg=#c27fd7 guibg=NONE guisp=NONE gui=NONE ctermfg=170 ctermbg=NONE cterm=NONE
hi markdownIdDeclaration guifg=#68aee8 guibg=NONE guisp=NONE gui=NONE ctermfg=39 ctermbg=NONE cterm=NONE
hi markdownIdDelimiter guifg=#c27fd7 guibg=NONE guisp=NONE gui=NONE ctermfg=170 ctermbg=NONE cterm=NONE
hi markdownItalic guifg=#c27fd7 guibg=NONE guisp=NONE gui=NONE ctermfg=170 ctermbg=NONE cterm=NONE
hi markdownLinkDelimiter guifg=#c27fd7 guibg=NONE guisp=NONE gui=NONE ctermfg=170 ctermbg=NONE cterm=NONE
hi markdownLinkText guifg=#68aee8 guibg=NONE guisp=NONE gui=NONE ctermfg=39 ctermbg=NONE cterm=NONE
hi markdownListMarker guifg=#e16d77 guibg=NONE guisp=NONE gui=NONE ctermfg=204 ctermbg=NONE cterm=NONE
hi markdownOrderedListMarker guifg=#e16d77 guibg=NONE guisp=NONE gui=NONE ctermfg=204 ctermbg=NONE cterm=NONE
hi markdownRule guifg=#646568 guibg=NONE guisp=NONE gui=NONE ctermfg=59 ctermbg=NONE cterm=NONE
hi markdownUrl guifg=#5fafb9 guibg=NONE guisp=NONE gui=NONE ctermfg=38 ctermbg=NONE cterm=NONE
hi perlFiledescRead guifg=#99bc80 guibg=NONE guisp=NONE gui=NONE ctermfg=114 ctermbg=NONE cterm=NONE
hi perlFunction guifg=#c27fd7 guibg=NONE guisp=NONE gui=NONE ctermfg=170 ctermbg=NONE cterm=NONE
hi perlMatchStartEnd guifg=#68aee8 guibg=NONE guisp=NONE gui=NONE ctermfg=39 ctermbg=NONE cterm=NONE
hi perlMethod guifg=#c27fd7 guibg=NONE guisp=NONE gui=NONE ctermfg=170 ctermbg=NONE cterm=NONE
hi perlPOD guifg=#646568 guibg=NONE guisp=NONE gui=NONE ctermfg=59 ctermbg=NONE cterm=NONE
hi perlSharpBang guifg=#646568 guibg=NONE guisp=NONE gui=NONE ctermfg=59 ctermbg=NONE cterm=NONE
hi perlSpecialString guifg=#c99a6e guibg=NONE guisp=NONE gui=NONE ctermfg=173 ctermbg=NONE cterm=NONE
hi perlStatementFiledesc guifg=#e16d77 guibg=NONE guisp=NONE gui=NONE ctermfg=204 ctermbg=NONE cterm=NONE
hi perlStatementFlow guifg=#e16d77 guibg=NONE guisp=NONE gui=NONE ctermfg=204 ctermbg=NONE cterm=NONE
hi perlStatementInclude guifg=#c27fd7 guibg=NONE guisp=NONE gui=NONE ctermfg=170 ctermbg=NONE cterm=NONE
hi perlStatementScalar guifg=#c27fd7 guibg=NONE guisp=NONE gui=NONE ctermfg=170 ctermbg=NONE cterm=NONE
hi perlStatementStorage guifg=#c27fd7 guibg=NONE guisp=NONE gui=NONE ctermfg=170 ctermbg=NONE cterm=NONE
hi perlSubName guifg=#dfbe81 guibg=NONE guisp=NONE gui=NONE ctermfg=180 ctermbg=NONE cterm=NONE
hi perlVarPlain guifg=#68aee8 guibg=NONE guisp=NONE gui=NONE ctermfg=39 ctermbg=NONE cterm=NONE
hi phpVarSelector guifg=#e16d77 guibg=NONE guisp=NONE gui=NONE ctermfg=204 ctermbg=NONE cterm=NONE
hi phpOperator guifg=#b1b4b9 guibg=NONE guisp=NONE gui=NONE ctermfg=145 ctermbg=NONE cterm=NONE
hi phpParent guifg=#b1b4b9 guibg=NONE guisp=NONE gui=NONE ctermfg=145 ctermbg=NONE cterm=NONE
hi phpMemberSelector guifg=#b1b4b9 guibg=NONE guisp=NONE gui=NONE ctermfg=145 ctermbg=NONE cterm=NONE
hi phpType guifg=#c27fd7 guibg=NONE guisp=NONE gui=NONE ctermfg=170 ctermbg=NONE cterm=NONE
hi phpKeyword guifg=#c27fd7 guibg=NONE guisp=NONE gui=NONE ctermfg=170 ctermbg=NONE cterm=NONE
hi phpClass guifg=#dfbe81 guibg=NONE guisp=NONE gui=NONE ctermfg=180 ctermbg=NONE cterm=NONE
hi phpUseClass guifg=#b1b4b9 guibg=NONE guisp=NONE gui=NONE ctermfg=145 ctermbg=NONE cterm=NONE
hi phpUseAlias guifg=#b1b4b9 guibg=NONE guisp=NONE gui=NONE ctermfg=145 ctermbg=NONE cterm=NONE
hi phpInclude guifg=#c27fd7 guibg=NONE guisp=NONE gui=NONE ctermfg=170 ctermbg=NONE cterm=NONE
hi phpClassExtends guifg=#99bc80 guibg=NONE guisp=NONE gui=NONE ctermfg=114 ctermbg=NONE cterm=NONE
hi phpDocTags guifg=#b1b4b9 guibg=NONE guisp=NONE gui=NONE ctermfg=145 ctermbg=NONE cterm=NONE
hi phpFunction guifg=#68aee8 guibg=NONE guisp=NONE gui=NONE ctermfg=39 ctermbg=NONE cterm=NONE
hi phpFunctions guifg=#5fafb9 guibg=NONE guisp=NONE gui=NONE ctermfg=38 ctermbg=NONE cterm=NONE
hi phpMethodsVar guifg=#c99a6e guibg=NONE guisp=NONE gui=NONE ctermfg=173 ctermbg=NONE cterm=NONE
hi phpMagicConstants guifg=#c99a6e guibg=NONE guisp=NONE gui=NONE ctermfg=173 ctermbg=NONE cterm=NONE
hi phpSuperglobals guifg=#e16d77 guibg=NONE guisp=NONE gui=NONE ctermfg=204 ctermbg=NONE cterm=NONE
hi phpConstants guifg=#c99a6e guibg=NONE guisp=NONE gui=NONE ctermfg=173 ctermbg=NONE cterm=NONE
hi rubyBlockParameter guifg=#e16d77 guibg=NONE guisp=NONE gui=NONE ctermfg=204 ctermbg=NONE cterm=NONE
hi rubyBlockParameterList guifg=#e16d77 guibg=NONE guisp=NONE gui=NONE ctermfg=204 ctermbg=NONE cterm=NONE
hi rubyClass guifg=#c27fd7 guibg=NONE guisp=NONE gui=NONE ctermfg=170 ctermbg=NONE cterm=NONE
hi rubyConstant guifg=#dfbe81 guibg=NONE guisp=NONE gui=NONE ctermfg=180 ctermbg=NONE cterm=NONE
hi rubyControl guifg=#c27fd7 guibg=NONE guisp=NONE gui=NONE ctermfg=170 ctermbg=NONE cterm=NONE
hi rubyEscape guifg=#e16d77 guibg=NONE guisp=NONE gui=NONE ctermfg=204 ctermbg=NONE cterm=NONE
hi rubyFunction guifg=#68aee8 guibg=NONE guisp=NONE gui=NONE ctermfg=39 ctermbg=NONE cterm=NONE
hi rubyGlobalVariable guifg=#e16d77 guibg=NONE guisp=NONE gui=NONE ctermfg=204 ctermbg=NONE cterm=NONE
hi rubyInclude guifg=#68aee8 guibg=NONE guisp=NONE gui=NONE ctermfg=39 ctermbg=NONE cterm=NONE
hi rubyIncluderubyGlobalVariable guifg=#e16d77 guibg=NONE guisp=NONE gui=NONE ctermfg=204 ctermbg=NONE cterm=NONE
hi rubyInstanceVariable guifg=#e16d77 guibg=NONE guisp=NONE gui=NONE ctermfg=204 ctermbg=NONE cterm=NONE
hi rubyInterpolation guifg=#5fafb9 guibg=NONE guisp=NONE gui=NONE ctermfg=38 ctermbg=NONE cterm=NONE
hi rubyInterpolationDelimiter guifg=#e16d77 guibg=NONE guisp=NONE gui=NONE ctermfg=204 ctermbg=NONE cterm=NONE
hi rubyInterpolationDelimiter guifg=#e16d77 guibg=NONE guisp=NONE gui=NONE ctermfg=204 ctermbg=NONE cterm=NONE
hi rubyRegexp guifg=#5fafb9 guibg=NONE guisp=NONE gui=NONE ctermfg=38 ctermbg=NONE cterm=NONE
hi rubyRegexpDelimiter guifg=#5fafb9 guibg=NONE guisp=NONE gui=NONE ctermfg=38 ctermbg=NONE cterm=NONE
hi rubyStringDelimiter guifg=#99bc80 guibg=NONE guisp=NONE gui=NONE ctermfg=114 ctermbg=NONE cterm=NONE
hi rubySymbol guifg=#5fafb9 guibg=NONE guisp=NONE gui=NONE ctermfg=38 ctermbg=NONE cterm=NONE
hi sassAmpersand guifg=#e16d77 guibg=NONE guisp=NONE gui=NONE ctermfg=204 ctermbg=NONE cterm=NONE
hi sassClass guifg=#c99a6e guibg=NONE guisp=NONE gui=NONE ctermfg=173 ctermbg=NONE cterm=NONE
hi sassControl guifg=#c27fd7 guibg=NONE guisp=NONE gui=NONE ctermfg=170 ctermbg=NONE cterm=NONE
hi sassExtend guifg=#c27fd7 guibg=NONE guisp=NONE gui=NONE ctermfg=170 ctermbg=NONE cterm=NONE
hi sassFor guifg=#b1b4b9 guibg=NONE guisp=NONE gui=NONE ctermfg=145 ctermbg=NONE cterm=NONE
hi sassFunction guifg=#5fafb9 guibg=NONE guisp=NONE gui=NONE ctermfg=38 ctermbg=NONE cterm=NONE
hi sassId guifg=#68aee8 guibg=NONE guisp=NONE gui=NONE ctermfg=39 ctermbg=NONE cterm=NONE
hi sassInclude guifg=#c27fd7 guibg=NONE guisp=NONE gui=NONE ctermfg=170 ctermbg=NONE cterm=NONE
hi sassMedia guifg=#c27fd7 guibg=NONE guisp=NONE gui=NONE ctermfg=170 ctermbg=NONE cterm=NONE
hi sassMediaOperators guifg=#b1b4b9 guibg=NONE guisp=NONE gui=NONE ctermfg=145 ctermbg=NONE cterm=NONE
hi sassMixin guifg=#c27fd7 guibg=NONE guisp=NONE gui=NONE ctermfg=170 ctermbg=NONE cterm=NONE
hi sassMixinName guifg=#68aee8 guibg=NONE guisp=NONE gui=NONE ctermfg=39 ctermbg=NONE cterm=NONE
hi sassMixing guifg=#c27fd7 guibg=NONE guisp=NONE gui=NONE ctermfg=170 ctermbg=NONE cterm=NONE
hi sassVariable guifg=#c27fd7 guibg=NONE guisp=NONE gui=NONE ctermfg=170 ctermbg=NONE cterm=NONE
hi scssExtend guifg=#c27fd7 guibg=NONE guisp=NONE gui=NONE ctermfg=170 ctermbg=NONE cterm=NONE
hi scssImport guifg=#c27fd7 guibg=NONE guisp=NONE gui=NONE ctermfg=170 ctermbg=NONE cterm=NONE
hi scssInclude guifg=#c27fd7 guibg=NONE guisp=NONE gui=NONE ctermfg=170 ctermbg=NONE cterm=NONE
hi scssMixin guifg=#c27fd7 guibg=NONE guisp=NONE gui=NONE ctermfg=170 ctermbg=NONE cterm=NONE
hi scssSelectorName guifg=#c99a6e guibg=NONE guisp=NONE gui=NONE ctermfg=173 ctermbg=NONE cterm=NONE
hi scssVariable guifg=#c27fd7 guibg=NONE guisp=NONE gui=NONE ctermfg=170 ctermbg=NONE cterm=NONE
hi texStatement guifg=#c27fd7 guibg=NONE guisp=NONE gui=NONE ctermfg=170 ctermbg=NONE cterm=NONE
hi texSubscripts guifg=#c99a6e guibg=NONE guisp=NONE gui=NONE ctermfg=173 ctermbg=NONE cterm=NONE
hi texSuperscripts guifg=#c99a6e guibg=NONE guisp=NONE gui=NONE ctermfg=173 ctermbg=NONE cterm=NONE
hi texTodo guifg=#914141 guibg=NONE guisp=NONE gui=NONE ctermfg=196 ctermbg=NONE cterm=NONE
hi texBeginEnd guifg=#c27fd7 guibg=NONE guisp=NONE gui=NONE ctermfg=170 ctermbg=NONE cterm=NONE
hi texBeginEndName guifg=#68aee8 guibg=NONE guisp=NONE gui=NONE ctermfg=39 ctermbg=NONE cterm=NONE
hi texMathMatcher guifg=#68aee8 guibg=NONE guisp=NONE gui=NONE ctermfg=39 ctermbg=NONE cterm=NONE
hi texMathDelim guifg=#68aee8 guibg=NONE guisp=NONE gui=NONE ctermfg=39 ctermbg=NONE cterm=NONE
hi texDelimiter guifg=#c99a6e guibg=NONE guisp=NONE gui=NONE ctermfg=173 ctermbg=NONE cterm=NONE
hi texSpecialChar guifg=#c99a6e guibg=NONE guisp=NONE gui=NONE ctermfg=173 ctermbg=NONE cterm=NONE
hi texCite guifg=#68aee8 guibg=NONE guisp=NONE gui=NONE ctermfg=39 ctermbg=NONE cterm=NONE
hi texRefZone guifg=#68aee8 guibg=NONE guisp=NONE gui=NONE ctermfg=39 ctermbg=NONE cterm=NONE
hi typescriptReserved guifg=#c27fd7 guibg=NONE guisp=NONE gui=NONE ctermfg=170 ctermbg=NONE cterm=NONE
hi typescriptEndColons guifg=#b1b4b9 guibg=NONE guisp=NONE gui=NONE ctermfg=145 ctermbg=NONE cterm=NONE
hi typescriptBraces guifg=#b1b4b9 guibg=NONE guisp=NONE gui=NONE ctermfg=145 ctermbg=NONE cterm=NONE
hi xmlAttrib guifg=#c99a6e guibg=NONE guisp=NONE gui=NONE ctermfg=173 ctermbg=NONE cterm=NONE
hi xmlEndTag guifg=#e16d77 guibg=NONE guisp=NONE gui=NONE ctermfg=204 ctermbg=NONE cterm=NONE
hi xmlTag guifg=#e16d77 guibg=NONE guisp=NONE gui=NONE ctermfg=204 ctermbg=NONE cterm=NONE
hi xmlTagName guifg=#e16d77 guibg=NONE guisp=NONE gui=NONE ctermfg=204 ctermbg=NONE cterm=NONE
hi GitGutterAdd guifg=#99bc80 guibg=NONE guisp=NONE gui=NONE ctermfg=114 ctermbg=NONE cterm=NONE
hi GitGutterChange guifg=#dfbe81 guibg=NONE guisp=NONE gui=NONE ctermfg=180 ctermbg=NONE cterm=NONE
hi GitGutterDelete guifg=#e16d77 guibg=NONE guisp=NONE gui=NONE ctermfg=204 ctermbg=NONE cterm=NONE
hi ALEError guifg=#e16d77 guibg=NONE guisp=NONE gui=NONE ctermfg=204 ctermbg=NONE cterm=NONE
hi ALEWarning guifg=#dfbe81 guibg=NONE guisp=NONE gui=NONE ctermfg=180 ctermbg=NONE cterm=NONE
hi ALEInfo guifg=NONE guibg=NONE guisp=NONE gui=NONE ctermfg=NONE ctermbg=NONE cterm=NONE
hi ALEErrorSign guifg=#e16d77 guibg=NONE guisp=NONE gui=NONE ctermfg=204 ctermbg=NONE cterm=NONE
hi ALEWarningSign guifg=#dfbe81 guibg=NONE guisp=NONE gui=NONE ctermfg=180 ctermbg=NONE cterm=NONE
hi ALEInfoSign guifg=NONE guibg=NONE guisp=NONE gui=NONE ctermfg=NONE ctermbg=NONE cterm=NONE
hi EasyMotionTarget guifg=#e16d77 guibg=NONE guisp=NONE gui=NONE ctermfg=204 ctermbg=NONE cterm=NONE
hi EasyMotionTarget2First guifg=#dfbe81 guibg=NONE guisp=NONE gui=NONE ctermfg=180 ctermbg=NONE cterm=NONE
hi EasyMotionTarget2Second guifg=#c99a6e guibg=NONE guisp=NONE gui=NONE ctermfg=173 ctermbg=NONE cterm=NONE
hi EasyMotionShade guifg=#646568 guibg=NONE guisp=NONE gui=NONE ctermfg=59 ctermbg=NONE cterm=NONE
hi CocErrorSign guifg=#e16d77 guibg=NONE guisp=NONE gui=NONE ctermfg=204 ctermbg=NONE cterm=NONE
hi CocWarningSign guifg=#dfbe81 guibg=NONE guisp=NONE gui=NONE ctermfg=180 ctermbg=NONE cterm=NONE
hi CocInfoSign guifg=#68aee8 guibg=NONE guisp=NONE gui=NONE ctermfg=39 ctermbg=NONE cterm=NONE
hi CocHintSign guifg=#5fafb9 guibg=NONE guisp=NONE gui=NONE ctermfg=38 ctermbg=NONE cterm=NONE
hi CocFadeOut guifg=#646568 guibg=NONE guisp=NONE gui=NONE ctermfg=59 ctermbg=NONE cterm=NONE
hi NeomakeErrorSign guifg=#e16d77 guibg=NONE guisp=NONE gui=NONE ctermfg=204 ctermbg=NONE cterm=NONE
hi NeomakeWarningSign guifg=#dfbe81 guibg=NONE guisp=NONE gui=NONE ctermfg=180 ctermbg=NONE cterm=NONE
hi NeomakeInfoSign guifg=#68aee8 guibg=NONE guisp=NONE gui=NONE ctermfg=39 ctermbg=NONE cterm=NONE
hi mkdDelimiter guifg=#c27fd7 guibg=NONE guisp=NONE gui=NONE ctermfg=170 ctermbg=NONE cterm=NONE
hi mkdHeading guifg=#e16d77 guibg=NONE guisp=NONE gui=NONE ctermfg=204 ctermbg=NONE cterm=NONE
hi mkdLink guifg=#68aee8 guibg=NONE guisp=NONE gui=NONE ctermfg=39 ctermbg=NONE cterm=NONE
hi mkdURL guifg=#5fafb9 guibg=NONE guisp=NONE gui=NONE ctermfg=38 ctermbg=NONE cterm=NONE
hi LspErrorText guifg=#e16d77 guibg=NONE guisp=NONE gui=NONE ctermfg=204 ctermbg=NONE cterm=NONE
hi LspWarningText guifg=#dfbe81 guibg=NONE guisp=NONE gui=NONE ctermfg=180 ctermbg=NONE cterm=NONE
hi LspInformationText guifg=#68aee8 guibg=NONE guisp=NONE gui=NONE ctermfg=39 ctermbg=NONE cterm=NONE
hi LspHintText guifg=#5fafb9 guibg=NONE guisp=NONE gui=NONE ctermfg=38 ctermbg=NONE cterm=NONE
hi LspErrorHighlight guifg=#e16d77 guibg=NONE guisp=NONE gui=NONE ctermfg=204 ctermbg=NONE cterm=NONE
hi LspWarningHighlight guifg=#dfbe81 guibg=NONE guisp=NONE gui=NONE ctermfg=180 ctermbg=NONE cterm=NONE
hi LspInformationHighlight guifg=#68aee8 guibg=NONE guisp=NONE gui=NONE ctermfg=39 ctermbg=NONE cterm=NONE
hi LspHintHighlight guifg=#5fafb9 guibg=NONE guisp=NONE gui=NONE ctermfg=38 ctermbg=NONE cterm=NONE
hi diffAdded guifg=#99bc80 guibg=NONE guisp=NONE gui=NONE ctermfg=114 ctermbg=NONE cterm=NONE
hi diffRemoved guifg=#e16d77 guibg=NONE guisp=NONE gui=NONE ctermfg=204 ctermbg=NONE cterm=NONE
hi gitcommitComment guifg=#646568 guibg=NONE guisp=NONE gui=NONE ctermfg=59 ctermbg=NONE cterm=NONE
hi gitcommitUnmerged guifg=#99bc80 guibg=NONE guisp=NONE gui=NONE ctermfg=114 ctermbg=NONE cterm=NONE
hi gitcommitOnBranch guifg=NONE guibg=NONE guisp=NONE gui=NONE ctermfg=NONE ctermbg=NONE cterm=NONE
hi gitcommitBranch guifg=#c27fd7 guibg=NONE guisp=NONE gui=NONE ctermfg=170 ctermbg=NONE cterm=NONE
hi gitcommitDiscardedType guifg=#e16d77 guibg=NONE guisp=NONE gui=NONE ctermfg=204 ctermbg=NONE cterm=NONE
hi gitcommitSelectedType guifg=#99bc80 guibg=NONE guisp=NONE gui=NONE ctermfg=114 ctermbg=NONE cterm=NONE
hi gitcommitHeader guifg=NONE guibg=NONE guisp=NONE gui=NONE ctermfg=NONE ctermbg=NONE cterm=NONE
hi gitcommitUntrackedFile guifg=#5fafb9 guibg=NONE guisp=NONE gui=NONE ctermfg=38 ctermbg=NONE cterm=NONE
hi gitcommitDiscardedFile guifg=#e16d77 guibg=NONE guisp=NONE gui=NONE ctermfg=204 ctermbg=NONE cterm=NONE
hi gitcommitSelectedFile guifg=#99bc80 guibg=NONE guisp=NONE gui=NONE ctermfg=114 ctermbg=NONE cterm=NONE
hi gitcommitUnmergedFile guifg=#dfbe81 guibg=NONE guisp=NONE gui=NONE ctermfg=180 ctermbg=NONE cterm=NONE
hi gitcommitFile guifg=NONE guibg=NONE guisp=NONE gui=NONE ctermfg=NONE ctermbg=NONE cterm=NONE
hi gitcommitSummary guifg=#b1b4b9 guibg=NONE guisp=NONE gui=NONE ctermfg=145 ctermbg=NONE cterm=NONE
hi gitcommitOverflow guifg=#e16d77 guibg=NONE guisp=NONE gui=NONE ctermfg=204 ctermbg=NONE cterm=NONE

hi link GitSignsAdd    GitGutterAdd
hi link GitSignsChange GitGutterChange
hi link GitSignsDelete GitGutterDelete

hi link SignifySignAdd    GitGutterAdd
hi link SignifySignChange GitGutterChange
hi link SignifySignDelete GitGutterDelete
	
hi link gitcommitNoBranch gitcommitBranch
hi link gitcommitUntracked gitcommitComment
hi link gitcommitDiscarded gitcommitComment
hi link gitcommitSelected gitcommitComment
hi link gitcommitDiscardedArrow gitcommitDiscardedFile
hi link gitcommitSelectedArrow gitcommitSelectedFile
hi link gitcommitUnmergedArrow gitcommitUnmergedFile
hi link vim9MethodDefName Function

# Terminal
g:terminal_ansi_colors = [
    '#2c2d30', '#e16d77', '#99bc80', '#dfbe81',
    '#68aee8', '#c27fd7', '#5fafb9', '#8b8d91',
    '#646568', '#e16d77', '#99bc80', '#dfbe81',
    '#68aee8', '#c27fd7', '#5fafb9', '#b1b4b9'
]

# ============================================================
#  SupraWarm — overrides
# ============================================================
# Comments
hi Comment        guifg=#646568 guibg=NONE gui=NONE cterm=NONE
hi SpecialComment guifg=#646568 guibg=NONE gui=NONE cterm=NONE
hi Folded         guifg=#646568 guibg=#242628 gui=NONE cterm=NONE

# Cursor / current line
hi CursorLine     guibg=#35373b gui=NONE cterm=NONE
hi CursorColumn   guibg=#35373b
hi ColorColumn    guibg=#35373b
hi CursorLineNr   guifg=#dfbe81 guibg=NONE gui=NONE cterm=NONE
hi LineNr         guifg=#595a5e guibg=NONE

# Matching paren
hi MatchParen     guifg=#5fafb9 guibg=#404247 gui=NONE cterm=NONE

# Visual selection
hi Visual         guibg=#394149
hi VisualNOS      guibg=#394149

# Search
hi Search         guifg=#2c2d30 guibg=#dfbe81 gui=NONE cterm=NONE
hi IncSearch      guifg=#2c2d30 guibg=#c99a6e gui=NONE cterm=NONE

# Completion menu
hi Pmenu          guifg=#b1b4b9 guibg=#35373b
hi PmenuSel       guifg=#2c2d30 guibg=#68aee8 gui=NONE cterm=NONE
hi PmenuSbar      guibg=#242628
hi PmenuThumb     guibg=#595a5e

# Splits / statusline
hi VertSplit      guifg=#404247 guibg=NONE
hi WinSeparator   guifg=#404247 guibg=NONE
hi StatusLine     guifg=#b1b4b9 guibg=#35373b gui=NONE cterm=NONE
hi StatusLineNC   guifg=#646568 guibg=#242628 gui=NONE cterm=NONE

# Spell
hi SpellBad       guifg=NONE guisp=#e16d77 gui=NONE cterm=NONE
hi SpellCap       guifg=NONE guisp=#dfbe81 gui=NONE cterm=NONE
hi SpellRare      guifg=NONE guisp=#5fafb9 gui=NONE cterm=NONE
hi SpellLocal     guifg=NONE guisp=#99bc80 gui=NONE cterm=NONE

# Diff
hi DiffAdd        guifg=NONE guibg=#32352f
hi DiffDelete     guifg=NONE guibg=#342f2f
hi DiffChange     guifg=NONE guibg=#203444
hi DiffText       guifg=NONE guibg=#32526c

# Titles / links
hi Title          guifg=#99bc80 gui=NONE cterm=NONE
hi Underlined     guifg=#68aee8 gui=NONE cterm=NONE
hi Directory      guifg=#68aee8 gui=NONE cterm=NONE

# SignColumn without border
hi! link SignColumn Normal
hi! link EndOfBuffer Normal
