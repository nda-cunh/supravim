vim9script

set background=dark
hi clear

if exists('syntax on')
    syntax reset
endif

g:colors_name = 'catppuccin_mocha'
set t_Co=256

const rosewater = "#F5E0DC"
const flamingo = "#F2CDCD"
const pink = "#F5C2E7"
const mauve = "#CBA6F7"
const red = "#F38BA8"
const maroon = "#EBA0AC"
const peach = "#FAB387"
const yellow = "#F9E2AF"
const green = "#A6E3A1"
const teal = "#94E2D5"
const sky = "#89DCEB"
const sapphire = "#74C7EC"
const blue = "#89B4FA"
const lavender = "#B4BEFE"

const text = "#CDD6F4"
const subtext1 = "#BAC2DE"
const subtext0 = "#A6ADC8"
const overlay2 = "#9399B2"
const overlay1 = "#7F849C"
const overlay0 = "#6C7086"
const surface2 = "#585B70"
const surface1 = "#45475A"
const surface0 = "#313244"

const base = "#1E1E2E"
const mantle = "#181825"
const crust = "#11111B"

hi Normal guisp=NONE guifg=#CDD6F4 guibg=#1E1E2E gui=NONE cterm=NONE
hi Visual guisp=NONE guifg=NONE guibg=#45475A gui=bold cterm=bold
hi Conceal guisp=NONE guifg=#7F849C guibg=NONE gui=NONE cterm=NONE
hi ColorColumn guisp=NONE guifg=NONE guibg=#313244 gui=NONE cterm=NONE
hi Cursor guisp=NONE guifg=#1E1E2E guibg=#F5E0DC gui=NONE cterm=NONE
hi lCursor guisp=NONE guifg=#1E1E2E guibg=#F5E0DC gui=NONE cterm=NONE
hi CursorIM guisp=NONE guifg=#1E1E2E guibg=#F5E0DC gui=NONE cterm=NONE
hi CursorColumn guisp=NONE guifg=NONE guibg=#181825 gui=NONE cterm=NONE
hi CursorLine guisp=NONE guifg=NONE guibg=#313244 gui=NONE cterm=NONE
hi Directory guisp=NONE guifg=#89B4FA guibg=NONE gui=NONE cterm=NONE
hi DiffAdd guisp=NONE guifg=#1E1E2E guibg=#A6E3A1 gui=NONE cterm=NONE
hi DiffChange guisp=NONE guifg=#1E1E2E guibg=#F9E2AF gui=NONE cterm=NONE
hi DiffDelete guisp=NONE guifg=#1E1E2E guibg=#F38BA8 gui=NONE cterm=NONE
hi DiffText guisp=NONE guifg=#1E1E2E guibg=#89B4FA gui=NONE cterm=NONE
hi EndOfBuffer guisp=NONE guifg=NONE guibg=NONE gui=NONE cterm=NONE
hi ErrorMsg guisp=NONE guifg=#F38BA8 guibg=NONE gui=bolditalic cterm=bold,italic
hi VertSplit guisp=NONE guifg=#11111B guibg=NONE gui=NONE cterm=NONE
hi Folded guisp=NONE guifg=#89B4FA guibg=#45475A gui=NONE cterm=NONE
hi FoldColumn guisp=NONE guifg=#6C7086 guibg=#1E1E2E gui=NONE cterm=NONE
hi SignColumn guisp=NONE guifg=#45475A guibg=#1E1E2E gui=NONE cterm=NONE
hi IncSearch guisp=NONE guifg=#45475A guibg=#F5C2E7 gui=NONE cterm=NONE
hi CursorLineNR guisp=NONE guifg=#B4BEFE guibg=NONE gui=NONE cterm=NONE
hi LineNr guisp=NONE guifg=#45475A guibg=NONE gui=NONE cterm=NONE
hi MatchParen guisp=NONE guifg=#FAB387 guibg=NONE gui=bold cterm=bold
hi ModeMsg guisp=NONE guifg=#CDD6F4 guibg=NONE gui=bold cterm=bold
hi MoreMsg guisp=NONE guifg=#89B4FA guibg=NONE gui=NONE cterm=NONE
hi NonText guisp=NONE guifg=#6C7086 guibg=NONE gui=NONE cterm=NONE
hi Pmenu guisp=NONE guifg=#9399B2 guibg=#313244 gui=NONE cterm=NONE
hi PmenuSel guisp=NONE guifg=#CDD6F4 guibg=#45475A gui=bold cterm=bold
hi PmenuSbar guisp=NONE guifg=NONE guibg=#45475A gui=NONE cterm=NONE
hi PmenuThumb guisp=NONE guifg=NONE guibg=#6C7086 gui=NONE cterm=NONE
hi Question guisp=NONE guifg=#89B4FA guibg=NONE gui=NONE cterm=NONE
hi QuickFixLine guisp=NONE guifg=NONE guibg=#45475A gui=bold cterm=bold
hi Search guisp=NONE guifg=#F5C2E7 guibg=#45475A gui=bold cterm=bold
hi SpecialKey guisp=NONE guifg=#A6ADC8 guibg=NONE gui=NONE cterm=NONE
hi SpellBad guisp=NONE guifg=#1E1E2E guibg=#F38BA8 gui=NONE cterm=NONE
hi SpellCap guisp=NONE guifg=#1E1E2E guibg=#F9E2AF gui=NONE cterm=NONE
hi SpellLocal guisp=NONE guifg=#1E1E2E guibg=#89B4FA gui=NONE cterm=NONE
hi SpellRare guisp=NONE guifg=#1E1E2E guibg=#A6E3A1 gui=NONE cterm=NONE
hi StatusLine guisp=NONE guifg=#CDD6F4 guibg=#181825 gui=NONE cterm=NONE
hi StatusLineNC guisp=NONE guifg=#45475A guibg=#181825 gui=NONE cterm=NONE
hi StatusLineTerm guisp=NONE guifg=#CDD6F4 guibg=#181825 gui=NONE cterm=NONE
hi StatusLineTermNC guisp=NONE guifg=#45475A guibg=#181825 gui=NONE cterm=NONE
hi TabLine guisp=NONE guifg=#45475A guibg=#181825 gui=NONE cterm=NONE
hi TabLineFill guisp=NONE guifg=NONE guibg=#181825 gui=NONE cterm=NONE
hi TabLineSel guisp=NONE guifg=#A6E3A1 guibg=#45475A gui=NONE cterm=NONE
hi Title guisp=NONE guifg=#89B4FA guibg=NONE gui=bold cterm=bold
hi VisualNOS guisp=NONE guifg=NONE guibg=#45475A gui=bold cterm=bold
hi WarningMsg guisp=NONE guifg=#F9E2AF guibg=NONE gui=NONE cterm=NONE
hi WildMenu guisp=NONE guifg=NONE guibg=#6C7086 gui=NONE cterm=NONE
hi Comment guisp=NONE guifg=#6C7086 guibg=NONE gui=NONE cterm=NONE
hi Constant guisp=NONE guifg=#FAB387 guibg=NONE gui=NONE cterm=NONE
hi Identifier guisp=NONE guifg=#F2CDCD guibg=NONE gui=NONE cterm=NONE
hi Statement guisp=NONE guifg=#CBA6F7 guibg=NONE gui=NONE cterm=NONE
hi PreProc guisp=NONE guifg=#F5C2E7 guibg=NONE gui=NONE cterm=NONE
hi Type guisp=NONE guifg=#89B4FA guibg=NONE gui=NONE cterm=NONE
hi Special guisp=NONE guifg=#F5C2E7 guibg=NONE gui=NONE cterm=NONE
hi Underlined guisp=NONE guifg=#CDD6F4 guibg=#1E1E2E gui=underline cterm=underline
hi Error guisp=NONE guifg=#F38BA8 guibg=NONE gui=NONE cterm=NONE
hi Todo guisp=NONE guifg=#1E1E2E guibg=#F2CDCD gui=bold cterm=bold
hi String guisp=NONE guifg=#A6E3A1 guibg=NONE gui=NONE cterm=NONE
hi Character guisp=NONE guifg=#94E2D5 guibg=NONE gui=NONE cterm=NONE
hi Number guisp=NONE guifg=#FAB387 guibg=NONE gui=NONE cterm=NONE
hi Boolean guisp=NONE guifg=#FAB387 guibg=NONE gui=NONE cterm=NONE
hi Float guisp=NONE guifg=#FAB387 guibg=NONE gui=NONE cterm=NONE
hi Function guisp=NONE guifg=#89B4FA guibg=NONE gui=NONE cterm=NONE
hi Conditional guisp=NONE guifg=#F38BA8 guibg=NONE gui=NONE cterm=NONE
hi Repeat guisp=NONE guifg=#F38BA8 guibg=NONE gui=NONE cterm=NONE
hi Label guisp=NONE guifg=#FAB387 guibg=NONE gui=NONE cterm=NONE
hi Operator guisp=NONE guifg=#89DCEB guibg=NONE gui=NONE cterm=NONE
hi Keyword guisp=NONE guifg=#F5C2E7 guibg=NONE gui=NONE cterm=NONE
hi Include guisp=NONE guifg=#F5C2E7 guibg=NONE gui=NONE cterm=NONE
hi StorageClass guisp=NONE guifg=#F9E2AF guibg=NONE gui=NONE cterm=NONE
hi Structure guisp=NONE guifg=#F9E2AF guibg=NONE gui=NONE cterm=NONE
hi Typedef guisp=NONE guifg=#F9E2AF guibg=NONE gui=NONE cterm=NONE
hi debugPC guisp=NONE guifg=NONE guibg=#11111B gui=NONE cterm=NONE
hi debugBreakpoint guisp=NONE guifg=#6C7086 guibg=#1E1E2E gui=NONE cterm=NONE
hi PmenuMatch guisp=NONE guifg=#F9E2AF guibg=NONE gui=bold cterm=bold
hi PmenuKind guisp=NONE guifg=#89B4FA guibg=NONE gui=NONE cterm=NONE

hi link Define PreProc
hi link Macro PreProc
hi link PreCondit PreProc
hi link SpecialChar Special
hi link Tag Special
hi link Delimiter Special
hi link SpecialComment Special
hi link Debug Special
hi link Exception Error
hi link StatusLineTerm StatusLine
hi link StatusLineTermNC StatusLineNC
hi link Terminal Normal
hi link Ignore Comment

g:terminal_ansi_colors = [
  \ surface1, red, green, yellow, blue, pink, teal, subtext1,
  \ surface2, red, green, yellow, blue, pink, teal, subtext0
]
