vim9script
# supra-gui: background=#c9c9c9 include=#4078f2 stdio=#50a14f typedef=#986801 struct=#986801 type_s=#383a42 scope=#383a42 float=#986801 function=#383a42 format=#c18401 text=#50a14f integer=#c18401

hi clear

if exists("syntax_on")
  syntax reset
endif

set t_Co=256

g:colors_name = "supralight"

if !exists("g:supralight_termcolors")
	g:supralight_termcolors = 256
endif

if !exists("g:supralight_terminal_italics")
	g:supralight_terminal_italics = 0
endif

hi Comment guifg=#a0a1a7 guibg=NONE guisp=NONE gui=NONE ctermfg=59 ctermbg=NONE cterm=NONE
hi Constant guifg=#0184bc guibg=NONE guisp=NONE gui=NONE ctermfg=38 ctermbg=NONE cterm=NONE
hi String guifg=#50a14f guibg=NONE guisp=NONE gui=NONE ctermfg=114 ctermbg=NONE cterm=NONE
hi Character guifg=#50a14f guibg=NONE guisp=NONE gui=NONE ctermfg=114 ctermbg=NONE cterm=NONE
hi Number guifg=#c18401 guibg=NONE guisp=NONE gui=NONE ctermfg=173 ctermbg=NONE cterm=NONE
hi Boolean guifg=#c18401 guibg=NONE guisp=NONE gui=NONE ctermfg=173 ctermbg=NONE cterm=NONE
hi Float guifg=#c18401 guibg=NONE guisp=NONE gui=NONE ctermfg=173 ctermbg=NONE cterm=NONE
hi Identifier guifg=#e45649 guibg=NONE guisp=NONE gui=NONE ctermfg=204 ctermbg=NONE cterm=NONE
hi Function guifg=#4078f2 guibg=NONE guisp=NONE gui=NONE ctermfg=39 ctermbg=NONE cterm=NONE
hi Statement guifg=#a626a4 guibg=NONE guisp=NONE gui=NONE ctermfg=170 ctermbg=NONE cterm=NONE
hi Conditional guifg=#a626a4 guibg=NONE guisp=NONE gui=NONE ctermfg=170 ctermbg=NONE cterm=NONE
hi Repeat guifg=#a626a4 guibg=NONE guisp=NONE gui=NONE ctermfg=170 ctermbg=NONE cterm=NONE
hi Label guifg=#a626a4 guibg=NONE guisp=NONE gui=NONE ctermfg=170 ctermbg=NONE cterm=NONE
hi Operator guifg=#a626a4 guibg=NONE guisp=NONE gui=NONE ctermfg=170 ctermbg=NONE cterm=NONE
hi Keyword guifg=#a626a4 guibg=NONE guisp=NONE gui=NONE ctermfg=170 ctermbg=NONE cterm=NONE
hi Exception guifg=#a626a4 guibg=NONE guisp=NONE gui=NONE ctermfg=170 ctermbg=NONE cterm=NONE
hi PreProc guifg=#986801 guibg=NONE guisp=NONE gui=NONE ctermfg=180 ctermbg=NONE cterm=NONE
hi Include guifg=#4078f2 guibg=NONE guisp=NONE gui=NONE ctermfg=39 ctermbg=NONE cterm=NONE
hi Define guifg=#a626a4 guibg=NONE guisp=NONE gui=NONE ctermfg=170 ctermbg=NONE cterm=NONE
hi Macro guifg=#a626a4 guibg=NONE guisp=NONE gui=NONE ctermfg=170 ctermbg=NONE cterm=NONE
hi PreCondit guifg=#986801 guibg=NONE guisp=NONE gui=NONE ctermfg=180 ctermbg=NONE cterm=NONE
hi Type guifg=#986801 guibg=NONE guisp=NONE gui=NONE ctermfg=180 ctermbg=NONE cterm=NONE
hi StorageClass guifg=#986801 guibg=NONE guisp=NONE gui=NONE ctermfg=180 ctermbg=NONE cterm=NONE
hi Structure guifg=#986801 guibg=NONE guisp=NONE gui=NONE ctermfg=180 ctermbg=NONE cterm=NONE
hi Typedef guifg=#986801 guibg=NONE guisp=NONE gui=NONE ctermfg=180 ctermbg=NONE cterm=NONE
hi Special guifg=#4078f2 guibg=NONE guisp=NONE gui=NONE ctermfg=39 ctermbg=NONE cterm=NONE
hi SpecialChar guifg=#c18401 guibg=NONE guisp=NONE gui=NONE ctermfg=173 ctermbg=NONE cterm=NONE
hi Tag guifg=NONE guibg=NONE guisp=NONE gui=NONE ctermfg=NONE ctermbg=NONE cterm=NONE
hi Delimiter guifg=NONE guibg=NONE guisp=NONE gui=NONE ctermfg=NONE ctermbg=NONE cterm=NONE
hi SpecialComment guifg=#a0a1a7 guibg=NONE guisp=NONE gui=NONE ctermfg=59 ctermbg=NONE cterm=NONE
hi Debug guifg=NONE guibg=NONE guisp=NONE gui=NONE ctermfg=NONE ctermbg=NONE cterm=NONE
hi Underlined guifg=NONE guibg=NONE guisp=NONE gui=NONE ctermfg=NONE ctermbg=NONE cterm=NONE
hi Ignore guifg=NONE guibg=NONE guisp=NONE gui=NONE ctermfg=NONE ctermbg=NONE cterm=NONE
hi Error guifg=#e45649 guibg=NONE guisp=NONE gui=NONE ctermfg=204 ctermbg=NONE cterm=NONE
hi Todo guifg=#a626a4 guibg=NONE guisp=NONE gui=NONE ctermfg=170 ctermbg=NONE cterm=NONE
hi ColorColumn guifg=NONE guibg=#f0f0f0 guisp=NONE gui=NONE ctermfg=NONE ctermbg=236 cterm=NONE
hi Conceal guifg=NONE guibg=NONE guisp=NONE gui=NONE ctermfg=NONE ctermbg=NONE cterm=NONE
hi Cursor guifg=#fafafa guibg=#4078f2 guisp=NONE gui=NONE ctermfg=235 ctermbg=39 cterm=NONE
hi CursorIM guifg=NONE guibg=NONE guisp=NONE gui=NONE ctermfg=NONE ctermbg=NONE cterm=NONE
hi CursorColumn guifg=NONE guibg=#f0f0f0 guisp=NONE gui=NONE ctermfg=NONE ctermbg=236 cterm=NONE
hi CursorLine guifg=NONE guibg=#f0f0f0 guisp=NONE gui=NONE ctermfg=NONE ctermbg=236 cterm=NONE
hi Directory guifg=#4078f2 guibg=NONE guisp=NONE gui=NONE ctermfg=39 ctermbg=NONE cterm=NONE
hi DiffAdd guifg=#fafafa guibg=#50a14f guisp=NONE gui=NONE ctermfg=235 ctermbg=114 cterm=NONE
hi DiffChange guifg=#986801 guibg=NONE guisp=NONE gui=NONE ctermfg=180 ctermbg=NONE cterm=NONE
hi DiffDelete guifg=#fafafa guibg=#e45649 guisp=NONE gui=NONE ctermfg=235 ctermbg=204 cterm=NONE
hi DiffText guifg=#fafafa guibg=#986801 guisp=NONE gui=NONE ctermfg=235 ctermbg=180 cterm=NONE
hi ErrorMsg guifg=#e45649 guibg=NONE guisp=NONE gui=NONE ctermfg=204 ctermbg=NONE cterm=NONE
hi VertSplit guifg=#dcdcdc guibg=NONE guisp=NONE gui=NONE ctermfg=59 ctermbg=NONE cterm=NONE
hi Folded guifg=#a0a1a7 guibg=NONE guisp=NONE gui=NONE ctermfg=59 ctermbg=NONE cterm=NONE
hi FoldColumn guifg=NONE guibg=NONE guisp=NONE gui=NONE ctermfg=NONE ctermbg=NONE cterm=NONE
hi SignColumn guifg=NONE guibg=NONE guisp=NONE gui=NONE ctermfg=NONE ctermbg=NONE cterm=NONE
hi IncSearch guifg=#986801 guibg=#a0a1a7 guisp=NONE gui=NONE ctermfg=180 ctermbg=59 cterm=NONE
hi LineNr guifg=#b2b3b7 guibg=NONE guisp=NONE gui=NONE ctermfg=238 ctermbg=NONE cterm=NONE
hi CursorLineNr guifg=#c18401 guibg=NONE guisp=NONE gui=NONE ctermfg=NONE ctermbg=NONE cterm=NONE
hi MatchParen guifg=#4078f2 guibg=NONE guisp=NONE gui=NONE ctermfg=39 ctermbg=NONE cterm=NONE
hi ModeMsg guifg=NONE guibg=NONE guisp=NONE gui=NONE ctermfg=NONE ctermbg=NONE cterm=NONE
hi MoreMsg guifg=NONE guibg=NONE guisp=NONE gui=NONE ctermfg=NONE ctermbg=NONE cterm=NONE
hi NonText guifg=#e6e6e6 guibg=NONE guisp=NONE gui=NONE ctermfg=238 ctermbg=NONE cterm=NONE
hi Normal guifg=#383a42 guibg=#fafafa guisp=NONE gui=NONE ctermfg=145 ctermbg=235 cterm=NONE
hi Pmenu guifg=#383a42 guibg=#dcdcdc guisp=NONE gui=NONE ctermfg=145 ctermbg=237 cterm=NONE
hi PmenuSel guifg=#f0f0f0 guibg=#4078f2 guisp=NONE gui=NONE ctermfg=236 ctermbg=39 cterm=NONE
hi PmenuSbar guifg=NONE guibg=#f0f0f0 guisp=NONE gui=NONE ctermfg=NONE ctermbg=236 cterm=NONE
hi PmenuThumb guifg=NONE guibg=#383a42 guisp=NONE gui=NONE ctermfg=NONE ctermbg=145 cterm=NONE
hi Question guifg=#a626a4 guibg=NONE guisp=NONE gui=NONE ctermfg=170 ctermbg=NONE cterm=NONE
hi QuickFixLine guifg=#fafafa guibg=#986801 guisp=NONE gui=NONE ctermfg=235 ctermbg=180 cterm=NONE
hi Search guifg=#fafafa guibg=#986801 guisp=NONE gui=NONE ctermfg=235 ctermbg=180 cterm=NONE
hi SpecialKey guifg=#e6e6e6 guibg=NONE guisp=NONE gui=NONE ctermfg=238 ctermbg=NONE cterm=NONE
hi SpellBad guifg=#e45649 guibg=NONE guisp=NONE gui=NONE ctermfg=204 ctermbg=NONE cterm=NONE
hi SpellCap guifg=#c18401 guibg=NONE guisp=NONE gui=NONE ctermfg=173 ctermbg=NONE cterm=NONE
hi SpellLocal guifg=#c18401 guibg=NONE guisp=NONE gui=NONE ctermfg=173 ctermbg=NONE cterm=NONE
hi SpellRare guifg=#c18401 guibg=NONE guisp=NONE gui=NONE ctermfg=173 ctermbg=NONE cterm=NONE
hi StatusLine guifg=#383a42 guibg=#f0f0f0 guisp=NONE gui=NONE ctermfg=145 ctermbg=236 cterm=NONE
hi StatusLineNC guifg=#a0a1a7 guibg=NONE guisp=NONE gui=NONE ctermfg=59 ctermbg=NONE cterm=NONE
hi StatusLineTerm guifg=#383a42 guibg=#f0f0f0 guisp=NONE gui=NONE ctermfg=145 ctermbg=236 cterm=NONE
hi StatusLineTermNC guifg=#a0a1a7 guibg=NONE guisp=NONE gui=NONE ctermfg=59 ctermbg=NONE cterm=NONE
hi TabLine guifg=#a0a1a7 guibg=NONE guisp=NONE gui=NONE ctermfg=59 ctermbg=NONE cterm=NONE
hi TabLineFill guifg=NONE guibg=NONE guisp=NONE gui=NONE ctermfg=NONE ctermbg=NONE cterm=NONE
hi TabLineSel guifg=#383a42 guibg=NONE guisp=NONE gui=NONE ctermfg=145 ctermbg=NONE cterm=NONE
hi Terminal guifg=#383a42 guibg=#fafafa guisp=NONE gui=NONE ctermfg=145 ctermbg=235 cterm=NONE
hi Title guifg=#50a14f guibg=NONE guisp=NONE gui=NONE ctermfg=114 ctermbg=NONE cterm=NONE
hi Visual guifg=NONE guibg=#dcdcdc guisp=NONE gui=NONE ctermfg=NONE ctermbg=237 cterm=NONE
hi VisualNOS guifg=NONE guibg=#dcdcdc guisp=NONE gui=NONE ctermfg=NONE ctermbg=237 cterm=NONE
hi WarningMsg guifg=#986801 guibg=NONE guisp=NONE gui=NONE ctermfg=180 ctermbg=NONE cterm=NONE
hi WildMenu guifg=#fafafa guibg=#4078f2 guisp=NONE gui=NONE ctermfg=235 ctermbg=39 cterm=NONE

