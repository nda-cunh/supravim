vim9script
# supra-gui: background=#1e242e include=#5ab0f6 stdio=#97ca72 typedef=#ebc275 struct=#ebc275 type_s=#a5b0c5 scope=#c4ccd9 float=#ebc275 function=#a5b0c5 format=#d99a5e text=#97ca72 integer=#d99a5e

hi clear

if exists("syntax_on")
  syntax reset
endif

set t_Co=256

g:colors_name = "supracool"

if !exists("g:supracool_termcolors")
	g:supracool_termcolors = 256
endif

if !exists("g:supracool_terminal_italics")
	g:supracool_terminal_italics = 0
endif

hi Comment guifg=#546178 guibg=NONE guisp=NONE gui=NONE ctermfg=59 ctermbg=NONE cterm=NONE
hi Constant guifg=#4dbdcb guibg=NONE guisp=NONE gui=NONE ctermfg=38 ctermbg=NONE cterm=NONE
hi String guifg=#97ca72 guibg=NONE guisp=NONE gui=NONE ctermfg=114 ctermbg=NONE cterm=NONE
hi Character guifg=#97ca72 guibg=NONE guisp=NONE gui=NONE ctermfg=114 ctermbg=NONE cterm=NONE
hi Number guifg=#d99a5e guibg=NONE guisp=NONE gui=NONE ctermfg=173 ctermbg=NONE cterm=NONE
hi Boolean guifg=#d99a5e guibg=NONE guisp=NONE gui=NONE ctermfg=173 ctermbg=NONE cterm=NONE
hi Float guifg=#d99a5e guibg=NONE guisp=NONE gui=NONE ctermfg=173 ctermbg=NONE cterm=NONE
hi Identifier guifg=#ef5f6b guibg=NONE guisp=NONE gui=NONE ctermfg=204 ctermbg=NONE cterm=NONE
hi Function guifg=#5ab0f6 guibg=NONE guisp=NONE gui=NONE ctermfg=39 ctermbg=NONE cterm=NONE
hi Statement guifg=#ca72e4 guibg=NONE guisp=NONE gui=NONE ctermfg=170 ctermbg=NONE cterm=NONE
hi Conditional guifg=#ca72e4 guibg=NONE guisp=NONE gui=NONE ctermfg=170 ctermbg=NONE cterm=NONE
hi Repeat guifg=#ca72e4 guibg=NONE guisp=NONE gui=NONE ctermfg=170 ctermbg=NONE cterm=NONE
hi Label guifg=#ca72e4 guibg=NONE guisp=NONE gui=NONE ctermfg=170 ctermbg=NONE cterm=NONE
hi Operator guifg=#ca72e4 guibg=NONE guisp=NONE gui=NONE ctermfg=170 ctermbg=NONE cterm=NONE
hi Keyword guifg=#ca72e4 guibg=NONE guisp=NONE gui=NONE ctermfg=170 ctermbg=NONE cterm=NONE
hi Exception guifg=#ca72e4 guibg=NONE guisp=NONE gui=NONE ctermfg=170 ctermbg=NONE cterm=NONE
hi PreProc guifg=#ebc275 guibg=NONE guisp=NONE gui=NONE ctermfg=180 ctermbg=NONE cterm=NONE
hi Include guifg=#5ab0f6 guibg=NONE guisp=NONE gui=NONE ctermfg=39 ctermbg=NONE cterm=NONE
hi Define guifg=#ca72e4 guibg=NONE guisp=NONE gui=NONE ctermfg=170 ctermbg=NONE cterm=NONE
hi Macro guifg=#ca72e4 guibg=NONE guisp=NONE gui=NONE ctermfg=170 ctermbg=NONE cterm=NONE
hi PreCondit guifg=#ebc275 guibg=NONE guisp=NONE gui=NONE ctermfg=180 ctermbg=NONE cterm=NONE
hi Type guifg=#ebc275 guibg=NONE guisp=NONE gui=NONE ctermfg=180 ctermbg=NONE cterm=NONE
hi StorageClass guifg=#ebc275 guibg=NONE guisp=NONE gui=NONE ctermfg=180 ctermbg=NONE cterm=NONE
hi Structure guifg=#ebc275 guibg=NONE guisp=NONE gui=NONE ctermfg=180 ctermbg=NONE cterm=NONE
hi Typedef guifg=#ebc275 guibg=NONE guisp=NONE gui=NONE ctermfg=180 ctermbg=NONE cterm=NONE
hi Special guifg=#5ab0f6 guibg=NONE guisp=NONE gui=NONE ctermfg=39 ctermbg=NONE cterm=NONE
hi SpecialChar guifg=#d99a5e guibg=NONE guisp=NONE gui=NONE ctermfg=173 ctermbg=NONE cterm=NONE
hi Tag guifg=NONE guibg=NONE guisp=NONE gui=NONE ctermfg=NONE ctermbg=NONE cterm=NONE
hi Delimiter guifg=NONE guibg=NONE guisp=NONE gui=NONE ctermfg=NONE ctermbg=NONE cterm=NONE
hi SpecialComment guifg=#546178 guibg=NONE guisp=NONE gui=NONE ctermfg=59 ctermbg=NONE cterm=NONE
hi Debug guifg=NONE guibg=NONE guisp=NONE gui=NONE ctermfg=NONE ctermbg=NONE cterm=NONE
hi Underlined guifg=NONE guibg=NONE guisp=NONE gui=NONE ctermfg=NONE ctermbg=NONE cterm=NONE
hi Ignore guifg=NONE guibg=NONE guisp=NONE gui=NONE ctermfg=NONE ctermbg=NONE cterm=NONE
hi Error guifg=#ef5f6b guibg=NONE guisp=NONE gui=NONE ctermfg=204 ctermbg=NONE cterm=NONE
hi Todo guifg=#ca72e4 guibg=NONE guisp=NONE gui=NONE ctermfg=170 ctermbg=NONE cterm=NONE
hi ColorColumn guifg=NONE guibg=#2d3343 guisp=NONE gui=NONE ctermfg=NONE ctermbg=236 cterm=NONE
hi Conceal guifg=NONE guibg=NONE guisp=NONE gui=NONE ctermfg=NONE ctermbg=NONE cterm=NONE
hi Cursor guifg=#242b38 guibg=#5ab0f6 guisp=NONE gui=NONE ctermfg=235 ctermbg=39 cterm=NONE
hi CursorIM guifg=NONE guibg=NONE guisp=NONE gui=NONE ctermfg=NONE ctermbg=NONE cterm=NONE
hi CursorColumn guifg=NONE guibg=#2d3343 guisp=NONE gui=NONE ctermfg=NONE ctermbg=236 cterm=NONE
hi CursorLine guifg=NONE guibg=#2d3343 guisp=NONE gui=NONE ctermfg=NONE ctermbg=236 cterm=NONE
hi Directory guifg=#5ab0f6 guibg=NONE guisp=NONE gui=NONE ctermfg=39 ctermbg=NONE cterm=NONE
hi DiffAdd guifg=#242b38 guibg=#97ca72 guisp=NONE gui=NONE ctermfg=235 ctermbg=114 cterm=NONE
hi DiffChange guifg=#ebc275 guibg=NONE guisp=NONE gui=NONE ctermfg=180 ctermbg=NONE cterm=NONE
hi DiffDelete guifg=#242b38 guibg=#ef5f6b guisp=NONE gui=NONE ctermfg=235 ctermbg=204 cterm=NONE
hi DiffText guifg=#242b38 guibg=#ebc275 guisp=NONE gui=NONE ctermfg=235 ctermbg=180 cterm=NONE
hi ErrorMsg guifg=#ef5f6b guibg=NONE guisp=NONE gui=NONE ctermfg=204 ctermbg=NONE cterm=NONE
hi VertSplit guifg=#363c51 guibg=NONE guisp=NONE gui=NONE ctermfg=59 ctermbg=NONE cterm=NONE
hi Folded guifg=#546178 guibg=NONE guisp=NONE gui=NONE ctermfg=59 ctermbg=NONE cterm=NONE
hi FoldColumn guifg=NONE guibg=NONE guisp=NONE gui=NONE ctermfg=NONE ctermbg=NONE cterm=NONE
hi SignColumn guifg=NONE guibg=NONE guisp=NONE gui=NONE ctermfg=NONE ctermbg=NONE cterm=NONE
hi IncSearch guifg=#ebc275 guibg=#546178 guisp=NONE gui=NONE ctermfg=180 ctermbg=59 cterm=NONE
hi LineNr guifg=#4b566c guibg=NONE guisp=NONE gui=NONE ctermfg=238 ctermbg=NONE cterm=NONE
hi CursorLineNr guifg=#d99a5e guibg=NONE guisp=NONE gui=NONE ctermfg=NONE ctermbg=NONE cterm=NONE
hi MatchParen guifg=#5ab0f6 guibg=NONE guisp=NONE gui=NONE ctermfg=39 ctermbg=NONE cterm=NONE
hi ModeMsg guifg=NONE guibg=NONE guisp=NONE gui=NONE ctermfg=NONE ctermbg=NONE cterm=NONE
hi MoreMsg guifg=NONE guibg=NONE guisp=NONE gui=NONE ctermfg=NONE ctermbg=NONE cterm=NONE
hi NonText guifg=#343e4f guibg=NONE guisp=NONE gui=NONE ctermfg=238 ctermbg=NONE cterm=NONE
hi Normal guifg=#a5b0c5 guibg=#242b38 guisp=NONE gui=NONE ctermfg=145 ctermbg=235 cterm=NONE
hi Pmenu guifg=#a5b0c5 guibg=#363c51 guisp=NONE gui=NONE ctermfg=145 ctermbg=237 cterm=NONE
hi PmenuSel guifg=#2d3343 guibg=#5ab0f6 guisp=NONE gui=NONE ctermfg=236 ctermbg=39 cterm=NONE
hi PmenuSbar guifg=NONE guibg=#2d3343 guisp=NONE gui=NONE ctermfg=NONE ctermbg=236 cterm=NONE
hi PmenuThumb guifg=NONE guibg=#a5b0c5 guisp=NONE gui=NONE ctermfg=NONE ctermbg=145 cterm=NONE
hi Question guifg=#ca72e4 guibg=NONE guisp=NONE gui=NONE ctermfg=170 ctermbg=NONE cterm=NONE
hi QuickFixLine guifg=#242b38 guibg=#ebc275 guisp=NONE gui=NONE ctermfg=235 ctermbg=180 cterm=NONE
hi Search guifg=#242b38 guibg=#ebc275 guisp=NONE gui=NONE ctermfg=235 ctermbg=180 cterm=NONE
hi SpecialKey guifg=#343e4f guibg=NONE guisp=NONE gui=NONE ctermfg=238 ctermbg=NONE cterm=NONE
hi SpellBad guifg=#ef5f6b guibg=NONE guisp=NONE gui=NONE ctermfg=204 ctermbg=NONE cterm=NONE
hi SpellCap guifg=#d99a5e guibg=NONE guisp=NONE gui=NONE ctermfg=173 ctermbg=NONE cterm=NONE
hi SpellLocal guifg=#d99a5e guibg=NONE guisp=NONE gui=NONE ctermfg=173 ctermbg=NONE cterm=NONE
hi SpellRare guifg=#d99a5e guibg=NONE guisp=NONE gui=NONE ctermfg=173 ctermbg=NONE cterm=NONE
hi StatusLine guifg=#a5b0c5 guibg=#2d3343 guisp=NONE gui=NONE ctermfg=145 ctermbg=236 cterm=NONE
hi StatusLineNC guifg=#546178 guibg=NONE guisp=NONE gui=NONE ctermfg=59 ctermbg=NONE cterm=NONE
hi StatusLineTerm guifg=#a5b0c5 guibg=#2d3343 guisp=NONE gui=NONE ctermfg=145 ctermbg=236 cterm=NONE
hi StatusLineTermNC guifg=#546178 guibg=NONE guisp=NONE gui=NONE ctermfg=59 ctermbg=NONE cterm=NONE
hi TabLine guifg=#546178 guibg=NONE guisp=NONE gui=NONE ctermfg=59 ctermbg=NONE cterm=NONE
hi TabLineFill guifg=NONE guibg=NONE guisp=NONE gui=NONE ctermfg=NONE ctermbg=NONE cterm=NONE
hi TabLineSel guifg=#a5b0c5 guibg=NONE guisp=NONE gui=NONE ctermfg=145 ctermbg=NONE cterm=NONE
hi Terminal guifg=#a5b0c5 guibg=#242b38 guisp=NONE gui=NONE ctermfg=145 ctermbg=235 cterm=NONE
hi Title guifg=#97ca72 guibg=NONE guisp=NONE gui=NONE ctermfg=114 ctermbg=NONE cterm=NONE
hi Visual guifg=NONE guibg=#363c51 guisp=NONE gui=NONE ctermfg=NONE ctermbg=237 cterm=NONE
hi VisualNOS guifg=NONE guibg=#363c51 guisp=NONE gui=NONE ctermfg=NONE ctermbg=237 cterm=NONE
hi WarningMsg guifg=#ebc275 guibg=NONE guisp=NONE gui=NONE ctermfg=180 ctermbg=NONE cterm=NONE
hi WildMenu guifg=#242b38 guibg=#5ab0f6 guisp=NONE gui=NONE ctermfg=235 ctermbg=39 cterm=NONE

