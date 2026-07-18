vim9script
# supra-gui: background=#262626 include=#8cbf7a stdio=#b8ba24 typedef=#fc8017 struct=#db6bab type_s=#ebd9b3 scope=#ebd9b3 float=#80d6e8 function=#ebd9b3 format=#fc8017 text=#b8ba24 integer=#d18599

hi clear

if exists("syntax_on")
  syntax reset
endif

set t_Co=256

g:colors_name = "gruvbox"

hi ErrorMsg guifg=#282828 guibg=#fb4934 guisp=NONE gui=NONE ctermfg=235 ctermbg=167 cterm=NONE
hi IncSearch guifg=#282828 guibg=#fe8019 guisp=NONE gui=NONE ctermfg=208 ctermbg=235 cterm=NONE
hi Search guifg=#282828 guibg=#fe8019 guisp=NONE gui=NONE ctermfg=214 ctermbg=235 cterm=NONE
hi LineNr guifg=#7c6f64 guibg=NONE guisp=NONE gui=NONE ctermfg=243 ctermbg=NONE cterm=NONE
hi CursorLineNr guifg=#fabd2f guibg=#3c3836 guisp=NONE gui=NONE ctermfg=214 ctermbg=237 cterm=NONE
hi StatusLine guifg=#504945 guibg=#ebdbb2 guisp=NONE gui=NONE ctermfg=239 ctermbg=223 cterm=NONE
hi StatusLineNC guifg=#3c3836 guibg=#a89984 guisp=NONE gui=NONE ctermfg=237 ctermbg=246 cterm=NONE
hi VertSplit guifg=#665c54 guibg=#282828 guisp=NONE gui=NONE ctermfg=241 ctermbg=235 cterm=NONE
hi Visual guifg=NONE guibg=#665c54 guisp=NONE gui=NONE ctermfg=NONE ctermbg=241 cterm=NONE
hi WildMenu guifg=#83a598 guibg=#504945 guisp=NONE gui=NONE ctermfg=109 ctermbg=239 cterm=NONE
hi Folded guifg=#928374 guibg=#3c3836 guisp=NONE gui=NONE ctermfg=245 ctermbg=237 cterm=NONE
hi FoldColumn guifg=#928374 guibg=#3c3836 guisp=NONE gui=NONE ctermfg=245 ctermbg=237 cterm=NONE
hi DiffAdd guifg=#b8bb26 guibg=#282828 guisp=NONE gui=NONE ctermfg=142 ctermbg=235 cterm=NONE
hi DiffChange guifg=#8ec07c guibg=#282828 guisp=NONE gui=NONE ctermfg=108 ctermbg=235 cterm=NONE
hi DiffDelete guifg=#fb4934 guibg=#282828 guisp=NONE gui=NONE ctermfg=167 ctermbg=235 cterm=NONE
hi DiffText guifg=#fabd2f guibg=#282828 guisp=NONE gui=NONE ctermfg=214 ctermbg=235 cterm=NONE
hi SignColumn guifg=NONE guibg=#3c3836 guisp=NONE gui=NONE ctermfg=NONE ctermbg=237 cterm=NONE
hi Conceal guifg=#83a598 guibg=NONE guisp=NONE gui=NONE ctermfg=109 ctermbg=NONE cterm=NONE
hi SpellBad guifg=NONE guibg=NONE guisp=NONE gui=NONE ctermfg=NONE ctermbg=NONE cterm=NONE
hi SpellCap guifg=NONE guibg=NONE guisp=NONE gui=NONE ctermfg=NONE ctermbg=NONE cterm=NONE
hi SpellRare guifg=NONE guibg=NONE guisp=NONE gui=NONE ctermfg=NONE ctermbg=NONE cterm=NONE
hi SpellLocal guifg=NONE guibg=NONE guisp=NONE gui=NONE ctermfg=NONE ctermbg=NONE cterm=NONE
hi Pmenu guifg=#ebdbb2 guibg=#504945 guisp=NONE gui=NONE ctermfg=223 ctermbg=239 cterm=NONE
hi PmenuSel guifg=#504945 guibg=#83a598 guisp=NONE gui=NONE ctermfg=239 ctermbg=109 cterm=NONE
hi PmenuMatch guifg=#fabd2f guibg=#504945 guisp=NONE gui=NONE ctermfg=214 ctermbg=239 cterm=NONE
hi PmenuKind guifg=#a89984 guibg=#504945 guisp=NONE gui=NONE ctermfg=246 ctermbg=239 cterm=NONE
hi PmenuSbar guifg=NONE guibg=#504945 guisp=NONE gui=NONE ctermfg=NONE ctermbg=239 cterm=NONE
hi PmenuThumb guifg=NONE guibg=#7c6f64 guisp=NONE gui=NONE ctermfg=NONE ctermbg=243 cterm=NONE
hi PmenuShadow guifg=DarkGrey guibg=Black guisp=NONE gui=NONE ctermfg=242 ctermbg=0 cterm=NONE
hi TabLineSel guifg=#b8bb26 guibg=#3c3836 guisp=NONE gui=NONE ctermfg=142 ctermbg=237 cterm=NONE
hi TabLineFill guifg=#7c6f64 guibg=#3c3836 guisp=NONE gui=NONE ctermfg=243 ctermbg=237 cterm=NONE
hi CursorLine guifg=NONE guibg=#3c3836 guisp=NONE gui=NONE ctermfg=NONE ctermbg=237 cterm=NONE
hi ColorColumn guifg=NONE guibg=#3c3836 guisp=NONE gui=NONE ctermfg=NONE ctermbg=237 cterm=NONE
hi StatusLineTerm guifg=bg guibg=LightGreen guisp=NONE gui=NONE ctermfg=0 ctermbg=121 cterm=NONE
hi StatusLineTermNC guifg=bg guibg=LightGreen guisp=NONE gui=NONE ctermfg=0 ctermbg=121 cterm=NONE
hi Normal guifg=#ebdbb2 guibg=#282828 guisp=NONE gui=NONE ctermfg=223 ctermbg=235 cterm=NONE
hi MatchParen guifg=NONE guibg=#665c54 guisp=NONE gui=NONE ctermfg=NONE ctermbg=241 cterm=NONE
hi ToolbarLine guifg=NONE guibg=Grey50 guisp=NONE gui=NONE ctermfg=NONE ctermbg=242 cterm=NONE
hi ToolbarButton guifg=Black guibg=LightGrey guisp=NONE gui=NONE ctermfg=0 ctermbg=7 cterm=NONE
hi GruvboxFg0 guifg=#fbf1c7 guibg=NONE guisp=NONE gui=NONE ctermfg=229 ctermbg=NONE cterm=NONE
hi GruvboxFg1 guifg=#ebdbb2 guibg=NONE guisp=NONE gui=NONE ctermfg=223 ctermbg=NONE cterm=NONE
hi GruvboxFg2 guifg=#d5c4a1 guibg=NONE guisp=NONE gui=NONE ctermfg=250 ctermbg=NONE cterm=NONE
hi GruvboxFg3 guifg=#bdae93 guibg=NONE guisp=NONE gui=NONE ctermfg=248 ctermbg=NONE cterm=NONE
hi GruvboxFg4 guifg=#a89984 guibg=NONE guisp=NONE gui=NONE ctermfg=246 ctermbg=NONE cterm=NONE
hi GruvboxGray guifg=#928374 guibg=NONE guisp=NONE gui=NONE ctermfg=245 ctermbg=NONE cterm=NONE
hi GruvboxBg0 guifg=#282828 guibg=NONE guisp=NONE gui=NONE ctermfg=235 ctermbg=NONE cterm=NONE
hi GruvboxBg1 guifg=#3c3836 guibg=NONE guisp=NONE gui=NONE ctermfg=237 ctermbg=NONE cterm=NONE
hi GruvboxBg2 guifg=#504945 guibg=NONE guisp=NONE gui=NONE ctermfg=239 ctermbg=NONE cterm=NONE
hi GruvboxBg3 guifg=#665c54 guibg=NONE guisp=NONE gui=NONE ctermfg=241 ctermbg=NONE cterm=NONE
hi GruvboxBg4 guifg=#7c6f64 guibg=NONE guisp=NONE gui=NONE ctermfg=243 ctermbg=NONE cterm=NONE
hi GruvboxRed guifg=#fb4934 guibg=NONE guisp=NONE gui=NONE ctermfg=167 ctermbg=NONE cterm=NONE
hi GruvboxRedBold guifg=#fb4934 guibg=NONE guisp=NONE gui=NONE ctermfg=167 ctermbg=NONE cterm=NONE
hi GruvboxGreen guifg=#b8bb26 guibg=NONE guisp=NONE gui=NONE ctermfg=142 ctermbg=NONE cterm=NONE
hi GruvboxGreenBold guifg=#b8bb26 guibg=NONE guisp=NONE gui=NONE ctermfg=142 ctermbg=NONE cterm=NONE
hi GruvboxYellow guifg=#fabd2f guibg=NONE guisp=NONE gui=NONE ctermfg=214 ctermbg=NONE cterm=NONE
hi GruvboxYellowBold guifg=#fabd2f guibg=NONE guisp=NONE gui=NONE ctermfg=214 ctermbg=NONE cterm=NONE
hi GruvboxBlue guifg=#83a598 guibg=NONE guisp=NONE gui=NONE ctermfg=109 ctermbg=NONE cterm=NONE
hi GruvboxBlueBold guifg=#83a598 guibg=NONE guisp=NONE gui=NONE ctermfg=109 ctermbg=NONE cterm=NONE
hi GruvboxPurple guifg=#d3869b guibg=NONE guisp=NONE gui=NONE ctermfg=175 ctermbg=NONE cterm=NONE
hi GruvboxPurpleBold guifg=#d3869b guibg=NONE guisp=NONE gui=NONE ctermfg=175 ctermbg=NONE cterm=NONE
hi GruvboxAqua guifg=#8ec07c guibg=NONE guisp=NONE gui=NONE ctermfg=108 ctermbg=NONE cterm=NONE
hi GruvboxAquaBold guifg=#8ec07c guibg=NONE guisp=NONE gui=NONE ctermfg=108 ctermbg=NONE cterm=NONE
hi GruvboxOrange guifg=#fe8019 guibg=NONE guisp=NONE gui=NONE ctermfg=208 ctermbg=NONE cterm=NONE
hi GruvboxOrangeBold guifg=#fe8019 guibg=NONE guisp=NONE gui=NONE ctermfg=208 ctermbg=NONE cterm=NONE
hi GruvboxRedSign guifg=#fb4934 guibg=#3c3836 guisp=NONE gui=NONE ctermfg=167 ctermbg=237 cterm=NONE
hi GruvboxGreenSign guifg=#b8bb26 guibg=#3c3836 guisp=NONE gui=NONE ctermfg=142 ctermbg=237 cterm=NONE
hi GruvboxYellowSign guifg=#fabd2f guibg=#3c3836 guisp=NONE gui=NONE ctermfg=214 ctermbg=237 cterm=NONE
hi GruvboxBlueSign guifg=#83a598 guibg=#3c3836 guisp=NONE gui=NONE ctermfg=109 ctermbg=237 cterm=NONE
hi GruvboxPurpleSign guifg=#d3869b guibg=#3c3836 guisp=NONE gui=NONE ctermfg=175 ctermbg=237 cterm=NONE
hi GruvboxAquaSign guifg=#8ec07c guibg=#3c3836 guisp=NONE gui=NONE ctermfg=108 ctermbg=237 cterm=NONE
hi GruvboxOrangeSign guifg=#fe8019 guibg=#3c3836 guisp=NONE gui=NONE ctermfg=208 ctermbg=237 cterm=NONE
hi Underlined guifg=#83a598 guibg=NONE guisp=NONE gui=NONE ctermfg=109 ctermbg=NONE cterm=NONE
hi Cursor guifg=NONE guibg=NONE guisp=NONE gui=NONE ctermfg=NONE ctermbg=NONE cterm=NONE
hi Comment guifg=#928374 guibg=NONE guisp=NONE gui=NONE ctermfg=245 ctermbg=NONE cterm=NONE
hi Todo guifg=fg guibg=bg guisp=NONE gui=NONE ctermfg=223 ctermbg=235 cterm=NONE
hi Error guifg=#fb4934 guibg=bg guisp=NONE gui=NONE ctermfg=167 ctermbg=235 cterm=NONE
hi String guifg=#b8bb26 guibg=NONE guisp=NONE gui=NONE ctermfg=142 ctermbg=NONE cterm=NONE
hi IndentGuidesOdd guifg=bg guibg=#504945 guisp=NONE gui=NONE ctermfg=235 ctermbg=239 cterm=NONE
hi IndentGuidesEven guifg=bg guibg=#3c3836 guisp=NONE gui=NONE ctermfg=235 ctermbg=237 cterm=NONE
hi SyntasticError guifg=NONE guibg=NONE guisp=NONE gui=NONE ctermfg=NONE ctermbg=NONE cterm=NONE
hi SyntasticWarning guifg=NONE guibg=NONE guisp=NONE gui=NONE ctermfg=NONE ctermbg=NONE cterm=NONE
hi CtrlPMode1 guifg=#83a598 guibg=#504945 guisp=NONE gui=NONE ctermfg=109 ctermbg=239 cterm=NONE
hi CtrlPMode2 guifg=#282828 guibg=#83a598 guisp=NONE gui=NONE ctermfg=235 ctermbg=109 cterm=NONE
hi CtrlPStats guifg=#a89984 guibg=#504945 guisp=NONE gui=NONE ctermfg=246 ctermbg=239 cterm=NONE
hi BufTabLineCurrent guifg=#282828 guibg=#a89984 guisp=NONE gui=NONE ctermfg=235 ctermbg=246 cterm=NONE
hi BufTabLineActive guifg=#a89984 guibg=#504945 guisp=NONE gui=NONE ctermfg=246 ctermbg=239 cterm=NONE
hi BufTabLineHidden guifg=#7c6f64 guibg=#3c3836 guisp=NONE gui=NONE ctermfg=243 ctermbg=237 cterm=NONE
hi BufTabLineFill guifg=#282828 guibg=#282828 guisp=NONE gui=NONE ctermfg=235 ctermbg=235 cterm=NONE
hi ALEError guifg=NONE guibg=NONE guisp=NONE gui=NONE ctermfg=NONE ctermbg=NONE cterm=NONE
hi ALEWarning guifg=NONE guibg=NONE guisp=NONE gui=NONE ctermfg=NONE ctermbg=NONE cterm=NONE
hi ALEInfo guifg=NONE guibg=NONE guisp=NONE gui=NONE ctermfg=NONE ctermbg=NONE cterm=NONE
hi multiple_cursors_cursor guifg=NONE guibg=NONE guisp=NONE gui=NONE ctermfg=NONE ctermbg=NONE cterm=NONE
hi multiple_cursors_visual guifg=NONE guibg=#504945 guisp=NONE gui=NONE ctermfg=NONE ctermbg=239 cterm=NONE
hi CocErrorHighlight guifg=NONE guibg=NONE guisp=NONE gui=NONE ctermfg=NONE ctermbg=NONE cterm=NONE
hi CocWarningHighlight guifg=NONE guibg=NONE guisp=NONE gui=NONE ctermfg=NONE ctermbg=NONE cterm=NONE
hi CocInfoHighlight guifg=NONE guibg=NONE guisp=NONE gui=NONE ctermfg=NONE ctermbg=NONE cterm=NONE
hi CocHintHighlight guifg=NONE guibg=NONE guisp=NONE gui=NONE ctermfg=NONE ctermbg=NONE cterm=NONE
hi htmlLink guifg=#a89984 guibg=NONE guisp=NONE gui=NONE ctermfg=246 ctermbg=NONE cterm=NONE
hi htmlBold guifg=fg guibg=bg guisp=NONE gui=NONE ctermfg=223 ctermbg=235 cterm=NONE
hi htmlBoldUnderline guifg=fg guibg=bg guisp=NONE gui=NONE ctermfg=223 ctermbg=235 cterm=NONE
hi htmlBoldItalic guifg=fg guibg=bg guisp=NONE gui=NONE ctermfg=223 ctermbg=235 cterm=NONE
hi htmlBoldUnderlineItalic guifg=fg guibg=bg guisp=NONE gui=NONE ctermfg=223 ctermbg=235 cterm=NONE
hi htmlUnderline guifg=fg guibg=bg guisp=NONE gui=NONE ctermfg=223 ctermbg=235 cterm=NONE
hi htmlUnderlineItalic guifg=fg guibg=bg guisp=NONE gui=NONE ctermfg=223 ctermbg=235 cterm=NONE
hi htmlItalic guifg=fg guibg=bg guisp=NONE gui=NONE ctermfg=223 ctermbg=235 cterm=NONE
hi vimCommentTitle guifg=#a89984 guibg=NONE guisp=NONE gui=NONE ctermfg=246 ctermbg=NONE cterm=NONE
hi clojureRegexpCharClass guifg=#bdae93 guibg=NONE guisp=NONE gui=NONE ctermfg=248 ctermbg=NONE cterm=NONE
hi markdownItalic guifg=#bdae93 guibg=NONE guisp=NONE gui=NONE ctermfg=248 ctermbg=NONE cterm=NONE
hi markdownLinkText guifg=#928374 guibg=NONE guisp=NONE gui=NONE ctermfg=245 ctermbg=NONE cterm=NONE
hi! link SpecialKey GruvboxBg2
hi! link EndOfBuffer NonText
hi! link NonText GruvboxBg2
hi! link Directory GruvboxGreenBold
hi! link CurSearch Search
hi! link MoreMsg GruvboxYellowBold
hi! link ModeMsg GruvboxYellowBold
hi! link CursorLineSign SignColumn
hi! link CursorLineFold FoldColumn
hi! link Question GruvboxOrangeBold
hi! link VertSplitNC VertSplit
hi! link Title GruvboxGreenBold
hi! link VisualNOS Visual
hi! link WarningMsg GruvboxRedBold
hi! link DiffTextAdd DiffText
hi! link PmenuMatchSel PmenuSel
hi! link PmenuKindSel PmenuSel
hi! link PmenuExtra Pmenu
hi! link PmenuExtraSel PmenuSel
hi! link PmenuBorder Pmenu
hi! link TabLine TabLineFill
hi! link CursorColumn CursorLine
hi! link QuickFixLine Search
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
hi! link Special GruvboxOrange
hi! link Statement GruvboxRed
hi! link Conditional GruvboxRed
hi! link Repeat GruvboxRed
hi! link Label GruvboxRed
hi! link Exception GruvboxRed
hi! link Operator Normal
hi! link Keyword GruvboxRed
hi! link Identifier GruvboxBlue
hi! link Function GruvboxGreenBold
hi! link PreProc GruvboxAqua
hi! link Include GruvboxAqua
hi! link Define GruvboxAqua
hi! link Macro GruvboxAqua
hi! link PreCondit GruvboxAqua
hi! link Constant GruvboxPurple
hi! link Character GruvboxPurple
hi! link Boolean GruvboxPurple
hi! link Number GruvboxPurple
hi! link Float GruvboxPurple
hi! link Type GruvboxYellow
hi! link StorageClass GruvboxOrange
hi! link Structure GruvboxAqua
hi! link Typedef GruvboxYellow
hi! link EasyMotionTarget Search
hi! link EasyMotionShade Comment
hi! link Sneak Search
hi! link SneakLabel Search
hi! link GitGutterAdd GruvboxGreenSign
hi! link GitGutterChange GruvboxAquaSign
hi! link GitGutterDelete GruvboxRedSign
hi! link GitGutterChangeDelete GruvboxAquaSign
hi! link gitcommitSelectedFile GruvboxGreen
hi! link gitcommitDiscardedFile GruvboxRed
hi! link SignifySignAdd GruvboxGreenSign
hi! link SignifySignChange GruvboxAquaSign
hi! link SignifySignDelete GruvboxRedSign
hi! link SyntasticErrorSign GruvboxRedSign
hi! link SyntasticWarningSign GruvboxYellowSign
hi! link SignatureMarkText GruvboxBlueSign
hi! link SignatureMarkerText GruvboxPurpleSign
hi! link ShowMarksHLl GruvboxBlueSign
hi! link ShowMarksHLu GruvboxBlueSign
hi! link ShowMarksHLo GruvboxBlueSign
hi! link ShowMarksHLm GruvboxBlueSign
hi! link CtrlPMatch GruvboxYellow
hi! link CtrlPNoEntries GruvboxRed
hi! link CtrlPPrtBase GruvboxBg2
hi! link CtrlPPrtCursor GruvboxBlue
hi! link CtrlPLinePre GruvboxBg2
hi! link StartifyBracket GruvboxFg3
hi! link StartifyFile GruvboxFg1
hi! link StartifyNumber GruvboxBlue
hi! link StartifyPath GruvboxGray
hi! link StartifySlash GruvboxGray
hi! link StartifySection GruvboxYellow
hi! link StartifySpecial GruvboxBg2
hi! link StartifyHeader GruvboxOrange
hi! link StartifyFooter GruvboxBg2
hi! link ALEErrorSign GruvboxRedSign
hi! link ALEWarningSign GruvboxYellowSign
hi! link ALEInfoSign GruvboxBlueSign
hi! link DirvishPathTail GruvboxAqua
hi! link DirvishArg GruvboxYellow
hi! link netrwDir GruvboxAqua
hi! link netrwClassify GruvboxAqua
hi! link netrwLink GruvboxGray
hi! link netrwSymLink GruvboxFg1
hi! link netrwExe GruvboxYellow
hi! link netrwComment GruvboxGray
hi! link netrwList GruvboxBlue
hi! link netrwHelpCmd GruvboxAqua
hi! link netrwCmdSep GruvboxFg3
hi! link netrwVersion GruvboxGreen
hi! link NERDTreeDir GruvboxAqua
hi! link NERDTreeDirSlash GruvboxAqua
hi! link NERDTreeOpenable GruvboxOrange
hi! link NERDTreeClosable GruvboxOrange
hi! link NERDTreeFile GruvboxFg1
hi! link NERDTreeExecFile GruvboxYellow
hi! link NERDTreeUp GruvboxGray
hi! link NERDTreeCWD GruvboxGreen
hi! link NERDTreeHelp GruvboxFg1
hi! link NERDTreeToggleOn GruvboxGreen
hi! link NERDTreeToggleOff GruvboxRed
hi! link CocErrorSign GruvboxRedSign
hi! link CocWarningSign GruvboxOrangeSign
hi! link CocInfoSign GruvboxYellowSign
hi! link CocHintSign GruvboxBlueSign
hi! link CocErrorFloat GruvboxRed
hi! link CocWarningFloat GruvboxOrange
hi! link CocInfoFloat GruvboxYellow
hi! link CocHintFloat GruvboxBlue
hi! link CocDiagnosticsError GruvboxRed
hi! link CocDiagnosticsWarning GruvboxOrange
hi! link CocDiagnosticsInfo GruvboxYellow
hi! link CocDiagnosticsHint GruvboxBlue
hi! link CocSelectedText GruvboxRed
hi! link CocCodeLens GruvboxGray
hi! link diffAdded GruvboxGreen
hi! link diffRemoved GruvboxRed
hi! link diffChanged GruvboxAqua
hi! link diffFile GruvboxOrange
hi! link diffNewFile GruvboxYellow
hi! link diffLine GruvboxBlue
hi! link htmlTag GruvboxBlue
hi! link htmlEndTag GruvboxBlue
hi! link htmlTagName GruvboxAquaBold
hi! link htmlArg GruvboxAqua
hi! link htmlScriptTag GruvboxPurple
hi! link htmlTagN GruvboxFg1
hi! link htmlSpecialTagName GruvboxAquaBold
hi! link htmlSpecialChar GruvboxOrange
hi! link xmlTag GruvboxBlue
hi! link xmlEndTag GruvboxBlue
hi! link xmlTagName GruvboxBlue
hi! link xmlEqual GruvboxBlue
hi! link docbkKeyword GruvboxAquaBold
hi! link xmlDocTypeDecl GruvboxGray
hi! link xmlDocTypeKeyword GruvboxPurple
hi! link xmlCdataStart GruvboxGray
hi! link xmlCdataCdata GruvboxPurple
hi! link dtdFunction GruvboxGray
hi! link dtdTagName GruvboxPurple
hi! link xmlAttrib GruvboxAqua
hi! link xmlProcessingDelim GruvboxGray
hi! link dtdParamEntityPunct GruvboxGray
hi! link dtdParamEntityDPunct GruvboxGray
hi! link xmlAttribPunct GruvboxGray
hi! link xmlEntity GruvboxOrange
hi! link xmlEntityPunct GruvboxOrange
hi! link vimNotation GruvboxOrange
hi! link vimBracket GruvboxOrange
hi! link vimMapModKey GruvboxOrange
hi! link vimFuncSID GruvboxFg3
hi! link vimSetSep GruvboxFg3
hi! link vimSep GruvboxFg3
hi! link vimContinue GruvboxFg3
hi! link clojureKeyword GruvboxBlue
hi! link clojureCond GruvboxOrange
hi! link clojureSpecial GruvboxOrange
hi! link clojureDefine GruvboxOrange
hi! link clojureFunc GruvboxYellow
hi! link clojureRepeat GruvboxYellow
hi! link clojureCharacter GruvboxAqua
hi! link clojureStringEscape GruvboxAqua
hi! link clojureException GruvboxRed
hi! link clojureRegexp GruvboxAqua
hi! link clojureRegexpEscape GruvboxAqua
hi! link clojureRegexpMod clojureRegexpCharClass
hi! link clojureRegexpQuantifier clojureRegexpCharClass
hi! link clojureParen GruvboxFg3
hi! link clojureAnonArg GruvboxYellow
hi! link clojureVariable GruvboxBlue
hi! link clojureMacro GruvboxOrange
hi! link clojureMeta GruvboxYellow
hi! link clojureDeref GruvboxYellow
hi! link clojureQuote GruvboxYellow
hi! link clojureUnquote GruvboxYellow
hi! link cOperator GruvboxPurple
hi! link cStructure GruvboxOrange
hi! link pythonBuiltin GruvboxOrange
hi! link pythonBuiltinObj GruvboxOrange
hi! link pythonBuiltinFunc GruvboxOrange
hi! link pythonFunction GruvboxAqua
hi! link pythonDecorator GruvboxRed
hi! link pythonInclude GruvboxBlue
hi! link pythonImport GruvboxBlue
hi! link pythonRun GruvboxBlue
hi! link pythonCoding GruvboxBlue
hi! link pythonOperator GruvboxRed
hi! link pythonException GruvboxRed
hi! link pythonExceptions GruvboxPurple
hi! link pythonBoolean GruvboxPurple
hi! link pythonDot GruvboxFg3
hi! link pythonConditional GruvboxRed
hi! link pythonRepeat GruvboxRed
hi! link pythonDottedName GruvboxGreenBold
hi! link cssBraces GruvboxBlue
hi! link cssFunctionName GruvboxYellow
hi! link cssIdentifier GruvboxOrange
hi! link cssClassName GruvboxGreen
hi! link cssColor GruvboxBlue
hi! link cssSelectorOp GruvboxBlue
hi! link cssSelectorOp2 GruvboxBlue
hi! link cssImportant GruvboxGreen
hi! link cssVendor GruvboxFg1
hi! link cssTextProp GruvboxAqua
hi! link cssAnimationProp GruvboxAqua
hi! link cssUIProp GruvboxYellow
hi! link cssTransformProp GruvboxAqua
hi! link cssTransitionProp GruvboxAqua
hi! link cssPrintProp GruvboxAqua
hi! link cssPositioningProp GruvboxYellow
hi! link cssBoxProp GruvboxAqua
hi! link cssFontDescriptorProp GruvboxAqua
hi! link cssFlexibleBoxProp GruvboxAqua
hi! link cssBorderOutlineProp GruvboxAqua
hi! link cssBackgroundProp GruvboxAqua
hi! link cssMarginProp GruvboxAqua
hi! link cssListProp GruvboxAqua
hi! link cssTableProp GruvboxAqua
hi! link cssFontProp GruvboxAqua
hi! link cssPaddingProp GruvboxAqua
hi! link cssDimensionProp GruvboxAqua
hi! link cssRenderProp GruvboxAqua
hi! link cssColorProp GruvboxAqua
hi! link cssGeneratedContentProp GruvboxAqua
hi! link javaScriptBraces GruvboxFg1
hi! link javaScriptFunction GruvboxAqua
hi! link javaScriptIdentifier GruvboxOrange
hi! link javaScriptMember GruvboxBlue
hi! link javaScriptNumber GruvboxPurple
hi! link javaScriptNull GruvboxPurple
hi! link javaScriptParens GruvboxFg3
hi! link javascriptImport GruvboxAqua
hi! link javascriptExport GruvboxAqua
hi! link javascriptClassKeyword GruvboxAqua
hi! link javascriptClassExtends GruvboxAqua
hi! link javascriptDefault GruvboxAqua
hi! link javascriptClassName GruvboxYellow
hi! link javascriptClassSuperName GruvboxYellow
hi! link javascriptGlobal GruvboxYellow
hi! link javascriptEndColons GruvboxFg1
hi! link javascriptFuncArg GruvboxFg1
hi! link javascriptGlobalMethod GruvboxFg1
hi! link javascriptNodeGlobal GruvboxFg1
hi! link javascriptBOMWindowProp GruvboxFg1
hi! link javascriptArrayMethod GruvboxFg1
hi! link javascriptArrayStaticMethod GruvboxFg1
hi! link javascriptCacheMethod GruvboxFg1
hi! link javascriptDateMethod GruvboxFg1
hi! link javascriptMathStaticMethod GruvboxFg1
hi! link javascriptURLUtilsProp GruvboxFg1
hi! link javascriptBOMNavigatorProp GruvboxFg1
hi! link javascriptDOMDocMethod GruvboxFg1
hi! link javascriptDOMDocProp GruvboxFg1
hi! link javascriptBOMLocationMethod GruvboxFg1
hi! link javascriptBOMWindowMethod GruvboxFg1
hi! link javascriptStringMethod GruvboxFg1
hi! link javascriptVariable GruvboxOrange
hi! link javascriptClassSuper GruvboxOrange
hi! link javascriptFuncKeyword GruvboxAqua
hi! link javascriptAsyncFunc GruvboxAqua
hi! link javascriptClassStatic GruvboxOrange
hi! link javascriptOperator GruvboxRed
hi! link javascriptForOperator GruvboxRed
hi! link javascriptYield GruvboxRed
hi! link javascriptExceptions GruvboxRed
hi! link javascriptMessage GruvboxRed
hi! link javascriptTemplateSB GruvboxAqua
hi! link javascriptTemplateSubstitution GruvboxFg1
hi! link javascriptLabel GruvboxFg1
hi! link javascriptObjectLabel GruvboxFg1
hi! link javascriptPropertyName GruvboxFg1
hi! link javascriptLogicSymbols GruvboxFg1
hi! link javascriptArrowFunc GruvboxYellow
hi! link javascriptDocParamName GruvboxFg4
hi! link javascriptDocTags GruvboxFg4
hi! link javascriptDocNotation GruvboxFg4
hi! link javascriptDocParamType GruvboxFg4
hi! link javascriptDocNamedParamType GruvboxFg4
hi! link javascriptBrackets GruvboxFg1
hi! link javascriptDOMElemAttrs GruvboxFg1
hi! link javascriptDOMEventMethod GruvboxFg1
hi! link javascriptDOMNodeMethod GruvboxFg1
hi! link javascriptDOMStorageMethod GruvboxFg1
hi! link javascriptHeadersMethod GruvboxFg1
hi! link javascriptAsyncFuncKeyword GruvboxRed
hi! link javascriptAwaitFuncKeyword GruvboxRed
hi! link jsClassKeyword GruvboxAqua
hi! link jsExtendsKeyword GruvboxAqua
hi! link jsExportDefault GruvboxAqua
hi! link jsTemplateBraces GruvboxAqua
hi! link jsGlobalNodeObjects GruvboxFg1
hi! link jsGlobalObjects GruvboxFg1
hi! link jsFunction GruvboxAqua
hi! link jsFuncParens GruvboxFg3
hi! link jsParens GruvboxFg3
hi! link jsNull GruvboxPurple
hi! link jsUndefined GruvboxPurple
hi! link jsClassDefinition GruvboxYellow
hi! link typeScriptReserved GruvboxAqua
hi! link typeScriptLabel GruvboxAqua
hi! link typeScriptFuncKeyword GruvboxAqua
hi! link typeScriptIdentifier GruvboxOrange
hi! link typeScriptBraces GruvboxFg1
hi! link typeScriptEndColons GruvboxFg1
hi! link typeScriptDOMObjects GruvboxFg1
hi! link typeScriptAjaxMethods GruvboxFg1
hi! link typeScriptLogicSymbols GruvboxFg1
hi! link typeScriptDocSeeTag Comment
hi! link typeScriptDocParam Comment
hi! link typeScriptDocTags vimCommentTitle
hi! link typeScriptGlobalObjects GruvboxFg1
hi! link typeScriptParens GruvboxFg3
hi! link typeScriptOpSymbols GruvboxFg3
hi! link typeScriptHtmlElemProperties GruvboxFg1
hi! link typeScriptNull GruvboxPurple
hi! link typeScriptInterpolationDelimiter GruvboxAqua
hi! link purescriptModuleKeyword GruvboxAqua
hi! link purescriptModuleName GruvboxFg1
hi! link purescriptWhere GruvboxAqua
hi! link purescriptDelimiter GruvboxFg4
hi! link purescriptType GruvboxFg1
hi! link purescriptImportKeyword GruvboxAqua
hi! link purescriptHidingKeyword GruvboxAqua
hi! link purescriptAsKeyword GruvboxAqua
hi! link purescriptStructure GruvboxAqua
hi! link purescriptOperator GruvboxBlue
hi! link purescriptTypeVar GruvboxFg1
hi! link purescriptConstructor GruvboxFg1
hi! link purescriptFunction GruvboxFg1
hi! link purescriptConditional GruvboxOrange
hi! link purescriptBacktick GruvboxOrange
hi! link coffeeExtendedOp GruvboxFg3
hi! link coffeeSpecialOp GruvboxFg3
hi! link coffeeCurly GruvboxOrange
hi! link coffeeParen GruvboxFg3
hi! link coffeeBracket GruvboxOrange
hi! link rubyStringDelimiter GruvboxGreen
hi! link rubyInterpolationDelimiter GruvboxAqua
hi! link objcTypeModifier GruvboxRed
hi! link objcDirective GruvboxBlue
hi! link goDirective GruvboxAqua
hi! link goConstants GruvboxPurple
hi! link goDeclaration GruvboxRed
hi! link goDeclType GruvboxBlue
hi! link goBuiltins GruvboxOrange
hi! link luaIn GruvboxRed
hi! link luaFunction GruvboxAqua
hi! link luaTable GruvboxOrange
hi! link moonSpecialOp GruvboxFg3
hi! link moonExtendedOp GruvboxFg3
hi! link moonFunction GruvboxFg3
hi! link moonObject GruvboxYellow
hi! link javaAnnotation GruvboxBlue
hi! link javaDocTags GruvboxAqua
hi! link javaCommentTitle vimCommentTitle
hi! link javaParen GruvboxFg3
hi! link javaParen1 GruvboxFg3
hi! link javaParen2 GruvboxFg3
hi! link javaParen3 GruvboxFg3
hi! link javaParen4 GruvboxFg3
hi! link javaParen5 GruvboxFg3
hi! link javaOperator GruvboxOrange
hi! link javaVarArg GruvboxGreen
hi! link elixirDocString Comment
hi! link elixirStringDelimiter GruvboxGreen
hi! link elixirInterpolationDelimiter GruvboxAqua
hi! link elixirModuleDeclaration GruvboxYellow
hi! link scalaNameDefinition GruvboxFg1
hi! link scalaCaseFollowing GruvboxFg1
hi! link scalaCapitalWord GruvboxFg1
hi! link scalaTypeExtension GruvboxFg1
hi! link scalaKeyword GruvboxRed
hi! link scalaKeywordModifier GruvboxRed
hi! link scalaSpecial GruvboxAqua
hi! link scalaOperator GruvboxFg1
hi! link scalaTypeDeclaration GruvboxYellow
hi! link scalaTypeTypePostDeclaration GruvboxYellow
hi! link scalaInstanceDeclaration GruvboxFg1
hi! link scalaInterpolation GruvboxAqua
hi! link markdownH1 GruvboxGreenBold
hi! link markdownH2 GruvboxGreenBold
hi! link markdownH3 GruvboxYellowBold
hi! link markdownH4 GruvboxYellowBold
hi! link markdownH5 GruvboxYellow
hi! link markdownH6 GruvboxYellow
hi! link markdownCode GruvboxAqua
hi! link markdownCodeBlock GruvboxAqua
hi! link markdownCodeDelimiter GruvboxAqua
hi! link markdownBlockquote GruvboxGray
hi! link markdownListMarker GruvboxGray
hi! link markdownOrderedListMarker GruvboxGray
hi! link markdownRule GruvboxGray
hi! link markdownHeadingRule GruvboxGray
hi! link markdownUrlDelimiter GruvboxFg3
hi! link markdownLinkDelimiter GruvboxFg3
hi! link markdownLinkTextDelimiter GruvboxFg3
hi! link markdownHeadingDelimiter GruvboxOrange
hi! link markdownUrl GruvboxPurple
hi! link markdownUrlTitleDelimiter GruvboxGreen
hi! link markdownIdDeclaration markdownLinkText
hi! link haskellType GruvboxFg1
hi! link haskellIdentifier GruvboxFg1
hi! link haskellSeparator GruvboxFg1
hi! link haskellDelimiter GruvboxFg4
hi! link haskellOperators GruvboxBlue
hi! link haskellBacktick GruvboxOrange
hi! link haskellStatement GruvboxOrange
hi! link haskellConditional GruvboxOrange
hi! link haskellLet GruvboxAqua
hi! link haskellDefault GruvboxAqua
hi! link haskellWhere GruvboxAqua
hi! link haskellBottom GruvboxAqua
hi! link haskellBlockKeywords GruvboxAqua
hi! link haskellImportKeywords GruvboxAqua
hi! link haskellDeclKeyword GruvboxAqua
hi! link haskellDeriving GruvboxAqua
hi! link haskellAssocType GruvboxAqua
hi! link haskellNumber GruvboxPurple
hi! link haskellPragma GruvboxPurple
hi! link haskellString GruvboxGreen
hi! link haskellChar GruvboxGreen
hi! link jsonKeyword GruvboxGreen
hi! link jsonQuote GruvboxGreen
hi! link jsonBraces GruvboxFg1
hi! link jsonString GruvboxFg1
