vim9script
# supra-gui: background=#1b1c1e include=#57a5e5 stdio=#8fb573 typedef=#dbb671 struct=#dbb671 type_s=#a7aab0 scope=#c6c8cc float=#dbb671 function=#a7aab0 format=#c49060 text=#8fb573 integer=#c49060

hi clear

if exists("syntax_on")
  syntax reset
endif

set t_Co=256

g:colors_name = "suprawarmer"

if !exists("g:suprawarmer_termcolors")
	g:suprawarmer_termcolors = 256
endif

if !exists("g:suprawarmer_terminal_italics")
	g:suprawarmer_terminal_italics = 0
endif

hi Comment guifg=#5a5b5e guibg=NONE guisp=NONE gui=NONE ctermfg=59 ctermbg=NONE cterm=NONE
hi Constant guifg=#51a8b3 guibg=NONE guisp=NONE gui=NONE ctermfg=38 ctermbg=NONE cterm=NONE
hi String guifg=#8fb573 guibg=NONE guisp=NONE gui=NONE ctermfg=114 ctermbg=NONE cterm=NONE
hi Character guifg=#8fb573 guibg=NONE guisp=NONE gui=NONE ctermfg=114 ctermbg=NONE cterm=NONE
hi Number guifg=#c49060 guibg=NONE guisp=NONE gui=NONE ctermfg=173 ctermbg=NONE cterm=NONE
hi Boolean guifg=#c49060 guibg=NONE guisp=NONE gui=NONE ctermfg=173 ctermbg=NONE cterm=NONE
hi Float guifg=#c49060 guibg=NONE guisp=NONE gui=NONE ctermfg=173 ctermbg=NONE cterm=NONE
hi Identifier guifg=#de5d68 guibg=NONE guisp=NONE gui=NONE ctermfg=204 ctermbg=NONE cterm=NONE
hi Function guifg=#57a5e5 guibg=NONE guisp=NONE gui=NONE ctermfg=39 ctermbg=NONE cterm=NONE
hi Statement guifg=#bb70d2 guibg=NONE guisp=NONE gui=NONE ctermfg=170 ctermbg=NONE cterm=NONE
hi Conditional guifg=#bb70d2 guibg=NONE guisp=NONE gui=NONE ctermfg=170 ctermbg=NONE cterm=NONE
hi Repeat guifg=#bb70d2 guibg=NONE guisp=NONE gui=NONE ctermfg=170 ctermbg=NONE cterm=NONE
hi Label guifg=#bb70d2 guibg=NONE guisp=NONE gui=NONE ctermfg=170 ctermbg=NONE cterm=NONE
hi Operator guifg=#bb70d2 guibg=NONE guisp=NONE gui=NONE ctermfg=170 ctermbg=NONE cterm=NONE
hi Keyword guifg=#bb70d2 guibg=NONE guisp=NONE gui=NONE ctermfg=170 ctermbg=NONE cterm=NONE
hi Exception guifg=#bb70d2 guibg=NONE guisp=NONE gui=NONE ctermfg=170 ctermbg=NONE cterm=NONE
hi PreProc guifg=#dbb671 guibg=NONE guisp=NONE gui=NONE ctermfg=180 ctermbg=NONE cterm=NONE
hi Include guifg=#57a5e5 guibg=NONE guisp=NONE gui=NONE ctermfg=39 ctermbg=NONE cterm=NONE
hi Define guifg=#bb70d2 guibg=NONE guisp=NONE gui=NONE ctermfg=170 ctermbg=NONE cterm=NONE
hi Macro guifg=#bb70d2 guibg=NONE guisp=NONE gui=NONE ctermfg=170 ctermbg=NONE cterm=NONE
hi PreCondit guifg=#dbb671 guibg=NONE guisp=NONE gui=NONE ctermfg=180 ctermbg=NONE cterm=NONE
hi Type guifg=#dbb671 guibg=NONE guisp=NONE gui=NONE ctermfg=180 ctermbg=NONE cterm=NONE
hi StorageClass guifg=#dbb671 guibg=NONE guisp=NONE gui=NONE ctermfg=180 ctermbg=NONE cterm=NONE
hi Structure guifg=#dbb671 guibg=NONE guisp=NONE gui=NONE ctermfg=180 ctermbg=NONE cterm=NONE
hi Typedef guifg=#dbb671 guibg=NONE guisp=NONE gui=NONE ctermfg=180 ctermbg=NONE cterm=NONE
hi Special guifg=#57a5e5 guibg=NONE guisp=NONE gui=NONE ctermfg=39 ctermbg=NONE cterm=NONE
hi SpecialChar guifg=#c49060 guibg=NONE guisp=NONE gui=NONE ctermfg=173 ctermbg=NONE cterm=NONE
hi Tag guifg=NONE guibg=NONE guisp=NONE gui=NONE ctermfg=NONE ctermbg=NONE cterm=NONE
hi Delimiter guifg=NONE guibg=NONE guisp=NONE gui=NONE ctermfg=NONE ctermbg=NONE cterm=NONE
hi SpecialComment guifg=#5a5b5e guibg=NONE guisp=NONE gui=NONE ctermfg=59 ctermbg=NONE cterm=NONE
hi Debug guifg=NONE guibg=NONE guisp=NONE gui=NONE ctermfg=NONE ctermbg=NONE cterm=NONE
hi Underlined guifg=NONE guibg=NONE guisp=NONE gui=NONE ctermfg=NONE ctermbg=NONE cterm=NONE
hi Ignore guifg=NONE guibg=NONE guisp=NONE gui=NONE ctermfg=NONE ctermbg=NONE cterm=NONE
hi Error guifg=#de5d68 guibg=NONE guisp=NONE gui=NONE ctermfg=204 ctermbg=NONE cterm=NONE
hi Todo guifg=#bb70d2 guibg=NONE guisp=NONE gui=NONE ctermfg=170 ctermbg=NONE cterm=NONE
hi ColorColumn guifg=NONE guibg=#2c2d31 guisp=NONE gui=NONE ctermfg=NONE ctermbg=236 cterm=NONE
hi Conceal guifg=NONE guibg=NONE guisp=NONE gui=NONE ctermfg=NONE ctermbg=NONE cterm=NONE
hi Cursor guifg=#232326 guibg=#57a5e5 guisp=NONE gui=NONE ctermfg=235 ctermbg=39 cterm=NONE
hi CursorIM guifg=NONE guibg=NONE guisp=NONE gui=NONE ctermfg=NONE ctermbg=NONE cterm=NONE
hi CursorColumn guifg=NONE guibg=#2c2d31 guisp=NONE gui=NONE ctermfg=NONE ctermbg=236 cterm=NONE
hi CursorLine guifg=NONE guibg=#2c2d31 guisp=NONE gui=NONE ctermfg=NONE ctermbg=236 cterm=NONE
hi Directory guifg=#57a5e5 guibg=NONE guisp=NONE gui=NONE ctermfg=39 ctermbg=NONE cterm=NONE
hi DiffAdd guifg=#232326 guibg=#8fb573 guisp=NONE gui=NONE ctermfg=235 ctermbg=114 cterm=NONE
hi DiffChange guifg=#dbb671 guibg=NONE guisp=NONE gui=NONE ctermfg=180 ctermbg=NONE cterm=NONE
hi DiffDelete guifg=#232326 guibg=#de5d68 guisp=NONE gui=NONE ctermfg=235 ctermbg=204 cterm=NONE
hi DiffText guifg=#232326 guibg=#dbb671 guisp=NONE gui=NONE ctermfg=235 ctermbg=180 cterm=NONE
hi ErrorMsg guifg=#de5d68 guibg=NONE guisp=NONE gui=NONE ctermfg=204 ctermbg=NONE cterm=NONE
hi VertSplit guifg=#37383d guibg=NONE guisp=NONE gui=NONE ctermfg=59 ctermbg=NONE cterm=NONE
hi Folded guifg=#5a5b5e guibg=NONE guisp=NONE gui=NONE ctermfg=59 ctermbg=NONE cterm=NONE
hi FoldColumn guifg=NONE guibg=NONE guisp=NONE gui=NONE ctermfg=NONE ctermbg=NONE cterm=NONE
hi SignColumn guifg=NONE guibg=NONE guisp=NONE gui=NONE ctermfg=NONE ctermbg=NONE cterm=NONE
hi IncSearch guifg=#dbb671 guibg=#5a5b5e guisp=NONE gui=NONE ctermfg=180 ctermbg=59 cterm=NONE
hi LineNr guifg=#505054 guibg=NONE guisp=NONE gui=NONE ctermfg=238 ctermbg=NONE cterm=NONE
hi CursorLineNr guifg=#c49060 guibg=NONE guisp=NONE gui=NONE ctermfg=NONE ctermbg=NONE cterm=NONE
hi MatchParen guifg=#57a5e5 guibg=NONE guisp=NONE gui=NONE ctermfg=39 ctermbg=NONE cterm=NONE
hi ModeMsg guifg=NONE guibg=NONE guisp=NONE gui=NONE ctermfg=NONE ctermbg=NONE cterm=NONE
hi MoreMsg guifg=NONE guibg=NONE guisp=NONE gui=NONE ctermfg=NONE ctermbg=NONE cterm=NONE
hi NonText guifg=#35363b guibg=NONE guisp=NONE gui=NONE ctermfg=238 ctermbg=NONE cterm=NONE
hi Normal guifg=#a7aab0 guibg=#232326 guisp=NONE gui=NONE ctermfg=145 ctermbg=235 cterm=NONE
hi Pmenu guifg=#a7aab0 guibg=#37383d guisp=NONE gui=NONE ctermfg=145 ctermbg=237 cterm=NONE
hi PmenuSel guifg=#2c2d31 guibg=#57a5e5 guisp=NONE gui=NONE ctermfg=236 ctermbg=39 cterm=NONE
hi PmenuSbar guifg=NONE guibg=#2c2d31 guisp=NONE gui=NONE ctermfg=NONE ctermbg=236 cterm=NONE
hi PmenuThumb guifg=NONE guibg=#a7aab0 guisp=NONE gui=NONE ctermfg=NONE ctermbg=145 cterm=NONE
hi Question guifg=#bb70d2 guibg=NONE guisp=NONE gui=NONE ctermfg=170 ctermbg=NONE cterm=NONE
hi QuickFixLine guifg=#232326 guibg=#dbb671 guisp=NONE gui=NONE ctermfg=235 ctermbg=180 cterm=NONE
hi Search guifg=#232326 guibg=#dbb671 guisp=NONE gui=NONE ctermfg=235 ctermbg=180 cterm=NONE
hi SpecialKey guifg=#35363b guibg=NONE guisp=NONE gui=NONE ctermfg=238 ctermbg=NONE cterm=NONE
hi SpellBad guifg=#de5d68 guibg=NONE guisp=NONE gui=NONE ctermfg=204 ctermbg=NONE cterm=NONE
hi SpellCap guifg=#c49060 guibg=NONE guisp=NONE gui=NONE ctermfg=173 ctermbg=NONE cterm=NONE
hi SpellLocal guifg=#c49060 guibg=NONE guisp=NONE gui=NONE ctermfg=173 ctermbg=NONE cterm=NONE
hi SpellRare guifg=#c49060 guibg=NONE guisp=NONE gui=NONE ctermfg=173 ctermbg=NONE cterm=NONE
hi StatusLine guifg=#a7aab0 guibg=#2c2d31 guisp=NONE gui=NONE ctermfg=145 ctermbg=236 cterm=NONE
hi StatusLineNC guifg=#5a5b5e guibg=NONE guisp=NONE gui=NONE ctermfg=59 ctermbg=NONE cterm=NONE
hi StatusLineTerm guifg=#a7aab0 guibg=#2c2d31 guisp=NONE gui=NONE ctermfg=145 ctermbg=236 cterm=NONE
hi StatusLineTermNC guifg=#5a5b5e guibg=NONE guisp=NONE gui=NONE ctermfg=59 ctermbg=NONE cterm=NONE
hi TabLine guifg=#5a5b5e guibg=NONE guisp=NONE gui=NONE ctermfg=59 ctermbg=NONE cterm=NONE
hi TabLineFill guifg=NONE guibg=NONE guisp=NONE gui=NONE ctermfg=NONE ctermbg=NONE cterm=NONE
hi TabLineSel guifg=#a7aab0 guibg=NONE guisp=NONE gui=NONE ctermfg=145 ctermbg=NONE cterm=NONE
hi Terminal guifg=#a7aab0 guibg=#232326 guisp=NONE gui=NONE ctermfg=145 ctermbg=235 cterm=NONE
hi Title guifg=#8fb573 guibg=NONE guisp=NONE gui=NONE ctermfg=114 ctermbg=NONE cterm=NONE
hi Visual guifg=NONE guibg=#37383d guisp=NONE gui=NONE ctermfg=NONE ctermbg=237 cterm=NONE
hi VisualNOS guifg=NONE guibg=#37383d guisp=NONE gui=NONE ctermfg=NONE ctermbg=237 cterm=NONE
hi WarningMsg guifg=#dbb671 guibg=NONE guisp=NONE gui=NONE ctermfg=180 ctermbg=NONE cterm=NONE
hi WildMenu guifg=#232326 guibg=#57a5e5 guisp=NONE gui=NONE ctermfg=235 ctermbg=39 cterm=NONE

