vim9script
# supra-gui: background=#181b20 include=#4fa6ed stdio=#8ebd6b typedef=#e2b86b struct=#e2b86b type_s=#a0a8b7 scope=#c8ccd4 float=#e2b86b function=#a0a8b7 format=#cc9057 text=#8ebd6b integer=#cc9057

hi clear

if exists("syntax_on")
  syntax reset
endif

set t_Co=256

g:colors_name = "supraonedark"

if !exists("g:supraonedark_termcolors")
	g:supraonedark_termcolors = 256
endif

if !exists("g:supraonedark_terminal_italics")
	g:supraonedark_terminal_italics = 0
endif

hi Comment guifg=#535965 guibg=NONE guisp=NONE gui=NONE ctermfg=59 ctermbg=NONE cterm=NONE
hi Constant guifg=#48b0bd guibg=NONE guisp=NONE gui=NONE ctermfg=38 ctermbg=NONE cterm=NONE
hi String guifg=#8ebd6b guibg=NONE guisp=NONE gui=NONE ctermfg=114 ctermbg=NONE cterm=NONE
hi Character guifg=#8ebd6b guibg=NONE guisp=NONE gui=NONE ctermfg=114 ctermbg=NONE cterm=NONE
hi Number guifg=#cc9057 guibg=NONE guisp=NONE gui=NONE ctermfg=173 ctermbg=NONE cterm=NONE
hi Boolean guifg=#cc9057 guibg=NONE guisp=NONE gui=NONE ctermfg=173 ctermbg=NONE cterm=NONE
hi Float guifg=#cc9057 guibg=NONE guisp=NONE gui=NONE ctermfg=173 ctermbg=NONE cterm=NONE
hi Identifier guifg=#e55561 guibg=NONE guisp=NONE gui=NONE ctermfg=204 ctermbg=NONE cterm=NONE
hi Function guifg=#4fa6ed guibg=NONE guisp=NONE gui=NONE ctermfg=39 ctermbg=NONE cterm=NONE
hi Statement guifg=#bf68d9 guibg=NONE guisp=NONE gui=NONE ctermfg=170 ctermbg=NONE cterm=NONE
hi Conditional guifg=#bf68d9 guibg=NONE guisp=NONE gui=NONE ctermfg=170 ctermbg=NONE cterm=NONE
hi Repeat guifg=#bf68d9 guibg=NONE guisp=NONE gui=NONE ctermfg=170 ctermbg=NONE cterm=NONE
hi Label guifg=#bf68d9 guibg=NONE guisp=NONE gui=NONE ctermfg=170 ctermbg=NONE cterm=NONE
hi Operator guifg=#bf68d9 guibg=NONE guisp=NONE gui=NONE ctermfg=170 ctermbg=NONE cterm=NONE
hi Keyword guifg=#bf68d9 guibg=NONE guisp=NONE gui=NONE ctermfg=170 ctermbg=NONE cterm=NONE
hi Exception guifg=#bf68d9 guibg=NONE guisp=NONE gui=NONE ctermfg=170 ctermbg=NONE cterm=NONE
hi PreProc guifg=#e2b86b guibg=NONE guisp=NONE gui=NONE ctermfg=180 ctermbg=NONE cterm=NONE
hi Include guifg=#4fa6ed guibg=NONE guisp=NONE gui=NONE ctermfg=39 ctermbg=NONE cterm=NONE
hi Define guifg=#bf68d9 guibg=NONE guisp=NONE gui=NONE ctermfg=170 ctermbg=NONE cterm=NONE
hi Macro guifg=#bf68d9 guibg=NONE guisp=NONE gui=NONE ctermfg=170 ctermbg=NONE cterm=NONE
hi PreCondit guifg=#e2b86b guibg=NONE guisp=NONE gui=NONE ctermfg=180 ctermbg=NONE cterm=NONE
hi Type guifg=#e2b86b guibg=NONE guisp=NONE gui=NONE ctermfg=180 ctermbg=NONE cterm=NONE
hi StorageClass guifg=#e2b86b guibg=NONE guisp=NONE gui=NONE ctermfg=180 ctermbg=NONE cterm=NONE
hi Structure guifg=#e2b86b guibg=NONE guisp=NONE gui=NONE ctermfg=180 ctermbg=NONE cterm=NONE
hi Typedef guifg=#e2b86b guibg=NONE guisp=NONE gui=NONE ctermfg=180 ctermbg=NONE cterm=NONE
hi Special guifg=#4fa6ed guibg=NONE guisp=NONE gui=NONE ctermfg=39 ctermbg=NONE cterm=NONE
hi SpecialChar guifg=#cc9057 guibg=NONE guisp=NONE gui=NONE ctermfg=173 ctermbg=NONE cterm=NONE
hi Tag guifg=NONE guibg=NONE guisp=NONE gui=NONE ctermfg=NONE ctermbg=NONE cterm=NONE
hi Delimiter guifg=NONE guibg=NONE guisp=NONE gui=NONE ctermfg=NONE ctermbg=NONE cterm=NONE
hi SpecialComment guifg=#535965 guibg=NONE guisp=NONE gui=NONE ctermfg=59 ctermbg=NONE cterm=NONE
hi Debug guifg=NONE guibg=NONE guisp=NONE gui=NONE ctermfg=NONE ctermbg=NONE cterm=NONE
hi Underlined guifg=NONE guibg=NONE guisp=NONE gui=NONE ctermfg=NONE ctermbg=NONE cterm=NONE
hi Ignore guifg=NONE guibg=NONE guisp=NONE gui=NONE ctermfg=NONE ctermbg=NONE cterm=NONE
hi Error guifg=#e55561 guibg=NONE guisp=NONE gui=NONE ctermfg=204 ctermbg=NONE cterm=NONE
hi Todo guifg=#bf68d9 guibg=NONE guisp=NONE gui=NONE ctermfg=170 ctermbg=NONE cterm=NONE
hi ColorColumn guifg=NONE guibg=#282c34 guisp=NONE gui=NONE ctermfg=NONE ctermbg=236 cterm=NONE
hi Conceal guifg=NONE guibg=NONE guisp=NONE gui=NONE ctermfg=NONE ctermbg=NONE cterm=NONE
hi Cursor guifg=#1f2329 guibg=#4fa6ed guisp=NONE gui=NONE ctermfg=235 ctermbg=39 cterm=NONE
hi CursorIM guifg=NONE guibg=NONE guisp=NONE gui=NONE ctermfg=NONE ctermbg=NONE cterm=NONE
hi CursorColumn guifg=NONE guibg=#282c34 guisp=NONE gui=NONE ctermfg=NONE ctermbg=236 cterm=NONE
hi CursorLine guifg=NONE guibg=#282c34 guisp=NONE gui=NONE ctermfg=NONE ctermbg=236 cterm=NONE
hi Directory guifg=#4fa6ed guibg=NONE guisp=NONE gui=NONE ctermfg=39 ctermbg=NONE cterm=NONE
hi DiffAdd guifg=#1f2329 guibg=#8ebd6b guisp=NONE gui=NONE ctermfg=235 ctermbg=114 cterm=NONE
hi DiffChange guifg=#e2b86b guibg=NONE guisp=NONE gui=NONE ctermfg=180 ctermbg=NONE cterm=NONE
hi DiffDelete guifg=#1f2329 guibg=#e55561 guisp=NONE gui=NONE ctermfg=235 ctermbg=204 cterm=NONE
hi DiffText guifg=#1f2329 guibg=#e2b86b guisp=NONE gui=NONE ctermfg=235 ctermbg=180 cterm=NONE
hi ErrorMsg guifg=#e55561 guibg=NONE guisp=NONE gui=NONE ctermfg=204 ctermbg=NONE cterm=NONE
hi VertSplit guifg=#323641 guibg=NONE guisp=NONE gui=NONE ctermfg=59 ctermbg=NONE cterm=NONE
hi Folded guifg=#535965 guibg=NONE guisp=NONE gui=NONE ctermfg=59 ctermbg=NONE cterm=NONE
hi FoldColumn guifg=NONE guibg=NONE guisp=NONE gui=NONE ctermfg=NONE ctermbg=NONE cterm=NONE
hi SignColumn guifg=NONE guibg=NONE guisp=NONE gui=NONE ctermfg=NONE ctermbg=NONE cterm=NONE
hi IncSearch guifg=#e2b86b guibg=#535965 guisp=NONE gui=NONE ctermfg=180 ctermbg=59 cterm=NONE
hi LineNr guifg=#495162 guibg=NONE guisp=NONE gui=NONE ctermfg=238 ctermbg=NONE cterm=NONE
hi CursorLineNr guifg=#cc9057 guibg=NONE guisp=NONE gui=NONE ctermfg=NONE ctermbg=NONE cterm=NONE
hi MatchParen guifg=#4fa6ed guibg=NONE guisp=NONE gui=NONE ctermfg=39 ctermbg=NONE cterm=NONE
hi ModeMsg guifg=NONE guibg=NONE guisp=NONE gui=NONE ctermfg=NONE ctermbg=NONE cterm=NONE
hi MoreMsg guifg=NONE guibg=NONE guisp=NONE gui=NONE ctermfg=NONE ctermbg=NONE cterm=NONE
hi NonText guifg=#30363f guibg=NONE guisp=NONE gui=NONE ctermfg=238 ctermbg=NONE cterm=NONE
hi Normal guifg=#a0a8b7 guibg=#1f2329 guisp=NONE gui=NONE ctermfg=145 ctermbg=235 cterm=NONE
hi Pmenu guifg=#a0a8b7 guibg=#323641 guisp=NONE gui=NONE ctermfg=145 ctermbg=237 cterm=NONE
hi PmenuSel guifg=#282c34 guibg=#4fa6ed guisp=NONE gui=NONE ctermfg=236 ctermbg=39 cterm=NONE
hi PmenuSbar guifg=NONE guibg=#282c34 guisp=NONE gui=NONE ctermfg=NONE ctermbg=236 cterm=NONE
hi PmenuThumb guifg=NONE guibg=#a0a8b7 guisp=NONE gui=NONE ctermfg=NONE ctermbg=145 cterm=NONE
hi Question guifg=#bf68d9 guibg=NONE guisp=NONE gui=NONE ctermfg=170 ctermbg=NONE cterm=NONE
hi QuickFixLine guifg=#1f2329 guibg=#e2b86b guisp=NONE gui=NONE ctermfg=235 ctermbg=180 cterm=NONE
hi Search guifg=#1f2329 guibg=#e2b86b guisp=NONE gui=NONE ctermfg=235 ctermbg=180 cterm=NONE
hi SpecialKey guifg=#30363f guibg=NONE guisp=NONE gui=NONE ctermfg=238 ctermbg=NONE cterm=NONE
hi SpellBad guifg=#e55561 guibg=NONE guisp=NONE gui=NONE ctermfg=204 ctermbg=NONE cterm=NONE
hi SpellCap guifg=#cc9057 guibg=NONE guisp=NONE gui=NONE ctermfg=173 ctermbg=NONE cterm=NONE
hi SpellLocal guifg=#cc9057 guibg=NONE guisp=NONE gui=NONE ctermfg=173 ctermbg=NONE cterm=NONE
hi SpellRare guifg=#cc9057 guibg=NONE guisp=NONE gui=NONE ctermfg=173 ctermbg=NONE cterm=NONE
hi StatusLine guifg=#a0a8b7 guibg=#282c34 guisp=NONE gui=NONE ctermfg=145 ctermbg=236 cterm=NONE
hi StatusLineNC guifg=#535965 guibg=NONE guisp=NONE gui=NONE ctermfg=59 ctermbg=NONE cterm=NONE
hi StatusLineTerm guifg=#a0a8b7 guibg=#282c34 guisp=NONE gui=NONE ctermfg=145 ctermbg=236 cterm=NONE
hi StatusLineTermNC guifg=#535965 guibg=NONE guisp=NONE gui=NONE ctermfg=59 ctermbg=NONE cterm=NONE
hi TabLine guifg=#535965 guibg=NONE guisp=NONE gui=NONE ctermfg=59 ctermbg=NONE cterm=NONE
hi TabLineFill guifg=NONE guibg=NONE guisp=NONE gui=NONE ctermfg=NONE ctermbg=NONE cterm=NONE
hi TabLineSel guifg=#a0a8b7 guibg=NONE guisp=NONE gui=NONE ctermfg=145 ctermbg=NONE cterm=NONE
hi Terminal guifg=#a0a8b7 guibg=#1f2329 guisp=NONE gui=NONE ctermfg=145 ctermbg=235 cterm=NONE
hi Title guifg=#8ebd6b guibg=NONE guisp=NONE gui=NONE ctermfg=114 ctermbg=NONE cterm=NONE
hi Visual guifg=NONE guibg=#323641 guisp=NONE gui=NONE ctermfg=NONE ctermbg=237 cterm=NONE
hi VisualNOS guifg=NONE guibg=#323641 guisp=NONE gui=NONE ctermfg=NONE ctermbg=237 cterm=NONE
hi WarningMsg guifg=#e2b86b guibg=NONE guisp=NONE gui=NONE ctermfg=180 ctermbg=NONE cterm=NONE
hi WildMenu guifg=#1f2329 guibg=#4fa6ed guisp=NONE gui=NONE ctermfg=235 ctermbg=39 cterm=NONE