hi PMenuMatch guifg=#ebc275 guibg=NONE guisp=NONE gui=NONE ctermfg=180 ctermbg=237 cterm=NONE
hi PMenuKind guifg=#ca72e4 guibg=NONE guisp=NONE cterm=NONE gui=NONE ctermfg=38

hi debugPC guifg=NONE guibg=#343e4f guisp=NONE gui=NONE ctermfg=NONE ctermbg=238 cterm=NONE
hi debugBreakpoint guifg=#242b38 guibg=#ef5f6b guisp=NONE gui=NONE ctermfg=235 ctermbg=204 cterm=NONE
hi cssAttrComma guifg=#ca72e4 guibg=NONE guisp=NONE gui=NONE ctermfg=170 ctermbg=NONE cterm=NONE
hi cssAttributeSelector guifg=#97ca72 guibg=NONE guisp=NONE gui=NONE ctermfg=114 ctermbg=NONE cterm=NONE
hi cssBraces guifg=#a5b0c5 guibg=NONE guisp=NONE gui=NONE ctermfg=145 ctermbg=NONE cterm=NONE
hi cssClassName guifg=#d99a5e guibg=NONE guisp=NONE gui=NONE ctermfg=173 ctermbg=NONE cterm=NONE
hi cssClassNameDot guifg=#d99a5e guibg=NONE guisp=NONE gui=NONE ctermfg=173 ctermbg=NONE cterm=NONE
hi cssDefinition guifg=#ca72e4 guibg=NONE guisp=NONE gui=NONE ctermfg=170 ctermbg=NONE cterm=NONE
hi cssFontAttr guifg=#d99a5e guibg=NONE guisp=NONE gui=NONE ctermfg=173 ctermbg=NONE cterm=NONE
hi cssFontDescriptor guifg=#ca72e4 guibg=NONE guisp=NONE gui=NONE ctermfg=170 ctermbg=NONE cterm=NONE
hi cssFunctionName guifg=#5ab0f6 guibg=NONE guisp=NONE gui=NONE ctermfg=39 ctermbg=NONE cterm=NONE
hi cssIdentifier guifg=#5ab0f6 guibg=NONE guisp=NONE gui=NONE ctermfg=39 ctermbg=NONE cterm=NONE
hi cssImportant guifg=#ca72e4 guibg=NONE guisp=NONE gui=NONE ctermfg=170 ctermbg=NONE cterm=NONE
hi cssInclude guifg=#a5b0c5 guibg=NONE guisp=NONE gui=NONE ctermfg=145 ctermbg=NONE cterm=NONE
hi cssIncludeKeyword guifg=#ca72e4 guibg=NONE guisp=NONE gui=NONE ctermfg=170 ctermbg=NONE cterm=NONE
hi cssMediaType guifg=#d99a5e guibg=NONE guisp=NONE gui=NONE ctermfg=173 ctermbg=NONE cterm=NONE
hi cssProp guifg=#a5b0c5 guibg=NONE guisp=NONE gui=NONE ctermfg=145 ctermbg=NONE cterm=NONE
hi cssPseudoClassId guifg=#d99a5e guibg=NONE guisp=NONE gui=NONE ctermfg=173 ctermbg=NONE cterm=NONE
hi cssSelectorOp guifg=#ca72e4 guibg=NONE guisp=NONE gui=NONE ctermfg=170 ctermbg=NONE cterm=NONE
hi cssSelectorOp2 guifg=#ca72e4 guibg=NONE guisp=NONE gui=NONE ctermfg=170 ctermbg=NONE cterm=NONE
hi cssTagName guifg=#ef5f6b guibg=NONE guisp=NONE gui=NONE ctermfg=204 ctermbg=NONE cterm=NONE
hi fishKeyword guifg=#ca72e4 guibg=NONE guisp=NONE gui=NONE ctermfg=170 ctermbg=NONE cterm=NONE
hi fishConditional guifg=#ca72e4 guibg=NONE guisp=NONE gui=NONE ctermfg=170 ctermbg=NONE cterm=NONE
hi goDeclaration guifg=#ca72e4 guibg=NONE guisp=NONE gui=NONE ctermfg=170 ctermbg=NONE cterm=NONE
hi goBuiltins guifg=#4dbdcb guibg=NONE guisp=NONE gui=NONE ctermfg=38 ctermbg=NONE cterm=NONE
hi goFunctionCall guifg=#5ab0f6 guibg=NONE guisp=NONE gui=NONE ctermfg=39 ctermbg=NONE cterm=NONE
hi goVarDefs guifg=#ef5f6b guibg=NONE guisp=NONE gui=NONE ctermfg=204 ctermbg=NONE cterm=NONE
hi goVarAssign guifg=#ef5f6b guibg=NONE guisp=NONE gui=NONE ctermfg=204 ctermbg=NONE cterm=NONE
hi goVar guifg=#ca72e4 guibg=NONE guisp=NONE gui=NONE ctermfg=170 ctermbg=NONE cterm=NONE
hi goConst guifg=#ca72e4 guibg=NONE guisp=NONE gui=NONE ctermfg=170 ctermbg=NONE cterm=NONE
hi goType guifg=#ebc275 guibg=NONE guisp=NONE gui=NONE ctermfg=180 ctermbg=NONE cterm=NONE
hi goTypeName guifg=#ebc275 guibg=NONE guisp=NONE gui=NONE ctermfg=180 ctermbg=NONE cterm=NONE
hi goDeclType guifg=#4dbdcb guibg=NONE guisp=NONE gui=NONE ctermfg=38 ctermbg=NONE cterm=NONE
hi goTypeDecl guifg=#ca72e4 guibg=NONE guisp=NONE gui=NONE ctermfg=170 ctermbg=NONE cterm=NONE
hi htmlArg guifg=#d99a5e guibg=NONE guisp=NONE gui=NONE ctermfg=173 ctermbg=NONE cterm=NONE
hi htmlBold guifg=#d99a5e guibg=NONE guisp=NONE gui=NONE ctermfg=173 ctermbg=NONE cterm=NONE
hi htmlBoldItalic guifg=#97ca72 guibg=NONE guisp=NONE gui=NONE ctermfg=114 ctermbg=NONE cterm=NONE
hi htmlEndTag guifg=#a5b0c5 guibg=NONE guisp=NONE gui=NONE ctermfg=145 ctermbg=NONE cterm=NONE
hi htmlH1 guifg=#ef5f6b guibg=NONE guisp=NONE gui=NONE ctermfg=204 ctermbg=NONE cterm=NONE
hi htmlH2 guifg=#ef5f6b guibg=NONE guisp=NONE gui=NONE ctermfg=204 ctermbg=NONE cterm=NONE
hi htmlH3 guifg=#ef5f6b guibg=NONE guisp=NONE gui=NONE ctermfg=204 ctermbg=NONE cterm=NONE
hi htmlH4 guifg=#ef5f6b guibg=NONE guisp=NONE gui=NONE ctermfg=204 ctermbg=NONE cterm=NONE
hi htmlH5 guifg=#ef5f6b guibg=NONE guisp=NONE gui=NONE ctermfg=204 ctermbg=NONE cterm=NONE
hi htmlH6 guifg=#ef5f6b guibg=NONE guisp=NONE gui=NONE ctermfg=204 ctermbg=NONE cterm=NONE
hi htmlItalic guifg=#ca72e4 guibg=NONE guisp=NONE gui=NONE ctermfg=170 ctermbg=NONE cterm=NONE
hi htmlLink guifg=#4dbdcb guibg=NONE guisp=NONE gui=NONE ctermfg=38 ctermbg=NONE cterm=NONE
hi htmlSpecialChar guifg=#d99a5e guibg=NONE guisp=NONE gui=NONE ctermfg=173 ctermbg=NONE cterm=NONE
hi htmlSpecialTagName guifg=#ef5f6b guibg=NONE guisp=NONE gui=NONE ctermfg=204 ctermbg=NONE cterm=NONE
hi htmlTag guifg=#a5b0c5 guibg=NONE guisp=NONE gui=NONE ctermfg=145 ctermbg=NONE cterm=NONE
hi htmlTagN guifg=#ef5f6b guibg=NONE guisp=NONE gui=NONE ctermfg=204 ctermbg=NONE cterm=NONE
hi htmlTagName guifg=#ef5f6b guibg=NONE guisp=NONE gui=NONE ctermfg=204 ctermbg=NONE cterm=NONE
hi htmlTitle guifg=#a5b0c5 guibg=NONE guisp=NONE gui=NONE ctermfg=145 ctermbg=NONE cterm=NONE
hi javaScriptBraces guifg=#a5b0c5 guibg=NONE guisp=NONE gui=NONE ctermfg=145 ctermbg=NONE cterm=NONE
hi javaScriptFunction guifg=#ca72e4 guibg=NONE guisp=NONE gui=NONE ctermfg=170 ctermbg=NONE cterm=NONE
hi javaScriptIdentifier guifg=#ca72e4 guibg=NONE guisp=NONE gui=NONE ctermfg=170 ctermbg=NONE cterm=NONE
hi javaScriptNull guifg=#d99a5e guibg=NONE guisp=NONE gui=NONE ctermfg=173 ctermbg=NONE cterm=NONE
hi javaScriptNumber guifg=#d99a5e guibg=NONE guisp=NONE gui=NONE ctermfg=173 ctermbg=NONE cterm=NONE
hi javaScriptRequire guifg=#4dbdcb guibg=NONE guisp=NONE gui=NONE ctermfg=38 ctermbg=NONE cterm=NONE
hi javaScriptReserved guifg=#ca72e4 guibg=NONE guisp=NONE gui=NONE ctermfg=170 ctermbg=NONE cterm=NONE
hi jsArrowFunction guifg=#ca72e4 guibg=NONE guisp=NONE gui=NONE ctermfg=170 ctermbg=NONE cterm=NONE
hi jsClassKeyword guifg=#ca72e4 guibg=NONE guisp=NONE gui=NONE ctermfg=170 ctermbg=NONE cterm=NONE
hi jsClassMethodType guifg=#ca72e4 guibg=NONE guisp=NONE gui=NONE ctermfg=170 ctermbg=NONE cterm=NONE
hi jsDocParam guifg=#5ab0f6 guibg=NONE guisp=NONE gui=NONE ctermfg=39 ctermbg=NONE cterm=NONE
hi jsDocTags guifg=#ca72e4 guibg=NONE guisp=NONE gui=NONE ctermfg=170 ctermbg=NONE cterm=NONE
hi jsExport guifg=#ca72e4 guibg=NONE guisp=NONE gui=NONE ctermfg=170 ctermbg=NONE cterm=NONE
hi jsExportDefault guifg=#ca72e4 guibg=NONE guisp=NONE gui=NONE ctermfg=170 ctermbg=NONE cterm=NONE
hi jsExtendsKeyword guifg=#ca72e4 guibg=NONE guisp=NONE gui=NONE ctermfg=170 ctermbg=NONE cterm=NONE
hi jsFrom guifg=#ca72e4 guibg=NONE guisp=NONE gui=NONE ctermfg=170 ctermbg=NONE cterm=NONE
hi jsFuncCall guifg=#5ab0f6 guibg=NONE guisp=NONE gui=NONE ctermfg=39 ctermbg=NONE cterm=NONE
hi jsFunction guifg=#ca72e4 guibg=NONE guisp=NONE gui=NONE ctermfg=170 ctermbg=NONE cterm=NONE
hi jsGenerator guifg=#ebc275 guibg=NONE guisp=NONE gui=NONE ctermfg=180 ctermbg=NONE cterm=NONE
hi jsGlobalObjects guifg=#ebc275 guibg=NONE guisp=NONE gui=NONE ctermfg=180 ctermbg=NONE cterm=NONE
hi jsImport guifg=#ca72e4 guibg=NONE guisp=NONE gui=NONE ctermfg=170 ctermbg=NONE cterm=NONE
hi jsModuleAs guifg=#ca72e4 guibg=NONE guisp=NONE gui=NONE ctermfg=170 ctermbg=NONE cterm=NONE
hi jsModuleWords guifg=#ca72e4 guibg=NONE guisp=NONE gui=NONE ctermfg=170 ctermbg=NONE cterm=NONE
hi jsModules guifg=#ca72e4 guibg=NONE guisp=NONE gui=NONE ctermfg=170 ctermbg=NONE cterm=NONE
hi jsNull guifg=#d99a5e guibg=NONE guisp=NONE gui=NONE ctermfg=173 ctermbg=NONE cterm=NONE
hi jsOperator guifg=#ca72e4 guibg=NONE guisp=NONE gui=NONE ctermfg=170 ctermbg=NONE cterm=NONE
hi jsStorageClass guifg=#ca72e4 guibg=NONE guisp=NONE gui=NONE ctermfg=170 ctermbg=NONE cterm=NONE
hi jsSuper guifg=#ef5f6b guibg=NONE guisp=NONE gui=NONE ctermfg=204 ctermbg=NONE cterm=NONE
hi jsTemplateBraces guifg=#a13131 guibg=NONE guisp=NONE gui=NONE ctermfg=196 ctermbg=NONE cterm=NONE
hi jsTemplateVar guifg=#97ca72 guibg=NONE guisp=NONE gui=NONE ctermfg=114 ctermbg=NONE cterm=NONE
hi jsThis guifg=#ef5f6b guibg=NONE guisp=NONE gui=NONE ctermfg=204 ctermbg=NONE cterm=NONE
hi jsUndefined guifg=#d99a5e guibg=NONE guisp=NONE gui=NONE ctermfg=173 ctermbg=NONE cterm=NONE
hi javascriptArrowFunc guifg=#ca72e4 guibg=NONE guisp=NONE gui=NONE ctermfg=170 ctermbg=NONE cterm=NONE
hi javascriptClassExtends guifg=#ca72e4 guibg=NONE guisp=NONE gui=NONE ctermfg=170 ctermbg=NONE cterm=NONE
hi javascriptClassKeyword guifg=#ca72e4 guibg=NONE guisp=NONE gui=NONE ctermfg=170 ctermbg=NONE cterm=NONE
hi javascriptDocNotation guifg=#ca72e4 guibg=NONE guisp=NONE gui=NONE ctermfg=170 ctermbg=NONE cterm=NONE
hi javascriptDocParamName guifg=#5ab0f6 guibg=NONE guisp=NONE gui=NONE ctermfg=39 ctermbg=NONE cterm=NONE
hi javascriptDocTags guifg=#ca72e4 guibg=NONE guisp=NONE gui=NONE ctermfg=170 ctermbg=NONE cterm=NONE
hi javascriptEndColons guifg=#a5b0c5 guibg=NONE guisp=NONE gui=NONE ctermfg=145 ctermbg=NONE cterm=NONE
hi javascriptExport guifg=#ca72e4 guibg=NONE guisp=NONE gui=NONE ctermfg=170 ctermbg=NONE cterm=NONE
hi javascriptFuncArg guifg=#a5b0c5 guibg=NONE guisp=NONE gui=NONE ctermfg=145 ctermbg=NONE cterm=NONE
hi javascriptFuncKeyword guifg=#ca72e4 guibg=NONE guisp=NONE gui=NONE ctermfg=170 ctermbg=NONE cterm=NONE
hi javascriptIdentifier guifg=#ef5f6b guibg=NONE guisp=NONE gui=NONE ctermfg=204 ctermbg=NONE cterm=NONE
hi javascriptImport guifg=#ca72e4 guibg=NONE guisp=NONE gui=NONE ctermfg=170 ctermbg=NONE cterm=NONE
hi javascriptMethodName guifg=#a5b0c5 guibg=NONE guisp=NONE gui=NONE ctermfg=145 ctermbg=NONE cterm=NONE
hi javascriptObjectLabel guifg=#a5b0c5 guibg=NONE guisp=NONE gui=NONE ctermfg=145 ctermbg=NONE cterm=NONE
hi javascriptOpSymbol guifg=#4dbdcb guibg=NONE guisp=NONE gui=NONE ctermfg=38 ctermbg=NONE cterm=NONE
hi javascriptOpSymbols guifg=#4dbdcb guibg=NONE guisp=NONE gui=NONE ctermfg=38 ctermbg=NONE cterm=NONE
hi javascriptPropertyName guifg=#97ca72 guibg=NONE guisp=NONE gui=NONE ctermfg=114 ctermbg=NONE cterm=NONE
hi javascriptTemplateSB guifg=#a13131 guibg=NONE guisp=NONE gui=NONE ctermfg=196 ctermbg=NONE cterm=NONE
hi javascriptVariable guifg=#ca72e4 guibg=NONE guisp=NONE gui=NONE ctermfg=170 ctermbg=NONE cterm=NONE
hi jsonCommentError guifg=#a5b0c5 guibg=NONE guisp=NONE gui=NONE ctermfg=145 ctermbg=NONE cterm=NONE
hi jsonKeyword guifg=#ef5f6b guibg=NONE guisp=NONE gui=NONE ctermfg=204 ctermbg=NONE cterm=NONE
hi jsonBoolean guifg=#d99a5e guibg=NONE guisp=NONE gui=NONE ctermfg=173 ctermbg=NONE cterm=NONE
hi jsonNumber guifg=#d99a5e guibg=NONE guisp=NONE gui=NONE ctermfg=173 ctermbg=NONE cterm=NONE
hi jsonQuote guifg=#a5b0c5 guibg=NONE guisp=NONE gui=NONE ctermfg=145 ctermbg=NONE cterm=NONE
hi jsonMissingCommaError guifg=#ef5f6b guibg=NONE guisp=NONE gui=NONE ctermfg=204 ctermbg=NONE cterm=NONE
hi jsonNoQuotesError guifg=#ef5f6b guibg=NONE guisp=NONE gui=NONE ctermfg=204 ctermbg=NONE cterm=NONE
hi jsonNumError guifg=#ef5f6b guibg=NONE guisp=NONE gui=NONE ctermfg=204 ctermbg=NONE cterm=NONE
hi jsonString guifg=#97ca72 guibg=NONE guisp=NONE gui=NONE ctermfg=114 ctermbg=NONE cterm=NONE
hi jsonStringSQError guifg=#ef5f6b guibg=NONE guisp=NONE gui=NONE ctermfg=204 ctermbg=NONE cterm=NONE
hi jsonSemicolonError guifg=#ef5f6b guibg=NONE guisp=NONE gui=NONE ctermfg=204 ctermbg=NONE cterm=NONE
hi lessVariable guifg=#ca72e4 guibg=NONE guisp=NONE gui=NONE ctermfg=170 ctermbg=NONE cterm=NONE
hi lessAmpersandChar guifg=#a5b0c5 guibg=NONE guisp=NONE gui=NONE ctermfg=145 ctermbg=NONE cterm=NONE
hi lessClass guifg=#d99a5e guibg=NONE guisp=NONE gui=NONE ctermfg=173 ctermbg=NONE cterm=NONE
hi markdownBlockquote guifg=#546178 guibg=NONE guisp=NONE gui=NONE ctermfg=59 ctermbg=NONE cterm=NONE
hi markdownBold guifg=#d99a5e guibg=NONE guisp=NONE gui=NONE ctermfg=173 ctermbg=NONE cterm=NONE
hi markdownBoldItalic guifg=#97ca72 guibg=NONE guisp=NONE gui=NONE ctermfg=114 ctermbg=NONE cterm=NONE
hi markdownCode guifg=#97ca72 guibg=NONE guisp=NONE gui=NONE ctermfg=114 ctermbg=NONE cterm=NONE
hi markdownCodeBlock guifg=#97ca72 guibg=NONE guisp=NONE gui=NONE ctermfg=114 ctermbg=NONE cterm=NONE
hi markdownCodeDelimiter guifg=#97ca72 guibg=NONE guisp=NONE gui=NONE ctermfg=114 ctermbg=NONE cterm=NONE
hi markdownH1 guifg=#ef5f6b guibg=NONE guisp=NONE gui=NONE ctermfg=204 ctermbg=NONE cterm=NONE
hi markdownH2 guifg=#ef5f6b guibg=NONE guisp=NONE gui=NONE ctermfg=204 ctermbg=NONE cterm=NONE
hi markdownH3 guifg=#ef5f6b guibg=NONE guisp=NONE gui=NONE ctermfg=204 ctermbg=NONE cterm=NONE
hi markdownH4 guifg=#ef5f6b guibg=NONE guisp=NONE gui=NONE ctermfg=204 ctermbg=NONE cterm=NONE
hi markdownH5 guifg=#ef5f6b guibg=NONE guisp=NONE gui=NONE ctermfg=204 ctermbg=NONE cterm=NONE
hi markdownH6 guifg=#ef5f6b guibg=NONE guisp=NONE gui=NONE ctermfg=204 ctermbg=NONE cterm=NONE
hi markdownHeadingDelimiter guifg=#ef5f6b guibg=NONE guisp=NONE gui=NONE ctermfg=204 ctermbg=NONE cterm=NONE
hi markdownHeadingRule guifg=#546178 guibg=NONE guisp=NONE gui=NONE ctermfg=59 ctermbg=NONE cterm=NONE
hi markdownId guifg=#ca72e4 guibg=NONE guisp=NONE gui=NONE ctermfg=170 ctermbg=NONE cterm=NONE
hi markdownIdDeclaration guifg=#5ab0f6 guibg=NONE guisp=NONE gui=NONE ctermfg=39 ctermbg=NONE cterm=NONE
hi markdownIdDelimiter guifg=#ca72e4 guibg=NONE guisp=NONE gui=NONE ctermfg=170 ctermbg=NONE cterm=NONE
hi markdownItalic guifg=#ca72e4 guibg=NONE guisp=NONE gui=NONE ctermfg=170 ctermbg=NONE cterm=NONE
hi markdownLinkDelimiter guifg=#ca72e4 guibg=NONE guisp=NONE gui=NONE ctermfg=170 ctermbg=NONE cterm=NONE
hi markdownLinkText guifg=#5ab0f6 guibg=NONE guisp=NONE gui=NONE ctermfg=39 ctermbg=NONE cterm=NONE
hi markdownListMarker guifg=#ef5f6b guibg=NONE guisp=NONE gui=NONE ctermfg=204 ctermbg=NONE cterm=NONE
hi markdownOrderedListMarker guifg=#ef5f6b guibg=NONE guisp=NONE gui=NONE ctermfg=204 ctermbg=NONE cterm=NONE
hi markdownRule guifg=#546178 guibg=NONE guisp=NONE gui=NONE ctermfg=59 ctermbg=NONE cterm=NONE
hi markdownUrl guifg=#4dbdcb guibg=NONE guisp=NONE gui=NONE ctermfg=38 ctermbg=NONE cterm=NONE
hi perlFiledescRead guifg=#97ca72 guibg=NONE guisp=NONE gui=NONE ctermfg=114 ctermbg=NONE cterm=NONE
hi perlFunction guifg=#ca72e4 guibg=NONE guisp=NONE gui=NONE ctermfg=170 ctermbg=NONE cterm=NONE
hi perlMatchStartEnd guifg=#5ab0f6 guibg=NONE guisp=NONE gui=NONE ctermfg=39 ctermbg=NONE cterm=NONE
hi perlMethod guifg=#ca72e4 guibg=NONE guisp=NONE gui=NONE ctermfg=170 ctermbg=NONE cterm=NONE
hi perlPOD guifg=#546178 guibg=NONE guisp=NONE gui=NONE ctermfg=59 ctermbg=NONE cterm=NONE
hi perlSharpBang guifg=#546178 guibg=NONE guisp=NONE gui=NONE ctermfg=59 ctermbg=NONE cterm=NONE
hi perlSpecialString guifg=#d99a5e guibg=NONE guisp=NONE gui=NONE ctermfg=173 ctermbg=NONE cterm=NONE
hi perlStatementFiledesc guifg=#ef5f6b guibg=NONE guisp=NONE gui=NONE ctermfg=204 ctermbg=NONE cterm=NONE
hi perlStatementFlow guifg=#ef5f6b guibg=NONE guisp=NONE gui=NONE ctermfg=204 ctermbg=NONE cterm=NONE
hi perlStatementInclude guifg=#ca72e4 guibg=NONE guisp=NONE gui=NONE ctermfg=170 ctermbg=NONE cterm=NONE
hi perlStatementScalar guifg=#ca72e4 guibg=NONE guisp=NONE gui=NONE ctermfg=170 ctermbg=NONE cterm=NONE
hi perlStatementStorage guifg=#ca72e4 guibg=NONE guisp=NONE gui=NONE ctermfg=170 ctermbg=NONE cterm=NONE
hi perlSubName guifg=#ebc275 guibg=NONE guisp=NONE gui=NONE ctermfg=180 ctermbg=NONE cterm=NONE
hi perlVarPlain guifg=#5ab0f6 guibg=NONE guisp=NONE gui=NONE ctermfg=39 ctermbg=NONE cterm=NONE
hi phpVarSelector guifg=#ef5f6b guibg=NONE guisp=NONE gui=NONE ctermfg=204 ctermbg=NONE cterm=NONE
hi phpOperator guifg=#a5b0c5 guibg=NONE guisp=NONE gui=NONE ctermfg=145 ctermbg=NONE cterm=NONE
hi phpParent guifg=#a5b0c5 guibg=NONE guisp=NONE gui=NONE ctermfg=145 ctermbg=NONE cterm=NONE
hi phpMemberSelector guifg=#a5b0c5 guibg=NONE guisp=NONE gui=NONE ctermfg=145 ctermbg=NONE cterm=NONE
hi phpType guifg=#ca72e4 guibg=NONE guisp=NONE gui=NONE ctermfg=170 ctermbg=NONE cterm=NONE
hi phpKeyword guifg=#ca72e4 guibg=NONE guisp=NONE gui=NONE ctermfg=170 ctermbg=NONE cterm=NONE
hi phpClass guifg=#ebc275 guibg=NONE guisp=NONE gui=NONE ctermfg=180 ctermbg=NONE cterm=NONE
hi phpUseClass guifg=#a5b0c5 guibg=NONE guisp=NONE gui=NONE ctermfg=145 ctermbg=NONE cterm=NONE
hi phpUseAlias guifg=#a5b0c5 guibg=NONE guisp=NONE gui=NONE ctermfg=145 ctermbg=NONE cterm=NONE
hi phpInclude guifg=#ca72e4 guibg=NONE guisp=NONE gui=NONE ctermfg=170 ctermbg=NONE cterm=NONE
hi phpClassExtends guifg=#97ca72 guibg=NONE guisp=NONE gui=NONE ctermfg=114 ctermbg=NONE cterm=NONE
hi phpDocTags guifg=#a5b0c5 guibg=NONE guisp=NONE gui=NONE ctermfg=145 ctermbg=NONE cterm=NONE
hi phpFunction guifg=#5ab0f6 guibg=NONE guisp=NONE gui=NONE ctermfg=39 ctermbg=NONE cterm=NONE
hi phpFunctions guifg=#4dbdcb guibg=NONE guisp=NONE gui=NONE ctermfg=38 ctermbg=NONE cterm=NONE
hi phpMethodsVar guifg=#d99a5e guibg=NONE guisp=NONE gui=NONE ctermfg=173 ctermbg=NONE cterm=NONE
hi phpMagicConstants guifg=#d99a5e guibg=NONE guisp=NONE gui=NONE ctermfg=173 ctermbg=NONE cterm=NONE
hi phpSuperglobals guifg=#ef5f6b guibg=NONE guisp=NONE gui=NONE ctermfg=204 ctermbg=NONE cterm=NONE
hi phpConstants guifg=#d99a5e guibg=NONE guisp=NONE gui=NONE ctermfg=173 ctermbg=NONE cterm=NONE
hi rubyBlockParameter guifg=#ef5f6b guibg=NONE guisp=NONE gui=NONE ctermfg=204 ctermbg=NONE cterm=NONE
hi rubyBlockParameterList guifg=#ef5f6b guibg=NONE guisp=NONE gui=NONE ctermfg=204 ctermbg=NONE cterm=NONE
hi rubyClass guifg=#ca72e4 guibg=NONE guisp=NONE gui=NONE ctermfg=170 ctermbg=NONE cterm=NONE
hi rubyConstant guifg=#ebc275 guibg=NONE guisp=NONE gui=NONE ctermfg=180 ctermbg=NONE cterm=NONE
hi rubyControl guifg=#ca72e4 guibg=NONE guisp=NONE gui=NONE ctermfg=170 ctermbg=NONE cterm=NONE
hi rubyEscape guifg=#ef5f6b guibg=NONE guisp=NONE gui=NONE ctermfg=204 ctermbg=NONE cterm=NONE
hi rubyFunction guifg=#5ab0f6 guibg=NONE guisp=NONE gui=NONE ctermfg=39 ctermbg=NONE cterm=NONE
hi rubyGlobalVariable guifg=#ef5f6b guibg=NONE guisp=NONE gui=NONE ctermfg=204 ctermbg=NONE cterm=NONE
hi rubyInclude guifg=#5ab0f6 guibg=NONE guisp=NONE gui=NONE ctermfg=39 ctermbg=NONE cterm=NONE
hi rubyIncluderubyGlobalVariable guifg=#ef5f6b guibg=NONE guisp=NONE gui=NONE ctermfg=204 ctermbg=NONE cterm=NONE
hi rubyInstanceVariable guifg=#ef5f6b guibg=NONE guisp=NONE gui=NONE ctermfg=204 ctermbg=NONE cterm=NONE
hi rubyInterpolation guifg=#4dbdcb guibg=NONE guisp=NONE gui=NONE ctermfg=38 ctermbg=NONE cterm=NONE
hi rubyInterpolationDelimiter guifg=#ef5f6b guibg=NONE guisp=NONE gui=NONE ctermfg=204 ctermbg=NONE cterm=NONE
hi rubyInterpolationDelimiter guifg=#ef5f6b guibg=NONE guisp=NONE gui=NONE ctermfg=204 ctermbg=NONE cterm=NONE
hi rubyRegexp guifg=#4dbdcb guibg=NONE guisp=NONE gui=NONE ctermfg=38 ctermbg=NONE cterm=NONE
hi rubyRegexpDelimiter guifg=#4dbdcb guibg=NONE guisp=NONE gui=NONE ctermfg=38 ctermbg=NONE cterm=NONE
hi rubyStringDelimiter guifg=#97ca72 guibg=NONE guisp=NONE gui=NONE ctermfg=114 ctermbg=NONE cterm=NONE
hi rubySymbol guifg=#4dbdcb guibg=NONE guisp=NONE gui=NONE ctermfg=38 ctermbg=NONE cterm=NONE
hi sassAmpersand guifg=#ef5f6b guibg=NONE guisp=NONE gui=NONE ctermfg=204 ctermbg=NONE cterm=NONE
hi sassClass guifg=#d99a5e guibg=NONE guisp=NONE gui=NONE ctermfg=173 ctermbg=NONE cterm=NONE
hi sassControl guifg=#ca72e4 guibg=NONE guisp=NONE gui=NONE ctermfg=170 ctermbg=NONE cterm=NONE
hi sassExtend guifg=#ca72e4 guibg=NONE guisp=NONE gui=NONE ctermfg=170 ctermbg=NONE cterm=NONE
hi sassFor guifg=#a5b0c5 guibg=NONE guisp=NONE gui=NONE ctermfg=145 ctermbg=NONE cterm=NONE
hi sassFunction guifg=#4dbdcb guibg=NONE guisp=NONE gui=NONE ctermfg=38 ctermbg=NONE cterm=NONE
hi sassId guifg=#5ab0f6 guibg=NONE guisp=NONE gui=NONE ctermfg=39 ctermbg=NONE cterm=NONE
hi sassInclude guifg=#ca72e4 guibg=NONE guisp=NONE gui=NONE ctermfg=170 ctermbg=NONE cterm=NONE
hi sassMedia guifg=#ca72e4 guibg=NONE guisp=NONE gui=NONE ctermfg=170 ctermbg=NONE cterm=NONE
hi sassMediaOperators guifg=#a5b0c5 guibg=NONE guisp=NONE gui=NONE ctermfg=145 ctermbg=NONE cterm=NONE
hi sassMixin guifg=#ca72e4 guibg=NONE guisp=NONE gui=NONE ctermfg=170 ctermbg=NONE cterm=NONE
hi sassMixinName guifg=#5ab0f6 guibg=NONE guisp=NONE gui=NONE ctermfg=39 ctermbg=NONE cterm=NONE
hi sassMixing guifg=#ca72e4 guibg=NONE guisp=NONE gui=NONE ctermfg=170 ctermbg=NONE cterm=NONE
hi sassVariable guifg=#ca72e4 guibg=NONE guisp=NONE gui=NONE ctermfg=170 ctermbg=NONE cterm=NONE
hi scssExtend guifg=#ca72e4 guibg=NONE guisp=NONE gui=NONE ctermfg=170 ctermbg=NONE cterm=NONE
hi scssImport guifg=#ca72e4 guibg=NONE guisp=NONE gui=NONE ctermfg=170 ctermbg=NONE cterm=NONE
hi scssInclude guifg=#ca72e4 guibg=NONE guisp=NONE gui=NONE ctermfg=170 ctermbg=NONE cterm=NONE
hi scssMixin guifg=#ca72e4 guibg=NONE guisp=NONE gui=NONE ctermfg=170 ctermbg=NONE cterm=NONE
hi scssSelectorName guifg=#d99a5e guibg=NONE guisp=NONE gui=NONE ctermfg=173 ctermbg=NONE cterm=NONE
hi scssVariable guifg=#ca72e4 guibg=NONE guisp=NONE gui=NONE ctermfg=170 ctermbg=NONE cterm=NONE
hi texStatement guifg=#ca72e4 guibg=NONE guisp=NONE gui=NONE ctermfg=170 ctermbg=NONE cterm=NONE
hi texSubscripts guifg=#d99a5e guibg=NONE guisp=NONE gui=NONE ctermfg=173 ctermbg=NONE cterm=NONE
hi texSuperscripts guifg=#d99a5e guibg=NONE guisp=NONE gui=NONE ctermfg=173 ctermbg=NONE cterm=NONE
hi texTodo guifg=#a13131 guibg=NONE guisp=NONE gui=NONE ctermfg=196 ctermbg=NONE cterm=NONE
hi texBeginEnd guifg=#ca72e4 guibg=NONE guisp=NONE gui=NONE ctermfg=170 ctermbg=NONE cterm=NONE
hi texBeginEndName guifg=#5ab0f6 guibg=NONE guisp=NONE gui=NONE ctermfg=39 ctermbg=NONE cterm=NONE
hi texMathMatcher guifg=#5ab0f6 guibg=NONE guisp=NONE gui=NONE ctermfg=39 ctermbg=NONE cterm=NONE
hi texMathDelim guifg=#5ab0f6 guibg=NONE guisp=NONE gui=NONE ctermfg=39 ctermbg=NONE cterm=NONE
hi texDelimiter guifg=#d99a5e guibg=NONE guisp=NONE gui=NONE ctermfg=173 ctermbg=NONE cterm=NONE
hi texSpecialChar guifg=#d99a5e guibg=NONE guisp=NONE gui=NONE ctermfg=173 ctermbg=NONE cterm=NONE
hi texCite guifg=#5ab0f6 guibg=NONE guisp=NONE gui=NONE ctermfg=39 ctermbg=NONE cterm=NONE
hi texRefZone guifg=#5ab0f6 guibg=NONE guisp=NONE gui=NONE ctermfg=39 ctermbg=NONE cterm=NONE
hi typescriptReserved guifg=#ca72e4 guibg=NONE guisp=NONE gui=NONE ctermfg=170 ctermbg=NONE cterm=NONE
hi typescriptEndColons guifg=#a5b0c5 guibg=NONE guisp=NONE gui=NONE ctermfg=145 ctermbg=NONE cterm=NONE
hi typescriptBraces guifg=#a5b0c5 guibg=NONE guisp=NONE gui=NONE ctermfg=145 ctermbg=NONE cterm=NONE
hi xmlAttrib guifg=#d99a5e guibg=NONE guisp=NONE gui=NONE ctermfg=173 ctermbg=NONE cterm=NONE
hi xmlEndTag guifg=#ef5f6b guibg=NONE guisp=NONE gui=NONE ctermfg=204 ctermbg=NONE cterm=NONE
hi xmlTag guifg=#ef5f6b guibg=NONE guisp=NONE gui=NONE ctermfg=204 ctermbg=NONE cterm=NONE
hi xmlTagName guifg=#ef5f6b guibg=NONE guisp=NONE gui=NONE ctermfg=204 ctermbg=NONE cterm=NONE
hi GitGutterAdd guifg=#97ca72 guibg=NONE guisp=NONE gui=NONE ctermfg=114 ctermbg=NONE cterm=NONE
hi GitGutterChange guifg=#ebc275 guibg=NONE guisp=NONE gui=NONE ctermfg=180 ctermbg=NONE cterm=NONE
hi GitGutterDelete guifg=#ef5f6b guibg=NONE guisp=NONE gui=NONE ctermfg=204 ctermbg=NONE cterm=NONE
hi ALEError guifg=#ef5f6b guibg=NONE guisp=NONE gui=NONE ctermfg=204 ctermbg=NONE cterm=NONE
hi ALEWarning guifg=#ebc275 guibg=NONE guisp=NONE gui=NONE ctermfg=180 ctermbg=NONE cterm=NONE
hi ALEInfo guifg=NONE guibg=NONE guisp=NONE gui=NONE ctermfg=NONE ctermbg=NONE cterm=NONE
hi ALEErrorSign guifg=#ef5f6b guibg=NONE guisp=NONE gui=NONE ctermfg=204 ctermbg=NONE cterm=NONE
hi ALEWarningSign guifg=#ebc275 guibg=NONE guisp=NONE gui=NONE ctermfg=180 ctermbg=NONE cterm=NONE
hi ALEInfoSign guifg=NONE guibg=NONE guisp=NONE gui=NONE ctermfg=NONE ctermbg=NONE cterm=NONE
hi EasyMotionTarget guifg=#ef5f6b guibg=NONE guisp=NONE gui=NONE ctermfg=204 ctermbg=NONE cterm=NONE
hi EasyMotionTarget2First guifg=#ebc275 guibg=NONE guisp=NONE gui=NONE ctermfg=180 ctermbg=NONE cterm=NONE
hi EasyMotionTarget2Second guifg=#d99a5e guibg=NONE guisp=NONE gui=NONE ctermfg=173 ctermbg=NONE cterm=NONE
hi EasyMotionShade guifg=#546178 guibg=NONE guisp=NONE gui=NONE ctermfg=59 ctermbg=NONE cterm=NONE
hi CocErrorSign guifg=#ef5f6b guibg=NONE guisp=NONE gui=NONE ctermfg=204 ctermbg=NONE cterm=NONE
hi CocWarningSign guifg=#ebc275 guibg=NONE guisp=NONE gui=NONE ctermfg=180 ctermbg=NONE cterm=NONE
hi CocInfoSign guifg=#5ab0f6 guibg=NONE guisp=NONE gui=NONE ctermfg=39 ctermbg=NONE cterm=NONE
hi CocHintSign guifg=#4dbdcb guibg=NONE guisp=NONE gui=NONE ctermfg=38 ctermbg=NONE cterm=NONE
hi CocFadeOut guifg=#546178 guibg=NONE guisp=NONE gui=NONE ctermfg=59 ctermbg=NONE cterm=NONE
hi NeomakeErrorSign guifg=#ef5f6b guibg=NONE guisp=NONE gui=NONE ctermfg=204 ctermbg=NONE cterm=NONE
hi NeomakeWarningSign guifg=#ebc275 guibg=NONE guisp=NONE gui=NONE ctermfg=180 ctermbg=NONE cterm=NONE
hi NeomakeInfoSign guifg=#5ab0f6 guibg=NONE guisp=NONE gui=NONE ctermfg=39 ctermbg=NONE cterm=NONE
hi mkdDelimiter guifg=#ca72e4 guibg=NONE guisp=NONE gui=NONE ctermfg=170 ctermbg=NONE cterm=NONE
hi mkdHeading guifg=#ef5f6b guibg=NONE guisp=NONE gui=NONE ctermfg=204 ctermbg=NONE cterm=NONE
hi mkdLink guifg=#5ab0f6 guibg=NONE guisp=NONE gui=NONE ctermfg=39 ctermbg=NONE cterm=NONE
hi mkdURL guifg=#4dbdcb guibg=NONE guisp=NONE gui=NONE ctermfg=38 ctermbg=NONE cterm=NONE
hi LspErrorText guifg=#ef5f6b guibg=NONE guisp=NONE gui=NONE ctermfg=204 ctermbg=NONE cterm=NONE
hi LspWarningText guifg=#ebc275 guibg=NONE guisp=NONE gui=NONE ctermfg=180 ctermbg=NONE cterm=NONE
hi LspInformationText guifg=#5ab0f6 guibg=NONE guisp=NONE gui=NONE ctermfg=39 ctermbg=NONE cterm=NONE
hi LspHintText guifg=#4dbdcb guibg=NONE guisp=NONE gui=NONE ctermfg=38 ctermbg=NONE cterm=NONE
hi LspErrorHighlight guifg=#ef5f6b guibg=NONE guisp=NONE gui=NONE ctermfg=204 ctermbg=NONE cterm=NONE
hi LspWarningHighlight guifg=#ebc275 guibg=NONE guisp=NONE gui=NONE ctermfg=180 ctermbg=NONE cterm=NONE
hi LspInformationHighlight guifg=#5ab0f6 guibg=NONE guisp=NONE gui=NONE ctermfg=39 ctermbg=NONE cterm=NONE
hi LspHintHighlight guifg=#4dbdcb guibg=NONE guisp=NONE gui=NONE ctermfg=38 ctermbg=NONE cterm=NONE
hi diffAdded guifg=#97ca72 guibg=NONE guisp=NONE gui=NONE ctermfg=114 ctermbg=NONE cterm=NONE
hi diffRemoved guifg=#ef5f6b guibg=NONE guisp=NONE gui=NONE ctermfg=204 ctermbg=NONE cterm=NONE
hi gitcommitComment guifg=#546178 guibg=NONE guisp=NONE gui=NONE ctermfg=59 ctermbg=NONE cterm=NONE
hi gitcommitUnmerged guifg=#97ca72 guibg=NONE guisp=NONE gui=NONE ctermfg=114 ctermbg=NONE cterm=NONE
hi gitcommitOnBranch guifg=NONE guibg=NONE guisp=NONE gui=NONE ctermfg=NONE ctermbg=NONE cterm=NONE
hi gitcommitBranch guifg=#ca72e4 guibg=NONE guisp=NONE gui=NONE ctermfg=170 ctermbg=NONE cterm=NONE
hi gitcommitDiscardedType guifg=#ef5f6b guibg=NONE guisp=NONE gui=NONE ctermfg=204 ctermbg=NONE cterm=NONE
hi gitcommitSelectedType guifg=#97ca72 guibg=NONE guisp=NONE gui=NONE ctermfg=114 ctermbg=NONE cterm=NONE
hi gitcommitHeader guifg=NONE guibg=NONE guisp=NONE gui=NONE ctermfg=NONE ctermbg=NONE cterm=NONE
hi gitcommitUntrackedFile guifg=#4dbdcb guibg=NONE guisp=NONE gui=NONE ctermfg=38 ctermbg=NONE cterm=NONE
hi gitcommitDiscardedFile guifg=#ef5f6b guibg=NONE guisp=NONE gui=NONE ctermfg=204 ctermbg=NONE cterm=NONE
hi gitcommitSelectedFile guifg=#97ca72 guibg=NONE guisp=NONE gui=NONE ctermfg=114 ctermbg=NONE cterm=NONE
hi gitcommitUnmergedFile guifg=#ebc275 guibg=NONE guisp=NONE gui=NONE ctermfg=180 ctermbg=NONE cterm=NONE
hi gitcommitFile guifg=NONE guibg=NONE guisp=NONE gui=NONE ctermfg=NONE ctermbg=NONE cterm=NONE
hi gitcommitSummary guifg=#a5b0c5 guibg=NONE guisp=NONE gui=NONE ctermfg=145 ctermbg=NONE cterm=NONE
hi gitcommitOverflow guifg=#ef5f6b guibg=NONE guisp=NONE gui=NONE ctermfg=204 ctermbg=NONE cterm=NONE

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
    '#242b38', '#ef5f6b', '#97ca72', '#ebc275',
    '#5ab0f6', '#ca72e4', '#4dbdcb', '#7d899f',
    '#546178', '#ef5f6b', '#97ca72', '#ebc275',
    '#5ab0f6', '#ca72e4', '#4dbdcb', '#a5b0c5'
]

