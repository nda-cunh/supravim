vim9script
# supra-gui: background=#323237 include=#e88ae8 stdio=#f2a0a0 typedef=#7ce08a struct=#7ce08a type_s=#dcdfe8 scope=#eceef5 float=#7ce08a function=#dcdfe8 format=#f2b45f text=#f2a0a0 integer=#f2b45f

hi clear

if exists("syntax_on")
  syntax reset
endif

set t_Co=256

g:colors_name = "supraevening"

if !exists("g:supraevening_termcolors")
	g:supraevening_termcolors = 256
endif

if !exists("g:supraevening_terminal_italics")
	g:supraevening_terminal_italics = 0
endif

hi Comment guifg=#7183bd guibg=NONE guisp=NONE gui=NONE ctermfg=67 ctermbg=NONE cterm=NONE
hi Constant guifg=#f2a0a0 guibg=NONE guisp=NONE gui=NONE ctermfg=217 ctermbg=NONE cterm=NONE
hi String guifg=#f2a0a0 guibg=NONE guisp=NONE gui=NONE ctermfg=217 ctermbg=NONE cterm=NONE
hi Character guifg=#f2a0a0 guibg=NONE guisp=NONE gui=NONE ctermfg=217 ctermbg=NONE cterm=NONE
hi Number guifg=#f2b45f guibg=NONE guisp=NONE gui=NONE ctermfg=215 ctermbg=NONE cterm=NONE
hi Boolean guifg=#f2b45f guibg=NONE guisp=NONE gui=NONE ctermfg=215 ctermbg=NONE cterm=NONE
hi Float guifg=#f2b45f guibg=NONE guisp=NONE gui=NONE ctermfg=215 ctermbg=NONE cterm=NONE
hi Identifier guifg=#5ad4e6 guibg=NONE guisp=NONE gui=NONE ctermfg=80 ctermbg=NONE cterm=NONE
hi Function guifg=#80a0ff guibg=NONE guisp=NONE gui=NONE ctermfg=111 ctermbg=NONE cterm=NONE
hi Statement guifg=#f2e86e guibg=NONE guisp=NONE gui=NONE ctermfg=221 ctermbg=NONE cterm=NONE
hi Conditional guifg=#f2e86e guibg=NONE guisp=NONE gui=NONE ctermfg=221 ctermbg=NONE cterm=NONE
hi Repeat guifg=#f2e86e guibg=NONE guisp=NONE gui=NONE ctermfg=221 ctermbg=NONE cterm=NONE
hi Label guifg=#f2e86e guibg=NONE guisp=NONE gui=NONE ctermfg=221 ctermbg=NONE cterm=NONE
hi Operator guifg=#f2e86e guibg=NONE guisp=NONE gui=NONE ctermfg=221 ctermbg=NONE cterm=NONE
hi Keyword guifg=#f2e86e guibg=NONE guisp=NONE gui=NONE ctermfg=221 ctermbg=NONE cterm=NONE
hi Exception guifg=#f2e86e guibg=NONE guisp=NONE gui=NONE ctermfg=221 ctermbg=NONE cterm=NONE
hi PreProc guifg=#e88ae8 guibg=NONE guisp=NONE gui=NONE ctermfg=176 ctermbg=NONE cterm=NONE
hi Include guifg=#e88ae8 guibg=NONE guisp=NONE gui=NONE ctermfg=176 ctermbg=NONE cterm=NONE
hi Define guifg=#e88ae8 guibg=NONE guisp=NONE gui=NONE ctermfg=176 ctermbg=NONE cterm=NONE
hi Macro guifg=#e88ae8 guibg=NONE guisp=NONE gui=NONE ctermfg=176 ctermbg=NONE cterm=NONE
hi PreCondit guifg=#e88ae8 guibg=NONE guisp=NONE gui=NONE ctermfg=176 ctermbg=NONE cterm=NONE
hi Type guifg=#7ce08a guibg=NONE guisp=NONE gui=NONE ctermfg=114 ctermbg=NONE cterm=NONE
hi StorageClass guifg=#7ce08a guibg=NONE guisp=NONE gui=NONE ctermfg=114 ctermbg=NONE cterm=NONE
hi Structure guifg=#7ce08a guibg=NONE guisp=NONE gui=NONE ctermfg=114 ctermbg=NONE cterm=NONE
hi Typedef guifg=#7ce08a guibg=NONE guisp=NONE gui=NONE ctermfg=114 ctermbg=NONE cterm=NONE
hi Special guifg=#f2b45f guibg=NONE guisp=NONE gui=NONE ctermfg=215 ctermbg=NONE cterm=NONE
hi SpecialChar guifg=#f2b45f guibg=NONE guisp=NONE gui=NONE ctermfg=215 ctermbg=NONE cterm=NONE
hi Tag guifg=NONE guibg=NONE guisp=NONE gui=NONE ctermfg=NONE ctermbg=NONE cterm=NONE
hi Delimiter guifg=NONE guibg=NONE guisp=NONE gui=NONE ctermfg=NONE ctermbg=NONE cterm=NONE
hi SpecialComment guifg=#7183bd guibg=NONE guisp=NONE gui=NONE ctermfg=67 ctermbg=NONE cterm=NONE
hi Debug guifg=NONE guibg=NONE guisp=NONE gui=NONE ctermfg=NONE ctermbg=NONE cterm=NONE
hi Underlined guifg=NONE guibg=NONE guisp=NONE gui=NONE ctermfg=NONE ctermbg=NONE cterm=NONE
hi Ignore guifg=NONE guibg=NONE guisp=NONE gui=NONE ctermfg=NONE ctermbg=NONE cterm=NONE
hi Error guifg=#f2606e guibg=NONE guisp=NONE gui=NONE ctermfg=203 ctermbg=NONE cterm=NONE
hi Todo guifg=#f2e86e guibg=NONE guisp=NONE gui=NONE ctermfg=221 ctermbg=NONE cterm=NONE
hi ColorColumn guifg=NONE guibg=#3e3e46 guisp=NONE gui=NONE ctermfg=NONE ctermbg=238 cterm=NONE
hi Conceal guifg=NONE guibg=NONE guisp=NONE gui=NONE ctermfg=NONE ctermbg=NONE cterm=NONE
hi Cursor guifg=#323237 guibg=#80a0ff guisp=NONE gui=NONE ctermfg=236 ctermbg=111 cterm=NONE
hi CursorIM guifg=NONE guibg=NONE guisp=NONE gui=NONE ctermfg=NONE ctermbg=NONE cterm=NONE
hi CursorColumn guifg=NONE guibg=#3e3e46 guisp=NONE gui=NONE ctermfg=NONE ctermbg=238 cterm=NONE
hi CursorLine guifg=NONE guibg=#3e3e46 guisp=NONE gui=NONE ctermfg=NONE ctermbg=238 cterm=NONE
hi Directory guifg=#80a0ff guibg=NONE guisp=NONE gui=NONE ctermfg=111 ctermbg=NONE cterm=NONE
hi DiffAdd guifg=#323237 guibg=#7ce08a guisp=NONE gui=NONE ctermfg=236 ctermbg=114 cterm=NONE
hi DiffChange guifg=#f2e86e guibg=NONE guisp=NONE gui=NONE ctermfg=221 ctermbg=NONE cterm=NONE
hi DiffDelete guifg=#323237 guibg=#f2606e guisp=NONE gui=NONE ctermfg=236 ctermbg=203 cterm=NONE
hi DiffText guifg=#323237 guibg=#f2e86e guisp=NONE gui=NONE ctermfg=236 ctermbg=221 cterm=NONE
hi ErrorMsg guifg=#f2606e guibg=NONE guisp=NONE gui=NONE ctermfg=203 ctermbg=NONE cterm=NONE
hi VertSplit guifg=#484852 guibg=NONE guisp=NONE gui=NONE ctermfg=239 ctermbg=NONE cterm=NONE
hi Folded guifg=#7183bd guibg=NONE guisp=NONE gui=NONE ctermfg=67 ctermbg=NONE cterm=NONE
hi FoldColumn guifg=NONE guibg=NONE guisp=NONE gui=NONE ctermfg=NONE ctermbg=NONE cterm=NONE
hi SignColumn guifg=NONE guibg=NONE guisp=NONE gui=NONE ctermfg=NONE ctermbg=NONE cterm=NONE
hi IncSearch guifg=#f2e86e guibg=#7183bd guisp=NONE gui=NONE ctermfg=221 ctermbg=67 cterm=NONE
hi LineNr guifg=#5c6072 guibg=NONE guisp=NONE gui=NONE ctermfg=241 ctermbg=NONE cterm=NONE
hi CursorLineNr guifg=#f2b45f guibg=NONE guisp=NONE gui=NONE ctermfg=215 ctermbg=NONE cterm=NONE
hi MatchParen guifg=#80a0ff guibg=NONE guisp=NONE gui=NONE ctermfg=111 ctermbg=NONE cterm=NONE
hi ModeMsg guifg=NONE guibg=NONE guisp=NONE gui=NONE ctermfg=NONE ctermbg=NONE cterm=NONE
hi MoreMsg guifg=NONE guibg=NONE guisp=NONE gui=NONE ctermfg=NONE ctermbg=NONE cterm=NONE
hi NonText guifg=#45454d guibg=NONE guisp=NONE gui=NONE ctermfg=238 ctermbg=NONE cterm=NONE
hi Normal guifg=#dcdfe8 guibg=#323237 guisp=NONE gui=NONE ctermfg=254 ctermbg=236 cterm=NONE
hi Pmenu guifg=#dcdfe8 guibg=#484852 guisp=NONE gui=NONE ctermfg=254 ctermbg=239 cterm=NONE
hi PmenuSel guifg=#3e3e46 guibg=#80a0ff guisp=NONE gui=NONE ctermfg=238 ctermbg=111 cterm=NONE
hi PmenuSbar guifg=NONE guibg=#3e3e46 guisp=NONE gui=NONE ctermfg=NONE ctermbg=238 cterm=NONE
hi PmenuThumb guifg=NONE guibg=#dcdfe8 guisp=NONE gui=NONE ctermfg=NONE ctermbg=254 cterm=NONE
hi Question guifg=#5ad4e6 guibg=NONE guisp=NONE gui=NONE ctermfg=80 ctermbg=NONE cterm=NONE
hi QuickFixLine guifg=#323237 guibg=#f2e86e guisp=NONE gui=NONE ctermfg=236 ctermbg=221 cterm=NONE
hi Search guifg=#323237 guibg=#f2e86e guisp=NONE gui=NONE ctermfg=236 ctermbg=221 cterm=NONE
hi SpecialKey guifg=#45454d guibg=NONE guisp=NONE gui=NONE ctermfg=238 ctermbg=NONE cterm=NONE
hi SpellBad guifg=#f2606e guibg=NONE guisp=NONE gui=NONE ctermfg=203 ctermbg=NONE cterm=NONE
hi SpellCap guifg=#f2b45f guibg=NONE guisp=NONE gui=NONE ctermfg=215 ctermbg=NONE cterm=NONE
hi SpellLocal guifg=#f2b45f guibg=NONE guisp=NONE gui=NONE ctermfg=215 ctermbg=NONE cterm=NONE
hi SpellRare guifg=#f2b45f guibg=NONE guisp=NONE gui=NONE ctermfg=215 ctermbg=NONE cterm=NONE
hi StatusLine guifg=#dcdfe8 guibg=#3e3e46 guisp=NONE gui=NONE ctermfg=254 ctermbg=238 cterm=NONE
hi StatusLineNC guifg=#7183bd guibg=NONE guisp=NONE gui=NONE ctermfg=67 ctermbg=NONE cterm=NONE
hi StatusLineTerm guifg=#dcdfe8 guibg=#3e3e46 guisp=NONE gui=NONE ctermfg=254 ctermbg=238 cterm=NONE
hi StatusLineTermNC guifg=#7183bd guibg=NONE guisp=NONE gui=NONE ctermfg=67 ctermbg=NONE cterm=NONE
hi TabLine guifg=#7183bd guibg=NONE guisp=NONE gui=NONE ctermfg=67 ctermbg=NONE cterm=NONE
hi TabLineFill guifg=NONE guibg=NONE guisp=NONE gui=NONE ctermfg=NONE ctermbg=NONE cterm=NONE
hi TabLineSel guifg=#dcdfe8 guibg=NONE guisp=NONE gui=NONE ctermfg=254 ctermbg=NONE cterm=NONE
hi Terminal guifg=#dcdfe8 guibg=#323237 guisp=NONE gui=NONE ctermfg=254 ctermbg=236 cterm=NONE
hi Title guifg=#e88ae8 guibg=NONE guisp=NONE gui=NONE ctermfg=176 ctermbg=NONE cterm=NONE
hi Visual guifg=NONE guibg=#484852 guisp=NONE gui=NONE ctermfg=NONE ctermbg=239 cterm=NONE
hi VisualNOS guifg=NONE guibg=#484852 guisp=NONE gui=NONE ctermfg=NONE ctermbg=239 cterm=NONE
hi WarningMsg guifg=#f2e86e guibg=NONE guisp=NONE gui=NONE ctermfg=221 ctermbg=NONE cterm=NONE
hi WildMenu guifg=#323237 guibg=#80a0ff guisp=NONE gui=NONE ctermfg=236 ctermbg=111 cterm=NONE