hi PMenuMatch guifg=#e2b86b guibg=NONE guisp=NONE gui=NONE ctermfg=180 ctermbg=237 cterm=NONE
hi PMenuKind guifg=#bf68d9 guibg=NONE guisp=NONE cterm=NONE gui=NONE ctermfg=38

hi debugPC guifg=NONE guibg=#30363f guisp=NONE gui=NONE ctermfg=NONE ctermbg=238 cterm=NONE
hi debugBreakpoint guifg=#1f2329 guibg=#e55561 guisp=NONE gui=NONE ctermfg=235 ctermbg=204 cterm=NONE
hi cssAttrComma guifg=#bf68d9 guibg=NONE guisp=NONE gui=NONE ctermfg=170 ctermbg=NONE cterm=NONE
hi cssAttributeSelector guifg=#8ebd6b guibg=NONE guisp=NONE gui=NONE ctermfg=114 ctermbg=NONE cterm=NONE
hi cssBraces guifg=#a0a8b7 guibg=NONE guisp=NONE gui=NONE ctermfg=145 ctermbg=NONE cterm=NONE
hi cssClassName guifg=#cc9057 guibg=NONE guisp=NONE gui=NONE ctermfg=173 ctermbg=NONE cterm=NONE
hi cssClassNameDot guifg=#cc9057 guibg=NONE guisp=NONE gui=NONE ctermfg=173 ctermbg=NONE cterm=NONE
hi cssDefinition guifg=#bf68d9 guibg=NONE guisp=NONE gui=NONE ctermfg=170 ctermbg=NONE cterm=NONE
hi cssFontAttr guifg=#cc9057 guibg=NONE guisp=NONE gui=NONE ctermfg=173 ctermbg=NONE cterm=NONE
hi cssFontDescriptor guifg=#bf68d9 guibg=NONE guisp=NONE gui=NONE ctermfg=170 ctermbg=NONE cterm=NONE
hi cssFunctionName guifg=#4fa6ed guibg=NONE guisp=NONE gui=NONE ctermfg=39 ctermbg=NONE cterm=NONE
hi cssIdentifier guifg=#4fa6ed guibg=NONE guisp=NONE gui=NONE ctermfg=39 ctermbg=NONE cterm=NONE
hi cssImportant guifg=#bf68d9 guibg=NONE guisp=NONE gui=NONE ctermfg=170 ctermbg=NONE cterm=NONE
hi cssInclude guifg=#a0a8b7 guibg=NONE guisp=NONE gui=NONE ctermfg=145 ctermbg=NONE cterm=NONE
hi cssIncludeKeyword guifg=#bf68d9 guibg=NONE guisp=NONE gui=NONE ctermfg=170 ctermbg=NONE cterm=NONE
hi cssMediaType guifg=#cc9057 guibg=NONE guisp=NONE gui=NONE ctermfg=173 ctermbg=NONE cterm=NONE
hi cssProp guifg=#a0a8b7 guibg=NONE guisp=NONE gui=NONE ctermfg=145 ctermbg=NONE cterm=NONE
hi cssPseudoClassId guifg=#cc9057 guibg=NONE guisp=NONE gui=NONE ctermfg=173 ctermbg=NONE cterm=NONE
hi cssSelectorOp guifg=#bf68d9 guibg=NONE guisp=NONE gui=NONE ctermfg=170 ctermbg=NONE cterm=NONE
hi cssSelectorOp2 guifg=#bf68d9 guibg=NONE guisp=NONE gui=NONE ctermfg=170 ctermbg=NONE cterm=NONE
hi cssTagName guifg=#e55561 guibg=NONE guisp=NONE gui=NONE ctermfg=204 ctermbg=NONE cterm=NONE
hi fishKeyword guifg=#bf68d9 guibg=NONE guisp=NONE gui=NONE ctermfg=170 ctermbg=NONE cterm=NONE
hi fishConditional guifg=#bf68d9 guibg=NONE guisp=NONE gui=NONE ctermfg=170 ctermbg=NONE cterm=NONE
hi goDeclaration guifg=#bf68d9 guibg=NONE guisp=NONE gui=NONE ctermfg=170 ctermbg=NONE cterm=NONE
hi goBuiltins guifg=#48b0bd guibg=NONE guisp=NONE gui=NONE ctermfg=38 ctermbg=NONE cterm=NONE
hi goFunctionCall guifg=#4fa6ed guibg=NONE guisp=NONE gui=NONE ctermfg=39 ctermbg=NONE cterm=NONE
hi goVarDefs guifg=#e55561 guibg=NONE guisp=NONE gui=NONE ctermfg=204 ctermbg=NONE cterm=NONE
hi goVarAssign guifg=#e55561 guibg=NONE guisp=NONE gui=NONE ctermfg=204 ctermbg=NONE cterm=NONE
hi goVar guifg=#bf68d9 guibg=NONE guisp=NONE gui=NONE ctermfg=170 ctermbg=NONE cterm=NONE
hi goConst guifg=#bf68d9 guibg=NONE guisp=NONE gui=NONE ctermfg=170 ctermbg=NONE cterm=NONE
hi goType guifg=#e2b86b guibg=NONE guisp=NONE gui=NONE ctermfg=180 ctermbg=NONE cterm=NONE
hi goTypeName guifg=#e2b86b guibg=NONE guisp=NONE gui=NONE ctermfg=180 ctermbg=NONE cterm=NONE
hi goDeclType guifg=#48b0bd guibg=NONE guisp=NONE gui=NONE ctermfg=38 ctermbg=NONE cterm=NONE
hi goTypeDecl guifg=#bf68d9 guibg=NONE guisp=NONE gui=NONE ctermfg=170 ctermbg=NONE cterm=NONE
hi htmlArg guifg=#cc9057 guibg=NONE guisp=NONE gui=NONE ctermfg=173 ctermbg=NONE cterm=NONE
hi htmlBold guifg=#cc9057 guibg=NONE guisp=NONE gui=NONE ctermfg=173 ctermbg=NONE cterm=NONE
hi htmlBoldItalic guifg=#8ebd6b guibg=NONE guisp=NONE gui=NONE ctermfg=114 ctermbg=NONE cterm=NONE
hi htmlEndTag guifg=#a0a8b7 guibg=NONE guisp=NONE gui=NONE ctermfg=145 ctermbg=NONE cterm=NONE
hi htmlH1 guifg=#e55561 guibg=NONE guisp=NONE gui=NONE ctermfg=204 ctermbg=NONE cterm=NONE
hi htmlH2 guifg=#e55561 guibg=NONE guisp=NONE gui=NONE ctermfg=204 ctermbg=NONE cterm=NONE
hi htmlH3 guifg=#e55561 guibg=NONE guisp=NONE gui=NONE ctermfg=204 ctermbg=NONE cterm=NONE
hi htmlH4 guifg=#e55561 guibg=NONE guisp=NONE gui=NONE ctermfg=204 ctermbg=NONE cterm=NONE
hi htmlH5 guifg=#e55561 guibg=NONE guisp=NONE gui=NONE ctermfg=204 ctermbg=NONE cterm=NONE
hi htmlH6 guifg=#e55561 guibg=NONE guisp=NONE gui=NONE ctermfg=204 ctermbg=NONE cterm=NONE
hi htmlItalic guifg=#bf68d9 guibg=NONE guisp=NONE gui=NONE ctermfg=170 ctermbg=NONE cterm=NONE
hi htmlLink guifg=#48b0bd guibg=NONE guisp=NONE gui=NONE ctermfg=38 ctermbg=NONE cterm=NONE
hi htmlSpecialChar guifg=#cc9057 guibg=NONE guisp=NONE gui=NONE ctermfg=173 ctermbg=NONE cterm=NONE
hi htmlSpecialTagName guifg=#e55561 guibg=NONE guisp=NONE gui=NONE ctermfg=204 ctermbg=NONE cterm=NONE
hi htmlTag guifg=#a0a8b7 guibg=NONE guisp=NONE gui=NONE ctermfg=145 ctermbg=NONE cterm=NONE
hi htmlTagN guifg=#e55561 guibg=NONE guisp=NONE gui=NONE ctermfg=204 ctermbg=NONE cterm=NONE
hi htmlTagName guifg=#e55561 guibg=NONE guisp=NONE gui=NONE ctermfg=204 ctermbg=NONE cterm=NONE
hi htmlTitle guifg=#a0a8b7 guibg=NONE guisp=NONE gui=NONE ctermfg=145 ctermbg=NONE cterm=NONE
hi javaScriptBraces guifg=#a0a8b7 guibg=NONE guisp=NONE gui=NONE ctermfg=145 ctermbg=NONE cterm=NONE
hi javaScriptFunction guifg=#bf68d9 guibg=NONE guisp=NONE gui=NONE ctermfg=170 ctermbg=NONE cterm=NONE
hi javaScriptIdentifier guifg=#bf68d9 guibg=NONE guisp=NONE gui=NONE ctermfg=170 ctermbg=NONE cterm=NONE
hi javaScriptNull guifg=#cc9057 guibg=NONE guisp=NONE gui=NONE ctermfg=173 ctermbg=NONE cterm=NONE
hi javaScriptNumber guifg=#cc9057 guibg=NONE guisp=NONE gui=NONE ctermfg=173 ctermbg=NONE cterm=NONE
hi javaScriptRequire guifg=#48b0bd guibg=NONE guisp=NONE gui=NONE ctermfg=38 ctermbg=NONE cterm=NONE
hi javaScriptReserved guifg=#bf68d9 guibg=NONE guisp=NONE gui=NONE ctermfg=170 ctermbg=NONE cterm=NONE
hi jsArrowFunction guifg=#bf68d9 guibg=NONE guisp=NONE gui=NONE ctermfg=170 ctermbg=NONE cterm=NONE
hi jsClassKeyword guifg=#bf68d9 guibg=NONE guisp=NONE gui=NONE ctermfg=170 ctermbg=NONE cterm=NONE
hi jsClassMethodType guifg=#bf68d9 guibg=NONE guisp=NONE gui=NONE ctermfg=170 ctermbg=NONE cterm=NONE
hi jsDocParam guifg=#4fa6ed guibg=NONE guisp=NONE gui=NONE ctermfg=39 ctermbg=NONE cterm=NONE
hi jsDocTags guifg=#bf68d9 guibg=NONE guisp=NONE gui=NONE ctermfg=170 ctermbg=NONE cterm=NONE
hi jsExport guifg=#bf68d9 guibg=NONE guisp=NONE gui=NONE ctermfg=170 ctermbg=NONE cterm=NONE
hi jsExportDefault guifg=#bf68d9 guibg=NONE guisp=NONE gui=NONE ctermfg=170 ctermbg=NONE cterm=NONE
hi jsExtendsKeyword guifg=#bf68d9 guibg=NONE guisp=NONE gui=NONE ctermfg=170 ctermbg=NONE cterm=NONE
hi jsFrom guifg=#bf68d9 guibg=NONE guisp=NONE gui=NONE ctermfg=170 ctermbg=NONE cterm=NONE
hi jsFuncCall guifg=#4fa6ed guibg=NONE guisp=NONE gui=NONE ctermfg=39 ctermbg=NONE cterm=NONE
hi jsFunction guifg=#bf68d9 guibg=NONE guisp=NONE gui=NONE ctermfg=170 ctermbg=NONE cterm=NONE
hi jsGenerator guifg=#e2b86b guibg=NONE guisp=NONE gui=NONE ctermfg=180 ctermbg=NONE cterm=NONE
hi jsGlobalObjects guifg=#e2b86b guibg=NONE guisp=NONE gui=NONE ctermfg=180 ctermbg=NONE cterm=NONE
hi jsImport guifg=#bf68d9 guibg=NONE guisp=NONE gui=NONE ctermfg=170 ctermbg=NONE cterm=NONE
hi jsModuleAs guifg=#bf68d9 guibg=NONE guisp=NONE gui=NONE ctermfg=170 ctermbg=NONE cterm=NONE
hi jsModuleWords guifg=#bf68d9 guibg=NONE guisp=NONE gui=NONE ctermfg=170 ctermbg=NONE cterm=NONE
hi jsModules guifg=#bf68d9 guibg=NONE guisp=NONE gui=NONE ctermfg=170 ctermbg=NONE cterm=NONE
hi jsNull guifg=#cc9057 guibg=NONE guisp=NONE gui=NONE ctermfg=173 ctermbg=NONE cterm=NONE
hi jsOperator guifg=#bf68d9 guibg=NONE guisp=NONE gui=NONE ctermfg=170 ctermbg=NONE cterm=NONE
hi jsStorageClass guifg=#bf68d9 guibg=NONE guisp=NONE gui=NONE ctermfg=170 ctermbg=NONE cterm=NONE
hi jsSuper guifg=#e55561 guibg=NONE guisp=NONE gui=NONE ctermfg=204 ctermbg=NONE cterm=NONE
hi jsTemplateBraces guifg=#8b3434 guibg=NONE guisp=NONE gui=NONE ctermfg=196 ctermbg=NONE cterm=NONE
hi jsTemplateVar guifg=#8ebd6b guibg=NONE guisp=NONE gui=NONE ctermfg=114 ctermbg=NONE cterm=NONE
hi jsThis guifg=#e55561 guibg=NONE guisp=NONE gui=NONE ctermfg=204 ctermbg=NONE cterm=NONE
hi jsUndefined guifg=#cc9057 guibg=NONE guisp=NONE gui=NONE ctermfg=173 ctermbg=NONE cterm=NONE
hi javascriptArrowFunc guifg=#bf68d9 guibg=NONE guisp=NONE gui=NONE ctermfg=170 ctermbg=NONE cterm=NONE
hi javascriptClassExtends guifg=#bf68d9 guibg=NONE guisp=NONE gui=NONE ctermfg=170 ctermbg=NONE cterm=NONE
hi javascriptClassKeyword guifg=#bf68d9 guibg=NONE guisp=NONE gui=NONE ctermfg=170 ctermbg=NONE cterm=NONE
hi javascriptDocNotation guifg=#bf68d9 guibg=NONE guisp=NONE gui=NONE ctermfg=170 ctermbg=NONE cterm=NONE
hi javascriptDocParamName guifg=#4fa6ed guibg=NONE guisp=NONE gui=NONE ctermfg=39 ctermbg=NONE cterm=NONE
hi javascriptDocTags guifg=#bf68d9 guibg=NONE guisp=NONE gui=NONE ctermfg=170 ctermbg=NONE cterm=NONE
hi javascriptEndColons guifg=#a0a8b7 guibg=NONE guisp=NONE gui=NONE ctermfg=145 ctermbg=NONE cterm=NONE
hi javascriptExport guifg=#bf68d9 guibg=NONE guisp=NONE gui=NONE ctermfg=170 ctermbg=NONE cterm=NONE
hi javascriptFuncArg guifg=#a0a8b7 guibg=NONE guisp=NONE gui=NONE ctermfg=145 ctermbg=NONE cterm=NONE
hi javascriptFuncKeyword guifg=#bf68d9 guibg=NONE guisp=NONE gui=NONE ctermfg=170 ctermbg=NONE cterm=NONE
hi javascriptIdentifier guifg=#e55561 guibg=NONE guisp=NONE gui=NONE ctermfg=204 ctermbg=NONE cterm=NONE
hi javascriptImport guifg=#bf68d9 guibg=NONE guisp=NONE gui=NONE ctermfg=170 ctermbg=NONE cterm=NONE
hi javascriptMethodName guifg=#a0a8b7 guibg=NONE guisp=NONE gui=NONE ctermfg=145 ctermbg=NONE cterm=NONE
hi javascriptObjectLabel guifg=#a0a8b7 guibg=NONE guisp=NONE gui=NONE ctermfg=145 ctermbg=NONE cterm=NONE
hi javascriptOpSymbol guifg=#48b0bd guibg=NONE guisp=NONE gui=NONE ctermfg=38 ctermbg=NONE cterm=NONE
hi javascriptOpSymbols guifg=#48b0bd guibg=NONE guisp=NONE gui=NONE ctermfg=38 ctermbg=NONE cterm=NONE
hi javascriptPropertyName guifg=#8ebd6b guibg=NONE guisp=NONE gui=NONE ctermfg=114 ctermbg=NONE cterm=NONE
hi javascriptTemplateSB guifg=#8b3434 guibg=NONE guisp=NONE gui=NONE ctermfg=196 ctermbg=NONE cterm=NONE
hi javascriptVariable guifg=#bf68d9 guibg=NONE guisp=NONE gui=NONE ctermfg=170 ctermbg=NONE cterm=NONE
hi jsonCommentError guifg=#a0a8b7 guibg=NONE guisp=NONE gui=NONE ctermfg=145 ctermbg=NONE cterm=NONE
hi jsonKeyword guifg=#e55561 guibg=NONE guisp=NONE gui=NONE ctermfg=204 ctermbg=NONE cterm=NONE
hi jsonBoolean guifg=#cc9057 guibg=NONE guisp=NONE gui=NONE ctermfg=173 ctermbg=NONE cterm=NONE
hi jsonNumber guifg=#cc9057 guibg=NONE guisp=NONE gui=NONE ctermfg=173 ctermbg=NONE cterm=NONE
hi jsonQuote guifg=#a0a8b7 guibg=NONE guisp=NONE gui=NONE ctermfg=145 ctermbg=NONE cterm=NONE
hi jsonMissingCommaError guifg=#e55561 guibg=NONE guisp=NONE gui=NONE ctermfg=204 ctermbg=NONE cterm=NONE
hi jsonNoQuotesError guifg=#e55561 guibg=NONE guisp=NONE gui=NONE ctermfg=204 ctermbg=NONE cterm=NONE
hi jsonNumError guifg=#e55561 guibg=NONE guisp=NONE gui=NONE ctermfg=204 ctermbg=NONE cterm=NONE
hi jsonString guifg=#8ebd6b guibg=NONE guisp=NONE gui=NONE ctermfg=114 ctermbg=NONE cterm=NONE
hi jsonStringSQError guifg=#e55561 guibg=NONE guisp=NONE gui=NONE ctermfg=204 ctermbg=NONE cterm=NONE
hi jsonSemicolonError guifg=#e55561 guibg=NONE guisp=NONE gui=NONE ctermfg=204 ctermbg=NONE cterm=NONE
hi lessVariable guifg=#bf68d9 guibg=NONE guisp=NONE gui=NONE ctermfg=170 ctermbg=NONE cterm=NONE
hi lessAmpersandChar guifg=#a0a8b7 guibg=NONE guisp=NONE gui=NONE ctermfg=145 ctermbg=NONE cterm=NONE
hi lessClass guifg=#cc9057 guibg=NONE guisp=NONE gui=NONE ctermfg=173 ctermbg=NONE cterm=NONE
hi markdownBlockquote guifg=#535965 guibg=NONE guisp=NONE gui=NONE ctermfg=59 ctermbg=NONE cterm=NONE
hi markdownBold guifg=#cc9057 guibg=NONE guisp=NONE gui=NONE ctermfg=173 ctermbg=NONE cterm=NONE
hi markdownBoldItalic guifg=#8ebd6b guibg=NONE guisp=NONE gui=NONE ctermfg=114 ctermbg=NONE cterm=NONE
hi markdownCode guifg=#8ebd6b guibg=NONE guisp=NONE gui=NONE ctermfg=114 ctermbg=NONE cterm=NONE
hi markdownCodeBlock guifg=#8ebd6b guibg=NONE guisp=NONE gui=NONE ctermfg=114 ctermbg=NONE cterm=NONE
hi markdownCodeDelimiter guifg=#8ebd6b guibg=NONE guisp=NONE gui=NONE ctermfg=114 ctermbg=NONE cterm=NONE
hi markdownH1 guifg=#e55561 guibg=NONE guisp=NONE gui=NONE ctermfg=204 ctermbg=NONE cterm=NONE
hi markdownH2 guifg=#e55561 guibg=NONE guisp=NONE gui=NONE ctermfg=204 ctermbg=NONE cterm=NONE
hi markdownH3 guifg=#e55561 guibg=NONE guisp=NONE gui=NONE ctermfg=204 ctermbg=NONE cterm=NONE
hi markdownH4 guifg=#e55561 guibg=NONE guisp=NONE gui=NONE ctermfg=204 ctermbg=NONE cterm=NONE
hi markdownH5 guifg=#e55561 guibg=NONE guisp=NONE gui=NONE ctermfg=204 ctermbg=NONE cterm=NONE
hi markdownH6 guifg=#e55561 guibg=NONE guisp=NONE gui=NONE ctermfg=204 ctermbg=NONE cterm=NONE
hi markdownHeadingDelimiter guifg=#e55561 guibg=NONE guisp=NONE gui=NONE ctermfg=204 ctermbg=NONE cterm=NONE
hi markdownHeadingRule guifg=#535965 guibg=NONE guisp=NONE gui=NONE ctermfg=59 ctermbg=NONE cterm=NONE
hi markdownId guifg=#bf68d9 guibg=NONE guisp=NONE gui=NONE ctermfg=170 ctermbg=NONE cterm=NONE
hi markdownIdDeclaration guifg=#4fa6ed guibg=NONE guisp=NONE gui=NONE ctermfg=39 ctermbg=NONE cterm=NONE
hi markdownIdDelimiter guifg=#bf68d9 guibg=NONE guisp=NONE gui=NONE ctermfg=170 ctermbg=NONE cterm=NONE
hi markdownItalic guifg=#bf68d9 guibg=NONE guisp=NONE gui=NONE ctermfg=170 ctermbg=NONE cterm=NONE
hi markdownLinkDelimiter guifg=#bf68d9 guibg=NONE guisp=NONE gui=NONE ctermfg=170 ctermbg=NONE cterm=NONE
hi markdownLinkText guifg=#4fa6ed guibg=NONE guisp=NONE gui=NONE ctermfg=39 ctermbg=NONE cterm=NONE
hi markdownListMarker guifg=#e55561 guibg=NONE guisp=NONE gui=NONE ctermfg=204 ctermbg=NONE cterm=NONE
hi markdownOrderedListMarker guifg=#e55561 guibg=NONE guisp=NONE gui=NONE ctermfg=204 ctermbg=NONE cterm=NONE
hi markdownRule guifg=#535965 guibg=NONE guisp=NONE gui=NONE ctermfg=59 ctermbg=NONE cterm=NONE
hi markdownUrl guifg=#48b0bd guibg=NONE guisp=NONE gui=NONE ctermfg=38 ctermbg=NONE cterm=NONE
hi perlFiledescRead guifg=#8ebd6b guibg=NONE guisp=NONE gui=NONE ctermfg=114 ctermbg=NONE cterm=NONE
hi perlFunction guifg=#bf68d9 guibg=NONE guisp=NONE gui=NONE ctermfg=170 ctermbg=NONE cterm=NONE
hi perlMatchStartEnd guifg=#4fa6ed guibg=NONE guisp=NONE gui=NONE ctermfg=39 ctermbg=NONE cterm=NONE
hi perlMethod guifg=#bf68d9 guibg=NONE guisp=NONE gui=NONE ctermfg=170 ctermbg=NONE cterm=NONE
hi perlPOD guifg=#535965 guibg=NONE guisp=NONE gui=NONE ctermfg=59 ctermbg=NONE cterm=NONE
hi perlSharpBang guifg=#535965 guibg=NONE guisp=NONE gui=NONE ctermfg=59 ctermbg=NONE cterm=NONE
hi perlSpecialString guifg=#cc9057 guibg=NONE guisp=NONE gui=NONE ctermfg=173 ctermbg=NONE cterm=NONE
hi perlStatementFiledesc guifg=#e55561 guibg=NONE guisp=NONE gui=NONE ctermfg=204 ctermbg=NONE cterm=NONE
hi perlStatementFlow guifg=#e55561 guibg=NONE guisp=NONE gui=NONE ctermfg=204 ctermbg=NONE cterm=NONE
hi perlStatementInclude guifg=#bf68d9 guibg=NONE guisp=NONE gui=NONE ctermfg=170 ctermbg=NONE cterm=NONE
hi perlStatementScalar guifg=#bf68d9 guibg=NONE guisp=NONE gui=NONE ctermfg=170 ctermbg=NONE cterm=NONE
hi perlStatementStorage guifg=#bf68d9 guibg=NONE guisp=NONE gui=NONE ctermfg=170 ctermbg=NONE cterm=NONE
hi perlSubName guifg=#e2b86b guibg=NONE guisp=NONE gui=NONE ctermfg=180 ctermbg=NONE cterm=NONE
hi perlVarPlain guifg=#4fa6ed guibg=NONE guisp=NONE gui=NONE ctermfg=39 ctermbg=NONE cterm=NONE
hi phpVarSelector guifg=#e55561 guibg=NONE guisp=NONE gui=NONE ctermfg=204 ctermbg=NONE cterm=NONE
hi phpOperator guifg=#a0a8b7 guibg=NONE guisp=NONE gui=NONE ctermfg=145 ctermbg=NONE cterm=NONE
hi phpParent guifg=#a0a8b7 guibg=NONE guisp=NONE gui=NONE ctermfg=145 ctermbg=NONE cterm=NONE
hi phpMemberSelector guifg=#a0a8b7 guibg=NONE guisp=NONE gui=NONE ctermfg=145 ctermbg=NONE cterm=NONE
hi phpType guifg=#bf68d9 guibg=NONE guisp=NONE gui=NONE ctermfg=170 ctermbg=NONE cterm=NONE
hi phpKeyword guifg=#bf68d9 guibg=NONE guisp=NONE gui=NONE ctermfg=170 ctermbg=NONE cterm=NONE
hi phpClass guifg=#e2b86b guibg=NONE guisp=NONE gui=NONE ctermfg=180 ctermbg=NONE cterm=NONE
hi phpUseClass guifg=#a0a8b7 guibg=NONE guisp=NONE gui=NONE ctermfg=145 ctermbg=NONE cterm=NONE
hi phpUseAlias guifg=#a0a8b7 guibg=NONE guisp=NONE gui=NONE ctermfg=145 ctermbg=NONE cterm=NONE
hi phpInclude guifg=#bf68d9 guibg=NONE guisp=NONE gui=NONE ctermfg=170 ctermbg=NONE cterm=NONE
hi phpClassExtends guifg=#8ebd6b guibg=NONE guisp=NONE gui=NONE ctermfg=114 ctermbg=NONE cterm=NONE
hi phpDocTags guifg=#a0a8b7 guibg=NONE guisp=NONE gui=NONE ctermfg=145 ctermbg=NONE cterm=NONE
hi phpFunction guifg=#4fa6ed guibg=NONE guisp=NONE gui=NONE ctermfg=39 ctermbg=NONE cterm=NONE
hi phpFunctions guifg=#48b0bd guibg=NONE guisp=NONE gui=NONE ctermfg=38 ctermbg=NONE cterm=NONE
hi phpMethodsVar guifg=#cc9057 guibg=NONE guisp=NONE gui=NONE ctermfg=173 ctermbg=NONE cterm=NONE
hi phpMagicConstants guifg=#cc9057 guibg=NONE guisp=NONE gui=NONE ctermfg=173 ctermbg=NONE cterm=NONE
hi phpSuperglobals guifg=#e55561 guibg=NONE guisp=NONE gui=NONE ctermfg=204 ctermbg=NONE cterm=NONE
hi phpConstants guifg=#cc9057 guibg=NONE guisp=NONE gui=NONE ctermfg=173 ctermbg=NONE cterm=NONE
hi rubyBlockParameter guifg=#e55561 guibg=NONE guisp=NONE gui=NONE ctermfg=204 ctermbg=NONE cterm=NONE
hi rubyBlockParameterList guifg=#e55561 guibg=NONE guisp=NONE gui=NONE ctermfg=204 ctermbg=NONE cterm=NONE
hi rubyClass guifg=#bf68d9 guibg=NONE guisp=NONE gui=NONE ctermfg=170 ctermbg=NONE cterm=NONE
hi rubyConstant guifg=#e2b86b guibg=NONE guisp=NONE gui=NONE ctermfg=180 ctermbg=NONE cterm=NONE
hi rubyControl guifg=#bf68d9 guibg=NONE guisp=NONE gui=NONE ctermfg=170 ctermbg=NONE cterm=NONE
hi rubyEscape guifg=#e55561 guibg=NONE guisp=NONE gui=NONE ctermfg=204 ctermbg=NONE cterm=NONE
hi rubyFunction guifg=#4fa6ed guibg=NONE guisp=NONE gui=NONE ctermfg=39 ctermbg=NONE cterm=NONE
hi rubyGlobalVariable guifg=#e55561 guibg=NONE guisp=NONE gui=NONE ctermfg=204 ctermbg=NONE cterm=NONE
hi rubyInclude guifg=#4fa6ed guibg=NONE guisp=NONE gui=NONE ctermfg=39 ctermbg=NONE cterm=NONE
hi rubyIncluderubyGlobalVariable guifg=#e55561 guibg=NONE guisp=NONE gui=NONE ctermfg=204 ctermbg=NONE cterm=NONE
hi rubyInstanceVariable guifg=#e55561 guibg=NONE guisp=NONE gui=NONE ctermfg=204 ctermbg=NONE cterm=NONE
hi rubyInterpolation guifg=#48b0bd guibg=NONE guisp=NONE gui=NONE ctermfg=38 ctermbg=NONE cterm=NONE
hi rubyInterpolationDelimiter guifg=#e55561 guibg=NONE guisp=NONE gui=NONE ctermfg=204 ctermbg=NONE cterm=NONE
hi rubyInterpolationDelimiter guifg=#e55561 guibg=NONE guisp=NONE gui=NONE ctermfg=204 ctermbg=NONE cterm=NONE
hi rubyRegexp guifg=#48b0bd guibg=NONE guisp=NONE gui=NONE ctermfg=38 ctermbg=NONE cterm=NONE
hi rubyRegexpDelimiter guifg=#48b0bd guibg=NONE guisp=NONE gui=NONE ctermfg=38 ctermbg=NONE cterm=NONE
hi rubyStringDelimiter guifg=#8ebd6b guibg=NONE guisp=NONE gui=NONE ctermfg=114 ctermbg=NONE cterm=NONE
hi rubySymbol guifg=#48b0bd guibg=NONE guisp=NONE gui=NONE ctermfg=38 ctermbg=NONE cterm=NONE
hi sassAmpersand guifg=#e55561 guibg=NONE guisp=NONE gui=NONE ctermfg=204 ctermbg=NONE cterm=NONE
hi sassClass guifg=#cc9057 guibg=NONE guisp=NONE gui=NONE ctermfg=173 ctermbg=NONE cterm=NONE
hi sassControl guifg=#bf68d9 guibg=NONE guisp=NONE gui=NONE ctermfg=170 ctermbg=NONE cterm=NONE
hi sassExtend guifg=#bf68d9 guibg=NONE guisp=NONE gui=NONE ctermfg=170 ctermbg=NONE cterm=NONE
hi sassFor guifg=#a0a8b7 guibg=NONE guisp=NONE gui=NONE ctermfg=145 ctermbg=NONE cterm=NONE
hi sassFunction guifg=#48b0bd guibg=NONE guisp=NONE gui=NONE ctermfg=38 ctermbg=NONE cterm=NONE
hi sassId guifg=#4fa6ed guibg=NONE guisp=NONE gui=NONE ctermfg=39 ctermbg=NONE cterm=NONE
hi sassInclude guifg=#bf68d9 guibg=NONE guisp=NONE gui=NONE ctermfg=170 ctermbg=NONE cterm=NONE
hi sassMedia guifg=#bf68d9 guibg=NONE guisp=NONE gui=NONE ctermfg=170 ctermbg=NONE cterm=NONE
hi sassMediaOperators guifg=#a0a8b7 guibg=NONE guisp=NONE gui=NONE ctermfg=145 ctermbg=NONE cterm=NONE
hi sassMixin guifg=#bf68d9 guibg=NONE guisp=NONE gui=NONE ctermfg=170 ctermbg=NONE cterm=NONE
hi sassMixinName guifg=#4fa6ed guibg=NONE guisp=NONE gui=NONE ctermfg=39 ctermbg=NONE cterm=NONE
hi sassMixing guifg=#bf68d9 guibg=NONE guisp=NONE gui=NONE ctermfg=170 ctermbg=NONE cterm=NONE
hi sassVariable guifg=#bf68d9 guibg=NONE guisp=NONE gui=NONE ctermfg=170 ctermbg=NONE cterm=NONE
hi scssExtend guifg=#bf68d9 guibg=NONE guisp=NONE gui=NONE ctermfg=170 ctermbg=NONE cterm=NONE
hi scssImport guifg=#bf68d9 guibg=NONE guisp=NONE gui=NONE ctermfg=170 ctermbg=NONE cterm=NONE
hi scssInclude guifg=#bf68d9 guibg=NONE guisp=NONE gui=NONE ctermfg=170 ctermbg=NONE cterm=NONE
hi scssMixin guifg=#bf68d9 guibg=NONE guisp=NONE gui=NONE ctermfg=170 ctermbg=NONE cterm=NONE
hi scssSelectorName guifg=#cc9057 guibg=NONE guisp=NONE gui=NONE ctermfg=173 ctermbg=NONE cterm=NONE
hi scssVariable guifg=#bf68d9 guibg=NONE guisp=NONE gui=NONE ctermfg=170 ctermbg=NONE cterm=NONE
hi texStatement guifg=#bf68d9 guibg=NONE guisp=NONE gui=NONE ctermfg=170 ctermbg=NONE cterm=NONE
hi texSubscripts guifg=#cc9057 guibg=NONE guisp=NONE gui=NONE ctermfg=173 ctermbg=NONE cterm=NONE
hi texSuperscripts guifg=#cc9057 guibg=NONE guisp=NONE gui=NONE ctermfg=173 ctermbg=NONE cterm=NONE
hi texTodo guifg=#8b3434 guibg=NONE guisp=NONE gui=NONE ctermfg=196 ctermbg=NONE cterm=NONE
hi texBeginEnd guifg=#bf68d9 guibg=NONE guisp=NONE gui=NONE ctermfg=170 ctermbg=NONE cterm=NONE
hi texBeginEndName guifg=#4fa6ed guibg=NONE guisp=NONE gui=NONE ctermfg=39 ctermbg=NONE cterm=NONE
hi texMathMatcher guifg=#4fa6ed guibg=NONE guisp=NONE gui=NONE ctermfg=39 ctermbg=NONE cterm=NONE
hi texMathDelim guifg=#4fa6ed guibg=NONE guisp=NONE gui=NONE ctermfg=39 ctermbg=NONE cterm=NONE
hi texDelimiter guifg=#cc9057 guibg=NONE guisp=NONE gui=NONE ctermfg=173 ctermbg=NONE cterm=NONE
hi texSpecialChar guifg=#cc9057 guibg=NONE guisp=NONE gui=NONE ctermfg=173 ctermbg=NONE cterm=NONE
hi texCite guifg=#4fa6ed guibg=NONE guisp=NONE gui=NONE ctermfg=39 ctermbg=NONE cterm=NONE
hi texRefZone guifg=#4fa6ed guibg=NONE guisp=NONE gui=NONE ctermfg=39 ctermbg=NONE cterm=NONE
hi typescriptReserved guifg=#bf68d9 guibg=NONE guisp=NONE gui=NONE ctermfg=170 ctermbg=NONE cterm=NONE
hi typescriptEndColons guifg=#a0a8b7 guibg=NONE guisp=NONE gui=NONE ctermfg=145 ctermbg=NONE cterm=NONE
hi typescriptBraces guifg=#a0a8b7 guibg=NONE guisp=NONE gui=NONE ctermfg=145 ctermbg=NONE cterm=NONE
hi xmlAttrib guifg=#cc9057 guibg=NONE guisp=NONE gui=NONE ctermfg=173 ctermbg=NONE cterm=NONE
hi xmlEndTag guifg=#e55561 guibg=NONE guisp=NONE gui=NONE ctermfg=204 ctermbg=NONE cterm=NONE
hi xmlTag guifg=#e55561 guibg=NONE guisp=NONE gui=NONE ctermfg=204 ctermbg=NONE cterm=NONE
hi xmlTagName guifg=#e55561 guibg=NONE guisp=NONE gui=NONE ctermfg=204 ctermbg=NONE cterm=NONE
hi GitGutterAdd guifg=#8ebd6b guibg=NONE guisp=NONE gui=NONE ctermfg=114 ctermbg=NONE cterm=NONE
hi GitGutterChange guifg=#e2b86b guibg=NONE guisp=NONE gui=NONE ctermfg=180 ctermbg=NONE cterm=NONE
hi GitGutterDelete guifg=#e55561 guibg=NONE guisp=NONE gui=NONE ctermfg=204 ctermbg=NONE cterm=NONE
hi ALEError guifg=#e55561 guibg=NONE guisp=NONE gui=NONE ctermfg=204 ctermbg=NONE cterm=NONE
hi ALEWarning guifg=#e2b86b guibg=NONE guisp=NONE gui=NONE ctermfg=180 ctermbg=NONE cterm=NONE
hi ALEInfo guifg=NONE guibg=NONE guisp=NONE gui=NONE ctermfg=NONE ctermbg=NONE cterm=NONE
hi ALEErrorSign guifg=#e55561 guibg=NONE guisp=NONE gui=NONE ctermfg=204 ctermbg=NONE cterm=NONE
hi ALEWarningSign guifg=#e2b86b guibg=NONE guisp=NONE gui=NONE ctermfg=180 ctermbg=NONE cterm=NONE
hi ALEInfoSign guifg=NONE guibg=NONE guisp=NONE gui=NONE ctermfg=NONE ctermbg=NONE cterm=NONE
hi EasyMotionTarget guifg=#e55561 guibg=NONE guisp=NONE gui=NONE ctermfg=204 ctermbg=NONE cterm=NONE
hi EasyMotionTarget2First guifg=#e2b86b guibg=NONE guisp=NONE gui=NONE ctermfg=180 ctermbg=NONE cterm=NONE
hi EasyMotionTarget2Second guifg=#cc9057 guibg=NONE guisp=NONE gui=NONE ctermfg=173 ctermbg=NONE cterm=NONE
hi EasyMotionShade guifg=#535965 guibg=NONE guisp=NONE gui=NONE ctermfg=59 ctermbg=NONE cterm=NONE
hi CocErrorSign guifg=#e55561 guibg=NONE guisp=NONE gui=NONE ctermfg=204 ctermbg=NONE cterm=NONE
hi CocWarningSign guifg=#e2b86b guibg=NONE guisp=NONE gui=NONE ctermfg=180 ctermbg=NONE cterm=NONE
hi CocInfoSign guifg=#4fa6ed guibg=NONE guisp=NONE gui=NONE ctermfg=39 ctermbg=NONE cterm=NONE
hi CocHintSign guifg=#48b0bd guibg=NONE guisp=NONE gui=NONE ctermfg=38 ctermbg=NONE cterm=NONE
hi CocFadeOut guifg=#535965 guibg=NONE guisp=NONE gui=NONE ctermfg=59 ctermbg=NONE cterm=NONE
hi NeomakeErrorSign guifg=#e55561 guibg=NONE guisp=NONE gui=NONE ctermfg=204 ctermbg=NONE cterm=NONE
hi NeomakeWarningSign guifg=#e2b86b guibg=NONE guisp=NONE gui=NONE ctermfg=180 ctermbg=NONE cterm=NONE
hi NeomakeInfoSign guifg=#4fa6ed guibg=NONE guisp=NONE gui=NONE ctermfg=39 ctermbg=NONE cterm=NONE
hi mkdDelimiter guifg=#bf68d9 guibg=NONE guisp=NONE gui=NONE ctermfg=170 ctermbg=NONE cterm=NONE
hi mkdHeading guifg=#e55561 guibg=NONE guisp=NONE gui=NONE ctermfg=204 ctermbg=NONE cterm=NONE
hi mkdLink guifg=#4fa6ed guibg=NONE guisp=NONE gui=NONE ctermfg=39 ctermbg=NONE cterm=NONE
hi mkdURL guifg=#48b0bd guibg=NONE guisp=NONE gui=NONE ctermfg=38 ctermbg=NONE cterm=NONE
hi LspErrorText guifg=#e55561 guibg=NONE guisp=NONE gui=NONE ctermfg=204 ctermbg=NONE cterm=NONE
hi LspWarningText guifg=#e2b86b guibg=NONE guisp=NONE gui=NONE ctermfg=180 ctermbg=NONE cterm=NONE
hi LspInformationText guifg=#4fa6ed guibg=NONE guisp=NONE gui=NONE ctermfg=39 ctermbg=NONE cterm=NONE
hi LspHintText guifg=#48b0bd guibg=NONE guisp=NONE gui=NONE ctermfg=38 ctermbg=NONE cterm=NONE
hi LspErrorHighlight guifg=#e55561 guibg=NONE guisp=NONE gui=NONE ctermfg=204 ctermbg=NONE cterm=NONE
hi LspWarningHighlight guifg=#e2b86b guibg=NONE guisp=NONE gui=NONE ctermfg=180 ctermbg=NONE cterm=NONE
hi LspInformationHighlight guifg=#4fa6ed guibg=NONE guisp=NONE gui=NONE ctermfg=39 ctermbg=NONE cterm=NONE
hi LspHintHighlight guifg=#48b0bd guibg=NONE guisp=NONE gui=NONE ctermfg=38 ctermbg=NONE cterm=NONE
hi diffAdded guifg=#8ebd6b guibg=NONE guisp=NONE gui=NONE ctermfg=114 ctermbg=NONE cterm=NONE
hi diffRemoved guifg=#e55561 guibg=NONE guisp=NONE gui=NONE ctermfg=204 ctermbg=NONE cterm=NONE
hi gitcommitComment guifg=#535965 guibg=NONE guisp=NONE gui=NONE ctermfg=59 ctermbg=NONE cterm=NONE
hi gitcommitUnmerged guifg=#8ebd6b guibg=NONE guisp=NONE gui=NONE ctermfg=114 ctermbg=NONE cterm=NONE
hi gitcommitOnBranch guifg=NONE guibg=NONE guisp=NONE gui=NONE ctermfg=NONE ctermbg=NONE cterm=NONE
hi gitcommitBranch guifg=#bf68d9 guibg=NONE guisp=NONE gui=NONE ctermfg=170 ctermbg=NONE cterm=NONE
hi gitcommitDiscardedType guifg=#e55561 guibg=NONE guisp=NONE gui=NONE ctermfg=204 ctermbg=NONE cterm=NONE
hi gitcommitSelectedType guifg=#8ebd6b guibg=NONE guisp=NONE gui=NONE ctermfg=114 ctermbg=NONE cterm=NONE
hi gitcommitHeader guifg=NONE guibg=NONE guisp=NONE gui=NONE ctermfg=NONE ctermbg=NONE cterm=NONE
hi gitcommitUntrackedFile guifg=#48b0bd guibg=NONE guisp=NONE gui=NONE ctermfg=38 ctermbg=NONE cterm=NONE
hi gitcommitDiscardedFile guifg=#e55561 guibg=NONE guisp=NONE gui=NONE ctermfg=204 ctermbg=NONE cterm=NONE
hi gitcommitSelectedFile guifg=#8ebd6b guibg=NONE guisp=NONE gui=NONE ctermfg=114 ctermbg=NONE cterm=NONE
hi gitcommitUnmergedFile guifg=#e2b86b guibg=NONE guisp=NONE gui=NONE ctermfg=180 ctermbg=NONE cterm=NONE
hi gitcommitFile guifg=NONE guibg=NONE guisp=NONE gui=NONE ctermfg=NONE ctermbg=NONE cterm=NONE
hi gitcommitSummary guifg=#a0a8b7 guibg=NONE guisp=NONE gui=NONE ctermfg=145 ctermbg=NONE cterm=NONE
hi gitcommitOverflow guifg=#e55561 guibg=NONE guisp=NONE gui=NONE ctermfg=204 ctermbg=NONE cterm=NONE

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
    '#1f2329', '#e55561', '#8ebd6b', '#e2b86b',
    '#4fa6ed', '#bf68d9', '#48b0bd', '#7a818e',
    '#535965', '#e55561', '#8ebd6b', '#e2b86b',
    '#4fa6ed', '#bf68d9', '#48b0bd', '#a0a8b7'
]