# ============================================================
#  SupraCool — overrides
# ============================================================
# Comments
hi Comment        guifg=#546178 guibg=NONE gui=NONE cterm=NONE
hi SpecialComment guifg=#546178 guibg=NONE gui=NONE cterm=NONE
hi Folded         guifg=#546178 guibg=#1e242e gui=NONE cterm=NONE

# Cursor / current line
hi CursorLine     guibg=#2d3343 gui=NONE cterm=NONE
hi CursorColumn   guibg=#2d3343
hi ColorColumn    guibg=#2d3343
hi CursorLineNr   guifg=#ebc275 guibg=NONE gui=NONE cterm=NONE
hi LineNr         guifg=#4b566c guibg=NONE

# Matching paren
hi MatchParen     guifg=#4dbdcb guibg=#363c51 gui=NONE cterm=NONE

# Visual selection
hi Visual         guibg=#313d51
hi VisualNOS      guibg=#313d51

# Search
hi Search         guifg=#242b38 guibg=#ebc275 gui=NONE cterm=NONE
hi IncSearch      guifg=#242b38 guibg=#d99a5e gui=NONE cterm=NONE

# Completion menu
hi Pmenu          guifg=#a5b0c5 guibg=#2d3343
hi PmenuSel       guifg=#242b38 guibg=#5ab0f6 gui=NONE cterm=NONE
hi PmenuSbar      guibg=#1e242e
hi PmenuThumb     guibg=#4b566c