hi PMenuMatch guifg=#dbb671 guibg=NONE guisp=NONE gui=NONE ctermfg=180 ctermbg=237 cterm=NONE
hi PMenuKind guifg=#bb70d2 guibg=NONE guisp=NONE cterm=NONE gui=NONE ctermfg=38

hi debugPC guifg=NONE guibg=#35363b guisp=NONE gui=NONE ctermfg=NONE ctermbg=238 cterm=NONE
hi debugBreakpoint guifg=#232326 guibg=#de5d68 guisp=NONE gui=NONE ctermfg=235 ctermbg=204 cterm=NONE
hi cssAttrComma guifg=#bb70d2 guibg=NONE guisp=NONE gui=NONE ctermfg=170 ctermbg=NONE cterm=NONE
hi cssAttributeSelector guifg=#8fb573 guibg=NONE guisp=NONE gui=NONE ctermfg=114 ctermbg=NONE cterm=NONE
hi cssBraces guifg=#a7aab0 guibg=NONE guisp=NONE gui=NONE ctermfg=145 ctermbg=NONE cterm=NONE
hi cssClassName guifg=#c49060 guibg=NONE guisp=NONE gui=NONE ctermfg=173 ctermbg=NONE cterm=NONE
hi cssClassNameDot guifg=#c49060 guibg=NONE guisp=NONE gui=NONE ctermfg=173 ctermbg=NONE cterm=NONE
hi cssDefinition guifg=#bb70d2 guibg=NONE guisp=NONE gui=NONE ctermfg=170 ctermbg=NONE cterm=NONE
hi cssFontAttr guifg=#c49060 guibg=NONE guisp=NONE gui=NONE ctermfg=173 ctermbg=NONE cterm=NONE
hi cssFontDescriptor guifg=#bb70d2 guibg=NONE guisp=NONE gui=NONE ctermfg=170 ctermbg=NONE cterm=NONE
hi cssFunctionName guifg=#57a5e5 guibg=NONE guisp=NONE gui=NONE ctermfg=39 ctermbg=NONE cterm=NONE
hi cssIdentifier guifg=#57a5e5 guibg=NONE guisp=NONE gui=NONE ctermfg=39 ctermbg=NONE cterm=NONE
hi cssImportant guifg=#bb70d2 guibg=NONE guisp=NONE gui=NONE ctermfg=170 ctermbg=NONE cterm=NONE
hi cssInclude guifg=#a7aab0 guibg=NONE guisp=NONE gui=NONE ctermfg=145 ctermbg=NONE cterm=NONE
hi cssIncludeKeyword guifg=#bb70d2 guibg=NONE guisp=NONE gui=NONE ctermfg=170 ctermbg=NONE cterm=NONE
hi cssMediaType guifg=#c49060 guibg=NONE guisp=NONE gui=NONE ctermfg=173 ctermbg=NONE cterm=NONE
hi cssProp guifg=#a7aab0 guibg=NONE guisp=NONE gui=NONE ctermfg=145 ctermbg=NONE cterm=NONE
hi cssPseudoClassId guifg=#c49060 guibg=NONE guisp=NONE gui=NONE ctermfg=173 ctermbg=NONE cterm=NONE
hi cssSelectorOp guifg=#bb70d2 guibg=NONE guisp=NONE gui=NONE ctermfg=170 ctermbg=NONE cterm=NONE
hi cssSelectorOp2 guifg=#bb70d2 guibg=NONE guisp=NONE gui=NONE ctermfg=170 ctermbg=NONE cterm=NONE
hi cssTagName guifg=#de5d68 guibg=NONE guisp=NONE gui=NONE ctermfg=204 ctermbg=NONE cterm=NONE
hi fishKeyword guifg=#bb70d2 guibg=NONE guisp=NONE gui=NONE ctermfg=170 ctermbg=NONE cterm=NONE
hi fishConditional guifg=#bb70d2 guibg=NONE guisp=NONE gui=NONE ctermfg=170 ctermbg=NONE cterm=NONE
hi goDeclaration guifg=#bb70d2 guibg=NONE guisp=NONE gui=NONE ctermfg=170 ctermbg=NONE cterm=NONE
hi goBuiltins guifg=#51a8b3 guibg=NONE guisp=NONE gui=NONE ctermfg=38 ctermbg=NONE cterm=NONE
hi goFunctionCall guifg=#57a5e5 guibg=NONE guisp=NONE gui=NONE ctermfg=39 ctermbg=NONE cterm=NONE
hi goVarDefs guifg=#de5d68 guibg=NONE guisp=NONE gui=NONE ctermfg=204 ctermbg=NONE cterm=NONE
hi goVarAssign guifg=#de5d68 guibg=NONE guisp=NONE gui=NONE ctermfg=204 ctermbg=NONE cterm=NONE
hi goVar guifg=#bb70d2 guibg=NONE guisp=NONE gui=NONE ctermfg=170 ctermbg=NONE cterm=NONE
hi goConst guifg=#bb70d2 guibg=NONE guisp=NONE gui=NONE ctermfg=170 ctermbg=NONE cterm=NONE
hi goType guifg=#dbb671 guibg=NONE guisp=NONE gui=NONE ctermfg=180 ctermbg=NONE cterm=NONE
hi goTypeName guifg=#dbb671 guibg=NONE guisp=NONE gui=NONE ctermfg=180 ctermbg=NONE cterm=NONE
hi goDeclType guifg=#51a8b3 guibg=NONE guisp=NONE gui=NONE ctermfg=38 ctermbg=NONE cterm=NONE
hi goTypeDecl guifg=#bb70d2 guibg=NONE guisp=NONE gui=NONE ctermfg=170 ctermbg=NONE cterm=NONE
hi htmlArg guifg=#c49060 guibg=NONE guisp=NONE gui=NONE ctermfg=173 ctermbg=NONE cterm=NONE
hi htmlBold guifg=#c49060 guibg=NONE guisp=NONE gui=NONE ctermfg=173 ctermbg=NONE cterm=NONE
hi htmlBoldItalic guifg=#8fb573 guibg=NONE guisp=NONE gui=NONE ctermfg=114 ctermbg=NONE cterm=NONE
hi htmlEndTag guifg=#a7aab0 guibg=NONE guisp=NONE gui=NONE ctermfg=145 ctermbg=NONE cterm=NONE
hi htmlH1 guifg=#de5d68 guibg=NONE guisp=NONE gui=NONE ctermfg=204 ctermbg=NONE cterm=NONE
hi htmlH2 guifg=#de5d68 guibg=NONE guisp=NONE gui=NONE ctermfg=204 ctermbg=NONE cterm=NONE
hi htmlH3 guifg=#de5d68 guibg=NONE guisp=NONE gui=NONE ctermfg=204 ctermbg=NONE cterm=NONE
hi htmlH4 guifg=#de5d68 guibg=NONE guisp=NONE gui=NONE ctermfg=204 ctermbg=NONE cterm=NONE
hi htmlH5 guifg=#de5d68 guibg=NONE guisp=NONE gui=NONE ctermfg=204 ctermbg=NONE cterm=NONE
hi htmlH6 guifg=#de5d68 guibg=NONE guisp=NONE gui=NONE ctermfg=204 ctermbg=NONE cterm=NONE
hi htmlItalic guifg=#bb70d2 guibg=NONE guisp=NONE gui=NONE ctermfg=170 ctermbg=NONE cterm=NONE
hi htmlLink guifg=#51a8b3 guibg=NONE guisp=NONE gui=NONE ctermfg=38 ctermbg=NONE cterm=NONE
hi htmlSpecialChar guifg=#c49060 guibg=NONE guisp=NONE gui=NONE ctermfg=173 ctermbg=NONE cterm=NONE
hi htmlSpecialTagName guifg=#de5d68 guibg=NONE guisp=NONE gui=NONE ctermfg=204 ctermbg=NONE cterm=NONE
hi htmlTag guifg=#a7aab0 guibg=NONE guisp=NONE gui=NONE ctermfg=145 ctermbg=NONE cterm=NONE
hi htmlTagN guifg=#de5d68 guibg=NONE guisp=NONE gui=NONE ctermfg=204 ctermbg=NONE cterm=NONE
hi htmlTagName guifg=#de5d68 guibg=NONE guisp=NONE gui=NONE ctermfg=204 ctermbg=NONE cterm=NONE
hi htmlTitle guifg=#a7aab0 guibg=NONE guisp=NONE gui=NONE ctermfg=145 ctermbg=NONE cterm=NONE
hi javaScriptBraces guifg=#a7aab0 guibg=NONE guisp=NONE gui=NONE ctermfg=145 ctermbg=NONE cterm=NONE
hi javaScriptFunction guifg=#bb70d2 guibg=NONE guisp=NONE gui=NONE ctermfg=170 ctermbg=NONE cterm=NONE
hi javaScriptIdentifier guifg=#bb70d2 guibg=NONE guisp=NONE gui=NONE ctermfg=170 ctermbg=NONE cterm=NONE
hi javaScriptNull guifg=#c49060 guibg=NONE guisp=NONE gui=NONE ctermfg=173 ctermbg=NONE cterm=NONE
hi javaScriptNumber guifg=#c49060 guibg=NONE guisp=NONE gui=NONE ctermfg=173 ctermbg=NONE cterm=NONE
hi javaScriptRequire guifg=#51a8b3 guibg=NONE guisp=NONE gui=NONE ctermfg=38 ctermbg=NONE cterm=NONE
hi javaScriptReserved guifg=#bb70d2 guibg=NONE guisp=NONE gui=NONE ctermfg=170 ctermbg=NONE cterm=NONE
hi jsArrowFunction guifg=#bb70d2 guibg=NONE guisp=NONE gui=NONE ctermfg=170 ctermbg=NONE cterm=NONE
hi jsClassKeyword guifg=#bb70d2 guibg=NONE guisp=NONE gui=NONE ctermfg=170 ctermbg=NONE cterm=NONE
hi jsClassMethodType guifg=#bb70d2 guibg=NONE guisp=NONE gui=NONE ctermfg=170 ctermbg=NONE cterm=NONE
hi jsDocParam guifg=#57a5e5 guibg=NONE guisp=NONE gui=NONE ctermfg=39 ctermbg=NONE cterm=NONE
hi jsDocTags guifg=#bb70d2 guibg=NONE guisp=NONE gui=NONE ctermfg=170 ctermbg=NONE cterm=NONE
hi jsExport guifg=#bb70d2 guibg=NONE guisp=NONE gui=NONE ctermfg=170 ctermbg=NONE cterm=NONE
hi jsExportDefault guifg=#bb70d2 guibg=NONE guisp=NONE gui=NONE ctermfg=170 ctermbg=NONE cterm=NONE
hi jsExtendsKeyword guifg=#bb70d2 guibg=NONE guisp=NONE gui=NONE ctermfg=170 ctermbg=NONE cterm=NONE
hi jsFrom guifg=#bb70d2 guibg=NONE guisp=NONE gui=NONE ctermfg=170 ctermbg=NONE cterm=NONE
hi jsFuncCall guifg=#57a5e5 guibg=NONE guisp=NONE gui=NONE ctermfg=39 ctermbg=NONE cterm=NONE
hi jsFunction guifg=#bb70d2 guibg=NONE guisp=NONE gui=NONE ctermfg=170 ctermbg=NONE cterm=NONE
hi jsGenerator guifg=#dbb671 guibg=NONE guisp=NONE gui=NONE ctermfg=180 ctermbg=NONE cterm=NONE
hi jsGlobalObjects guifg=#dbb671 guibg=NONE guisp=NONE gui=NONE ctermfg=180 ctermbg=NONE cterm=NONE
hi jsImport guifg=#bb70d2 guibg=NONE guisp=NONE gui=NONE ctermfg=170 ctermbg=NONE cterm=NONE
hi jsModuleAs guifg=#bb70d2 guibg=NONE guisp=NONE gui=NONE ctermfg=170 ctermbg=NONE cterm=NONE
hi jsModuleWords guifg=#bb70d2 guibg=NONE guisp=NONE gui=NONE ctermfg=170 ctermbg=NONE cterm=NONE
hi jsModules guifg=#bb70d2 guibg=NONE guisp=NONE gui=NONE ctermfg=170 ctermbg=NONE cterm=NONE
hi jsNull guifg=#c49060 guibg=NONE guisp=NONE gui=NONE ctermfg=173 ctermbg=NONE cterm=NONE
hi jsOperator guifg=#bb70d2 guibg=NONE guisp=NONE gui=NONE ctermfg=170 ctermbg=NONE cterm=NONE
hi jsStorageClass guifg=#bb70d2 guibg=NONE guisp=NONE gui=NONE ctermfg=170 ctermbg=NONE cterm=NONE
hi jsSuper guifg=#de5d68 guibg=NONE guisp=NONE gui=NONE ctermfg=204 ctermbg=NONE cterm=NONE
hi jsTemplateBraces guifg=#833b3b guibg=NONE guisp=NONE gui=NONE ctermfg=196 ctermbg=NONE cterm=NONE
hi jsTemplateVar guifg=#8fb573 guibg=NONE guisp=NONE gui=NONE ctermfg=114 ctermbg=NONE cterm=NONE
hi jsThis guifg=#de5d68 guibg=NONE guisp=NONE gui=NONE ctermfg=204 ctermbg=NONE cterm=NONE
hi jsUndefined guifg=#c49060 guibg=NONE guisp=NONE gui=NONE ctermfg=173 ctermbg=NONE cterm=NONE
hi javascriptArrowFunc guifg=#bb70d2 guibg=NONE guisp=NONE gui=NONE ctermfg=170 ctermbg=NONE cterm=NONE
hi javascriptClassExtends guifg=#bb70d2 guibg=NONE guisp=NONE gui=NONE ctermfg=170 ctermbg=NONE cterm=NONE
hi javascriptClassKeyword guifg=#bb70d2 guibg=NONE guisp=NONE gui=NONE ctermfg=170 ctermbg=NONE cterm=NONE
hi javascriptDocNotation guifg=#bb70d2 guibg=NONE guisp=NONE gui=NONE ctermfg=170 ctermbg=NONE cterm=NONE
hi javascriptDocParamName guifg=#57a5e5 guibg=NONE guisp=NONE gui=NONE ctermfg=39 ctermbg=NONE cterm=NONE
hi javascriptDocTags guifg=#bb70d2 guibg=NONE guisp=NONE gui=NONE ctermfg=170 ctermbg=NONE cterm=NONE
hi javascriptEndColons guifg=#a7aab0 guibg=NONE guisp=NONE gui=NONE ctermfg=145 ctermbg=NONE cterm=NONE
hi javascriptExport guifg=#bb70d2 guibg=NONE guisp=NONE gui=NONE ctermfg=170 ctermbg=NONE cterm=NONE
hi javascriptFuncArg guifg=#a7aab0 guibg=NONE guisp=NONE gui=NONE ctermfg=145 ctermbg=NONE cterm=NONE
hi javascriptFuncKeyword guifg=#bb70d2 guibg=NONE guisp=NONE gui=NONE ctermfg=170 ctermbg=NONE cterm=NONE
hi javascriptIdentifier guifg=#de5d68 guibg=NONE guisp=NONE gui=NONE ctermfg=204 ctermbg=NONE cterm=NONE
hi javascriptImport guifg=#bb70d2 guibg=NONE guisp=NONE gui=NONE ctermfg=170 ctermbg=NONE cterm=NONE
hi javascriptMethodName guifg=#a7aab0 guibg=NONE guisp=NONE gui=NONE ctermfg=145 ctermbg=NONE cterm=NONE
hi javascriptObjectLabel guifg=#a7aab0 guibg=NONE guisp=NONE gui=NONE ctermfg=145 ctermbg=NONE cterm=NONE
hi javascriptOpSymbol guifg=#51a8b3 guibg=NONE guisp=NONE gui=NONE ctermfg=38 ctermbg=NONE cterm=NONE
hi javascriptOpSymbols guifg=#51a8b3 guibg=NONE guisp=NONE gui=NONE ctermfg=38 ctermbg=NONE cterm=NONE
hi javascriptPropertyName guifg=#8fb573 guibg=NONE guisp=NONE gui=NONE ctermfg=114 ctermbg=NONE cterm=NONE
hi javascriptTemplateSB guifg=#833b3b guibg=NONE guisp=NONE gui=NONE ctermfg=196 ctermbg=NONE cterm=NONE
hi javascriptVariable guifg=#bb70d2 guibg=NONE guisp=NONE gui=NONE ctermfg=170 ctermbg=NONE cterm=NONE
hi jsonCommentError guifg=#a7aab0 guibg=NONE guisp=NONE gui=NONE ctermfg=145 ctermbg=NONE cterm=NONE
hi jsonKeyword guifg=#de5d68 guibg=NONE guisp=NONE gui=NONE ctermfg=204 ctermbg=NONE cterm=NONE
hi jsonBoolean guifg=#c49060 guibg=NONE guisp=NONE gui=NONE ctermfg=173 ctermbg=NONE cterm=NONE
hi jsonNumber guifg=#c49060 guibg=NONE guisp=NONE gui=NONE ctermfg=173 ctermbg=NONE cterm=NONE
hi jsonQuote guifg=#a7aab0 guibg=NONE guisp=NONE gui=NONE ctermfg=145 ctermbg=NONE cterm=NONE
hi jsonMissingCommaError guifg=#de5d68 guibg=NONE guisp=NONE gui=NONE ctermfg=204 ctermbg=NONE cterm=NONE
hi jsonNoQuotesError guifg=#de5d68 guibg=NONE guisp=NONE gui=NONE ctermfg=204 ctermbg=NONE cterm=NONE
hi jsonNumError guifg=#de5d68 guibg=NONE guisp=NONE gui=NONE ctermfg=204 ctermbg=NONE cterm=NONE
hi jsonString guifg=#8fb573 guibg=NONE guisp=NONE gui=NONE ctermfg=114 ctermbg=NONE cterm=NONE
hi jsonStringSQError guifg=#de5d68 guibg=NONE guisp=NONE gui=NONE ctermfg=204 ctermbg=NONE cterm=NONE
hi jsonSemicolonError guifg=#de5d68 guibg=NONE guisp=NONE gui=NONE ctermfg=204 ctermbg=NONE cterm=NONE
hi lessVariable guifg=#bb70d2 guibg=NONE guisp=NONE gui=NONE ctermfg=170 ctermbg=NONE cterm=NONE
hi lessAmpersandChar guifg=#a7aab0 guibg=NONE guisp=NONE gui=NONE ctermfg=145 ctermbg=NONE cterm=NONE
hi lessClass guifg=#c49060 guibg=NONE guisp=NONE gui=NONE ctermfg=173 ctermbg=NONE cterm=NONE
hi markdownBlockquote guifg=#5a5b5e guibg=NONE guisp=NONE gui=NONE ctermfg=59 ctermbg=NONE cterm=NONE
hi markdownBold guifg=#c49060 guibg=NONE guisp=NONE gui=NONE ctermfg=173 ctermbg=NONE cterm=NONE
hi markdownBoldItalic guifg=#8fb573 guibg=NONE guisp=NONE gui=NONE ctermfg=114 ctermbg=NONE cterm=NONE
hi markdownCode guifg=#8fb573 guibg=NONE guisp=NONE gui=NONE ctermfg=114 ctermbg=NONE cterm=NONE
hi markdownCodeBlock guifg=#8fb573 guibg=NONE guisp=NONE gui=NONE ctermfg=114 ctermbg=NONE cterm=NONE
hi markdownCodeDelimiter guifg=#8fb573 guibg=NONE guisp=NONE gui=NONE ctermfg=114 ctermbg=NONE cterm=NONE
hi markdownH1 guifg=#de5d68 guibg=NONE guisp=NONE gui=NONE ctermfg=204 ctermbg=NONE cterm=NONE
hi markdownH2 guifg=#de5d68 guibg=NONE guisp=NONE gui=NONE ctermfg=204 ctermbg=NONE cterm=NONE
hi markdownH3 guifg=#de5d68 guibg=NONE guisp=NONE gui=NONE ctermfg=204 ctermbg=NONE cterm=NONE
hi markdownH4 guifg=#de5d68 guibg=NONE guisp=NONE gui=NONE ctermfg=204 ctermbg=NONE cterm=NONE
hi markdownH5 guifg=#de5d68 guibg=NONE guisp=NONE gui=NONE ctermfg=204 ctermbg=NONE cterm=NONE
hi markdownH6 guifg=#de5d68 guibg=NONE guisp=NONE gui=NONE ctermfg=204 ctermbg=NONE cterm=NONE
hi markdownHeadingDelimiter guifg=#de5d68 guibg=NONE guisp=NONE gui=NONE ctermfg=204 ctermbg=NONE cterm=NONE
hi markdownHeadingRule guifg=#5a5b5e guibg=NONE guisp=NONE gui=NONE ctermfg=59 ctermbg=NONE cterm=NONE
hi markdownId guifg=#bb70d2 guibg=NONE guisp=NONE gui=NONE ctermfg=170 ctermbg=NONE cterm=NONE
hi markdownIdDeclaration guifg=#57a5e5 guibg=NONE guisp=NONE gui=NONE ctermfg=39 ctermbg=NONE cterm=NONE
hi markdownIdDelimiter guifg=#bb70d2 guibg=NONE guisp=NONE gui=NONE ctermfg=170 ctermbg=NONE cterm=NONE
hi markdownItalic guifg=#bb70d2 guibg=NONE guisp=NONE gui=NONE ctermfg=170 ctermbg=NONE cterm=NONE
hi markdownLinkDelimiter guifg=#bb70d2 guibg=NONE guisp=NONE gui=NONE ctermfg=170 ctermbg=NONE cterm=NONE
hi markdownLinkText guifg=#57a5e5 guibg=NONE guisp=NONE gui=NONE ctermfg=39 ctermbg=NONE cterm=NONE
hi markdownListMarker guifg=#de5d68 guibg=NONE guisp=NONE gui=NONE ctermfg=204 ctermbg=NONE cterm=NONE
hi markdownOrderedListMarker guifg=#de5d68 guibg=NONE guisp=NONE gui=NONE ctermfg=204 ctermbg=NONE cterm=NONE
hi markdownRule guifg=#5a5b5e guibg=NONE guisp=NONE gui=NONE ctermfg=59 ctermbg=NONE cterm=NONE
hi markdownUrl guifg=#51a8b3 guibg=NONE guisp=NONE gui=NONE ctermfg=38 ctermbg=NONE cterm=NONE
hi perlFiledescRead guifg=#8fb573 guibg=NONE guisp=NONE gui=NONE ctermfg=114 ctermbg=NONE cterm=NONE
hi perlFunction guifg=#bb70d2 guibg=NONE guisp=NONE gui=NONE ctermfg=170 ctermbg=NONE cterm=NONE
hi perlMatchStartEnd guifg=#57a5e5 guibg=NONE guisp=NONE gui=NONE ctermfg=39 ctermbg=NONE cterm=NONE
hi perlMethod guifg=#bb70d2 guibg=NONE guisp=NONE gui=NONE ctermfg=170 ctermbg=NONE cterm=NONE
hi perlPOD guifg=#5a5b5e guibg=NONE guisp=NONE gui=NONE ctermfg=59 ctermbg=NONE cterm=NONE
hi perlSharpBang guifg=#5a5b5e guibg=NONE guisp=NONE gui=NONE ctermfg=59 ctermbg=NONE cterm=NONE
hi perlSpecialString guifg=#c49060 guibg=NONE guisp=NONE gui=NONE ctermfg=173 ctermbg=NONE cterm=NONE
hi perlStatementFiledesc guifg=#de5d68 guibg=NONE guisp=NONE gui=NONE ctermfg=204 ctermbg=NONE cterm=NONE
hi perlStatementFlow guifg=#de5d68 guibg=NONE guisp=NONE gui=NONE ctermfg=204 ctermbg=NONE cterm=NONE
hi perlStatementInclude guifg=#bb70d2 guibg=NONE guisp=NONE gui=NONE ctermfg=170 ctermbg=NONE cterm=NONE
hi perlStatementScalar guifg=#bb70d2 guibg=NONE guisp=NONE gui=NONE ctermfg=170 ctermbg=NONE cterm=NONE
hi perlStatementStorage guifg=#bb70d2 guibg=NONE guisp=NONE gui=NONE ctermfg=170 ctermbg=NONE cterm=NONE
hi perlSubName guifg=#dbb671 guibg=NONE guisp=NONE gui=NONE ctermfg=180 ctermbg=NONE cterm=NONE
hi perlVarPlain guifg=#57a5e5 guibg=NONE guisp=NONE gui=NONE ctermfg=39 ctermbg=NONE cterm=NONE
hi phpVarSelector guifg=#de5d68 guibg=NONE guisp=NONE gui=NONE ctermfg=204 ctermbg=NONE cterm=NONE
hi phpOperator guifg=#a7aab0 guibg=NONE guisp=NONE gui=NONE ctermfg=145 ctermbg=NONE cterm=NONE
hi phpParent guifg=#a7aab0 guibg=NONE guisp=NONE gui=NONE ctermfg=145 ctermbg=NONE cterm=NONE
hi phpMemberSelector guifg=#a7aab0 guibg=NONE guisp=NONE gui=NONE ctermfg=145 ctermbg=NONE cterm=NONE
hi phpType guifg=#bb70d2 guibg=NONE guisp=NONE gui=NONE ctermfg=170 ctermbg=NONE cterm=NONE
hi phpKeyword guifg=#bb70d2 guibg=NONE guisp=NONE gui=NONE ctermfg=170 ctermbg=NONE cterm=NONE
hi phpClass guifg=#dbb671 guibg=NONE guisp=NONE gui=NONE ctermfg=180 ctermbg=NONE cterm=NONE
hi phpUseClass guifg=#a7aab0 guibg=NONE guisp=NONE gui=NONE ctermfg=145 ctermbg=NONE cterm=NONE
hi phpUseAlias guifg=#a7aab0 guibg=NONE guisp=NONE gui=NONE ctermfg=145 ctermbg=NONE cterm=NONE
hi phpInclude guifg=#bb70d2 guibg=NONE guisp=NONE gui=NONE ctermfg=170 ctermbg=NONE cterm=NONE
hi phpClassExtends guifg=#8fb573 guibg=NONE guisp=NONE gui=NONE ctermfg=114 ctermbg=NONE cterm=NONE
hi phpDocTags guifg=#a7aab0 guibg=NONE guisp=NONE gui=NONE ctermfg=145 ctermbg=NONE cterm=NONE
hi phpFunction guifg=#57a5e5 guibg=NONE guisp=NONE gui=NONE ctermfg=39 ctermbg=NONE cterm=NONE
hi phpFunctions guifg=#51a8b3 guibg=NONE guisp=NONE gui=NONE ctermfg=38 ctermbg=NONE cterm=NONE
hi phpMethodsVar guifg=#c49060 guibg=NONE guisp=NONE gui=NONE ctermfg=173 ctermbg=NONE cterm=NONE
hi phpMagicConstants guifg=#c49060 guibg=NONE guisp=NONE gui=NONE ctermfg=173 ctermbg=NONE cterm=NONE
hi phpSuperglobals guifg=#de5d68 guibg=NONE guisp=NONE gui=NONE ctermfg=204 ctermbg=NONE cterm=NONE
hi phpConstants guifg=#c49060 guibg=NONE guisp=NONE gui=NONE ctermfg=173 ctermbg=NONE cterm=NONE
hi rubyBlockParameter guifg=#de5d68 guibg=NONE guisp=NONE gui=NONE ctermfg=204 ctermbg=NONE cterm=NONE
hi rubyBlockParameterList guifg=#de5d68 guibg=NONE guisp=NONE gui=NONE ctermfg=204 ctermbg=NONE cterm=NONE
hi rubyClass guifg=#bb70d2 guibg=NONE guisp=NONE gui=NONE ctermfg=170 ctermbg=NONE cterm=NONE
hi rubyConstant guifg=#dbb671 guibg=NONE guisp=NONE gui=NONE ctermfg=180 ctermbg=NONE cterm=NONE
hi rubyControl guifg=#bb70d2 guibg=NONE guisp=NONE gui=NONE ctermfg=170 ctermbg=NONE cterm=NONE
hi rubyEscape guifg=#de5d68 guibg=NONE guisp=NONE gui=NONE ctermfg=204 ctermbg=NONE cterm=NONE
hi rubyFunction guifg=#57a5e5 guibg=NONE guisp=NONE gui=NONE ctermfg=39 ctermbg=NONE cterm=NONE
hi rubyGlobalVariable guifg=#de5d68 guibg=NONE guisp=NONE gui=NONE ctermfg=204 ctermbg=NONE cterm=NONE
hi rubyInclude guifg=#57a5e5 guibg=NONE guisp=NONE gui=NONE ctermfg=39 ctermbg=NONE cterm=NONE
hi rubyIncluderubyGlobalVariable guifg=#de5d68 guibg=NONE guisp=NONE gui=NONE ctermfg=204 ctermbg=NONE cterm=NONE
hi rubyInstanceVariable guifg=#de5d68 guibg=NONE guisp=NONE gui=NONE ctermfg=204 ctermbg=NONE cterm=NONE
hi rubyInterpolation guifg=#51a8b3 guibg=NONE guisp=NONE gui=NONE ctermfg=38 ctermbg=NONE cterm=NONE
hi rubyInterpolationDelimiter guifg=#de5d68 guibg=NONE guisp=NONE gui=NONE ctermfg=204 ctermbg=NONE cterm=NONE
hi rubyInterpolationDelimiter guifg=#de5d68 guibg=NONE guisp=NONE gui=NONE ctermfg=204 ctermbg=NONE cterm=NONE
hi rubyRegexp guifg=#51a8b3 guibg=NONE guisp=NONE gui=NONE ctermfg=38 ctermbg=NONE cterm=NONE
hi rubyRegexpDelimiter guifg=#51a8b3 guibg=NONE guisp=NONE gui=NONE ctermfg=38 ctermbg=NONE cterm=NONE
hi rubyStringDelimiter guifg=#8fb573 guibg=NONE guisp=NONE gui=NONE ctermfg=114 ctermbg=NONE cterm=NONE
hi rubySymbol guifg=#51a8b3 guibg=NONE guisp=NONE gui=NONE ctermfg=38 ctermbg=NONE cterm=NONE
hi sassAmpersand guifg=#de5d68 guibg=NONE guisp=NONE gui=NONE ctermfg=204 ctermbg=NONE cterm=NONE
hi sassClass guifg=#c49060 guibg=NONE guisp=NONE gui=NONE ctermfg=173 ctermbg=NONE cterm=NONE
hi sassControl guifg=#bb70d2 guibg=NONE guisp=NONE gui=NONE ctermfg=170 ctermbg=NONE cterm=NONE
hi sassExtend guifg=#bb70d2 guibg=NONE guisp=NONE gui=NONE ctermfg=170 ctermbg=NONE cterm=NONE
hi sassFor guifg=#a7aab0 guibg=NONE guisp=NONE gui=NONE ctermfg=145 ctermbg=NONE cterm=NONE
hi sassFunction guifg=#51a8b3 guibg=NONE guisp=NONE gui=NONE ctermfg=38 ctermbg=NONE cterm=NONE
hi sassId guifg=#57a5e5 guibg=NONE guisp=NONE gui=NONE ctermfg=39 ctermbg=NONE cterm=NONE
hi sassInclude guifg=#bb70d2 guibg=NONE guisp=NONE gui=NONE ctermfg=170 ctermbg=NONE cterm=NONE
hi sassMedia guifg=#bb70d2 guibg=NONE guisp=NONE gui=NONE ctermfg=170 ctermbg=NONE cterm=NONE
hi sassMediaOperators guifg=#a7aab0 guibg=NONE guisp=NONE gui=NONE ctermfg=145 ctermbg=NONE cterm=NONE
hi sassMixin guifg=#bb70d2 guibg=NONE guisp=NONE gui=NONE ctermfg=170 ctermbg=NONE cterm=NONE
hi sassMixinName guifg=#57a5e5 guibg=NONE guisp=NONE gui=NONE ctermfg=39 ctermbg=NONE cterm=NONE
hi sassMixing guifg=#bb70d2 guibg=NONE guisp=NONE gui=NONE ctermfg=170 ctermbg=NONE cterm=NONE
hi sassVariable guifg=#bb70d2 guibg=NONE guisp=NONE gui=NONE ctermfg=170 ctermbg=NONE cterm=NONE
hi scssExtend guifg=#bb70d2 guibg=NONE guisp=NONE gui=NONE ctermfg=170 ctermbg=NONE cterm=NONE
hi scssImport guifg=#bb70d2 guibg=NONE guisp=NONE gui=NONE ctermfg=170 ctermbg=NONE cterm=NONE
hi scssInclude guifg=#bb70d2 guibg=NONE guisp=NONE gui=NONE ctermfg=170 ctermbg=NONE cterm=NONE
hi scssMixin guifg=#bb70d2 guibg=NONE guisp=NONE gui=NONE ctermfg=170 ctermbg=NONE cterm=NONE
hi scssSelectorName guifg=#c49060 guibg=NONE guisp=NONE gui=NONE ctermfg=173 ctermbg=NONE cterm=NONE
hi scssVariable guifg=#bb70d2 guibg=NONE guisp=NONE gui=NONE ctermfg=170 ctermbg=NONE cterm=NONE
hi texStatement guifg=#bb70d2 guibg=NONE guisp=NONE gui=NONE ctermfg=170 ctermbg=NONE cterm=NONE
hi texSubscripts guifg=#c49060 guibg=NONE guisp=NONE gui=NONE ctermfg=173 ctermbg=NONE cterm=NONE
hi texSuperscripts guifg=#c49060 guibg=NONE guisp=NONE gui=NONE ctermfg=173 ctermbg=NONE cterm=NONE
hi texTodo guifg=#833b3b guibg=NONE guisp=NONE gui=NONE ctermfg=196 ctermbg=NONE cterm=NONE
hi texBeginEnd guifg=#bb70d2 guibg=NONE guisp=NONE gui=NONE ctermfg=170 ctermbg=NONE cterm=NONE
hi texBeginEndName guifg=#57a5e5 guibg=NONE guisp=NONE gui=NONE ctermfg=39 ctermbg=NONE cterm=NONE
hi texMathMatcher guifg=#57a5e5 guibg=NONE guisp=NONE gui=NONE ctermfg=39 ctermbg=NONE cterm=NONE
hi texMathDelim guifg=#57a5e5 guibg=NONE guisp=NONE gui=NONE ctermfg=39 ctermbg=NONE cterm=NONE
hi texDelimiter guifg=#c49060 guibg=NONE guisp=NONE gui=NONE ctermfg=173 ctermbg=NONE cterm=NONE
hi texSpecialChar guifg=#c49060 guibg=NONE guisp=NONE gui=NONE ctermfg=173 ctermbg=NONE cterm=NONE
hi texCite guifg=#57a5e5 guibg=NONE guisp=NONE gui=NONE ctermfg=39 ctermbg=NONE cterm=NONE
hi texRefZone guifg=#57a5e5 guibg=NONE guisp=NONE gui=NONE ctermfg=39 ctermbg=NONE cterm=NONE
hi typescriptReserved guifg=#bb70d2 guibg=NONE guisp=NONE gui=NONE ctermfg=170 ctermbg=NONE cterm=NONE
hi typescriptEndColons guifg=#a7aab0 guibg=NONE guisp=NONE gui=NONE ctermfg=145 ctermbg=NONE cterm=NONE
hi typescriptBraces guifg=#a7aab0 guibg=NONE guisp=NONE gui=NONE ctermfg=145 ctermbg=NONE cterm=NONE
hi xmlAttrib guifg=#c49060 guibg=NONE guisp=NONE gui=NONE ctermfg=173 ctermbg=NONE cterm=NONE
hi xmlEndTag guifg=#de5d68 guibg=NONE guisp=NONE gui=NONE ctermfg=204 ctermbg=NONE cterm=NONE
hi xmlTag guifg=#de5d68 guibg=NONE guisp=NONE gui=NONE ctermfg=204 ctermbg=NONE cterm=NONE
hi xmlTagName guifg=#de5d68 guibg=NONE guisp=NONE gui=NONE ctermfg=204 ctermbg=NONE cterm=NONE
hi GitGutterAdd guifg=#8fb573 guibg=NONE guisp=NONE gui=NONE ctermfg=114 ctermbg=NONE cterm=NONE
hi GitGutterChange guifg=#dbb671 guibg=NONE guisp=NONE gui=NONE ctermfg=180 ctermbg=NONE cterm=NONE
hi GitGutterDelete guifg=#de5d68 guibg=NONE guisp=NONE gui=NONE ctermfg=204 ctermbg=NONE cterm=NONE
hi ALEError guifg=#de5d68 guibg=NONE guisp=NONE gui=NONE ctermfg=204 ctermbg=NONE cterm=NONE
hi ALEWarning guifg=#dbb671 guibg=NONE guisp=NONE gui=NONE ctermfg=180 ctermbg=NONE cterm=NONE
hi ALEInfo guifg=NONE guibg=NONE guisp=NONE gui=NONE ctermfg=NONE ctermbg=NONE cterm=NONE
hi ALEErrorSign guifg=#de5d68 guibg=NONE guisp=NONE gui=NONE ctermfg=204 ctermbg=NONE cterm=NONE
hi ALEWarningSign guifg=#dbb671 guibg=NONE guisp=NONE gui=NONE ctermfg=180 ctermbg=NONE cterm=NONE
hi ALEInfoSign guifg=NONE guibg=NONE guisp=NONE gui=NONE ctermfg=NONE ctermbg=NONE cterm=NONE
hi EasyMotionTarget guifg=#de5d68 guibg=NONE guisp=NONE gui=NONE ctermfg=204 ctermbg=NONE cterm=NONE
hi EasyMotionTarget2First guifg=#dbb671 guibg=NONE guisp=NONE gui=NONE ctermfg=180 ctermbg=NONE cterm=NONE
hi EasyMotionTarget2Second guifg=#c49060 guibg=NONE guisp=NONE gui=NONE ctermfg=173 ctermbg=NONE cterm=NONE
hi EasyMotionShade guifg=#5a5b5e guibg=NONE guisp=NONE gui=NONE ctermfg=59 ctermbg=NONE cterm=NONE
hi CocErrorSign guifg=#de5d68 guibg=NONE guisp=NONE gui=NONE ctermfg=204 ctermbg=NONE cterm=NONE
hi CocWarningSign guifg=#dbb671 guibg=NONE guisp=NONE gui=NONE ctermfg=180 ctermbg=NONE cterm=NONE
hi CocInfoSign guifg=#57a5e5 guibg=NONE guisp=NONE gui=NONE ctermfg=39 ctermbg=NONE cterm=NONE
hi CocHintSign guifg=#51a8b3 guibg=NONE guisp=NONE gui=NONE ctermfg=38 ctermbg=NONE cterm=NONE
hi CocFadeOut guifg=#5a5b5e guibg=NONE guisp=NONE gui=NONE ctermfg=59 ctermbg=NONE cterm=NONE
hi NeomakeErrorSign guifg=#de5d68 guibg=NONE guisp=NONE gui=NONE ctermfg=204 ctermbg=NONE cterm=NONE
hi NeomakeWarningSign guifg=#dbb671 guibg=NONE guisp=NONE gui=NONE ctermfg=180 ctermbg=NONE cterm=NONE
hi NeomakeInfoSign guifg=#57a5e5 guibg=NONE guisp=NONE gui=NONE ctermfg=39 ctermbg=NONE cterm=NONE
hi mkdDelimiter guifg=#bb70d2 guibg=NONE guisp=NONE gui=NONE ctermfg=170 ctermbg=NONE cterm=NONE
hi mkdHeading guifg=#de5d68 guibg=NONE guisp=NONE gui=NONE ctermfg=204 ctermbg=NONE cterm=NONE
hi mkdLink guifg=#57a5e5 guibg=NONE guisp=NONE gui=NONE ctermfg=39 ctermbg=NONE cterm=NONE
hi mkdURL guifg=#51a8b3 guibg=NONE guisp=NONE gui=NONE ctermfg=38 ctermbg=NONE cterm=NONE
hi LspErrorText guifg=#de5d68 guibg=NONE guisp=NONE gui=NONE ctermfg=204 ctermbg=NONE cterm=NONE
hi LspWarningText guifg=#dbb671 guibg=NONE guisp=NONE gui=NONE ctermfg=180 ctermbg=NONE cterm=NONE
hi LspInformationText guifg=#57a5e5 guibg=NONE guisp=NONE gui=NONE ctermfg=39 ctermbg=NONE cterm=NONE
hi LspHintText guifg=#51a8b3 guibg=NONE guisp=NONE gui=NONE ctermfg=38 ctermbg=NONE cterm=NONE
hi LspErrorHighlight guifg=#de5d68 guibg=NONE guisp=NONE gui=NONE ctermfg=204 ctermbg=NONE cterm=NONE
hi LspWarningHighlight guifg=#dbb671 guibg=NONE guisp=NONE gui=NONE ctermfg=180 ctermbg=NONE cterm=NONE
hi LspInformationHighlight guifg=#57a5e5 guibg=NONE guisp=NONE gui=NONE ctermfg=39 ctermbg=NONE cterm=NONE
hi LspHintHighlight guifg=#51a8b3 guibg=NONE guisp=NONE gui=NONE ctermfg=38 ctermbg=NONE cterm=NONE
hi diffAdded guifg=#8fb573 guibg=NONE guisp=NONE gui=NONE ctermfg=114 ctermbg=NONE cterm=NONE
hi diffRemoved guifg=#de5d68 guibg=NONE guisp=NONE gui=NONE ctermfg=204 ctermbg=NONE cterm=NONE
hi gitcommitComment guifg=#5a5b5e guibg=NONE guisp=NONE gui=NONE ctermfg=59 ctermbg=NONE cterm=NONE
hi gitcommitUnmerged guifg=#8fb573 guibg=NONE guisp=NONE gui=NONE ctermfg=114 ctermbg=NONE cterm=NONE
hi gitcommitOnBranch guifg=NONE guibg=NONE guisp=NONE gui=NONE ctermfg=NONE ctermbg=NONE cterm=NONE
hi gitcommitBranch guifg=#bb70d2 guibg=NONE guisp=NONE gui=NONE ctermfg=170 ctermbg=NONE cterm=NONE
hi gitcommitDiscardedType guifg=#de5d68 guibg=NONE guisp=NONE gui=NONE ctermfg=204 ctermbg=NONE cterm=NONE
hi gitcommitSelectedType guifg=#8fb573 guibg=NONE guisp=NONE gui=NONE ctermfg=114 ctermbg=NONE cterm=NONE
hi gitcommitHeader guifg=NONE guibg=NONE guisp=NONE gui=NONE ctermfg=NONE ctermbg=NONE cterm=NONE
hi gitcommitUntrackedFile guifg=#51a8b3 guibg=NONE guisp=NONE gui=NONE ctermfg=38 ctermbg=NONE cterm=NONE
hi gitcommitDiscardedFile guifg=#de5d68 guibg=NONE guisp=NONE gui=NONE ctermfg=204 ctermbg=NONE cterm=NONE
hi gitcommitSelectedFile guifg=#8fb573 guibg=NONE guisp=NONE gui=NONE ctermfg=114 ctermbg=NONE cterm=NONE
hi gitcommitUnmergedFile guifg=#dbb671 guibg=NONE guisp=NONE gui=NONE ctermfg=180 ctermbg=NONE cterm=NONE
hi gitcommitFile guifg=NONE guibg=NONE guisp=NONE gui=NONE ctermfg=NONE ctermbg=NONE cterm=NONE
hi gitcommitSummary guifg=#a7aab0 guibg=NONE guisp=NONE gui=NONE ctermfg=145 ctermbg=NONE cterm=NONE
hi gitcommitOverflow guifg=#de5d68 guibg=NONE guisp=NONE gui=NONE ctermfg=204 ctermbg=NONE cterm=NONE

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
    '#232326', '#de5d68', '#8fb573', '#dbb671',
    '#57a5e5', '#bb70d2', '#51a8b3', '#818387',
    '#5a5b5e', '#de5d68', '#8fb573', '#dbb671',
    '#57a5e5', '#bb70d2', '#51a8b3', '#a7aab0'
]