# ============================================================
#  SupraOneDark — overrides
# ============================================================
# Comments
hi Comment        guifg=#535965 guibg=NONE gui=NONE cterm=NONE
hi SpecialComment guifg=#535965 guibg=NONE gui=NONE cterm=NONE
hi Folded         guifg=#535965 guibg=#181b20 gui=NONE cterm=NONE

# Cursor / current line
hi CursorLine     guibg=#282c34 gui=NONE cterm=NONE
hi CursorColumn   guibg=#282c34
hi ColorColumn    guibg=#282c34
hi CursorLineNr   guifg=#e2b86b guibg=NONE gui=NONE cterm=NONE
hi LineNr         guifg=#495162 guibg=NONE

# Matching paren
hi MatchParen     guifg=#48b0bd guibg=#323641 gui=NONE cterm=NONE

# Visual selection
hi Visual         guibg=#2d3343
hi VisualNOS      guibg=#2d3343

# Search
hi Search         guifg=#1f2329 guibg=#e2b86b gui=NONE cterm=NONE
hi IncSearch      guifg=#1f2329 guibg=#cc9057 gui=NONE cterm=NONE

# Completion menu
hi Pmenu          guifg=#a0a8b7 guibg=#282c34
hi PmenuSel       guifg=#1f2329 guibg=#4fa6ed gui=NONE cterm=NONE
hi PmenuSbar      guibg=#181b20
hi PmenuThumb     guibg=#495162