hi PMenuMatch guifg=#f2e86e guibg=NONE guisp=NONE gui=NONE ctermfg=221 ctermbg=NONE cterm=NONE
hi PMenuKind guifg=#f2e86e guibg=NONE guisp=NONE cterm=NONE gui=NONE ctermfg=221

hi debugPC guifg=NONE guibg=#45454d guisp=NONE gui=NONE ctermfg=NONE ctermbg=238 cterm=NONE
hi debugBreakpoint guifg=#323237 guibg=#f2606e guisp=NONE gui=NONE ctermfg=236 ctermbg=203 cterm=NONE
hi cssAttrComma guifg=#f2e86e guibg=NONE guisp=NONE gui=NONE ctermfg=221 ctermbg=NONE cterm=NONE
hi cssAttributeSelector guifg=#f2a0a0 guibg=NONE guisp=NONE gui=NONE ctermfg=217 ctermbg=NONE cterm=NONE
hi cssBraces guifg=#dcdfe8 guibg=NONE guisp=NONE gui=NONE ctermfg=254 ctermbg=NONE cterm=NONE
hi cssClassName guifg=#f2b45f guibg=NONE guisp=NONE gui=NONE ctermfg=215 ctermbg=NONE cterm=NONE
hi cssClassNameDot guifg=#f2b45f guibg=NONE guisp=NONE gui=NONE ctermfg=215 ctermbg=NONE cterm=NONE
hi cssDefinition guifg=#f2e86e guibg=NONE guisp=NONE gui=NONE ctermfg=221 ctermbg=NONE cterm=NONE
hi cssFontAttr guifg=#f2b45f guibg=NONE guisp=NONE gui=NONE ctermfg=215 ctermbg=NONE cterm=NONE
hi cssFontDescriptor guifg=#f2e86e guibg=NONE guisp=NONE gui=NONE ctermfg=221 ctermbg=NONE cterm=NONE
hi cssFunctionName guifg=#80a0ff guibg=NONE guisp=NONE gui=NONE ctermfg=111 ctermbg=NONE cterm=NONE
hi cssIdentifier guifg=#80a0ff guibg=NONE guisp=NONE gui=NONE ctermfg=111 ctermbg=NONE cterm=NONE
hi cssImportant guifg=#f2e86e guibg=NONE guisp=NONE gui=NONE ctermfg=221 ctermbg=NONE cterm=NONE
hi cssInclude guifg=#dcdfe8 guibg=NONE guisp=NONE gui=NONE ctermfg=254 ctermbg=NONE cterm=NONE
hi cssIncludeKeyword guifg=#f2e86e guibg=NONE guisp=NONE gui=NONE ctermfg=221 ctermbg=NONE cterm=NONE
hi cssMediaType guifg=#f2b45f guibg=NONE guisp=NONE gui=NONE ctermfg=215 ctermbg=NONE cterm=NONE
hi cssProp guifg=#dcdfe8 guibg=NONE guisp=NONE gui=NONE ctermfg=254 ctermbg=NONE cterm=NONE
hi cssPseudoClassId guifg=#f2b45f guibg=NONE guisp=NONE gui=NONE ctermfg=215 ctermbg=NONE cterm=NONE
hi cssSelectorOp guifg=#f2e86e guibg=NONE guisp=NONE gui=NONE ctermfg=221 ctermbg=NONE cterm=NONE
hi cssSelectorOp2 guifg=#f2e86e guibg=NONE guisp=NONE gui=NONE ctermfg=221 ctermbg=NONE cterm=NONE
hi cssTagName guifg=#f2606e guibg=NONE guisp=NONE gui=NONE ctermfg=203 ctermbg=NONE cterm=NONE
hi fishKeyword guifg=#f2e86e guibg=NONE guisp=NONE gui=NONE ctermfg=221 ctermbg=NONE cterm=NONE
hi fishConditional guifg=#f2e86e guibg=NONE guisp=NONE gui=NONE ctermfg=221 ctermbg=NONE cterm=NONE
hi goDeclaration guifg=#f2e86e guibg=NONE guisp=NONE gui=NONE ctermfg=221 ctermbg=NONE cterm=NONE
hi goBuiltins guifg=#5ad4e6 guibg=NONE guisp=NONE gui=NONE ctermfg=80 ctermbg=NONE cterm=NONE
hi goFunctionCall guifg=#80a0ff guibg=NONE guisp=NONE gui=NONE ctermfg=111 ctermbg=NONE cterm=NONE
hi goVarDefs guifg=#f2606e guibg=NONE guisp=NONE gui=NONE ctermfg=203 ctermbg=NONE cterm=NONE
hi goVarAssign guifg=#f2606e guibg=NONE guisp=NONE gui=NONE ctermfg=203 ctermbg=NONE cterm=NONE
hi goVar guifg=#f2e86e guibg=NONE guisp=NONE gui=NONE ctermfg=221 ctermbg=NONE cterm=NONE
hi goConst guifg=#f2e86e guibg=NONE guisp=NONE gui=NONE ctermfg=221 ctermbg=NONE cterm=NONE
hi goType guifg=#7ce08a guibg=NONE guisp=NONE gui=NONE ctermfg=114 ctermbg=NONE cterm=NONE
hi goTypeName guifg=#7ce08a guibg=NONE guisp=NONE gui=NONE ctermfg=114 ctermbg=NONE cterm=NONE
hi goDeclType guifg=#5ad4e6 guibg=NONE guisp=NONE gui=NONE ctermfg=80 ctermbg=NONE cterm=NONE
hi goTypeDecl guifg=#f2e86e guibg=NONE guisp=NONE gui=NONE ctermfg=221 ctermbg=NONE cterm=NONE
hi htmlArg guifg=#f2b45f guibg=NONE guisp=NONE gui=NONE ctermfg=215 ctermbg=NONE cterm=NONE
hi htmlBold guifg=#f2b45f guibg=NONE guisp=NONE gui=NONE ctermfg=215 ctermbg=NONE cterm=NONE
hi htmlBoldItalic guifg=#f2a0a0 guibg=NONE guisp=NONE gui=NONE ctermfg=217 ctermbg=NONE cterm=NONE
hi htmlEndTag guifg=#dcdfe8 guibg=NONE guisp=NONE gui=NONE ctermfg=254 ctermbg=NONE cterm=NONE
hi htmlH1 guifg=#f2606e guibg=NONE guisp=NONE gui=NONE ctermfg=203 ctermbg=NONE cterm=NONE
hi htmlH2 guifg=#f2606e guibg=NONE guisp=NONE gui=NONE ctermfg=203 ctermbg=NONE cterm=NONE
hi htmlH3 guifg=#f2606e guibg=NONE guisp=NONE gui=NONE ctermfg=203 ctermbg=NONE cterm=NONE
hi htmlH4 guifg=#f2606e guibg=NONE guisp=NONE gui=NONE ctermfg=203 ctermbg=NONE cterm=NONE
hi htmlH5 guifg=#f2606e guibg=NONE guisp=NONE gui=NONE ctermfg=203 ctermbg=NONE cterm=NONE
hi htmlH6 guifg=#f2606e guibg=NONE guisp=NONE gui=NONE ctermfg=203 ctermbg=NONE cterm=NONE
hi htmlItalic guifg=#f2e86e guibg=NONE guisp=NONE gui=NONE ctermfg=221 ctermbg=NONE cterm=NONE
hi htmlLink guifg=#5ad4e6 guibg=NONE guisp=NONE gui=NONE ctermfg=80 ctermbg=NONE cterm=NONE
hi htmlSpecialChar guifg=#f2b45f guibg=NONE guisp=NONE gui=NONE ctermfg=215 ctermbg=NONE cterm=NONE
hi htmlSpecialTagName guifg=#f2606e guibg=NONE guisp=NONE gui=NONE ctermfg=203 ctermbg=NONE cterm=NONE
hi htmlTag guifg=#dcdfe8 guibg=NONE guisp=NONE gui=NONE ctermfg=254 ctermbg=NONE cterm=NONE
hi htmlTagN guifg=#f2606e guibg=NONE guisp=NONE gui=NONE ctermfg=203 ctermbg=NONE cterm=NONE
hi htmlTagName guifg=#f2606e guibg=NONE guisp=NONE gui=NONE ctermfg=203 ctermbg=NONE cterm=NONE
hi htmlTitle guifg=#dcdfe8 guibg=NONE guisp=NONE gui=NONE ctermfg=254 ctermbg=NONE cterm=NONE
hi javaScriptBraces guifg=#dcdfe8 guibg=NONE guisp=NONE gui=NONE ctermfg=254 ctermbg=NONE cterm=NONE
hi javaScriptFunction guifg=#f2e86e guibg=NONE guisp=NONE gui=NONE ctermfg=221 ctermbg=NONE cterm=NONE
hi javaScriptIdentifier guifg=#f2e86e guibg=NONE guisp=NONE gui=NONE ctermfg=221 ctermbg=NONE cterm=NONE
hi javaScriptNull guifg=#f2b45f guibg=NONE guisp=NONE gui=NONE ctermfg=215 ctermbg=NONE cterm=NONE
hi javaScriptNumber guifg=#f2b45f guibg=NONE guisp=NONE gui=NONE ctermfg=215 ctermbg=NONE cterm=NONE
hi javaScriptRequire guifg=#5ad4e6 guibg=NONE guisp=NONE gui=NONE ctermfg=80 ctermbg=NONE cterm=NONE
hi javaScriptReserved guifg=#f2e86e guibg=NONE guisp=NONE gui=NONE ctermfg=221 ctermbg=NONE cterm=NONE
hi jsArrowFunction guifg=#f2e86e guibg=NONE guisp=NONE gui=NONE ctermfg=221 ctermbg=NONE cterm=NONE
hi jsClassKeyword guifg=#f2e86e guibg=NONE guisp=NONE gui=NONE ctermfg=221 ctermbg=NONE cterm=NONE
hi jsClassMethodType guifg=#f2e86e guibg=NONE guisp=NONE gui=NONE ctermfg=221 ctermbg=NONE cterm=NONE
hi jsDocParam guifg=#80a0ff guibg=NONE guisp=NONE gui=NONE ctermfg=111 ctermbg=NONE cterm=NONE
hi jsDocTags guifg=#f2e86e guibg=NONE guisp=NONE gui=NONE ctermfg=221 ctermbg=NONE cterm=NONE
hi jsExport guifg=#f2e86e guibg=NONE guisp=NONE gui=NONE ctermfg=221 ctermbg=NONE cterm=NONE
hi jsExportDefault guifg=#f2e86e guibg=NONE guisp=NONE gui=NONE ctermfg=221 ctermbg=NONE cterm=NONE
hi jsExtendsKeyword guifg=#f2e86e guibg=NONE guisp=NONE gui=NONE ctermfg=221 ctermbg=NONE cterm=NONE
hi jsFrom guifg=#f2e86e guibg=NONE guisp=NONE gui=NONE ctermfg=221 ctermbg=NONE cterm=NONE
hi jsFuncCall guifg=#80a0ff guibg=NONE guisp=NONE gui=NONE ctermfg=111 ctermbg=NONE cterm=NONE
hi jsFunction guifg=#f2e86e guibg=NONE guisp=NONE gui=NONE ctermfg=221 ctermbg=NONE cterm=NONE
hi jsGenerator guifg=#f2e86e guibg=NONE guisp=NONE gui=NONE ctermfg=221 ctermbg=NONE cterm=NONE
hi jsGlobalObjects guifg=#f2e86e guibg=NONE guisp=NONE gui=NONE ctermfg=221 ctermbg=NONE cterm=NONE
hi jsImport guifg=#f2e86e guibg=NONE guisp=NONE gui=NONE ctermfg=221 ctermbg=NONE cterm=NONE
hi jsModuleAs guifg=#f2e86e guibg=NONE guisp=NONE gui=NONE ctermfg=221 ctermbg=NONE cterm=NONE
hi jsModuleWords guifg=#f2e86e guibg=NONE guisp=NONE gui=NONE ctermfg=221 ctermbg=NONE cterm=NONE
hi jsModules guifg=#f2e86e guibg=NONE guisp=NONE gui=NONE ctermfg=221 ctermbg=NONE cterm=NONE
hi jsNull guifg=#f2b45f guibg=NONE guisp=NONE gui=NONE ctermfg=215 ctermbg=NONE cterm=NONE
hi jsOperator guifg=#f2e86e guibg=NONE guisp=NONE gui=NONE ctermfg=221 ctermbg=NONE cterm=NONE
hi jsStorageClass guifg=#f2e86e guibg=NONE guisp=NONE gui=NONE ctermfg=221 ctermbg=NONE cterm=NONE
hi jsSuper guifg=#f2606e guibg=NONE guisp=NONE gui=NONE ctermfg=203 ctermbg=NONE cterm=NONE
hi jsTemplateBraces guifg=#b04a4a guibg=NONE guisp=NONE gui=NONE ctermfg=131 ctermbg=NONE cterm=NONE
hi jsTemplateVar guifg=#f2a0a0 guibg=NONE guisp=NONE gui=NONE ctermfg=217 ctermbg=NONE cterm=NONE
hi jsThis guifg=#f2606e guibg=NONE guisp=NONE gui=NONE ctermfg=203 ctermbg=NONE cterm=NONE
hi jsUndefined guifg=#f2b45f guibg=NONE guisp=NONE gui=NONE ctermfg=215 ctermbg=NONE cterm=NONE
hi javascriptArrowFunc guifg=#f2e86e guibg=NONE guisp=NONE gui=NONE ctermfg=221 ctermbg=NONE cterm=NONE
hi javascriptClassExtends guifg=#f2e86e guibg=NONE guisp=NONE gui=NONE ctermfg=221 ctermbg=NONE cterm=NONE
hi javascriptClassKeyword guifg=#f2e86e guibg=NONE guisp=NONE gui=NONE ctermfg=221 ctermbg=NONE cterm=NONE
hi javascriptDocNotation guifg=#f2e86e guibg=NONE guisp=NONE gui=NONE ctermfg=221 ctermbg=NONE cterm=NONE
hi javascriptDocParamName guifg=#80a0ff guibg=NONE guisp=NONE gui=NONE ctermfg=111 ctermbg=NONE cterm=NONE
hi javascriptDocTags guifg=#f2e86e guibg=NONE guisp=NONE gui=NONE ctermfg=221 ctermbg=NONE cterm=NONE
hi javascriptEndColons guifg=#dcdfe8 guibg=NONE guisp=NONE gui=NONE ctermfg=254 ctermbg=NONE cterm=NONE
hi javascriptExport guifg=#f2e86e guibg=NONE guisp=NONE gui=NONE ctermfg=221 ctermbg=NONE cterm=NONE
hi javascriptFuncArg guifg=#dcdfe8 guibg=NONE guisp=NONE gui=NONE ctermfg=254 ctermbg=NONE cterm=NONE
hi javascriptFuncKeyword guifg=#f2e86e guibg=NONE guisp=NONE gui=NONE ctermfg=221 ctermbg=NONE cterm=NONE
hi javascriptIdentifier guifg=#f2606e guibg=NONE guisp=NONE gui=NONE ctermfg=203 ctermbg=NONE cterm=NONE
hi javascriptImport guifg=#f2e86e guibg=NONE guisp=NONE gui=NONE ctermfg=221 ctermbg=NONE cterm=NONE
hi javascriptMethodName guifg=#dcdfe8 guibg=NONE guisp=NONE gui=NONE ctermfg=254 ctermbg=NONE cterm=NONE
hi javascriptObjectLabel guifg=#dcdfe8 guibg=NONE guisp=NONE gui=NONE ctermfg=254 ctermbg=NONE cterm=NONE
hi javascriptOpSymbol guifg=#5ad4e6 guibg=NONE guisp=NONE gui=NONE ctermfg=80 ctermbg=NONE cterm=NONE
hi javascriptOpSymbols guifg=#5ad4e6 guibg=NONE guisp=NONE gui=NONE ctermfg=80 ctermbg=NONE cterm=NONE
hi javascriptPropertyName guifg=#f2a0a0 guibg=NONE guisp=NONE gui=NONE ctermfg=217 ctermbg=NONE cterm=NONE
hi javascriptTemplateSB guifg=#b04a4a guibg=NONE guisp=NONE gui=NONE ctermfg=131 ctermbg=NONE cterm=NONE
hi javascriptVariable guifg=#f2e86e guibg=NONE guisp=NONE gui=NONE ctermfg=221 ctermbg=NONE cterm=NONE
hi jsonCommentError guifg=#dcdfe8 guibg=NONE guisp=NONE gui=NONE ctermfg=254 ctermbg=NONE cterm=NONE
hi jsonKeyword guifg=#f2606e guibg=NONE guisp=NONE gui=NONE ctermfg=203 ctermbg=NONE cterm=NONE
hi jsonBoolean guifg=#f2b45f guibg=NONE guisp=NONE gui=NONE ctermfg=215 ctermbg=NONE cterm=NONE
hi jsonNumber guifg=#f2b45f guibg=NONE guisp=NONE gui=NONE ctermfg=215 ctermbg=NONE cterm=NONE
hi jsonQuote guifg=#dcdfe8 guibg=NONE guisp=NONE gui=NONE ctermfg=254 ctermbg=NONE cterm=NONE
hi jsonMissingCommaError guifg=#f2606e guibg=NONE guisp=NONE gui=NONE ctermfg=203 ctermbg=NONE cterm=NONE
hi jsonNoQuotesError guifg=#f2606e guibg=NONE guisp=NONE gui=NONE ctermfg=203 ctermbg=NONE cterm=NONE
hi jsonNumError guifg=#f2606e guibg=NONE guisp=NONE gui=NONE ctermfg=203 ctermbg=NONE cterm=NONE
hi jsonString guifg=#f2a0a0 guibg=NONE guisp=NONE gui=NONE ctermfg=217 ctermbg=NONE cterm=NONE
hi jsonStringSQError guifg=#f2606e guibg=NONE guisp=NONE gui=NONE ctermfg=203 ctermbg=NONE cterm=NONE
hi jsonSemicolonError guifg=#f2606e guibg=NONE guisp=NONE gui=NONE ctermfg=203 ctermbg=NONE cterm=NONE
hi lessVariable guifg=#f2e86e guibg=NONE guisp=NONE gui=NONE ctermfg=221 ctermbg=NONE cterm=NONE
hi lessAmpersandChar guifg=#dcdfe8 guibg=NONE guisp=NONE gui=NONE ctermfg=254 ctermbg=NONE cterm=NONE
hi lessClass guifg=#f2b45f guibg=NONE guisp=NONE gui=NONE ctermfg=215 ctermbg=NONE cterm=NONE
hi markdownBlockquote guifg=#7183bd guibg=NONE guisp=NONE gui=NONE ctermfg=67 ctermbg=NONE cterm=NONE
hi markdownBold guifg=#f2b45f guibg=NONE guisp=NONE gui=NONE ctermfg=215 ctermbg=NONE cterm=NONE
hi markdownBoldItalic guifg=#f2a0a0 guibg=NONE guisp=NONE gui=NONE ctermfg=217 ctermbg=NONE cterm=NONE
hi markdownCode guifg=#f2a0a0 guibg=NONE guisp=NONE gui=NONE ctermfg=217 ctermbg=NONE cterm=NONE
hi markdownCodeBlock guifg=#f2a0a0 guibg=NONE guisp=NONE gui=NONE ctermfg=217 ctermbg=NONE cterm=NONE
hi markdownCodeDelimiter guifg=#f2a0a0 guibg=NONE guisp=NONE gui=NONE ctermfg=217 ctermbg=NONE cterm=NONE
hi markdownH1 guifg=#f2606e guibg=NONE guisp=NONE gui=NONE ctermfg=203 ctermbg=NONE cterm=NONE
hi markdownH2 guifg=#f2606e guibg=NONE guisp=NONE gui=NONE ctermfg=203 ctermbg=NONE cterm=NONE
hi markdownH3 guifg=#f2606e guibg=NONE guisp=NONE gui=NONE ctermfg=203 ctermbg=NONE cterm=NONE
hi markdownH4 guifg=#f2606e guibg=NONE guisp=NONE gui=NONE ctermfg=203 ctermbg=NONE cterm=NONE
hi markdownH5 guifg=#f2606e guibg=NONE guisp=NONE gui=NONE ctermfg=203 ctermbg=NONE cterm=NONE
hi markdownH6 guifg=#f2606e guibg=NONE guisp=NONE gui=NONE ctermfg=203 ctermbg=NONE cterm=NONE
hi markdownHeadingDelimiter guifg=#f2606e guibg=NONE guisp=NONE gui=NONE ctermfg=203 ctermbg=NONE cterm=NONE
hi markdownHeadingRule guifg=#7183bd guibg=NONE guisp=NONE gui=NONE ctermfg=67 ctermbg=NONE cterm=NONE
hi markdownId guifg=#f2e86e guibg=NONE guisp=NONE gui=NONE ctermfg=221 ctermbg=NONE cterm=NONE
hi markdownIdDeclaration guifg=#80a0ff guibg=NONE guisp=NONE gui=NONE ctermfg=111 ctermbg=NONE cterm=NONE
hi markdownIdDelimiter guifg=#f2e86e guibg=NONE guisp=NONE gui=NONE ctermfg=221 ctermbg=NONE cterm=NONE
hi markdownItalic guifg=#f2e86e guibg=NONE guisp=NONE gui=NONE ctermfg=221 ctermbg=NONE cterm=NONE
hi markdownLinkDelimiter guifg=#f2e86e guibg=NONE guisp=NONE gui=NONE ctermfg=221 ctermbg=NONE cterm=NONE
hi markdownLinkText guifg=#80a0ff guibg=NONE guisp=NONE gui=NONE ctermfg=111 ctermbg=NONE cterm=NONE
hi markdownListMarker guifg=#f2606e guibg=NONE guisp=NONE gui=NONE ctermfg=203 ctermbg=NONE cterm=NONE
hi markdownOrderedListMarker guifg=#f2606e guibg=NONE guisp=NONE gui=NONE ctermfg=203 ctermbg=NONE cterm=NONE
hi markdownRule guifg=#7183bd guibg=NONE guisp=NONE gui=NONE ctermfg=67 ctermbg=NONE cterm=NONE
hi markdownUrl guifg=#5ad4e6 guibg=NONE guisp=NONE gui=NONE ctermfg=80 ctermbg=NONE cterm=NONE
hi perlFiledescRead guifg=#f2a0a0 guibg=NONE guisp=NONE gui=NONE ctermfg=217 ctermbg=NONE cterm=NONE
hi perlFunction guifg=#f2e86e guibg=NONE guisp=NONE gui=NONE ctermfg=221 ctermbg=NONE cterm=NONE
hi perlMatchStartEnd guifg=#80a0ff guibg=NONE guisp=NONE gui=NONE ctermfg=111 ctermbg=NONE cterm=NONE
hi perlMethod guifg=#f2e86e guibg=NONE guisp=NONE gui=NONE ctermfg=221 ctermbg=NONE cterm=NONE
hi perlPOD guifg=#7183bd guibg=NONE guisp=NONE gui=NONE ctermfg=67 ctermbg=NONE cterm=NONE
hi perlSharpBang guifg=#7183bd guibg=NONE guisp=NONE gui=NONE ctermfg=67 ctermbg=NONE cterm=NONE
hi perlSpecialString guifg=#f2b45f guibg=NONE guisp=NONE gui=NONE ctermfg=215 ctermbg=NONE cterm=NONE
hi perlStatementFiledesc guifg=#f2606e guibg=NONE guisp=NONE gui=NONE ctermfg=203 ctermbg=NONE cterm=NONE
hi perlStatementFlow guifg=#f2606e guibg=NONE guisp=NONE gui=NONE ctermfg=203 ctermbg=NONE cterm=NONE
hi perlStatementInclude guifg=#f2e86e guibg=NONE guisp=NONE gui=NONE ctermfg=221 ctermbg=NONE cterm=NONE
hi perlStatementScalar guifg=#f2e86e guibg=NONE guisp=NONE gui=NONE ctermfg=221 ctermbg=NONE cterm=NONE
hi perlStatementStorage guifg=#f2e86e guibg=NONE guisp=NONE gui=NONE ctermfg=221 ctermbg=NONE cterm=NONE
hi perlSubName guifg=#7ce08a guibg=NONE guisp=NONE gui=NONE ctermfg=114 ctermbg=NONE cterm=NONE
hi perlVarPlain guifg=#80a0ff guibg=NONE guisp=NONE gui=NONE ctermfg=111 ctermbg=NONE cterm=NONE
hi phpVarSelector guifg=#f2606e guibg=NONE guisp=NONE gui=NONE ctermfg=203 ctermbg=NONE cterm=NONE
hi phpOperator guifg=#dcdfe8 guibg=NONE guisp=NONE gui=NONE ctermfg=254 ctermbg=NONE cterm=NONE
hi phpParent guifg=#dcdfe8 guibg=NONE guisp=NONE gui=NONE ctermfg=254 ctermbg=NONE cterm=NONE
hi phpMemberSelector guifg=#dcdfe8 guibg=NONE guisp=NONE gui=NONE ctermfg=254 ctermbg=NONE cterm=NONE
hi phpType guifg=#f2e86e guibg=NONE guisp=NONE gui=NONE ctermfg=221 ctermbg=NONE cterm=NONE
hi phpKeyword guifg=#f2e86e guibg=NONE guisp=NONE gui=NONE ctermfg=221 ctermbg=NONE cterm=NONE
hi phpClass guifg=#7ce08a guibg=NONE guisp=NONE gui=NONE ctermfg=114 ctermbg=NONE cterm=NONE
hi phpUseClass guifg=#dcdfe8 guibg=NONE guisp=NONE gui=NONE ctermfg=254 ctermbg=NONE cterm=NONE
hi phpUseAlias guifg=#dcdfe8 guibg=NONE guisp=NONE gui=NONE ctermfg=254 ctermbg=NONE cterm=NONE
hi phpInclude guifg=#f2e86e guibg=NONE guisp=NONE gui=NONE ctermfg=221 ctermbg=NONE cterm=NONE
hi phpClassExtends guifg=#f2a0a0 guibg=NONE guisp=NONE gui=NONE ctermfg=217 ctermbg=NONE cterm=NONE
hi phpDocTags guifg=#dcdfe8 guibg=NONE guisp=NONE gui=NONE ctermfg=254 ctermbg=NONE cterm=NONE
hi phpFunction guifg=#80a0ff guibg=NONE guisp=NONE gui=NONE ctermfg=111 ctermbg=NONE cterm=NONE
hi phpFunctions guifg=#5ad4e6 guibg=NONE guisp=NONE gui=NONE ctermfg=80 ctermbg=NONE cterm=NONE
hi phpMethodsVar guifg=#f2b45f guibg=NONE guisp=NONE gui=NONE ctermfg=215 ctermbg=NONE cterm=NONE
hi phpMagicConstants guifg=#f2b45f guibg=NONE guisp=NONE gui=NONE ctermfg=215 ctermbg=NONE cterm=NONE
hi phpSuperglobals guifg=#f2606e guibg=NONE guisp=NONE gui=NONE ctermfg=203 ctermbg=NONE cterm=NONE
hi phpConstants guifg=#f2b45f guibg=NONE guisp=NONE gui=NONE ctermfg=215 ctermbg=NONE cterm=NONE
hi rubyBlockParameter guifg=#f2606e guibg=NONE guisp=NONE gui=NONE ctermfg=203 ctermbg=NONE cterm=NONE
hi rubyBlockParameterList guifg=#f2606e guibg=NONE guisp=NONE gui=NONE ctermfg=203 ctermbg=NONE cterm=NONE
hi rubyClass guifg=#f2e86e guibg=NONE guisp=NONE gui=NONE ctermfg=221 ctermbg=NONE cterm=NONE
hi rubyConstant guifg=#7ce08a guibg=NONE guisp=NONE gui=NONE ctermfg=114 ctermbg=NONE cterm=NONE
hi rubyControl guifg=#f2e86e guibg=NONE guisp=NONE gui=NONE ctermfg=221 ctermbg=NONE cterm=NONE
hi rubyEscape guifg=#f2606e guibg=NONE guisp=NONE gui=NONE ctermfg=203 ctermbg=NONE cterm=NONE
hi rubyFunction guifg=#80a0ff guibg=NONE guisp=NONE gui=NONE ctermfg=111 ctermbg=NONE cterm=NONE
hi rubyGlobalVariable guifg=#f2606e guibg=NONE guisp=NONE gui=NONE ctermfg=203 ctermbg=NONE cterm=NONE
hi rubyInclude guifg=#80a0ff guibg=NONE guisp=NONE gui=NONE ctermfg=111 ctermbg=NONE cterm=NONE
hi rubyIncluderubyGlobalVariable guifg=#f2606e guibg=NONE guisp=NONE gui=NONE ctermfg=203 ctermbg=NONE cterm=NONE
hi rubyInstanceVariable guifg=#f2606e guibg=NONE guisp=NONE gui=NONE ctermfg=203 ctermbg=NONE cterm=NONE
hi rubyInterpolation guifg=#5ad4e6 guibg=NONE guisp=NONE gui=NONE ctermfg=80 ctermbg=NONE cterm=NONE
hi rubyInterpolationDelimiter guifg=#f2606e guibg=NONE guisp=NONE gui=NONE ctermfg=203 ctermbg=NONE cterm=NONE
hi rubyInterpolationDelimiter guifg=#f2606e guibg=NONE guisp=NONE gui=NONE ctermfg=203 ctermbg=NONE cterm=NONE
hi rubyRegexp guifg=#5ad4e6 guibg=NONE guisp=NONE gui=NONE ctermfg=80 ctermbg=NONE cterm=NONE
hi rubyRegexpDelimiter guifg=#5ad4e6 guibg=NONE guisp=NONE gui=NONE ctermfg=80 ctermbg=NONE cterm=NONE
hi rubyStringDelimiter guifg=#f2a0a0 guibg=NONE guisp=NONE gui=NONE ctermfg=217 ctermbg=NONE cterm=NONE
hi rubySymbol guifg=#5ad4e6 guibg=NONE guisp=NONE gui=NONE ctermfg=80 ctermbg=NONE cterm=NONE
hi sassAmpersand guifg=#f2606e guibg=NONE guisp=NONE gui=NONE ctermfg=203 ctermbg=NONE cterm=NONE
hi sassClass guifg=#f2b45f guibg=NONE guisp=NONE gui=NONE ctermfg=215 ctermbg=NONE cterm=NONE
hi sassControl guifg=#f2e86e guibg=NONE guisp=NONE gui=NONE ctermfg=221 ctermbg=NONE cterm=NONE
hi sassExtend guifg=#f2e86e guibg=NONE guisp=NONE gui=NONE ctermfg=221 ctermbg=NONE cterm=NONE
hi sassFor guifg=#dcdfe8 guibg=NONE guisp=NONE gui=NONE ctermfg=254 ctermbg=NONE cterm=NONE
hi sassFunction guifg=#5ad4e6 guibg=NONE guisp=NONE gui=NONE ctermfg=80 ctermbg=NONE cterm=NONE
hi sassId guifg=#80a0ff guibg=NONE guisp=NONE gui=NONE ctermfg=111 ctermbg=NONE cterm=NONE
hi sassInclude guifg=#f2e86e guibg=NONE guisp=NONE gui=NONE ctermfg=221 ctermbg=NONE cterm=NONE
hi sassMedia guifg=#f2e86e guibg=NONE guisp=NONE gui=NONE ctermfg=221 ctermbg=NONE cterm=NONE
hi sassMediaOperators guifg=#dcdfe8 guibg=NONE guisp=NONE gui=NONE ctermfg=254 ctermbg=NONE cterm=NONE
hi sassMixin guifg=#f2e86e guibg=NONE guisp=NONE gui=NONE ctermfg=221 ctermbg=NONE cterm=NONE
hi sassMixinName guifg=#80a0ff guibg=NONE guisp=NONE gui=NONE ctermfg=111 ctermbg=NONE cterm=NONE
hi sassMixing guifg=#f2e86e guibg=NONE guisp=NONE gui=NONE ctermfg=221 ctermbg=NONE cterm=NONE
hi sassVariable guifg=#f2e86e guibg=NONE guisp=NONE gui=NONE ctermfg=221 ctermbg=NONE cterm=NONE
hi scssExtend guifg=#f2e86e guibg=NONE guisp=NONE gui=NONE ctermfg=221 ctermbg=NONE cterm=NONE
hi scssImport guifg=#f2e86e guibg=NONE guisp=NONE gui=NONE ctermfg=221 ctermbg=NONE cterm=NONE
hi scssInclude guifg=#f2e86e guibg=NONE guisp=NONE gui=NONE ctermfg=221 ctermbg=NONE cterm=NONE
hi scssMixin guifg=#f2e86e guibg=NONE guisp=NONE gui=NONE ctermfg=221 ctermbg=NONE cterm=NONE
hi scssSelectorName guifg=#f2b45f guibg=NONE guisp=NONE gui=NONE ctermfg=215 ctermbg=NONE cterm=NONE
hi scssVariable guifg=#f2e86e guibg=NONE guisp=NONE gui=NONE ctermfg=221 ctermbg=NONE cterm=NONE
hi texStatement guifg=#f2e86e guibg=NONE guisp=NONE gui=NONE ctermfg=221 ctermbg=NONE cterm=NONE
hi texSubscripts guifg=#f2b45f guibg=NONE guisp=NONE gui=NONE ctermfg=215 ctermbg=NONE cterm=NONE
hi texSuperscripts guifg=#f2b45f guibg=NONE guisp=NONE gui=NONE ctermfg=215 ctermbg=NONE cterm=NONE
hi texTodo guifg=#b04a4a guibg=NONE guisp=NONE gui=NONE ctermfg=131 ctermbg=NONE cterm=NONE
hi texBeginEnd guifg=#f2e86e guibg=NONE guisp=NONE gui=NONE ctermfg=221 ctermbg=NONE cterm=NONE
hi texBeginEndName guifg=#80a0ff guibg=NONE guisp=NONE gui=NONE ctermfg=111 ctermbg=NONE cterm=NONE
hi texMathMatcher guifg=#80a0ff guibg=NONE guisp=NONE gui=NONE ctermfg=111 ctermbg=NONE cterm=NONE
hi texMathDelim guifg=#80a0ff guibg=NONE guisp=NONE gui=NONE ctermfg=111 ctermbg=NONE cterm=NONE
hi texDelimiter guifg=#f2b45f guibg=NONE guisp=NONE gui=NONE ctermfg=215 ctermbg=NONE cterm=NONE
hi texSpecialChar guifg=#f2b45f guibg=NONE guisp=NONE gui=NONE ctermfg=215 ctermbg=NONE cterm=NONE
hi texCite guifg=#80a0ff guibg=NONE guisp=NONE gui=NONE ctermfg=111 ctermbg=NONE cterm=NONE
hi texRefZone guifg=#80a0ff guibg=NONE guisp=NONE gui=NONE ctermfg=111 ctermbg=NONE cterm=NONE
hi typescriptReserved guifg=#f2e86e guibg=NONE guisp=NONE gui=NONE ctermfg=221 ctermbg=NONE cterm=NONE
hi typescriptEndColons guifg=#dcdfe8 guibg=NONE guisp=NONE gui=NONE ctermfg=254 ctermbg=NONE cterm=NONE
hi typescriptBraces guifg=#dcdfe8 guibg=NONE guisp=NONE gui=NONE ctermfg=254 ctermbg=NONE cterm=NONE
hi xmlAttrib guifg=#f2b45f guibg=NONE guisp=NONE gui=NONE ctermfg=215 ctermbg=NONE cterm=NONE
hi xmlEndTag guifg=#f2606e guibg=NONE guisp=NONE gui=NONE ctermfg=203 ctermbg=NONE cterm=NONE
hi xmlTag guifg=#f2606e guibg=NONE guisp=NONE gui=NONE ctermfg=203 ctermbg=NONE cterm=NONE
hi xmlTagName guifg=#f2606e guibg=NONE guisp=NONE gui=NONE ctermfg=203 ctermbg=NONE cterm=NONE
hi GitGutterAdd guifg=#7ce08a guibg=NONE guisp=NONE gui=NONE ctermfg=114 ctermbg=NONE cterm=NONE
hi GitGutterChange guifg=#f2e86e guibg=NONE guisp=NONE gui=NONE ctermfg=221 ctermbg=NONE cterm=NONE
hi GitGutterDelete guifg=#f2606e guibg=NONE guisp=NONE gui=NONE ctermfg=203 ctermbg=NONE cterm=NONE
hi ALEError guifg=#f2606e guibg=NONE guisp=NONE gui=NONE ctermfg=203 ctermbg=NONE cterm=NONE
hi ALEWarning guifg=#f2e86e guibg=NONE guisp=NONE gui=NONE ctermfg=221 ctermbg=NONE cterm=NONE
hi ALEInfo guifg=NONE guibg=NONE guisp=NONE gui=NONE ctermfg=NONE ctermbg=NONE cterm=NONE
hi ALEErrorSign guifg=#f2606e guibg=NONE guisp=NONE gui=NONE ctermfg=203 ctermbg=NONE cterm=NONE
hi ALEWarningSign guifg=#f2e86e guibg=NONE guisp=NONE gui=NONE ctermfg=221 ctermbg=NONE cterm=NONE
hi ALEInfoSign guifg=NONE guibg=NONE guisp=NONE gui=NONE ctermfg=NONE ctermbg=NONE cterm=NONE
hi EasyMotionTarget guifg=#f2606e guibg=NONE guisp=NONE gui=NONE ctermfg=203 ctermbg=NONE cterm=NONE
hi EasyMotionTarget2First guifg=#f2e86e guibg=NONE guisp=NONE gui=NONE ctermfg=221 ctermbg=NONE cterm=NONE
hi EasyMotionTarget2Second guifg=#f2b45f guibg=NONE guisp=NONE gui=NONE ctermfg=215 ctermbg=NONE cterm=NONE
hi EasyMotionShade guifg=#7183bd guibg=NONE guisp=NONE gui=NONE ctermfg=67 ctermbg=NONE cterm=NONE
hi CocErrorSign guifg=#f2606e guibg=NONE guisp=NONE gui=NONE ctermfg=203 ctermbg=NONE cterm=NONE
hi CocWarningSign guifg=#f2e86e guibg=NONE guisp=NONE gui=NONE ctermfg=221 ctermbg=NONE cterm=NONE
hi CocInfoSign guifg=#80a0ff guibg=NONE guisp=NONE gui=NONE ctermfg=111 ctermbg=NONE cterm=NONE
hi CocHintSign guifg=#5ad4e6 guibg=NONE guisp=NONE gui=NONE ctermfg=80 ctermbg=NONE cterm=NONE
hi CocFadeOut guifg=#7183bd guibg=NONE guisp=NONE gui=NONE ctermfg=67 ctermbg=NONE cterm=NONE
hi NeomakeErrorSign guifg=#f2606e guibg=NONE guisp=NONE gui=NONE ctermfg=203 ctermbg=NONE cterm=NONE
hi NeomakeWarningSign guifg=#f2e86e guibg=NONE guisp=NONE gui=NONE ctermfg=221 ctermbg=NONE cterm=NONE
hi NeomakeInfoSign guifg=#80a0ff guibg=NONE guisp=NONE gui=NONE ctermfg=111 ctermbg=NONE cterm=NONE
hi mkdDelimiter guifg=#f2e86e guibg=NONE guisp=NONE gui=NONE ctermfg=221 ctermbg=NONE cterm=NONE
hi mkdHeading guifg=#f2606e guibg=NONE guisp=NONE gui=NONE ctermfg=203 ctermbg=NONE cterm=NONE
hi mkdLink guifg=#80a0ff guibg=NONE guisp=NONE gui=NONE ctermfg=111 ctermbg=NONE cterm=NONE
hi mkdURL guifg=#5ad4e6 guibg=NONE guisp=NONE gui=NONE ctermfg=80 ctermbg=NONE cterm=NONE
hi LspErrorText guifg=#f2606e guibg=NONE guisp=NONE gui=NONE ctermfg=203 ctermbg=NONE cterm=NONE
hi LspWarningText guifg=#f2e86e guibg=NONE guisp=NONE gui=NONE ctermfg=221 ctermbg=NONE cterm=NONE
hi LspInformationText guifg=#80a0ff guibg=NONE guisp=NONE gui=NONE ctermfg=111 ctermbg=NONE cterm=NONE
hi LspHintText guifg=#5ad4e6 guibg=NONE guisp=NONE gui=NONE ctermfg=80 ctermbg=NONE cterm=NONE
hi LspErrorHighlight guifg=#f2606e guibg=NONE guisp=NONE gui=NONE ctermfg=203 ctermbg=NONE cterm=NONE
hi LspWarningHighlight guifg=#f2e86e guibg=NONE guisp=NONE gui=NONE ctermfg=221 ctermbg=NONE cterm=NONE
hi LspInformationHighlight guifg=#80a0ff guibg=NONE guisp=NONE gui=NONE ctermfg=111 ctermbg=NONE cterm=NONE
hi LspHintHighlight guifg=#5ad4e6 guibg=NONE guisp=NONE gui=NONE ctermfg=80 ctermbg=NONE cterm=NONE
hi diffAdded guifg=#7ce08a guibg=NONE guisp=NONE gui=NONE ctermfg=114 ctermbg=NONE cterm=NONE
hi diffRemoved guifg=#f2606e guibg=NONE guisp=NONE gui=NONE ctermfg=203 ctermbg=NONE cterm=NONE
hi gitcommitComment guifg=#7183bd guibg=NONE guisp=NONE gui=NONE ctermfg=67 ctermbg=NONE cterm=NONE
hi gitcommitUnmerged guifg=#7ce08a guibg=NONE guisp=NONE gui=NONE ctermfg=114 ctermbg=NONE cterm=NONE
hi gitcommitOnBranch guifg=NONE guibg=NONE guisp=NONE gui=NONE ctermfg=NONE ctermbg=NONE cterm=NONE
hi gitcommitBranch guifg=#f2e86e guibg=NONE guisp=NONE gui=NONE ctermfg=221 ctermbg=NONE cterm=NONE
hi gitcommitDiscardedType guifg=#f2606e guibg=NONE guisp=NONE gui=NONE ctermfg=203 ctermbg=NONE cterm=NONE
hi gitcommitSelectedType guifg=#7ce08a guibg=NONE guisp=NONE gui=NONE ctermfg=114 ctermbg=NONE cterm=NONE
hi gitcommitHeader guifg=NONE guibg=NONE guisp=NONE gui=NONE ctermfg=NONE ctermbg=NONE cterm=NONE
hi gitcommitUntrackedFile guifg=#5ad4e6 guibg=NONE guisp=NONE gui=NONE ctermfg=80 ctermbg=NONE cterm=NONE
hi gitcommitDiscardedFile guifg=#f2606e guibg=NONE guisp=NONE gui=NONE ctermfg=203 ctermbg=NONE cterm=NONE
hi gitcommitSelectedFile guifg=#7ce08a guibg=NONE guisp=NONE gui=NONE ctermfg=114 ctermbg=NONE cterm=NONE
hi gitcommitUnmergedFile guifg=#f2e86e guibg=NONE guisp=NONE gui=NONE ctermfg=221 ctermbg=NONE cterm=NONE
hi gitcommitFile guifg=NONE guibg=NONE guisp=NONE gui=NONE ctermfg=NONE ctermbg=NONE cterm=NONE
hi gitcommitSummary guifg=#dcdfe8 guibg=NONE guisp=NONE gui=NONE ctermfg=254 ctermbg=NONE cterm=NONE
hi gitcommitOverflow guifg=#f2606e guibg=NONE guisp=NONE gui=NONE ctermfg=203 ctermbg=NONE cterm=NONE

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