# ============================================================
#  SupraWarmer — overrides
# ============================================================
# Comments
hi Comment        guifg=#5a5b5e guibg=NONE gui=NONE cterm=NONE
hi SpecialComment guifg=#5a5b5e guibg=NONE gui=NONE cterm=NONE
hi Folded         guifg=#5a5b5e guibg=#1b1c1e gui=NONE cterm=NONE

# Cursor / current line
hi CursorLine     guibg=#2c2d31 gui=NONE cterm=NONE
hi CursorColumn   guibg=#2c2d31
hi ColorColumn    guibg=#2c2d31
hi CursorLineNr   guifg=#dbb671 guibg=NONE gui=NONE cterm=NONE
hi LineNr         guifg=#505054 guibg=NONE

# Matching paren
hi MatchParen     guifg=#51a8b3 guibg=#37383d gui=NONE cterm=NONE

# Visual selection
hi Visual         guibg=#2f373f
hi VisualNOS      guibg=#2f373f

# Search
hi Search         guifg=#232326 guibg=#dbb671 gui=NONE cterm=NONE
hi IncSearch      guifg=#232326 guibg=#c49060 gui=NONE cterm=NONE

# Completion menu
hi Pmenu          guifg=#a7aab0 guibg=#2c2d31
hi PmenuSel       guifg=#232326 guibg=#57a5e5 gui=NONE cterm=NONE
hi PmenuSbar      guibg=#1b1c1e
hi PmenuThumb     guibg=#505054