# Splits / statusline
hi VertSplit      guifg=#323641 guibg=NONE
hi WinSeparator   guifg=#323641 guibg=NONE
hi StatusLine     guifg=#a0a8b7 guibg=#282c34 gui=NONE cterm=NONE
hi StatusLineNC   guifg=#535965 guibg=#181b20 gui=NONE cterm=NONE

# Spell
hi SpellBad       guifg=NONE guisp=#e55561 gui=NONE cterm=NONE
hi SpellCap       guifg=NONE guisp=#e2b86b gui=NONE cterm=NONE
hi SpellRare      guifg=NONE guisp=#48b0bd gui=NONE cterm=NONE
hi SpellLocal     guifg=NONE guisp=#8ebd6b gui=NONE cterm=NONE

# Diff
hi DiffAdd        guifg=NONE guibg=#272e23
hi DiffDelete     guifg=NONE guibg=#2d2223
hi DiffChange     guifg=NONE guibg=#172a3a
hi DiffText       guifg=NONE guibg=#274964

# Titles / links
hi Title          guifg=#8ebd6b gui=NONE cterm=NONE
hi Underlined     guifg=#4fa6ed gui=NONE cterm=NONE
hi Directory      guifg=#4fa6ed gui=NONE cterm=NONE

# SignColumn without border
hi! link SignColumn Normal
hi! link EndOfBuffer Normal