g:terminal_ansi_colors = [
    '#323237', '#f2606e', '#7ce08a', '#f2e86e',
    '#80a0ff', '#e88ae8', '#5ad4e6', '#8a90a5',
    '#7183bd', '#f2606e', '#7ce08a', '#f2e86e',
    '#80a0ff', '#e88ae8', '#5ad4e6', '#dcdfe8'
]

hi Comment        guifg=#7183bd guibg=NONE gui=NONE cterm=NONE
hi SpecialComment guifg=#7183bd guibg=NONE gui=NONE cterm=NONE
hi Folded         guifg=#7183bd guibg=#2a2a2f gui=NONE cterm=NONE

hi CursorLine     guibg=#3e3e46 gui=NONE cterm=NONE
hi CursorColumn   guibg=#3e3e46
hi ColorColumn    guibg=#3e3e46
hi CursorLineNr   guifg=#f2e86e guibg=NONE gui=NONE cterm=NONE
hi LineNr         guifg=#5c6072 guibg=NONE

hi MatchParen     guifg=#5ad4e6 guibg=#484852 gui=NONE cterm=NONE

hi Visual         guibg=#474756
hi VisualNOS      guibg=#474756

hi Search         guifg=#323237 guibg=#f2e86e gui=NONE cterm=NONE
hi IncSearch      guifg=#323237 guibg=#f2b45f gui=NONE cterm=NONE