# Splits / statusline
hi VertSplit      guifg=#37383d guibg=NONE
hi WinSeparator   guifg=#37383d guibg=NONE
hi StatusLine     guifg=#a7aab0 guibg=#2c2d31 gui=NONE cterm=NONE
hi StatusLineNC   guifg=#5a5b5e guibg=#1b1c1e gui=NONE cterm=NONE

# Spell
hi SpellBad       guifg=NONE guisp=#de5d68 gui=NONE cterm=NONE
hi SpellCap       guifg=NONE guisp=#dbb671 gui=NONE cterm=NONE
hi SpellRare      guifg=NONE guisp=#51a8b3 gui=NONE cterm=NONE
hi SpellLocal     guifg=NONE guisp=#8fb573 gui=NONE cterm=NONE

# Diff
hi DiffAdd        guifg=NONE guibg=#282b26
hi DiffDelete     guifg=NONE guibg=#2a2626
hi DiffChange     guifg=NONE guibg=#1a2a37
hi DiffText       guifg=NONE guibg=#2c485f

# Titles / links
hi Title          guifg=#8fb573 gui=NONE cterm=NONE
hi Underlined     guifg=#57a5e5 gui=NONE cterm=NONE
hi Directory      guifg=#57a5e5 gui=NONE cterm=NONE

# SignColumn without border
hi! link SignColumn Normal
hi! link EndOfBuffer Normal