hi PMenuMatch guifg=#986801 guibg=NONE guisp=NONE gui=NONE ctermfg=180 ctermbg=237 cterm=NONE
hi PMenuKind guifg=#a626a4 guibg=NONE guisp=NONE cterm=NONE gui=NONE ctermfg=38

hi debugPC guifg=NONE guibg=#e6e6e6 guisp=NONE gui=NONE ctermfg=NONE ctermbg=238 cterm=NONE
hi debugBreakpoint guifg=#fafafa guibg=#e45649 guisp=NONE gui=NONE ctermfg=235 ctermbg=204 cterm=NONE
hi cssAttrComma guifg=#a626a4 guibg=NONE guisp=NONE gui=NONE ctermfg=170 ctermbg=NONE cterm=NONE
hi cssAttributeSelector guifg=#50a14f guibg=NONE guisp=NONE gui=NONE ctermfg=114 ctermbg=NONE cterm=NONE
hi cssBraces guifg=#383a42 guibg=NONE guisp=NONE gui=NONE ctermfg=145 ctermbg=NONE cterm=NONE
hi cssClassName guifg=#c18401 guibg=NONE guisp=NONE gui=NONE ctermfg=173 ctermbg=NONE cterm=NONE
hi cssClassNameDot guifg=#c18401 guibg=NONE guisp=NONE gui=NONE ctermfg=173 ctermbg=NONE cterm=NONE
hi cssDefinition guifg=#a626a4 guibg=NONE guisp=NONE gui=NONE ctermfg=170 ctermbg=NONE cterm=NONE
hi cssFontAttr guifg=#c18401 guibg=NONE guisp=NONE gui=NONE ctermfg=173 ctermbg=NONE cterm=NONE
hi cssFontDescriptor guifg=#a626a4 guibg=NONE guisp=NONE gui=NONE ctermfg=170 ctermbg=NONE cterm=NONE
hi cssFunctionName guifg=#4078f2 guibg=NONE guisp=NONE gui=NONE ctermfg=39 ctermbg=NONE cterm=NONE
hi cssIdentifier guifg=#4078f2 guibg=NONE guisp=NONE gui=NONE ctermfg=39 ctermbg=NONE cterm=NONE
hi cssImportant guifg=#a626a4 guibg=NONE guisp=NONE gui=NONE ctermfg=170 ctermbg=NONE cterm=NONE
hi cssInclude guifg=#383a42 guibg=NONE guisp=NONE gui=NONE ctermfg=145 ctermbg=NONE cterm=NONE
hi cssIncludeKeyword guifg=#a626a4 guibg=NONE guisp=NONE gui=NONE ctermfg=170 ctermbg=NONE cterm=NONE
hi cssMediaType guifg=#c18401 guibg=NONE guisp=NONE gui=NONE ctermfg=173 ctermbg=NONE cterm=NONE
hi cssProp guifg=#383a42 guibg=NONE guisp=NONE gui=NONE ctermfg=145 ctermbg=NONE cterm=NONE
hi cssPseudoClassId guifg=#c18401 guibg=NONE guisp=NONE gui=NONE ctermfg=173 ctermbg=NONE cterm=NONE
hi cssSelectorOp guifg=#a626a4 guibg=NONE guisp=NONE gui=NONE ctermfg=170 ctermbg=NONE cterm=NONE
hi cssSelectorOp2 guifg=#a626a4 guibg=NONE guisp=NONE gui=NONE ctermfg=170 ctermbg=NONE cterm=NONE
hi cssTagName guifg=#e45649 guibg=NONE guisp=NONE gui=NONE ctermfg=204 ctermbg=NONE cterm=NONE
hi fishKeyword guifg=#a626a4 guibg=NONE guisp=NONE gui=NONE ctermfg=170 ctermbg=NONE cterm=NONE
hi fishConditional guifg=#a626a4 guibg=NONE guisp=NONE gui=NONE ctermfg=170 ctermbg=NONE cterm=NONE
hi goDeclaration guifg=#a626a4 guibg=NONE guisp=NONE gui=NONE ctermfg=170 ctermbg=NONE cterm=NONE
hi goBuiltins guifg=#0184bc guibg=NONE guisp=NONE gui=NONE ctermfg=38 ctermbg=NONE cterm=NONE
hi goFunctionCall guifg=#4078f2 guibg=NONE guisp=NONE gui=NONE ctermfg=39 ctermbg=NONE cterm=NONE
hi goVarDefs guifg=#e45649 guibg=NONE guisp=NONE gui=NONE ctermfg=204 ctermbg=NONE cterm=NONE
hi goVarAssign guifg=#e45649 guibg=NONE guisp=NONE gui=NONE ctermfg=204 ctermbg=NONE cterm=NONE
hi goVar guifg=#a626a4 guibg=NONE guisp=NONE gui=NONE ctermfg=170 ctermbg=NONE cterm=NONE
hi goConst guifg=#a626a4 guibg=NONE guisp=NONE gui=NONE ctermfg=170 ctermbg=NONE cterm=NONE
hi goType guifg=#986801 guibg=NONE guisp=NONE gui=NONE ctermfg=180 ctermbg=NONE cterm=NONE
hi goTypeName guifg=#986801 guibg=NONE guisp=NONE gui=NONE ctermfg=180 ctermbg=NONE cterm=NONE
hi goDeclType guifg=#0184bc guibg=NONE guisp=NONE gui=NONE ctermfg=38 ctermbg=NONE cterm=NONE
hi goTypeDecl guifg=#a626a4 guibg=NONE guisp=NONE gui=NONE ctermfg=170 ctermbg=NONE cterm=NONE
hi htmlArg guifg=#c18401 guibg=NONE guisp=NONE gui=NONE ctermfg=173 ctermbg=NONE cterm=NONE
hi htmlBold guifg=#c18401 guibg=NONE guisp=NONE gui=NONE ctermfg=173 ctermbg=NONE cterm=NONE
hi htmlBoldItalic guifg=#50a14f guibg=NONE guisp=NONE gui=NONE ctermfg=114 ctermbg=NONE cterm=NONE
hi htmlEndTag guifg=#383a42 guibg=NONE guisp=NONE gui=NONE ctermfg=145 ctermbg=NONE cterm=NONE
hi htmlH1 guifg=#e45649 guibg=NONE guisp=NONE gui=NONE ctermfg=204 ctermbg=NONE cterm=NONE
hi htmlH2 guifg=#e45649 guibg=NONE guisp=NONE gui=NONE ctermfg=204 ctermbg=NONE cterm=NONE
hi htmlH3 guifg=#e45649 guibg=NONE guisp=NONE gui=NONE ctermfg=204 ctermbg=NONE cterm=NONE
hi htmlH4 guifg=#e45649 guibg=NONE guisp=NONE gui=NONE ctermfg=204 ctermbg=NONE cterm=NONE
hi htmlH5 guifg=#e45649 guibg=NONE guisp=NONE gui=NONE ctermfg=204 ctermbg=NONE cterm=NONE
hi htmlH6 guifg=#e45649 guibg=NONE guisp=NONE gui=NONE ctermfg=204 ctermbg=NONE cterm=NONE
hi htmlItalic guifg=#a626a4 guibg=NONE guisp=NONE gui=NONE ctermfg=170 ctermbg=NONE cterm=NONE
hi htmlLink guifg=#0184bc guibg=NONE guisp=NONE gui=NONE ctermfg=38 ctermbg=NONE cterm=NONE
hi htmlSpecialChar guifg=#c18401 guibg=NONE guisp=NONE gui=NONE ctermfg=173 ctermbg=NONE cterm=NONE
hi htmlSpecialTagName guifg=#e45649 guibg=NONE guisp=NONE gui=NONE ctermfg=204 ctermbg=NONE cterm=NONE
hi htmlTag guifg=#383a42 guibg=NONE guisp=NONE gui=NONE ctermfg=145 ctermbg=NONE cterm=NONE
hi htmlTagN guifg=#e45649 guibg=NONE guisp=NONE gui=NONE ctermfg=204 ctermbg=NONE cterm=NONE
hi htmlTagName guifg=#e45649 guibg=NONE guisp=NONE gui=NONE ctermfg=204 ctermbg=NONE cterm=NONE
hi htmlTitle guifg=#383a42 guibg=NONE guisp=NONE gui=NONE ctermfg=145 ctermbg=NONE cterm=NONE
hi javaScriptBraces guifg=#383a42 guibg=NONE guisp=NONE gui=NONE ctermfg=145 ctermbg=NONE cterm=NONE
hi javaScriptFunction guifg=#a626a4 guibg=NONE guisp=NONE gui=NONE ctermfg=170 ctermbg=NONE cterm=NONE
hi javaScriptIdentifier guifg=#a626a4 guibg=NONE guisp=NONE gui=NONE ctermfg=170 ctermbg=NONE cterm=NONE
hi javaScriptNull guifg=#c18401 guibg=NONE guisp=NONE gui=NONE ctermfg=173 ctermbg=NONE cterm=NONE
hi javaScriptNumber guifg=#c18401 guibg=NONE guisp=NONE gui=NONE ctermfg=173 ctermbg=NONE cterm=NONE
hi javaScriptRequire guifg=#0184bc guibg=NONE guisp=NONE gui=NONE ctermfg=38 ctermbg=NONE cterm=NONE
hi javaScriptReserved guifg=#a626a4 guibg=NONE guisp=NONE gui=NONE ctermfg=170 ctermbg=NONE cterm=NONE
hi jsArrowFunction guifg=#a626a4 guibg=NONE guisp=NONE gui=NONE ctermfg=170 ctermbg=NONE cterm=NONE
hi jsClassKeyword guifg=#a626a4 guibg=NONE guisp=NONE gui=NONE ctermfg=170 ctermbg=NONE cterm=NONE
hi jsClassMethodType guifg=#a626a4 guibg=NONE guisp=NONE gui=NONE ctermfg=170 ctermbg=NONE cterm=NONE
hi jsDocParam guifg=#4078f2 guibg=NONE guisp=NONE gui=NONE ctermfg=39 ctermbg=NONE cterm=NONE
hi jsDocTags guifg=#a626a4 guibg=NONE guisp=NONE gui=NONE ctermfg=170 ctermbg=NONE cterm=NONE
hi jsExport guifg=#a626a4 guibg=NONE guisp=NONE gui=NONE ctermfg=170 ctermbg=NONE cterm=NONE
hi jsExportDefault guifg=#a626a4 guibg=NONE guisp=NONE gui=NONE ctermfg=170 ctermbg=NONE cterm=NONE
hi jsExtendsKeyword guifg=#a626a4 guibg=NONE guisp=NONE gui=NONE ctermfg=170 ctermbg=NONE cterm=NONE
hi jsFrom guifg=#a626a4 guibg=NONE guisp=NONE gui=NONE ctermfg=170 ctermbg=NONE cterm=NONE
hi jsFuncCall guifg=#4078f2 guibg=NONE guisp=NONE gui=NONE ctermfg=39 ctermbg=NONE cterm=NONE
hi jsFunction guifg=#a626a4 guibg=NONE guisp=NONE gui=NONE ctermfg=170 ctermbg=NONE cterm=NONE
hi jsGenerator guifg=#986801 guibg=NONE guisp=NONE gui=NONE ctermfg=180 ctermbg=NONE cterm=NONE
hi jsGlobalObjects guifg=#986801 guibg=NONE guisp=NONE gui=NONE ctermfg=180 ctermbg=NONE cterm=NONE
hi jsImport guifg=#a626a4 guibg=NONE guisp=NONE gui=NONE ctermfg=170 ctermbg=NONE cterm=NONE
hi jsModuleAs guifg=#a626a4 guibg=NONE guisp=NONE gui=NONE ctermfg=170 ctermbg=NONE cterm=NONE
hi jsModuleWords guifg=#a626a4 guibg=NONE guisp=NONE gui=NONE ctermfg=170 ctermbg=NONE cterm=NONE
hi jsModules guifg=#a626a4 guibg=NONE guisp=NONE gui=NONE ctermfg=170 ctermbg=NONE cterm=NONE
hi jsNull guifg=#c18401 guibg=NONE guisp=NONE gui=NONE ctermfg=173 ctermbg=NONE cterm=NONE
hi jsOperator guifg=#a626a4 guibg=NONE guisp=NONE gui=NONE ctermfg=170 ctermbg=NONE cterm=NONE
hi jsStorageClass guifg=#a626a4 guibg=NONE guisp=NONE gui=NONE ctermfg=170 ctermbg=NONE cterm=NONE
hi jsSuper guifg=#e45649 guibg=NONE guisp=NONE gui=NONE ctermfg=204 ctermbg=NONE cterm=NONE
hi jsTemplateBraces guifg=#833b3b guibg=NONE guisp=NONE gui=NONE ctermfg=196 ctermbg=NONE cterm=NONE
hi jsTemplateVar guifg=#50a14f guibg=NONE guisp=NONE gui=NONE ctermfg=114 ctermbg=NONE cterm=NONE
hi jsThis guifg=#e45649 guibg=NONE guisp=NONE gui=NONE ctermfg=204 ctermbg=NONE cterm=NONE
hi jsUndefined guifg=#c18401 guibg=NONE guisp=NONE gui=NONE ctermfg=173 ctermbg=NONE cterm=NONE
hi javascriptArrowFunc guifg=#a626a4 guibg=NONE guisp=NONE gui=NONE ctermfg=170 ctermbg=NONE cterm=NONE
hi javascriptClassExtends guifg=#a626a4 guibg=NONE guisp=NONE gui=NONE ctermfg=170 ctermbg=NONE cterm=NONE
hi javascriptClassKeyword guifg=#a626a4 guibg=NONE guisp=NONE gui=NONE ctermfg=170 ctermbg=NONE cterm=NONE
hi javascriptDocNotation guifg=#a626a4 guibg=NONE guisp=NONE gui=NONE ctermfg=170 ctermbg=NONE cterm=NONE
hi javascriptDocParamName guifg=#4078f2 guibg=NONE guisp=NONE gui=NONE ctermfg=39 ctermbg=NONE cterm=NONE
hi javascriptDocTags guifg=#a626a4 guibg=NONE guisp=NONE gui=NONE ctermfg=170 ctermbg=NONE cterm=NONE
hi javascriptEndColons guifg=#383a42 guibg=NONE guisp=NONE gui=NONE ctermfg=145 ctermbg=NONE cterm=NONE
hi javascriptExport guifg=#a626a4 guibg=NONE guisp=NONE gui=NONE ctermfg=170 ctermbg=NONE cterm=NONE
hi javascriptFuncArg guifg=#383a42 guibg=NONE guisp=NONE gui=NONE ctermfg=145 ctermbg=NONE cterm=NONE
hi javascriptFuncKeyword guifg=#a626a4 guibg=NONE guisp=NONE gui=NONE ctermfg=170 ctermbg=NONE cterm=NONE
hi javascriptIdentifier guifg=#e45649 guibg=NONE guisp=NONE gui=NONE ctermfg=204 ctermbg=NONE cterm=NONE
hi javascriptImport guifg=#a626a4 guibg=NONE guisp=NONE gui=NONE ctermfg=170 ctermbg=NONE cterm=NONE
hi javascriptMethodName guifg=#383a42 guibg=NONE guisp=NONE gui=NONE ctermfg=145 ctermbg=NONE cterm=NONE
hi javascriptObjectLabel guifg=#383a42 guibg=NONE guisp=NONE gui=NONE ctermfg=145 ctermbg=NONE cterm=NONE
hi javascriptOpSymbol guifg=#0184bc guibg=NONE guisp=NONE gui=NONE ctermfg=38 ctermbg=NONE cterm=NONE
hi javascriptOpSymbols guifg=#0184bc guibg=NONE guisp=NONE gui=NONE ctermfg=38 ctermbg=NONE cterm=NONE
hi javascriptPropertyName guifg=#50a14f guibg=NONE guisp=NONE gui=NONE ctermfg=114 ctermbg=NONE cterm=NONE
hi javascriptTemplateSB guifg=#833b3b guibg=NONE guisp=NONE gui=NONE ctermfg=196 ctermbg=NONE cterm=NONE
hi javascriptVariable guifg=#a626a4 guibg=NONE guisp=NONE gui=NONE ctermfg=170 ctermbg=NONE cterm=NONE
hi jsonCommentError guifg=#383a42 guibg=NONE guisp=NONE gui=NONE ctermfg=145 ctermbg=NONE cterm=NONE
hi jsonKeyword guifg=#e45649 guibg=NONE guisp=NONE gui=NONE ctermfg=204 ctermbg=NONE cterm=NONE
hi jsonBoolean guifg=#c18401 guibg=NONE guisp=NONE gui=NONE ctermfg=173 ctermbg=NONE cterm=NONE
hi jsonNumber guifg=#c18401 guibg=NONE guisp=NONE gui=NONE ctermfg=173 ctermbg=NONE cterm=NONE
hi jsonQuote guifg=#383a42 guibg=NONE guisp=NONE gui=NONE ctermfg=145 ctermbg=NONE cterm=NONE
hi jsonMissingCommaError guifg=#e45649 guibg=NONE guisp=NONE gui=NONE ctermfg=204 ctermbg=NONE cterm=NONE
hi jsonNoQuotesError guifg=#e45649 guibg=NONE guisp=NONE gui=NONE ctermfg=204 ctermbg=NONE cterm=NONE
hi jsonNumError guifg=#e45649 guibg=NONE guisp=NONE gui=NONE ctermfg=204 ctermbg=NONE cterm=NONE
hi jsonString guifg=#50a14f guibg=NONE guisp=NONE gui=NONE ctermfg=114 ctermbg=NONE cterm=NONE
hi jsonStringSQError guifg=#e45649 guibg=NONE guisp=NONE gui=NONE ctermfg=204 ctermbg=NONE cterm=NONE
hi jsonSemicolonError guifg=#e45649 guibg=NONE guisp=NONE gui=NONE ctermfg=204 ctermbg=NONE cterm=NONE
hi lessVariable guifg=#a626a4 guibg=NONE guisp=NONE gui=NONE ctermfg=170 ctermbg=NONE cterm=NONE
hi lessAmpersandChar guifg=#383a42 guibg=NONE guisp=NONE gui=NONE ctermfg=145 ctermbg=NONE cterm=NONE
hi lessClass guifg=#c18401 guibg=NONE guisp=NONE gui=NONE ctermfg=173 ctermbg=NONE cterm=NONE
hi markdownBlockquote guifg=#a0a1a7 guibg=NONE guisp=NONE gui=NONE ctermfg=59 ctermbg=NONE cterm=NONE
hi markdownBold guifg=#c18401 guibg=NONE guisp=NONE gui=NONE ctermfg=173 ctermbg=NONE cterm=NONE
hi markdownBoldItalic guifg=#50a14f guibg=NONE guisp=NONE gui=NONE ctermfg=114 ctermbg=NONE cterm=NONE
hi markdownCode guifg=#50a14f guibg=NONE guisp=NONE gui=NONE ctermfg=114 ctermbg=NONE cterm=NONE
hi markdownCodeBlock guifg=#50a14f guibg=NONE guisp=NONE gui=NONE ctermfg=114 ctermbg=NONE cterm=NONE
hi markdownCodeDelimiter guifg=#50a14f guibg=NONE guisp=NONE gui=NONE ctermfg=114 ctermbg=NONE cterm=NONE
hi markdownH1 guifg=#e45649 guibg=NONE guisp=NONE gui=NONE ctermfg=204 ctermbg=NONE cterm=NONE
hi markdownH2 guifg=#e45649 guibg=NONE guisp=NONE gui=NONE ctermfg=204 ctermbg=NONE cterm=NONE
hi markdownH3 guifg=#e45649 guibg=NONE guisp=NONE gui=NONE ctermfg=204 ctermbg=NONE cterm=NONE
hi markdownH4 guifg=#e45649 guibg=NONE guisp=NONE gui=NONE ctermfg=204 ctermbg=NONE cterm=NONE
hi markdownH5 guifg=#e45649 guibg=NONE guisp=NONE gui=NONE ctermfg=204 ctermbg=NONE cterm=NONE
hi markdownH6 guifg=#e45649 guibg=NONE guisp=NONE gui=NONE ctermfg=204 ctermbg=NONE cterm=NONE
hi markdownHeadingDelimiter guifg=#e45649 guibg=NONE guisp=NONE gui=NONE ctermfg=204 ctermbg=NONE cterm=NONE
hi markdownHeadingRule guifg=#a0a1a7 guibg=NONE guisp=NONE gui=NONE ctermfg=59 ctermbg=NONE cterm=NONE
hi markdownId guifg=#a626a4 guibg=NONE guisp=NONE gui=NONE ctermfg=170 ctermbg=NONE cterm=NONE
hi markdownIdDeclaration guifg=#4078f2 guibg=NONE guisp=NONE gui=NONE ctermfg=39 ctermbg=NONE cterm=NONE
hi markdownIdDelimiter guifg=#a626a4 guibg=NONE guisp=NONE gui=NONE ctermfg=170 ctermbg=NONE cterm=NONE
hi markdownItalic guifg=#a626a4 guibg=NONE guisp=NONE gui=NONE ctermfg=170 ctermbg=NONE cterm=NONE
hi markdownLinkDelimiter guifg=#a626a4 guibg=NONE guisp=NONE gui=NONE ctermfg=170 ctermbg=NONE cterm=NONE
hi markdownLinkText guifg=#4078f2 guibg=NONE guisp=NONE gui=NONE ctermfg=39 ctermbg=NONE cterm=NONE
hi markdownListMarker guifg=#e45649 guibg=NONE guisp=NONE gui=NONE ctermfg=204 ctermbg=NONE cterm=NONE
hi markdownOrderedListMarker guifg=#e45649 guibg=NONE guisp=NONE gui=NONE ctermfg=204 ctermbg=NONE cterm=NONE
hi markdownRule guifg=#a0a1a7 guibg=NONE guisp=NONE gui=NONE ctermfg=59 ctermbg=NONE cterm=NONE
hi markdownUrl guifg=#0184bc guibg=NONE guisp=NONE gui=NONE ctermfg=38 ctermbg=NONE cterm=NONE
hi perlFiledescRead guifg=#50a14f guibg=NONE guisp=NONE gui=NONE ctermfg=114 ctermbg=NONE cterm=NONE
hi perlFunction guifg=#a626a4 guibg=NONE guisp=NONE gui=NONE ctermfg=170 ctermbg=NONE cterm=NONE
hi perlMatchStartEnd guifg=#4078f2 guibg=NONE guisp=NONE gui=NONE ctermfg=39 ctermbg=NONE cterm=NONE
hi perlMethod guifg=#a626a4 guibg=NONE guisp=NONE gui=NONE ctermfg=170 ctermbg=NONE cterm=NONE
hi perlPOD guifg=#a0a1a7 guibg=NONE guisp=NONE gui=NONE ctermfg=59 ctermbg=NONE cterm=NONE
hi perlSharpBang guifg=#a0a1a7 guibg=NONE guisp=NONE gui=NONE ctermfg=59 ctermbg=NONE cterm=NONE
hi perlSpecialString guifg=#c18401 guibg=NONE guisp=NONE gui=NONE ctermfg=173 ctermbg=NONE cterm=NONE
hi perlStatementFiledesc guifg=#e45649 guibg=NONE guisp=NONE gui=NONE ctermfg=204 ctermbg=NONE cterm=NONE
hi perlStatementFlow guifg=#e45649 guibg=NONE guisp=NONE gui=NONE ctermfg=204 ctermbg=NONE cterm=NONE
hi perlStatementInclude guifg=#a626a4 guibg=NONE guisp=NONE gui=NONE ctermfg=170 ctermbg=NONE cterm=NONE
hi perlStatementScalar guifg=#a626a4 guibg=NONE guisp=NONE gui=NONE ctermfg=170 ctermbg=NONE cterm=NONE
hi perlStatementStorage guifg=#a626a4 guibg=NONE guisp=NONE gui=NONE ctermfg=170 ctermbg=NONE cterm=NONE
hi perlSubName guifg=#986801 guibg=NONE guisp=NONE gui=NONE ctermfg=180 ctermbg=NONE cterm=NONE
hi perlVarPlain guifg=#4078f2 guibg=NONE guisp=NONE gui=NONE ctermfg=39 ctermbg=NONE cterm=NONE
hi phpVarSelector guifg=#e45649 guibg=NONE guisp=NONE gui=NONE ctermfg=204 ctermbg=NONE cterm=NONE
hi phpOperator guifg=#383a42 guibg=NONE guisp=NONE gui=NONE ctermfg=145 ctermbg=NONE cterm=NONE
hi phpParent guifg=#383a42 guibg=NONE guisp=NONE gui=NONE ctermfg=145 ctermbg=NONE cterm=NONE
hi phpMemberSelector guifg=#383a42 guibg=NONE guisp=NONE gui=NONE ctermfg=145 ctermbg=NONE cterm=NONE
hi phpType guifg=#a626a4 guibg=NONE guisp=NONE gui=NONE ctermfg=170 ctermbg=NONE cterm=NONE
hi phpKeyword guifg=#a626a4 guibg=NONE guisp=NONE gui=NONE ctermfg=170 ctermbg=NONE cterm=NONE
hi phpClass guifg=#986801 guibg=NONE guisp=NONE gui=NONE ctermfg=180 ctermbg=NONE cterm=NONE
hi phpUseClass guifg=#383a42 guibg=NONE guisp=NONE gui=NONE ctermfg=145 ctermbg=NONE cterm=NONE
hi phpUseAlias guifg=#383a42 guibg=NONE guisp=NONE gui=NONE ctermfg=145 ctermbg=NONE cterm=NONE
hi phpInclude guifg=#a626a4 guibg=NONE guisp=NONE gui=NONE ctermfg=170 ctermbg=NONE cterm=NONE
hi phpClassExtends guifg=#50a14f guibg=NONE guisp=NONE gui=NONE ctermfg=114 ctermbg=NONE cterm=NONE
hi phpDocTags guifg=#383a42 guibg=NONE guisp=NONE gui=NONE ctermfg=145 ctermbg=NONE cterm=NONE
hi phpFunction guifg=#4078f2 guibg=NONE guisp=NONE gui=NONE ctermfg=39 ctermbg=NONE cterm=NONE
hi phpFunctions guifg=#0184bc guibg=NONE guisp=NONE gui=NONE ctermfg=38 ctermbg=NONE cterm=NONE
hi phpMethodsVar guifg=#c18401 guibg=NONE guisp=NONE gui=NONE ctermfg=173 ctermbg=NONE cterm=NONE
hi phpMagicConstants guifg=#c18401 guibg=NONE guisp=NONE gui=NONE ctermfg=173 ctermbg=NONE cterm=NONE
hi phpSuperglobals guifg=#e45649 guibg=NONE guisp=NONE gui=NONE ctermfg=204 ctermbg=NONE cterm=NONE
hi phpConstants guifg=#c18401 guibg=NONE guisp=NONE gui=NONE ctermfg=173 ctermbg=NONE cterm=NONE
hi rubyBlockParameter guifg=#e45649 guibg=NONE guisp=NONE gui=NONE ctermfg=204 ctermbg=NONE cterm=NONE
hi rubyBlockParameterList guifg=#e45649 guibg=NONE guisp=NONE gui=NONE ctermfg=204 ctermbg=NONE cterm=NONE
hi rubyClass guifg=#a626a4 guibg=NONE guisp=NONE gui=NONE ctermfg=170 ctermbg=NONE cterm=NONE
hi rubyConstant guifg=#986801 guibg=NONE guisp=NONE gui=NONE ctermfg=180 ctermbg=NONE cterm=NONE
hi rubyControl guifg=#a626a4 guibg=NONE guisp=NONE gui=NONE ctermfg=170 ctermbg=NONE cterm=NONE
hi rubyEscape guifg=#e45649 guibg=NONE guisp=NONE gui=NONE ctermfg=204 ctermbg=NONE cterm=NONE
hi rubyFunction guifg=#4078f2 guibg=NONE guisp=NONE gui=NONE ctermfg=39 ctermbg=NONE cterm=NONE
hi rubyGlobalVariable guifg=#e45649 guibg=NONE guisp=NONE gui=NONE ctermfg=204 ctermbg=NONE cterm=NONE
hi rubyInclude guifg=#4078f2 guibg=NONE guisp=NONE gui=NONE ctermfg=39 ctermbg=NONE cterm=NONE
hi rubyIncluderubyGlobalVariable guifg=#e45649 guibg=NONE guisp=NONE gui=NONE ctermfg=204 ctermbg=NONE cterm=NONE
hi rubyInstanceVariable guifg=#e45649 guibg=NONE guisp=NONE gui=NONE ctermfg=204 ctermbg=NONE cterm=NONE
hi rubyInterpolation guifg=#0184bc guibg=NONE guisp=NONE gui=NONE ctermfg=38 ctermbg=NONE cterm=NONE
hi rubyInterpolationDelimiter guifg=#e45649 guibg=NONE guisp=NONE gui=NONE ctermfg=204 ctermbg=NONE cterm=NONE
hi rubyInterpolationDelimiter guifg=#e45649 guibg=NONE guisp=NONE gui=NONE ctermfg=204 ctermbg=NONE cterm=NONE
hi rubyRegexp guifg=#0184bc guibg=NONE guisp=NONE gui=NONE ctermfg=38 ctermbg=NONE cterm=NONE
hi rubyRegexpDelimiter guifg=#0184bc guibg=NONE guisp=NONE gui=NONE ctermfg=38 ctermbg=NONE cterm=NONE
hi rubyStringDelimiter guifg=#50a14f guibg=NONE guisp=NONE gui=NONE ctermfg=114 ctermbg=NONE cterm=NONE
hi rubySymbol guifg=#0184bc guibg=NONE guisp=NONE gui=NONE ctermfg=38 ctermbg=NONE cterm=NONE
hi sassAmpersand guifg=#e45649 guibg=NONE guisp=NONE gui=NONE ctermfg=204 ctermbg=NONE cterm=NONE
hi sassClass guifg=#c18401 guibg=NONE guisp=NONE gui=NONE ctermfg=173 ctermbg=NONE cterm=NONE
hi sassControl guifg=#a626a4 guibg=NONE guisp=NONE gui=NONE ctermfg=170 ctermbg=NONE cterm=NONE
hi sassExtend guifg=#a626a4 guibg=NONE guisp=NONE gui=NONE ctermfg=170 ctermbg=NONE cterm=NONE
hi sassFor guifg=#383a42 guibg=NONE guisp=NONE gui=NONE ctermfg=145 ctermbg=NONE cterm=NONE
hi sassFunction guifg=#0184bc guibg=NONE guisp=NONE gui=NONE ctermfg=38 ctermbg=NONE cterm=NONE
hi sassId guifg=#4078f2 guibg=NONE guisp=NONE gui=NONE ctermfg=39 ctermbg=NONE cterm=NONE
hi sassInclude guifg=#a626a4 guibg=NONE guisp=NONE gui=NONE ctermfg=170 ctermbg=NONE cterm=NONE
hi sassMedia guifg=#a626a4 guibg=NONE guisp=NONE gui=NONE ctermfg=170 ctermbg=NONE cterm=NONE
hi sassMediaOperators guifg=#383a42 guibg=NONE guisp=NONE gui=NONE ctermfg=145 ctermbg=NONE cterm=NONE
hi sassMixin guifg=#a626a4 guibg=NONE guisp=NONE gui=NONE ctermfg=170 ctermbg=NONE cterm=NONE
hi sassMixinName guifg=#4078f2 guibg=NONE guisp=NONE gui=NONE ctermfg=39 ctermbg=NONE cterm=NONE
hi sassMixing guifg=#a626a4 guibg=NONE guisp=NONE gui=NONE ctermfg=170 ctermbg=NONE cterm=NONE
hi sassVariable guifg=#a626a4 guibg=NONE guisp=NONE gui=NONE ctermfg=170 ctermbg=NONE cterm=NONE
hi scssExtend guifg=#a626a4 guibg=NONE guisp=NONE gui=NONE ctermfg=170 ctermbg=NONE cterm=NONE
hi scssImport guifg=#a626a4 guibg=NONE guisp=NONE gui=NONE ctermfg=170 ctermbg=NONE cterm=NONE
hi scssInclude guifg=#a626a4 guibg=NONE guisp=NONE gui=NONE ctermfg=170 ctermbg=NONE cterm=NONE
hi scssMixin guifg=#a626a4 guibg=NONE guisp=NONE gui=NONE ctermfg=170 ctermbg=NONE cterm=NONE
hi scssSelectorName guifg=#c18401 guibg=NONE guisp=NONE gui=NONE ctermfg=173 ctermbg=NONE cterm=NONE
hi scssVariable guifg=#a626a4 guibg=NONE guisp=NONE gui=NONE ctermfg=170 ctermbg=NONE cterm=NONE
hi texStatement guifg=#a626a4 guibg=NONE guisp=NONE gui=NONE ctermfg=170 ctermbg=NONE cterm=NONE
hi texSubscripts guifg=#c18401 guibg=NONE guisp=NONE gui=NONE ctermfg=173 ctermbg=NONE cterm=NONE
hi texSuperscripts guifg=#c18401 guibg=NONE guisp=NONE gui=NONE ctermfg=173 ctermbg=NONE cterm=NONE
hi texTodo guifg=#833b3b guibg=NONE guisp=NONE gui=NONE ctermfg=196 ctermbg=NONE cterm=NONE
hi texBeginEnd guifg=#a626a4 guibg=NONE guisp=NONE gui=NONE ctermfg=170 ctermbg=NONE cterm=NONE
hi texBeginEndName guifg=#4078f2 guibg=NONE guisp=NONE gui=NONE ctermfg=39 ctermbg=NONE cterm=NONE
hi texMathMatcher guifg=#4078f2 guibg=NONE guisp=NONE gui=NONE ctermfg=39 ctermbg=NONE cterm=NONE
hi texMathDelim guifg=#4078f2 guibg=NONE guisp=NONE gui=NONE ctermfg=39 ctermbg=NONE cterm=NONE
hi texDelimiter guifg=#c18401 guibg=NONE guisp=NONE gui=NONE ctermfg=173 ctermbg=NONE cterm=NONE
hi texSpecialChar guifg=#c18401 guibg=NONE guisp=NONE gui=NONE ctermfg=173 ctermbg=NONE cterm=NONE
hi texCite guifg=#4078f2 guibg=NONE guisp=NONE gui=NONE ctermfg=39 ctermbg=NONE cterm=NONE
hi texRefZone guifg=#4078f2 guibg=NONE guisp=NONE gui=NONE ctermfg=39 ctermbg=NONE cterm=NONE
hi typescriptReserved guifg=#a626a4 guibg=NONE guisp=NONE gui=NONE ctermfg=170 ctermbg=NONE cterm=NONE
hi typescriptEndColons guifg=#383a42 guibg=NONE guisp=NONE gui=NONE ctermfg=145 ctermbg=NONE cterm=NONE
hi typescriptBraces guifg=#383a42 guibg=NONE guisp=NONE gui=NONE ctermfg=145 ctermbg=NONE cterm=NONE
hi xmlAttrib guifg=#c18401 guibg=NONE guisp=NONE gui=NONE ctermfg=173 ctermbg=NONE cterm=NONE
hi xmlEndTag guifg=#e45649 guibg=NONE guisp=NONE gui=NONE ctermfg=204 ctermbg=NONE cterm=NONE
hi xmlTag guifg=#e45649 guibg=NONE guisp=NONE gui=NONE ctermfg=204 ctermbg=NONE cterm=NONE
hi xmlTagName guifg=#e45649 guibg=NONE guisp=NONE gui=NONE ctermfg=204 ctermbg=NONE cterm=NONE
hi GitGutterAdd guifg=#50a14f guibg=NONE guisp=NONE gui=NONE ctermfg=114 ctermbg=NONE cterm=NONE
hi GitGutterChange guifg=#986801 guibg=NONE guisp=NONE gui=NONE ctermfg=180 ctermbg=NONE cterm=NONE
hi GitGutterDelete guifg=#e45649 guibg=NONE guisp=NONE gui=NONE ctermfg=204 ctermbg=NONE cterm=NONE
hi ALEError guifg=#e45649 guibg=NONE guisp=NONE gui=NONE ctermfg=204 ctermbg=NONE cterm=NONE
hi ALEWarning guifg=#986801 guibg=NONE guisp=NONE gui=NONE ctermfg=180 ctermbg=NONE cterm=NONE
hi ALEInfo guifg=NONE guibg=NONE guisp=NONE gui=NONE ctermfg=NONE ctermbg=NONE cterm=NONE
hi ALEErrorSign guifg=#e45649 guibg=NONE guisp=NONE gui=NONE ctermfg=204 ctermbg=NONE cterm=NONE
hi ALEWarningSign guifg=#986801 guibg=NONE guisp=NONE gui=NONE ctermfg=180 ctermbg=NONE cterm=NONE
hi ALEInfoSign guifg=NONE guibg=NONE guisp=NONE gui=NONE ctermfg=NONE ctermbg=NONE cterm=NONE
hi EasyMotionTarget guifg=#e45649 guibg=NONE guisp=NONE gui=NONE ctermfg=204 ctermbg=NONE cterm=NONE
hi EasyMotionTarget2First guifg=#986801 guibg=NONE guisp=NONE gui=NONE ctermfg=180 ctermbg=NONE cterm=NONE
hi EasyMotionTarget2Second guifg=#c18401 guibg=NONE guisp=NONE gui=NONE ctermfg=173 ctermbg=NONE cterm=NONE
hi EasyMotionShade guifg=#a0a1a7 guibg=NONE guisp=NONE gui=NONE ctermfg=59 ctermbg=NONE cterm=NONE
hi CocErrorSign guifg=#e45649 guibg=NONE guisp=NONE gui=NONE ctermfg=204 ctermbg=NONE cterm=NONE
hi CocWarningSign guifg=#986801 guibg=NONE guisp=NONE gui=NONE ctermfg=180 ctermbg=NONE cterm=NONE
hi CocInfoSign guifg=#4078f2 guibg=NONE guisp=NONE gui=NONE ctermfg=39 ctermbg=NONE cterm=NONE
hi CocHintSign guifg=#0184bc guibg=NONE guisp=NONE gui=NONE ctermfg=38 ctermbg=NONE cterm=NONE
hi CocFadeOut guifg=#a0a1a7 guibg=NONE guisp=NONE gui=NONE ctermfg=59 ctermbg=NONE cterm=NONE
hi NeomakeErrorSign guifg=#e45649 guibg=NONE guisp=NONE gui=NONE ctermfg=204 ctermbg=NONE cterm=NONE
hi NeomakeWarningSign guifg=#986801 guibg=NONE guisp=NONE gui=NONE ctermfg=180 ctermbg=NONE cterm=NONE
hi NeomakeInfoSign guifg=#4078f2 guibg=NONE guisp=NONE gui=NONE ctermfg=39 ctermbg=NONE cterm=NONE
hi mkdDelimiter guifg=#a626a4 guibg=NONE guisp=NONE gui=NONE ctermfg=170 ctermbg=NONE cterm=NONE
hi mkdHeading guifg=#e45649 guibg=NONE guisp=NONE gui=NONE ctermfg=204 ctermbg=NONE cterm=NONE
hi mkdLink guifg=#4078f2 guibg=NONE guisp=NONE gui=NONE ctermfg=39 ctermbg=NONE cterm=NONE
hi mkdURL guifg=#0184bc guibg=NONE guisp=NONE gui=NONE ctermfg=38 ctermbg=NONE cterm=NONE
hi LspErrorText guifg=#e45649 guibg=NONE guisp=NONE gui=NONE ctermfg=204 ctermbg=NONE cterm=NONE
hi LspWarningText guifg=#986801 guibg=NONE guisp=NONE gui=NONE ctermfg=180 ctermbg=NONE cterm=NONE
hi LspInformationText guifg=#4078f2 guibg=NONE guisp=NONE gui=NONE ctermfg=39 ctermbg=NONE cterm=NONE
hi LspHintText guifg=#0184bc guibg=NONE guisp=NONE gui=NONE ctermfg=38 ctermbg=NONE cterm=NONE
hi LspErrorHighlight guifg=#e45649 guibg=NONE guisp=NONE gui=NONE ctermfg=204 ctermbg=NONE cterm=NONE
hi LspWarningHighlight guifg=#986801 guibg=NONE guisp=NONE gui=NONE ctermfg=180 ctermbg=NONE cterm=NONE
hi LspInformationHighlight guifg=#4078f2 guibg=NONE guisp=NONE gui=NONE ctermfg=39 ctermbg=NONE cterm=NONE
hi LspHintHighlight guifg=#0184bc guibg=NONE guisp=NONE gui=NONE ctermfg=38 ctermbg=NONE cterm=NONE
hi diffAdded guifg=#50a14f guibg=NONE guisp=NONE gui=NONE ctermfg=114 ctermbg=NONE cterm=NONE
hi diffRemoved guifg=#e45649 guibg=NONE guisp=NONE gui=NONE ctermfg=204 ctermbg=NONE cterm=NONE
hi gitcommitComment guifg=#a0a1a7 guibg=NONE guisp=NONE gui=NONE ctermfg=59 ctermbg=NONE cterm=NONE
hi gitcommitUnmerged guifg=#50a14f guibg=NONE guisp=NONE gui=NONE ctermfg=114 ctermbg=NONE cterm=NONE
hi gitcommitOnBranch guifg=NONE guibg=NONE guisp=NONE gui=NONE ctermfg=NONE ctermbg=NONE cterm=NONE
hi gitcommitBranch guifg=#a626a4 guibg=NONE guisp=NONE gui=NONE ctermfg=170 ctermbg=NONE cterm=NONE
hi gitcommitDiscardedType guifg=#e45649 guibg=NONE guisp=NONE gui=NONE ctermfg=204 ctermbg=NONE cterm=NONE
hi gitcommitSelectedType guifg=#50a14f guibg=NONE guisp=NONE gui=NONE ctermfg=114 ctermbg=NONE cterm=NONE
hi gitcommitHeader guifg=NONE guibg=NONE guisp=NONE gui=NONE ctermfg=NONE ctermbg=NONE cterm=NONE
hi gitcommitUntrackedFile guifg=#0184bc guibg=NONE guisp=NONE gui=NONE ctermfg=38 ctermbg=NONE cterm=NONE
hi gitcommitDiscardedFile guifg=#e45649 guibg=NONE guisp=NONE gui=NONE ctermfg=204 ctermbg=NONE cterm=NONE
hi gitcommitSelectedFile guifg=#50a14f guibg=NONE guisp=NONE gui=NONE ctermfg=114 ctermbg=NONE cterm=NONE
hi gitcommitUnmergedFile guifg=#986801 guibg=NONE guisp=NONE gui=NONE ctermfg=180 ctermbg=NONE cterm=NONE
hi gitcommitFile guifg=NONE guibg=NONE guisp=NONE gui=NONE ctermfg=NONE ctermbg=NONE cterm=NONE
hi gitcommitSummary guifg=#383a42 guibg=NONE guisp=NONE gui=NONE ctermfg=145 ctermbg=NONE cterm=NONE
hi gitcommitOverflow guifg=#e45649 guibg=NONE guisp=NONE gui=NONE ctermfg=204 ctermbg=NONE cterm=NONE

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
    '#fafafa', '#e45649', '#50a14f', '#986801',
    '#4078f2', '#a626a4', '#0184bc', '#818387',
    '#a0a1a7', '#e45649', '#50a14f', '#986801',
    '#4078f2', '#a626a4', '#0184bc', '#383a42'
]