# Splits / statusline
hi VertSplit      guifg=#363c51 guibg=NONE
hi WinSeparator   guifg=#363c51 guibg=NONE
hi StatusLine     guifg=#a5b0c5 guibg=#2d3343 gui=NONE cterm=NONE
hi StatusLineNC   guifg=#546178 guibg=#1e242e gui=NONE cterm=NONE

# Spell
hi SpellBad       guifg=NONE guisp=#ef5f6b gui=NONE cterm=NONE
hi SpellCap       guifg=NONE guisp=#ebc275 gui=NONE cterm=NONE
hi SpellRare      guifg=NONE guisp=#4dbdcb gui=NONE cterm=NONE
hi SpellLocal     guifg=NONE guisp=#97ca72 gui=NONE cterm=NONE

# Diff
hi DiffAdd        guifg=NONE guibg=#303d27
hi DiffDelete     guifg=NONE guibg=#3c2729
hi DiffChange     guifg=NONE guibg=#18344c
hi DiffText       guifg=NONE guibg=#265478

# Titles / links
hi Title          guifg=#97ca72 gui=NONE cterm=NONE
hi Underlined     guifg=#5ab0f6 gui=NONE cterm=NONE
hi Directory      guifg=#5ab0f6 gui=NONE cterm=NONE

# SignColumn without border
hi! link SignColumn Normal
hi! link EndOfBuffer Normal
