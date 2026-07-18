vim9script
# supra-gui: background=#1a1a24 include=#6bb0d9 stdio=#73d9c9 typedef=#b896f0 struct=#b896f0 type_s=#63b8ad scope=#474a52 float=#ff9e63 function=#474a52 format=#cca161 text=#9ecc69 integer=#ff9e63

hi clear

if exists("syntax_on")
  syntax reset
endif

set t_Co=256

g:colors_name = "kyotonight"

hi SpecialKey guifg=#414868 guibg=NONE guisp=NONE gui=NONE ctermfg=7 ctermbg=NONE cterm=NONE
hi EndOfBuffer guifg=#1a1b26 guibg=NONE guisp=NONE gui=NONE ctermfg=0 ctermbg=NONE cterm=NONE
hi NonText guifg=#565f89 guibg=NONE guisp=NONE gui=NONE ctermfg=15 ctermbg=NONE cterm=NONE
hi Directory guifg=#7aa2f7 guibg=NONE guisp=NONE gui=NONE ctermfg=4 ctermbg=NONE cterm=NONE
hi ErrorMsg guifg=#1a1b26 guibg=#f7768e guisp=NONE gui=NONE ctermfg=0 ctermbg=1 cterm=NONE
hi IncSearch guifg=#b4f9f8 guibg=#7aa2f7 guisp=NONE gui=NONE ctermfg=14 ctermbg=4 cterm=NONE
hi Search guifg=#24283b guibg=#7aa2f7 guisp=NONE gui=NONE ctermfg=8 ctermbg=4 cterm=NONE
hi MoreMsg guifg=#7aa2f7 guibg=NONE guisp=NONE gui=NONE ctermfg=4 ctermbg=NONE cterm=NONE
hi ModeMsg guifg=#a9b1d6 guibg=NONE guisp=NONE gui=NONE ctermfg=NONE ctermbg=NONE cterm=NONE
hi LineNr guifg=#414868 guibg=NONE guisp=NONE gui=NONE ctermfg=7 ctermbg=NONE cterm=NONE
hi CursorLineNr guifg=#a9b1d6 guibg=NONE guisp=NONE gui=NONE ctermfg=NONE ctermbg=NONE cterm=NONE
hi Question guifg=#a9b1d6 guibg=NONE guisp=NONE gui=NONE ctermfg=NONE ctermbg=NONE cterm=NONE
hi StatusLine guifg=#7aa2f7 guibg=#414868 guisp=NONE gui=NONE ctermfg=4 ctermbg=7 cterm=NONE
hi StatusLineNC guifg=#a9b1d6 guibg=#1a1b26 guisp=NONE gui=NONE ctermfg=NONE ctermbg=0 cterm=NONE
hi VertSplit guifg=#a9b1d6 guibg=NONE guisp=NONE gui=NONE ctermfg=NONE ctermbg=NONE cterm=NONE
hi Title guifg=#a9b1d6 guibg=NONE guisp=NONE gui=NONE ctermfg=NONE ctermbg=NONE cterm=NONE
hi Visual guifg=LightGrey guibg=#33467c guisp=NONE gui=NONE ctermfg=0 ctermbg=7 cterm=NONE
hi VisualNOS guifg=NONE guibg=#33467c guisp=NONE gui=NONE ctermfg=NONE ctermbg=7 cterm=NONE
hi WarningMsg guifg=#1a1b26 guibg=#e0af68 guisp=NONE gui=NONE ctermfg=0 ctermbg=11 cterm=NONE
hi WildMenu guifg=#7aa2f7 guibg=#1a1b26 guisp=NONE gui=NONE ctermfg=4 ctermbg=0 cterm=NONE
hi Folded guifg=#414868 guibg=#1a1b26 guisp=NONE gui=NONE ctermfg=7 ctermbg=0 cterm=NONE
hi FoldColumn guifg=#414868 guibg=#1a1b26 guisp=NONE gui=NONE ctermfg=7 ctermbg=0 cterm=NONE
hi DiffAdd guifg=#9ece6a guibg=#0f0f14 guisp=NONE gui=NONE ctermfg=2 ctermbg=NONE cterm=NONE
hi DiffChange guifg=#ff9e64 guibg=#0f0f14 guisp=NONE gui=NONE ctermfg=3 ctermbg=NONE cterm=NONE
hi DiffDelete guifg=#f7768e guibg=#0f0f14 guisp=NONE gui=NONE ctermfg=1 ctermbg=NONE cterm=NONE
hi DiffText guifg=#7aa2f7 guibg=#0f0f14 guisp=NONE gui=NONE ctermfg=4 ctermbg=NONE cterm=NONE
hi SignColumn guifg=#1a1b26 guibg=#1a1b26 guisp=NONE gui=NONE ctermfg=0 ctermbg=0 cterm=NONE
hi Conceal guifg=#565f89 guibg=#24283b guisp=NONE gui=NONE ctermfg=15 ctermbg=8 cterm=NONE
hi SpellBad guifg=#f7768e guibg=#1a1b26 guisp=NONE gui=NONE ctermfg=1 ctermbg=0 cterm=NONE
hi SpellCap guifg=#ff9e64 guibg=#1a1b26 guisp=NONE gui=NONE ctermfg=3 ctermbg=0 cterm=NONE
hi SpellRare guifg=#b4f9f8 guibg=#1a1b26 guisp=NONE gui=NONE ctermfg=14 ctermbg=0 cterm=NONE
hi SpellLocal guifg=#e0af68 guibg=#1a1b26 guisp=NONE gui=NONE ctermfg=11 ctermbg=0 cterm=NONE
hi Pmenu guifg=#a9b1d6 guibg=#24283b guisp=NONE gui=NONE ctermfg=NONE ctermbg=8 cterm=NONE
hi PmenuSel guifg=#7dcfff guibg=#414868 guisp=NONE gui=NONE ctermfg=12 ctermbg=7 cterm=NONE
hi PmenuMatch guifg=#07d7ff guibg=NONE guisp=NONE gui=NONE ctermfg=NONE ctermbg=NONE cterm=NONE
hi PmenuKind guifg=#49a8f5 guibg=NONE guisp=NONE gui=NONE ctermfg=NONE ctermbg=NONE cterm=NONE
hi PmenuSbar guifg=#a9b1d6 guibg=#24283b guisp=NONE gui=NONE ctermfg=NONE ctermbg=8 cterm=NONE
hi PmenuThumb guifg=#7dcfff guibg=#414868 guisp=NONE gui=NONE ctermfg=12 ctermbg=7 cterm=NONE
hi PmenuShadow guifg=DarkGrey guibg=Black guisp=NONE gui=NONE ctermfg=242 ctermbg=0 cterm=NONE
hi TabLine guifg=#a9b1d6 guibg=#1a1b26 guisp=NONE gui=NONE ctermfg=NONE ctermbg=0 cterm=NONE
hi TabLineSel guifg=#565f89 guibg=#1a1b26 guisp=NONE gui=NONE ctermfg=15 ctermbg=0 cterm=NONE
hi TabLineFill guifg=#414868 guibg=#1a1b26 guisp=NONE gui=NONE ctermfg=7 ctermbg=0 cterm=NONE
hi CursorColumn guifg=NONE guibg=#1a1b26 guisp=NONE gui=NONE ctermfg=NONE ctermbg=0 cterm=NONE
hi CursorLine guifg=NONE guibg=#292e42 guisp=NONE gui=NONE ctermfg=NONE ctermbg=NONE cterm=NONE
hi ColorColumn guifg=NONE guibg=#24283b guisp=NONE gui=NONE ctermfg=NONE ctermbg=8 cterm=NONE
hi StatusLineTerm guifg=#7aa2f7 guibg=#414868 guisp=NONE gui=NONE ctermfg=4 ctermbg=7 cterm=NONE
hi StatusLineTermNC guifg=#a9b1d6 guibg=#1a1b26 guisp=NONE gui=NONE ctermfg=NONE ctermbg=0 cterm=NONE
hi Normal guifg=#a9b1d6 guibg=#1a1b26 guisp=NONE gui=NONE ctermfg=NONE ctermbg=0 cterm=NONE
hi MatchParen guifg=#7dcfff guibg=#414868 guisp=NONE gui=NONE ctermfg=12 ctermbg=7 cterm=NONE
hi ToolbarLine guifg=NONE guibg=Grey50 guisp=NONE gui=NONE ctermfg=NONE ctermbg=242 cterm=NONE
hi ToolbarButton guifg=Black guibg=LightGrey guisp=NONE gui=NONE ctermfg=0 ctermbg=7 cterm=NONE
hi Bold guifg=NONE guibg=NONE guisp=NONE gui=NONE ctermfg=NONE ctermbg=NONE cterm=NONE
hi Underline guifg=NONE guibg=NONE guisp=NONE gui=NONE ctermfg=NONE ctermbg=NONE cterm=NONE
hi Cursor guifg=#1a1b26 guibg=#e0af68 guisp=NONE gui=NONE ctermfg=0 ctermbg=11 cterm=NONE
hi Error guifg=#1a1b26 guibg=#f7768e guisp=NONE gui=NONE ctermfg=0 ctermbg=1 cterm=NONE
hi iCursor guifg=#1a1b26 guibg=#e0af68 guisp=NONE gui=NONE ctermfg=0 ctermbg=11 cterm=NONE
hi Boolean guifg=#ff9e64 guibg=NONE guisp=NONE gui=NONE ctermfg=3 ctermbg=NONE cterm=NONE
hi Character guifg=#9ece6a guibg=NONE guisp=NONE gui=NONE ctermfg=2 ctermbg=NONE cterm=NONE
hi Comment guifg=#565f89 guibg=NONE guisp=NONE gui=NONE ctermfg=15 ctermbg=NONE cterm=NONE
hi Conditional guifg=#bb9af7 guibg=NONE guisp=NONE gui=NONE ctermfg=5 ctermbg=NONE cterm=NONE
hi Constant guifg=#cfc9c2 guibg=NONE guisp=NONE gui=NONE ctermfg=15 ctermbg=NONE cterm=NONE
hi Decorator guifg=#ff9e64 guibg=NONE guisp=NONE gui=NONE ctermfg=3 ctermbg=NONE cterm=NONE
hi Define guifg=#7aa2f7 guibg=NONE guisp=NONE gui=NONE ctermfg=4 ctermbg=NONE cterm=NONE
hi Delimiter guifg=#7aa2f7 guibg=NONE guisp=NONE gui=NONE ctermfg=4 ctermbg=NONE cterm=NONE
hi Exception guifg=#bb9af7 guibg=NONE guisp=NONE gui=NONE ctermfg=5 ctermbg=NONE cterm=NONE
hi Float guifg=#ff9e64 guibg=NONE guisp=NONE gui=NONE ctermfg=3 ctermbg=NONE cterm=NONE
hi Function guifg=#7dcfff guibg=NONE guisp=NONE gui=NONE ctermfg=12 ctermbg=NONE cterm=NONE
hi Identifier guifg=#7aa2f7 guibg=NONE guisp=NONE gui=NONE ctermfg=4 ctermbg=NONE cterm=NONE
hi Variable guifg=#a9b1d6 guibg=NONE guisp=NONE gui=NONE ctermfg=NONE ctermbg=NONE cterm=NONE
hi Include guifg=#7dcfff guibg=NONE guisp=NONE gui=NONE ctermfg=12 ctermbg=NONE cterm=NONE
hi Keyword guifg=#7aa2f7 guibg=NONE guisp=NONE gui=NONE ctermfg=4 ctermbg=NONE cterm=NONE
hi Label guifg=#7aa2f7 guibg=NONE guisp=NONE gui=NONE ctermfg=4 ctermbg=NONE cterm=NONE
hi Number guifg=#ff9e64 guibg=NONE guisp=NONE gui=NONE ctermfg=3 ctermbg=NONE cterm=NONE
hi Operator guifg=#bb9af7 guibg=NONE guisp=NONE gui=NONE ctermfg=5 ctermbg=NONE cterm=NONE
hi PreProc guifg=#7aa2f7 guibg=NONE guisp=NONE gui=NONE ctermfg=4 ctermbg=NONE cterm=NONE
hi Repeat guifg=#bb9af7 guibg=NONE guisp=NONE gui=NONE ctermfg=5 ctermbg=NONE cterm=NONE
hi Special guifg=#7aa2f7 guibg=NONE guisp=NONE gui=NONE ctermfg=4 ctermbg=NONE cterm=NONE
hi SpecialChar guifg=#e0af68 guibg=NONE guisp=NONE gui=NONE ctermfg=11 ctermbg=NONE cterm=NONE
hi SpecialComment guifg=#7dcfff guibg=NONE guisp=NONE gui=NONE ctermfg=12 ctermbg=NONE cterm=NONE
hi Statement guifg=#7aa2f7 guibg=NONE guisp=NONE gui=NONE ctermfg=4 ctermbg=NONE cterm=NONE
hi StorageClass guifg=#7aa2f7 guibg=NONE guisp=NONE gui=NONE ctermfg=4 ctermbg=NONE cterm=NONE
hi String guifg=#9ece6a guibg=NONE guisp=NONE gui=NONE ctermfg=2 ctermbg=NONE cterm=NONE
hi Structure guifg=#bb9af7 guibg=NONE guisp=NONE gui=NONE ctermfg=5 ctermbg=NONE cterm=NONE
hi Tag guifg=#a9b1d6 guibg=NONE guisp=NONE gui=NONE ctermfg=NONE ctermbg=NONE cterm=NONE
hi Todo guifg=#e0af68 guibg=NONE guisp=NONE gui=NONE ctermfg=11 ctermbg=NONE cterm=NONE
hi Type guifg=#73daca guibg=NONE guisp=NONE gui=NONE ctermfg=6 ctermbg=NONE cterm=NONE
hi Typedef guifg=#73daca guibg=NONE guisp=NONE gui=NONE ctermfg=6 ctermbg=NONE cterm=NONE
hi asciidocAttributeEntry guifg=#2ac3de guibg=NONE guisp=NONE gui=NONE ctermfg=6 ctermbg=NONE cterm=NONE
hi asciidocAttributeList guifg=#2ac3de guibg=NONE guisp=NONE gui=NONE ctermfg=6 ctermbg=NONE cterm=NONE
hi asciidocHLabel guifg=#7aa2f7 guibg=NONE guisp=NONE gui=NONE ctermfg=4 ctermbg=NONE cterm=NONE
hi asciidocListingBlock guifg=#73daca guibg=NONE guisp=NONE gui=NONE ctermfg=6 ctermbg=NONE cterm=NONE
hi asciidocMacroAttributes guifg=#7dcfff guibg=NONE guisp=NONE gui=NONE ctermfg=12 ctermbg=NONE cterm=NONE
hi asciidocOneLineTitle guifg=#7dcfff guibg=NONE guisp=NONE gui=NONE ctermfg=12 ctermbg=NONE cterm=NONE
hi asciidocPassthroughBlock guifg=#7aa2f7 guibg=NONE guisp=NONE gui=NONE ctermfg=4 ctermbg=NONE cterm=NONE
hi asciidocQuotedMonospaced guifg=#73daca guibg=NONE guisp=NONE gui=NONE ctermfg=6 ctermbg=NONE cterm=NONE
hi asciidocTriplePlusPassthrough guifg=#73daca guibg=NONE guisp=NONE gui=NONE ctermfg=6 ctermbg=NONE cterm=NONE
hi markdownH1 guifg=#7dcfff guibg=NONE guisp=NONE gui=NONE ctermfg=12 ctermbg=NONE cterm=NONE
hi markdownLinkText guifg=#7dcfff guibg=NONE guisp=NONE gui=NONE ctermfg=12 ctermbg=NONE cterm=NONE
hi awkCharClass guifg=#73daca guibg=NONE guisp=NONE gui=NONE ctermfg=6 ctermbg=NONE cterm=NONE
hi awkPatterns guifg=#7aa2f7 guibg=NONE guisp=NONE gui=NONE ctermfg=4 ctermbg=NONE cterm=NONE
hi cIncluded guifg=#73daca guibg=NONE guisp=NONE gui=NONE ctermfg=6 ctermbg=NONE cterm=NONE
hi cmakeGeneratorExpression guifg=#2ac3de guibg=NONE guisp=NONE gui=NONE ctermfg=6 ctermbg=NONE cterm=NONE
hi cssAttributeSelector guifg=#73daca guibg=NONE guisp=NONE gui=NONE ctermfg=6 ctermbg=NONE cterm=NONE
hi cssDefinition guifg=#73daca guibg=NONE guisp=NONE gui=NONE ctermfg=6 ctermbg=NONE cterm=NONE
hi cssIdentifier guifg=#73daca guibg=NONE guisp=NONE gui=NONE ctermfg=6 ctermbg=NONE cterm=NONE
hi cssStringQ guifg=#73daca guibg=NONE guisp=NONE gui=NONE ctermfg=6 ctermbg=NONE cterm=NONE
hi dosiniHeader guifg=#7dcfff guibg=NONE guisp=NONE gui=NONE ctermfg=12 ctermbg=NONE cterm=NONE
hi dtBooleanKey guifg=#73daca guibg=NONE guisp=NONE gui=NONE ctermfg=6 ctermbg=NONE cterm=NONE
hi dtExecKey guifg=#73daca guibg=NONE guisp=NONE gui=NONE ctermfg=6 ctermbg=NONE cterm=NONE
hi dtLocaleKey guifg=#73daca guibg=NONE guisp=NONE gui=NONE ctermfg=6 ctermbg=NONE cterm=NONE
hi dtNumericKey guifg=#73daca guibg=NONE guisp=NONE gui=NONE ctermfg=6 ctermbg=NONE cterm=NONE
hi dtTypeKey guifg=#73daca guibg=NONE guisp=NONE gui=NONE ctermfg=6 ctermbg=NONE cterm=NONE
hi gitconfigVariable guifg=#73daca guibg=NONE guisp=NONE gui=NONE ctermfg=6 ctermbg=NONE cterm=NONE
hi goBuiltins guifg=#73daca guibg=NONE guisp=NONE gui=NONE ctermfg=6 ctermbg=NONE cterm=NONE
hi helpBar guifg=#414868 guibg=NONE guisp=NONE gui=NONE ctermfg=7 ctermbg=NONE cterm=NONE
hi helpHyperTextJump guifg=#7dcfff guibg=NONE guisp=NONE gui=NONE ctermfg=12 ctermbg=NONE cterm=NONE
hi htmlArg guifg=#73daca guibg=NONE guisp=NONE gui=NONE ctermfg=6 ctermbg=NONE cterm=NONE
hi htmlLink guifg=#a9b1d6 guibg=NONE guisp=NONE gui=NONE ctermfg=NONE ctermbg=NONE cterm=NONE
hi javaDocTags guifg=#73daca guibg=NONE guisp=NONE gui=NONE ctermfg=6 ctermbg=NONE cterm=NONE
hi jsonKeyword guifg=#73daca guibg=NONE guisp=NONE gui=NONE ctermfg=6 ctermbg=NONE cterm=NONE
hi lessClass guifg=#73daca guibg=NONE guisp=NONE gui=NONE ctermfg=6 ctermbg=NONE cterm=NONE
hi markdownBlockquote guifg=#73daca guibg=NONE guisp=NONE gui=NONE ctermfg=6 ctermbg=NONE cterm=NONE
hi markdownCode guifg=#73daca guibg=NONE guisp=NONE gui=NONE ctermfg=6 ctermbg=NONE cterm=NONE
hi markdownCodeDelimiter guifg=#73daca guibg=NONE guisp=NONE gui=NONE ctermfg=6 ctermbg=NONE cterm=NONE
hi markdownFootnote guifg=#73daca guibg=NONE guisp=NONE gui=NONE ctermfg=6 ctermbg=NONE cterm=NONE
hi markdownId guifg=#73daca guibg=NONE guisp=NONE gui=NONE ctermfg=6 ctermbg=NONE cterm=NONE
hi markdownIdDeclaration guifg=#73daca guibg=NONE guisp=NONE gui=NONE ctermfg=6 ctermbg=NONE cterm=NONE
hi markdownUrl guifg=#a9b1d6 guibg=NONE guisp=NONE gui=NONE ctermfg=NONE ctermbg=NONE cterm=NONE
hi perlPackageDecl guifg=#73daca guibg=NONE guisp=NONE gui=NONE ctermfg=6 ctermbg=NONE cterm=NONE
hi phpClasses guifg=#73daca guibg=NONE guisp=NONE gui=NONE ctermfg=6 ctermbg=NONE cterm=NONE
hi phpDocTags guifg=#73daca guibg=NONE guisp=NONE gui=NONE ctermfg=6 ctermbg=NONE cterm=NONE
hi podCmdText guifg=#73daca guibg=NONE guisp=NONE gui=NONE ctermfg=6 ctermbg=NONE cterm=NONE
hi podVerbatimLine guifg=#a9b1d6 guibg=NONE guisp=NONE gui=NONE ctermfg=NONE ctermbg=NONE cterm=NONE
hi rubyConstant guifg=#73daca guibg=NONE guisp=NONE gui=NONE ctermfg=6 ctermbg=NONE cterm=NONE
hi rubySymbol guifg=#b4f9f8 guibg=NONE guisp=NONE gui=NONE ctermfg=14 ctermbg=NONE cterm=NONE
hi rustAttribute guifg=#2ac3de guibg=NONE guisp=NONE gui=NONE ctermfg=6 ctermbg=NONE cterm=NONE
hi rustEnum guifg=#73daca guibg=NONE guisp=NONE gui=NONE ctermfg=6 ctermbg=NONE cterm=NONE
hi rustMacro guifg=#7dcfff guibg=NONE guisp=NONE gui=NONE ctermfg=12 ctermbg=NONE cterm=NONE
hi rustModPath guifg=#73daca guibg=NONE guisp=NONE gui=NONE ctermfg=6 ctermbg=NONE cterm=NONE
hi rustPanic guifg=#7aa2f7 guibg=NONE guisp=NONE gui=NONE ctermfg=4 ctermbg=NONE cterm=NONE
hi rustTrait guifg=#73daca guibg=NONE guisp=NONE gui=NONE ctermfg=6 ctermbg=NONE cterm=NONE
hi sassClass guifg=#73daca guibg=NONE guisp=NONE gui=NONE ctermfg=6 ctermbg=NONE cterm=NONE
hi sassId guifg=#73daca guibg=NONE guisp=NONE gui=NONE ctermfg=6 ctermbg=NONE cterm=NONE
hi vimAugroup guifg=#73daca guibg=NONE guisp=NONE gui=NONE ctermfg=6 ctermbg=NONE cterm=NONE
hi vimMapRhs guifg=#73daca guibg=NONE guisp=NONE gui=NONE ctermfg=6 ctermbg=NONE cterm=NONE
hi vimNotation guifg=#73daca guibg=NONE guisp=NONE gui=NONE ctermfg=6 ctermbg=NONE cterm=NONE
hi xmlAttrib guifg=#73daca guibg=NONE guisp=NONE gui=NONE ctermfg=6 ctermbg=NONE cterm=NONE
hi xmlCdataStart guifg=#565f89 guibg=NONE guisp=NONE gui=NONE ctermfg=15 ctermbg=NONE cterm=NONE
hi xmlNamespace guifg=#73daca guibg=NONE guisp=NONE gui=NONE ctermfg=6 ctermbg=NONE cterm=NONE
hi yamlBlockMappingKey guifg=#73daca guibg=NONE guisp=NONE gui=NONE ctermfg=6 ctermbg=NONE cterm=NONE
hi ALEWarningSign guifg=#e0af68 guibg=NONE guisp=NONE gui=NONE ctermfg=11 ctermbg=NONE cterm=NONE
hi ALEErrorSign guifg=#f7768e guibg=NONE guisp=NONE gui=NONE ctermfg=1 ctermbg=NONE cterm=NONE
hi ALEWarning guifg=#e0af68 guibg=NONE guisp=NONE gui=NONE ctermfg=11 ctermbg=NONE cterm=NONE
hi ALEError guifg=#f7768e guibg=NONE guisp=NONE gui=NONE ctermfg=1 ctermbg=NONE cterm=NONE
hi CocWarningHighlight guifg=#e0af68 guibg=NONE guisp=NONE gui=NONE ctermfg=11 ctermbg=NONE cterm=NONE
hi CocErrorHighlight guifg=#f7768e guibg=NONE guisp=NONE gui=NONE ctermfg=1 ctermbg=NONE cterm=NONE
hi CocInfoHighlight guifg=#7dcfff guibg=NONE guisp=NONE gui=NONE ctermfg=12 ctermbg=NONE cterm=NONE
hi CocHintHighlight guifg=#b4f9f8 guibg=NONE guisp=NONE gui=NONE ctermfg=14 ctermbg=NONE cterm=NONE
hi CocWarningSign guifg=#e0af68 guibg=NONE guisp=NONE gui=NONE ctermfg=11 ctermbg=NONE cterm=NONE
hi CocErrorSign guifg=#f7768e guibg=NONE guisp=NONE gui=NONE ctermfg=1 ctermbg=NONE cterm=NONE
hi CocInfoSign guifg=#7dcfff guibg=NONE guisp=NONE gui=NONE ctermfg=12 ctermbg=NONE cterm=NONE
hi CocHintSign guifg=#b4f9f8 guibg=NONE guisp=NONE gui=NONE ctermfg=14 ctermbg=NONE cterm=NONE
hi CocSearch guifg=#7dcfff guibg=NONE guisp=NONE gui=NONE ctermfg=12 ctermbg=NONE cterm=NONE
hi CocNotificationProgress guifg=#7dcfff guibg=NONE guisp=NONE gui=NONE ctermfg=12 ctermbg=NONE cterm=NONE
hi GitGutterAdd guifg=#9ece6a guibg=NONE guisp=NONE gui=NONE ctermfg=2 ctermbg=NONE cterm=NONE
hi GitGutterChange guifg=#e0af68 guibg=NONE guisp=NONE gui=NONE ctermfg=11 ctermbg=NONE cterm=NONE
hi GitGutterChangeDelete guifg=#f7768e guibg=NONE guisp=NONE gui=NONE ctermfg=1 ctermbg=NONE cterm=NONE
hi GitGutterDelete guifg=#f7768e guibg=NONE guisp=NONE gui=NONE ctermfg=1 ctermbg=NONE cterm=NONE
hi SignifySignAdd guifg=#9ece6a guibg=NONE guisp=NONE gui=NONE ctermfg=2 ctermbg=NONE cterm=NONE
hi SignifySignChange guifg=#e0af68 guibg=NONE guisp=NONE gui=NONE ctermfg=11 ctermbg=NONE cterm=NONE
hi SignifySignChangeDelete guifg=#f7768e guibg=NONE guisp=NONE gui=NONE ctermfg=1 ctermbg=NONE cterm=NONE
hi SignifySignDelete guifg=#f7768e guibg=NONE guisp=NONE gui=NONE ctermfg=1 ctermbg=NONE cterm=NONE
hi gitcommitDiscardedFile guifg=#f7768e guibg=NONE guisp=NONE gui=NONE ctermfg=1 ctermbg=NONE cterm=NONE
hi gitcommitUntrackedFile guifg=#f7768e guibg=NONE guisp=NONE gui=NONE ctermfg=1 ctermbg=NONE cterm=NONE
hi gitcommitSelectedFile guifg=#9ece6a guibg=NONE guisp=NONE gui=NONE ctermfg=2 ctermbg=NONE cterm=NONE
hi jediFunction guifg=#a9b1d6 guibg=#414868 guisp=NONE gui=NONE ctermfg=NONE ctermbg=7 cterm=NONE
hi jediFat guifg=#7dcfff guibg=#414868 guisp=NONE gui=NONE ctermfg=12 ctermbg=7 cterm=NONE
hi NERDTreeExecFile guifg=#73daca guibg=NONE guisp=NONE gui=NONE ctermfg=6 ctermbg=NONE cterm=NONE
hi ClapDir guifg=#a9b1d6 guibg=NONE guisp=NONE gui=NONE ctermfg=NONE ctermbg=NONE cterm=NONE
hi ClapDisplay guifg=#a9b1d6 guibg=#1a1b26 guisp=NONE gui=NONE ctermfg=NONE ctermbg=0 cterm=NONE
hi ClapFile guifg=#a9b1d6 guibg=NONE guisp=NONE gui=NONE ctermfg=NONE ctermbg=NONE cterm=NONE
hi ClapMatches guifg=#7dcfff guibg=NONE guisp=NONE gui=NONE ctermfg=12 ctermbg=NONE cterm=NONE
hi ClapNoMatchesFound guifg=#e0af68 guibg=NONE guisp=NONE gui=NONE ctermfg=11 ctermbg=NONE cterm=NONE
hi ClapSelected guifg=#73daca guibg=NONE guisp=NONE gui=NONE ctermfg=6 ctermbg=NONE cterm=NONE
hi ClapSelectedSign guifg=#7aa2f7 guibg=NONE guisp=NONE gui=NONE ctermfg=4 ctermbg=NONE cterm=NONE
hi ClapMatches1 guifg=#7dcfff guibg=NONE guisp=NONE gui=NONE ctermfg=12 ctermbg=NONE cterm=NONE
hi ClapFuzzyMatches1 guifg=#7dcfff guibg=NONE guisp=NONE gui=NONE ctermfg=12 ctermbg=NONE cterm=NONE
hi ClapMatches2 guifg=#7aa2f7 guibg=NONE guisp=NONE gui=NONE ctermfg=4 ctermbg=NONE cterm=NONE
hi ClapFuzzyMatches2 guifg=#7aa2f7 guibg=NONE guisp=NONE gui=NONE ctermfg=4 ctermbg=NONE cterm=NONE
hi ClapMatches3 guifg=#2ac3de guibg=NONE guisp=NONE gui=NONE ctermfg=6 ctermbg=NONE cterm=NONE
hi ClapFuzzyMatches3 guifg=#2ac3de guibg=NONE guisp=NONE gui=NONE ctermfg=6 ctermbg=NONE cterm=NONE
hi ClapMatches4 guifg=#7dcfff guibg=NONE guisp=NONE gui=NONE ctermfg=12 ctermbg=NONE cterm=NONE
hi ClapFuzzyMatches4 guifg=#7dcfff guibg=NONE guisp=NONE gui=NONE ctermfg=12 ctermbg=NONE cterm=NONE
hi ClapMatches5 guifg=#7aa2f7 guibg=NONE guisp=NONE gui=NONE ctermfg=4 ctermbg=NONE cterm=NONE
hi ClapFuzzyMatches5 guifg=#7aa2f7 guibg=NONE guisp=NONE gui=NONE ctermfg=4 ctermbg=NONE cterm=NONE
hi ClapMatches6 guifg=#2ac3de guibg=NONE guisp=NONE gui=NONE ctermfg=6 ctermbg=NONE cterm=NONE
hi ClapFuzzyMatches6 guifg=#2ac3de guibg=NONE guisp=NONE gui=NONE ctermfg=6 ctermbg=NONE cterm=NONE
hi ClapMatches7 guifg=#7dcfff guibg=NONE guisp=NONE gui=NONE ctermfg=12 ctermbg=NONE cterm=NONE
hi ClapFuzzyMatches7 guifg=#7dcfff guibg=NONE guisp=NONE gui=NONE ctermfg=12 ctermbg=NONE cterm=NONE
hi ClapMatches8 guifg=#7aa2f7 guibg=NONE guisp=NONE gui=NONE ctermfg=4 ctermbg=NONE cterm=NONE
hi ClapFuzzyMatches8 guifg=#7aa2f7 guibg=NONE guisp=NONE gui=NONE ctermfg=4 ctermbg=NONE cterm=NONE
hi ClapMatches9 guifg=#2ac3de guibg=NONE guisp=NONE gui=NONE ctermfg=6 ctermbg=NONE cterm=NONE
hi ClapFuzzyMatches9 guifg=#2ac3de guibg=NONE guisp=NONE gui=NONE ctermfg=6 ctermbg=NONE cterm=NONE
hi ClapMatches10 guifg=#7dcfff guibg=NONE guisp=NONE gui=NONE ctermfg=12 ctermbg=NONE cterm=NONE
hi ClapFuzzyMatches10 guifg=#7dcfff guibg=NONE guisp=NONE gui=NONE ctermfg=12 ctermbg=NONE cterm=NONE
hi ClapMatches11 guifg=#7aa2f7 guibg=NONE guisp=NONE gui=NONE ctermfg=4 ctermbg=NONE cterm=NONE
hi ClapFuzzyMatches11 guifg=#7aa2f7 guibg=NONE guisp=NONE gui=NONE ctermfg=4 ctermbg=NONE cterm=NONE
hi ClapMatches12 guifg=#2ac3de guibg=NONE guisp=NONE gui=NONE ctermfg=6 ctermbg=NONE cterm=NONE
hi ClapFuzzyMatches12 guifg=#2ac3de guibg=NONE guisp=NONE gui=NONE ctermfg=6 ctermbg=NONE cterm=NONE
hi IndentGuidesEven guifg=NONE guibg=#1a1b26 guisp=NONE gui=NONE ctermfg=NONE ctermbg=0 cterm=NONE
hi IndentGuidesOdd guifg=NONE guibg=#24283b guisp=NONE gui=NONE ctermfg=NONE ctermbg=8 cterm=NONE
hi plugDeleted guifg=#f7768e guibg=NONE guisp=NONE gui=NONE ctermfg=1 ctermbg=NONE cterm=NONE
hi SignatureMarkText guifg=#7dcfff guibg=NONE guisp=NONE gui=NONE ctermfg=12 ctermbg=NONE cterm=NONE
hi StartifyFile guifg=#b4f9f8 guibg=NONE guisp=NONE gui=NONE ctermfg=14 ctermbg=NONE cterm=NONE
hi StartifyFooter guifg=#e0af68 guibg=NONE guisp=NONE gui=NONE ctermfg=11 ctermbg=NONE cterm=NONE
hi StartifyHeader guifg=#7aa2f7 guibg=NONE guisp=NONE gui=NONE ctermfg=4 ctermbg=NONE cterm=NONE
hi StartifyNumber guifg=#bb9af7 guibg=NONE guisp=NONE gui=NONE ctermfg=5 ctermbg=NONE cterm=NONE
hi StartifyPath guifg=#7aa2f7 guibg=NONE guisp=NONE gui=NONE ctermfg=4 ctermbg=NONE cterm=NONE
hi DashboardHeader guifg=#7aa2f7 guibg=NONE guisp=NONE gui=NONE ctermfg=4 ctermbg=NONE cterm=NONE
hi DashboardCenter guifg=#bb9af7 guibg=NONE guisp=NONE gui=NONE ctermfg=5 ctermbg=NONE cterm=NONE
hi DashboardFooter guifg=#e0af68 guibg=NONE guisp=NONE gui=NONE ctermfg=11 ctermbg=NONE cterm=NONE
hi DashboardShortCut guifg=#73daca guibg=NONE guisp=NONE gui=NONE ctermfg=6 ctermbg=NONE cterm=NONE
hi NvimTreeNormal guifg=#a9b1d6 guibg=#0f0f14 guisp=NONE gui=NONE ctermfg=NONE ctermbg=NONE cterm=NONE
hi NvimTreeWinSeparator guifg=#0f0f14 guibg=#0f0f14 guisp=NONE gui=NONE ctermfg=NONE ctermbg=NONE cterm=NONE
hi NvimTreeNormalNC guifg=#a9b1d6 guibg=#0f0f14 guisp=NONE gui=NONE ctermfg=NONE ctermbg=NONE cterm=NONE
hi NvimTreeRootFolder guifg=#bb9af7 guibg=#0f0f14 guisp=NONE gui=NONE ctermfg=5 ctermbg=NONE cterm=NONE
hi BufferCurrentMod guifg=#e0af68 guibg=#1a1b26 guisp=NONE gui=NONE ctermfg=11 ctermbg=0 cterm=NONE
hi BufferVisibleMod guifg=#e0af68 guibg=#414868 guisp=NONE gui=NONE ctermfg=11 ctermbg=7 cterm=NONE
hi BufferInactiveMod guifg=#e0af68 guibg=#0f0f14 guisp=NONE gui=NONE ctermfg=11 ctermbg=NONE cterm=NONE
hi NnnNormal guifg=#a9b1d6 guibg=#1a1b26 guisp=NONE gui=NONE ctermfg=NONE ctermbg=0 cterm=NONE
hi NnnNormalNC guifg=#a9b1d6 guibg=#1a1b26 guisp=NONE gui=NONE ctermfg=NONE ctermbg=0 cterm=NONE
hi CursorWord guifg=NONE guibg=#0f0f14 guisp=NONE gui=NONE ctermfg=NONE ctermbg=NONE cterm=NONE
hi haskellPreProc guifg=#2ac3de guibg=NONE guisp=NONE gui=NONE ctermfg=6 ctermbg=NONE cterm=NONE
hi haskellType guifg=#73daca guibg=NONE guisp=NONE gui=NONE ctermfg=6 ctermbg=NONE cterm=NONE
hi jsGlobalNodeObjects guifg=#7dcfff guibg=NONE guisp=NONE gui=NONE ctermfg=12 ctermbg=NONE cterm=NONE
hi pandocDefinitionBlockTerm guifg=#73daca guibg=NONE guisp=NONE gui=NONE ctermfg=6 ctermbg=NONE cterm=NONE
hi pandocTableDelims guifg=#414868 guibg=NONE guisp=NONE gui=NONE ctermfg=7 ctermbg=NONE cterm=NONE
hi typescriptBOMWindowMethod guifg=#7dcfff guibg=NONE guisp=NONE gui=NONE ctermfg=12 ctermbg=NONE cterm=NONE
hi typescriptClassName guifg=#73daca guibg=NONE guisp=NONE gui=NONE ctermfg=6 ctermbg=NONE cterm=NONE
hi typescriptDecorator guifg=#ff9e64 guibg=NONE guisp=NONE gui=NONE ctermfg=3 ctermbg=NONE cterm=NONE
hi typescriptInterfaceName guifg=#73daca guibg=NONE guisp=NONE gui=NONE ctermfg=6 ctermbg=NONE cterm=NONE
hi typescriptRegexpString guifg=#e0af68 guibg=NONE guisp=NONE gui=NONE ctermfg=11 ctermbg=NONE cterm=NONE
hi tsxAttrib guifg=#73daca guibg=NONE guisp=NONE gui=NONE ctermfg=6 ctermbg=NONE cterm=NONE
hi mkdCode guifg=#73daca guibg=NONE guisp=NONE gui=NONE ctermfg=6 ctermbg=NONE cterm=NONE
hi mkdFootnote guifg=#7dcfff guibg=NONE guisp=NONE gui=NONE ctermfg=12 ctermbg=NONE cterm=NONE
hi mkdRule guifg=#2ac3de guibg=NONE guisp=NONE gui=NONE ctermfg=6 ctermbg=NONE cterm=NONE
hi mkdLineBreak guifg=#7aa2f7 guibg=NONE guisp=NONE gui=NONE ctermfg=4 ctermbg=NONE cterm=NONE
hi phpClass guifg=#73daca guibg=NONE guisp=NONE gui=NONE ctermfg=6 ctermbg=NONE cterm=NONE
hi phpClassImplements guifg=#73daca guibg=NONE guisp=NONE gui=NONE ctermfg=6 ctermbg=NONE cterm=NONE
hi VimwikiHeader1 guifg=#7dcfff guibg=NONE guisp=NONE gui=NONE ctermfg=12 ctermbg=NONE cterm=NONE
hi VimwikiHeader2 guifg=#7dcfff guibg=NONE guisp=NONE gui=NONE ctermfg=12 ctermbg=NONE cterm=NONE
hi VimwikiHeader3 guifg=#7dcfff guibg=NONE guisp=NONE gui=NONE ctermfg=12 ctermbg=NONE cterm=NONE
hi VimwikiHeader4 guifg=#7dcfff guibg=NONE guisp=NONE gui=NONE ctermfg=12 ctermbg=NONE cterm=NONE
hi VimwikiHeader5 guifg=#7dcfff guibg=NONE guisp=NONE gui=NONE ctermfg=12 ctermbg=NONE cterm=NONE
hi VimwikiHeader6 guifg=#7dcfff guibg=NONE guisp=NONE gui=NONE ctermfg=12 ctermbg=NONE cterm=NONE
hi VimwikiLink guifg=#7dcfff guibg=NONE guisp=NONE gui=NONE ctermfg=12 ctermbg=NONE cterm=NONE
hi yamlKey guifg=#73daca guibg=NONE guisp=NONE gui=NONE ctermfg=6 ctermbg=NONE cterm=NONE
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
hi! link QuickFixLine Search
hi! link TabPanel TabLine
hi! link TabPanelSel TabLineSel
hi! link TabPanelFill TabLineFill
hi! link PreInsert Added
hi! link PopupSelected PmenuSel
hi! link MessageWindow WarningMsg
hi! link PopupNotification WarningMsg
hi! link WinSeparator VertSplit
hi! link Annotation Decorator
hi! link Macro Define
hi! link PreCondit PreProc
hi! link Ignore Comment
hi! link asciidocAttributeRef markdownH1
hi! link asciidocAdmonition Keyword
hi! link asciidocBackslash Keyword
hi! link asciidocMacro Keyword
hi! link asciidocQuotedBold Bold
hi! link asciidocQuotedEmphasized Italic
hi! link asciidocQuotedMonospaced2 asciidocQuotedMonospaced
hi! link asciidocQuotedUnconstrainedBold asciidocQuotedBold
hi! link asciidocQuotedUnconstrainedEmphasized asciidocQuotedEmphasized
hi! link asciidocURL markdownLinkText
hi! link awkArrayElement Identifier
hi! link awkBoolLogic Keyword
hi! link awkBrktRegExp SpecialChar
hi! link awkComma Delimiter
hi! link awkExpression Keyword
hi! link awkFieldVars Identifier
hi! link awkLineSkip Keyword
hi! link awkOperator Operator
hi! link awkRegExp SpecialChar
hi! link awkSearch Keyword
hi! link awkSemicolon Delimiter
hi! link awkSpecialCharacter SpecialChar
hi! link awkSpecialPrintf SpecialChar
hi! link awkVariables Identifier
hi! link cOperator Operator
hi! link cPreCondit PreCondit
hi! link cConstant Type
hi! link csPreCondit PreCondit
hi! link csType Type
hi! link csXmlTag SpecialComment
hi! link cssAttr Keyword
hi! link cssBraces Delimiter
hi! link cssClassName cssDefinition
hi! link cssColor Number
hi! link cssProp cssDefinition
hi! link cssPseudoClass cssDefinition
hi! link cssPseudoClassId cssPseudoClass
hi! link cssVendor Keyword
hi! link dosiniLabel Type
hi! link dtDelim Delimiter
hi! link dtLocaleValue Keyword
hi! link dtTypeValue Keyword
hi! link diffAdded DiffAdd
hi! link diffChanged DiffChange
hi! link diffRemoved DiffDelete
hi! link goConstants Keyword
hi! link htmlBold Bold
hi! link htmlEndTag htmlTag
hi! link htmlTag Keyword
hi! link htmlItalic Italic
hi! link htmlH1 markdownH1
hi! link htmlH2 markdownH1
hi! link htmlH3 markdownH1
hi! link htmlH4 markdownH1
hi! link htmlH5 markdownH1
hi! link htmlH6 markdownH1
hi! link htmlSpecialChar SpecialChar
hi! link htmlTagN htmlTag
hi! link javaCommentTitle Comment
hi! link javaScriptBraces Delimiter
hi! link javaScriptIdentifier Keyword
hi! link javaScriptNumber Number
hi! link lessAmpersand Keyword
hi! link lessCssAttribute Delimiter
hi! link lessFunction Function
hi! link cssSelectorOp Keyword
hi! link lispAtomBarSymbol SpecialChar
hi! link lispAtomList SpecialChar
hi! link lispAtomMark Keyword
hi! link lispBarSymbol SpecialChar
hi! link lispFunc Function
hi! link luaFunc Function
hi! link markdownBold Bold
hi! link markdownBoldDelimiter Keyword
hi! link markdownFootnoteDefinition markdownFootnote
hi! link markdownH2 markdownH1
hi! link markdownH3 markdownH1
hi! link markdownH4 markdownH1
hi! link markdownH5 markdownH1
hi! link markdownH6 markdownH1
hi! link markdownIdDelimiter Keyword
hi! link markdownItalic Italic
hi! link markdownItalicDelimiter Keyword
hi! link markdownLinkDelimiter Keyword
hi! link markdownLinkTextDelimiter Keyword
hi! link markdownListMarker Keyword
hi! link markdownRule Keyword
hi! link markdownHeadingDelimiter Keyword
hi! link phpDocCustomTags phpDocTags
hi! link phpMemberSelector Keyword
hi! link podFormat Keyword
hi! link pythonBuiltin Type
hi! link pythonEscape SpecialChar
hi! link rubyAttribute Identifier
hi! link rubyBlockParameterList Operator
hi! link rubyInterpolationDelimiter Keyword
hi! link rubyKeywordAsMethod Function
hi! link rubyLocalVariableOrMethod Function
hi! link rubyPseudoVariable Keyword
hi! link rubyRegexp SpecialChar
hi! link rustCommentLineDoc Comment
hi! link rustDerive rustAttribute
hi! link rustEnumVariant rustEnum
hi! link rustEscape SpecialChar
hi! link rustQuestionMark Keyword
hi! link sassAmpersand Keyword
hi! link sassClassChar Delimiter
hi! link sassControl Keyword
hi! link sassControlLine Keyword
hi! link sassExtend Keyword
hi! link sassFor Keyword
hi! link sassFunctionDecl Keyword
hi! link sassFunctionName Function
hi! link sassidChar sassId
hi! link sassInclude SpecialChar
hi! link sassMixinName Function
hi! link sassMixing SpecialChar
hi! link sassReturn Keyword
hi! link shCmdParenRegion Delimiter
hi! link shCmdSubRegion Delimiter
hi! link shDerefSimple Identifier
hi! link shDerefVar Identifier
hi! link sqlKeyword Keyword
hi! link sqlSpecial Keyword
hi! link vimFunc Function
hi! link vimFunction Function
hi! link vimUserFunc Function
hi! link xmlAttribPunct Delimiter
hi! link xmlCdata Comment
hi! link xmlCdataCdata xmlCdataStart
hi! link xmlCdataEnd xmlCdataStart
hi! link xmlEndTag xmlTagName
hi! link xmlTagName Keyword
hi! link xmlProcessingDelim Keyword
hi! link yamlBool Keyword
hi! link yamlDocumentStart Keyword
hi! link Sneak Search
hi! link NERDTreeDirSlash Keyword
hi! link NERDTreeHelp Comment
hi! link CtrlPMatch Keyword
hi! link CtrlPBufferHid Normal
hi! link ClapCurrentSelection PmenuSel
hi! link ClapCurrentSelectionSign ClapSelectedSign
hi! link ClapInput Pmenu
hi! link ClapPreview Pmenu
hi! link ClapProviderAbout ClapDisplay
hi! link ClapProviderColon Type
hi! link ClapProviderId Type
hi! link StartifyBracket Delimiter
hi! link StartifySlash Normal
hi! link StartifySpecial Comment
hi! link haskellPragma haskellPreProc
hi! link jsBrackets Delimiter
hi! link jsFuncCall Function
hi! link jsFuncParens Delimiter
hi! link jsThis Keyword
hi! link jsNoise Delimiter
hi! link jsPrototype Keyword
hi! link jsRegexpString SpecialChar
hi! link pandocAtxHeader markdownH1
hi! link pandocBlockQuote markdownBlockquote
hi! link pandocCiteAnchor Operator
hi! link pandocCiteKey pandocReferenceLabel
hi! link pandocReferenceLabel markdownLinkText
hi! link pandocDefinitionBlockMark Operator
hi! link pandocEmphasis markdownItalic
hi! link pandocFootnoteID pandocReferenceLabel
hi! link pandocFootnoteIDHead markdownLinkDelimiter
hi! link pandocFootnoteIDTail pandocFootnoteIDHead
hi! link pandocGridTableDelims pandocTableDelims
hi! link pandocGridTableHeader pandocTableDelims
hi! link pandocOperator Operator
hi! link pandocPipeTableDelims pandocTableDelims
hi! link pandocReferenceDefinition pandocReferenceLabel
hi! link pandocReferenceURL markdownUrl
hi! link pandocSimpleTableHeader pandocAtxHeader
hi! link pandocStrong markdownBold
hi! link pandocTableHeaderWord pandocAtxHeader
hi! link pandocUListItemBullet Operator
hi! link typescriptOperator Operator
hi! link typescriptBinaryOp Operator
hi! link typescriptAssign Operator
hi! link typescriptMember Identifier
hi! link typescriptDOMStorageMethod Identifier
hi! link typescriptArrowFuncArg Identifier
hi! link typescriptGlobal typescriptClassName
hi! link typescriptBOMWindowProp Function
hi! link typescriptArrowFuncDef Function
hi! link typescriptAliasDeclaration Function
hi! link typescriptPredefinedType Type
hi! link typescriptTypeReference typescriptClassName
hi! link typescriptTypeAnnotation Structure
hi! link typescriptDocNamedParamType SpecialComment
hi! link typescriptDocNotation Keyword
hi! link typescriptDocTags Keyword
hi! link typescriptImport Keyword
hi! link typescriptExport Keyword
hi! link typescriptTry Keyword
hi! link typescriptVariable Keyword
hi! link typescriptBraces Normal
hi! link typescriptObjectLabel Normal
hi! link typescriptCall Normal
hi! link typescriptClassHeritage typescriptClassName
hi! link typescriptFuncTypeArrow Structure
hi! link typescriptMemberOptionality Structure
hi! link typescriptNodeGlobal typescriptGlobal
hi! link typescriptTypeBrackets Structure
hi! link tsxEqual Operator
hi! link tsxIntrinsicTagName htmlTag
hi! link tsxTagName tsxIntrinsicTagName
hi! link mkdBold Bold
hi! link mkdItalic Italic
hi! link mkdString Keyword
hi! link mkdCodeStart mkdCode
hi! link mkdCodeEnd mkdCode
hi! link mkdBlockquote Comment
hi! link mkdListItem Keyword
hi! link mkdListItemLine Normal
hi! link mkdFootnotes mkdFootnote
hi! link mkdLink markdownLinkText
hi! link mkdURL markdownUrl
hi! link mkdInlineURL mkdURL
hi! link mkdID Identifier
hi! link mkdLinkDef mkdLink
hi! link mkdLinkDefTarget mkdURL
hi! link mkdLinkTitle mkdInlineURL
hi! link mkdDelimiter Keyword
hi! link phpClassExtends phpClass
hi! link phpFunction Function
hi! link phpMethod Function
hi! link phpUseClass phpClass
hi! link VimwikiHeaderChar markdownHeadingDelimiter
hi! link VimwikiHR Keyword
hi! link VimwikiList markdownListMarker