# ============================================================
#  SupraLight — overrides
# ============================================================
# Comments
hi Comment        guifg=#a0a1a7 guibg=NONE gui=NONE cterm=NONE
hi SpecialComment guifg=#a0a1a7 guibg=NONE gui=NONE cterm=NONE
hi Folded         guifg=#a0a1a7 guibg=#c9c9c9 gui=NONE cterm=NONE

# Cursor / current line
hi CursorLine     guibg=#f0f0f0 gui=NONE cterm=NONE
hi CursorColumn   guibg=#f0f0f0
hi ColorColumn    guibg=#f0f0f0
hi CursorLineNr   guifg=#986801 guibg=NONE gui=NONE cterm=NONE
hi LineNr         guifg=#b2b3b7 guibg=NONE

# Matching paren
hi MatchParen     guifg=#0184bc guibg=#dcdcdc gui=NONE cterm=NONE

# Visual selection
hi Visual         guibg=#e2e6f0
hi VisualNOS      guibg=#e2e6f0

# Search
hi Search         guifg=#fafafa guibg=#986801 gui=NONE cterm=NONE
hi IncSearch      guifg=#fafafa guibg=#c18401 gui=NONE cterm=NONE

# Completion menu
hi Pmenu          guifg=#383a42 guibg=#f0f0f0
hi PmenuSel       guifg=#fafafa guibg=#4078f2 gui=NONE cterm=NONE
hi PmenuSbar      guibg=#c9c9c9
hi PmenuThumb     guibg=#b2b3b7

