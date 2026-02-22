vim9script
# Name: catppuccin_latte.vim

set background=dark
hi clear

if exists('syntax on')
    syntax reset
endif

g:colors_name = 'catppuccin_latte'
set t_Co=256

const rosewater = "#DC8A78"
const flamingo = "#DD7878"
const pink = "#EA76CB"
const mauve = "#8839EF"
const red = "#D20F39"
const maroon = "#E64553"
const peach = "#FE640B"
const yellow = "#DF8E1D"
const green = "#40A02B"
const teal = "#179299"
const sky = "#04A5E5"
const sapphire = "#209FB5"
const blue = "#1E66F5"
const lavender = "#7287FD"

const text = "#4C4F69"
const subtext1 = "#5C5F77"
const subtext0 = "#6C6F85"
const overlay2 = "#7C7F93"
const overlay1 = "#8C8FA1"
const overlay0 = "#9CA0B0"
const surface2 = "#ACB0BE"
const surface1 = "#BCC0CC"
const surface0 = "#CCD0DA"

const base = "#EFF1F5"
const mantle = "#E6E9EF"
const crust = "#DCE0E8"

hi Normal guisp=NONE guifg=#4C4F69 guibg=#EFF1F5 gui=NONE cterm=NONE
hi Visual guisp=NONE guifg=NONE guibg=#BCC0CC gui=bold cterm=bold
hi Conceal guisp=NONE guifg=#8C8FA1 guibg=NONE gui=NONE cterm=NONE
hi ColorColumn guisp=NONE guifg=NONE guibg=#CCD0DA gui=NONE cterm=NONE
hi Cursor guisp=NONE guifg=#EFF1F5 guibg=#DC8A78 gui=NONE cterm=NONE
hi lCursor guisp=NONE guifg=#EFF1F5 guibg=#DC8A78 gui=NONE cterm=NONE
hi CursorIM guisp=NONE guifg=#EFF1F5 guibg=#DC8A78 gui=NONE cterm=NONE
hi CursorColumn guisp=NONE guifg=NONE guibg=#E6E9EF gui=NONE cterm=NONE
hi CursorLine guisp=NONE guifg=NONE guibg=#CCD0DA gui=NONE cterm=NONE
hi Directory guisp=NONE guifg=#1E66F5 guibg=NONE gui=NONE cterm=NONE
hi DiffAdd guisp=NONE guifg=#EFF1F5 guibg=#40A02B gui=NONE cterm=NONE
hi DiffChange guisp=NONE guifg=#EFF1F5 guibg=#DF8E1D gui=NONE cterm=NONE
hi DiffDelete guisp=NONE guifg=#EFF1F5 guibg=#D20F39 gui=NONE cterm=NONE
hi DiffText guisp=NONE guifg=#EFF1F5 guibg=#1E66F5 gui=NONE cterm=NONE
hi EndOfBuffer guisp=NONE guifg=NONE guibg=NONE gui=NONE cterm=NONE
hi ErrorMsg guisp=NONE guifg=#D20F39 guibg=NONE gui=bolditalic cterm=bold,italic
hi VertSplit guisp=NONE guifg=#DCE0E8 guibg=NONE gui=NONE cterm=NONE
hi Folded guisp=NONE guifg=#1E66F5 guibg=#BCC0CC gui=NONE cterm=NONE
hi FoldColumn guisp=NONE guifg=#9CA0B0 guibg=#EFF1F5 gui=NONE cterm=NONE
hi SignColumn guisp=NONE guifg=#BCC0CC guibg=#EFF1F5 gui=NONE cterm=NONE
hi IncSearch guisp=NONE guifg=#BCC0CC guibg=#EA76CB gui=NONE cterm=NONE
hi CursorLineNR guisp=NONE guifg=#7287FD guibg=NONE gui=NONE cterm=NONE
hi LineNr guisp=NONE guifg=#BCC0CC guibg=NONE gui=NONE cterm=NONE
hi MatchParen guisp=NONE guifg=#FE640B guibg=NONE gui=bold cterm=bold
hi ModeMsg guisp=NONE guifg=#4C4F69 guibg=NONE gui=bold cterm=bold
hi MoreMsg guisp=NONE guifg=#1E66F5 guibg=NONE gui=NONE cterm=NONE
hi NonText guisp=NONE guifg=#9CA0B0 guibg=NONE gui=NONE cterm=NONE
hi Pmenu guisp=NONE guifg=#7C7F93 guibg=#CCD0DA gui=NONE cterm=NONE
hi PmenuSel guisp=NONE guifg=#4C4F69 guibg=#BCC0CC gui=bold cterm=bold
hi PmenuSbar guisp=NONE guifg=NONE guibg=#BCC0CC gui=NONE cterm=NONE
hi PmenuThumb guisp=NONE guifg=NONE guibg=#9CA0B0 gui=NONE cterm=NONE
hi Question guisp=NONE guifg=#1E66F5 guibg=NONE gui=NONE cterm=NONE
hi QuickFixLine guisp=NONE guifg=NONE guibg=#BCC0CC gui=bold cterm=bold
hi Search guisp=NONE guifg=#EA76CB guibg=#BCC0CC gui=bold cterm=bold
hi SpecialKey guisp=NONE guifg=#6C6F85 guibg=NONE gui=NONE cterm=NONE
hi SpellBad guisp=NONE guifg=#EFF1F5 guibg=#D20F39 gui=NONE cterm=NONE
hi SpellCap guisp=NONE guifg=#EFF1F5 guibg=#DF8E1D gui=NONE cterm=NONE
hi SpellLocal guisp=NONE guifg=#EFF1F5 guibg=#1E66F5 gui=NONE cterm=NONE
hi SpellRare guisp=NONE guifg=#EFF1F5 guibg=#40A02B gui=NONE cterm=NONE
hi StatusLine guisp=NONE guifg=#4C4F69 guibg=#E6E9EF gui=NONE cterm=NONE
hi StatusLineNC guisp=NONE guifg=#BCC0CC guibg=#E6E9EF gui=NONE cterm=NONE
hi StatusLineTerm guisp=NONE guifg=#4C4F69 guibg=#E6E9EF gui=NONE cterm=NONE
hi StatusLineTermNC guisp=NONE guifg=#BCC0CC guibg=#E6E9EF gui=NONE cterm=NONE
hi TabLine guisp=NONE guifg=#BCC0CC guibg=#E6E9EF gui=NONE cterm=NONE
hi TabLineFill guisp=NONE guifg=NONE guibg=#E6E9EF gui=NONE cterm=NONE
hi TabLineSel guisp=NONE guifg=#40A02B guibg=#BCC0CC gui=NONE cterm=NONE
hi Title guisp=NONE guifg=#1E66F5 guibg=NONE gui=bold cterm=bold
hi VisualNOS guisp=NONE guifg=NONE guibg=#BCC0CC gui=bold cterm=bold
hi WarningMsg guisp=NONE guifg=#DF8E1D guibg=NONE gui=NONE cterm=NONE
hi WildMenu guisp=NONE guifg=NONE guibg=#9CA0B0 gui=NONE cterm=NONE
hi Comment guisp=NONE guifg=#9CA0B0 guibg=NONE gui=NONE cterm=NONE
hi Constant guisp=NONE guifg=#FE640B guibg=NONE gui=NONE cterm=NONE
hi Identifier guisp=NONE guifg=#DD7878 guibg=NONE gui=NONE cterm=NONE
hi Statement guisp=NONE guifg=#8839EF guibg=NONE gui=NONE cterm=NONE
hi PreProc guisp=NONE guifg=#EA76CB guibg=NONE gui=NONE cterm=NONE
hi Type guisp=NONE guifg=#1E66F5 guibg=NONE gui=NONE cterm=NONE
hi Special guisp=NONE guifg=#EA76CB guibg=NONE gui=NONE cterm=NONE
hi Underlined guisp=NONE guifg=#4C4F69 guibg=#EFF1F5 gui=underline cterm=underline
hi Error guisp=NONE guifg=#D20F39 guibg=NONE gui=NONE cterm=NONE
hi Todo guisp=NONE guifg=#EFF1F5 guibg=#DD7878 gui=bold cterm=bold
hi String guisp=NONE guifg=#40A02B guibg=NONE gui=NONE cterm=NONE
hi Character guisp=NONE guifg=#179299 guibg=NONE gui=NONE cterm=NONE
hi Number guisp=NONE guifg=#FE640B guibg=NONE gui=NONE cterm=NONE
hi Boolean guisp=NONE guifg=#FE640B guibg=NONE gui=NONE cterm=NONE
hi Float guisp=NONE guifg=#FE640B guibg=NONE gui=NONE cterm=NONE
hi Function guisp=NONE guifg=#1E66F5 guibg=NONE gui=NONE cterm=NONE
hi Conditional guisp=NONE guifg=#D20F39 guibg=NONE gui=NONE cterm=NONE
hi Repeat guisp=NONE guifg=#D20F39 guibg=NONE gui=NONE cterm=NONE
hi Label guisp=NONE guifg=#FE640B guibg=NONE gui=NONE cterm=NONE
hi Operator guisp=NONE guifg=#04A5E5 guibg=NONE gui=NONE cterm=NONE
hi Keyword guisp=NONE guifg=#EA76CB guibg=NONE gui=NONE cterm=NONE
hi Include guisp=NONE guifg=#EA76CB guibg=NONE gui=NONE cterm=NONE
hi StorageClass guisp=NONE guifg=#DF8E1D guibg=NONE gui=NONE cterm=NONE
hi Structure guisp=NONE guifg=#DF8E1D guibg=NONE gui=NONE cterm=NONE
hi Typedef guisp=NONE guifg=#DF8E1D guibg=NONE gui=NONE cterm=NONE
hi debugPC guisp=NONE guifg=NONE guibg=#DCE0E8 gui=NONE cterm=NONE
hi debugBreakpoint guisp=NONE guifg=#9CA0B0 guibg=#EFF1F5 gui=NONE cterm=NONE
hi PmenuMatch guisp=NONE guifg=#DF8E1D guibg=NONE gui=bold cterm=bold
hi PmenuKind guisp=NONE guifg=#1E66F5 guibg=NONE gui=NONE cterm=NONE

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

# Set terminal colors for playing well with plugins like fzf
g:terminal_ansi_colors = [
  \ subtext1, red, green, yellow, blue, pink, teal, surface2,
  \ subtext0, red, green, yellow, blue, pink, teal, surface1
]