hi Pmenu          guifg=#dcdfe8 guibg=#3e3e46
hi PmenuSel       guifg=#323237 guibg=#80a0ff gui=NONE cterm=NONE
hi PmenuSbar      guibg=#2a2a2f
hi PmenuThumb     guibg=#5c6072

hi VertSplit      guifg=#484852 guibg=NONE
hi WinSeparator   guifg=#484852 guibg=NONE
hi StatusLine     guifg=#dcdfe8 guibg=#3e3e46 gui=NONE cterm=NONE
hi StatusLineNC   guifg=#7183bd guibg=#2a2a2f gui=NONE cterm=NONE

hi SpellBad       guifg=NONE guisp=#f2606e gui=NONE cterm=NONE
hi SpellCap       guifg=NONE guisp=#f2e86e gui=NONE cterm=NONE
hi SpellRare      guifg=NONE guisp=#5ad4e6 gui=NONE cterm=NONE
hi SpellLocal     guifg=NONE guisp=#7ce08a gui=NONE cterm=NONE

hi DiffAdd        guifg=NONE guibg=#2c3a2e
hi DiffDelete     guifg=NONE guibg=#402d31
hi DiffChange     guifg=NONE guibg=#2f3040
hi DiffText       guifg=NONE guibg=#4a4c66

hi Title          guifg=#e88ae8 gui=NONE cterm=NONE
hi Underlined     guifg=#80a0ff gui=NONE cterm=NONE
hi Directory      guifg=#80a0ff gui=NONE cterm=NONE

hi! link SignColumn Normal
hi! link EndOfBuffer Normal