# Splits / statusline
hi VertSplit      guifg=#dcdcdc guibg=NONE
hi WinSeparator   guifg=#dcdcdc guibg=NONE
hi StatusLine     guifg=#383a42 guibg=#f0f0f0 gui=NONE cterm=NONE
hi StatusLineNC   guifg=#a0a1a7 guibg=#c9c9c9 gui=NONE cterm=NONE

# Spell
hi SpellBad       guifg=NONE guisp=#e45649 gui=NONE cterm=NONE
hi SpellCap       guifg=NONE guisp=#986801 gui=NONE cterm=NONE
hi SpellRare      guifg=NONE guisp=#0184bc gui=NONE cterm=NONE
hi SpellLocal     guifg=NONE guisp=#50a14f gui=NONE cterm=NONE

# Diff
hi DiffAdd        guifg=NONE guibg=#e2fbe4
hi DiffDelete     guifg=NONE guibg=#fce2e5
hi DiffChange     guifg=NONE guibg=#e2ecfb
hi DiffText       guifg=NONE guibg=#cad3e0

# Titles / links
hi Title          guifg=#50a14f gui=NONE cterm=NONE
hi Underlined     guifg=#4078f2 gui=NONE cterm=NONE
hi Directory      guifg=#4078f2 gui=NONE cterm=NONE

# SignColumn without border
hi! link SignColumn Normal
hi! link EndOfBuffer Normal
