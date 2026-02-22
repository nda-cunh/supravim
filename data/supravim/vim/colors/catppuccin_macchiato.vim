vim9script
# Name: catppuccin_macchiato.vim

set background=dark
hi clear

if exists('syntax on')
    syntax reset
endif

g:colors_name = 'catppuccin_macchiato'
set t_Co=256

const rosewater = "#F4DBD6"
const flamingo = "#F0C6C6"
const pink = "#F5BDE6"
const mauve = "#C6A0F6"
const red = "#ED8796"
const maroon = "#EE99A0"
const peach = "#F5A97F"
const yellow = "#EED49F"
const green = "#A6DA95"
const teal = "#8BD5CA"
const sky = "#91D7E3"
const sapphire = "#7DC4E4"
const blue = "#8AADF4"
const lavender = "#B7BDF8"

const text = "#CAD3F5"
const subtext1 = "#B8C0E0"
const subtext0 = "#A5ADCB"
const overlay2 = "#939AB7"
const overlay1 = "#8087A2"
const overlay0 = "#6E738D"
const surface2 = "#5B6078"
const surface1 = "#494D64"
const surface0 = "#363A4F"

const base = "#24273A"
const mantle = "#1E2030"
const crust = "#181926"

hi Normal guisp=NONE guifg=#CAD3F5 guibg=#24273A gui=NONE cterm=NONE
hi Visual guisp=NONE guifg=NONE guibg=#494D64 gui=bold cterm=bold
hi Conceal guisp=NONE guifg=#8087A2 guibg=NONE gui=NONE cterm=NONE
hi ColorColumn guisp=NONE guifg=NONE guibg=#363A4F gui=NONE cterm=NONE
hi Cursor guisp=NONE guifg=#24273A guibg=#F4DBD6 gui=NONE cterm=NONE
hi lCursor guisp=NONE guifg=#24273A guibg=#F4DBD6 gui=NONE cterm=NONE
hi CursorIM guisp=NONE guifg=#24273A guibg=#F4DBD6 gui=NONE cterm=NONE
hi CursorColumn guisp=NONE guifg=NONE guibg=#1E2030 gui=NONE cterm=NONE
hi CursorLine guisp=NONE guifg=NONE guibg=#363A4F gui=NONE cterm=NONE
hi Directory guisp=NONE guifg=#8AADF4 guibg=NONE gui=NONE cterm=NONE
hi DiffAdd guisp=NONE guifg=#24273A guibg=#A6DA95 gui=NONE cterm=NONE
hi DiffChange guisp=NONE guifg=#24273A guibg=#EED49F gui=NONE cterm=NONE
hi DiffDelete guisp=NONE guifg=#24273A guibg=#ED8796 gui=NONE cterm=NONE
hi DiffText guisp=NONE guifg=#24273A guibg=#8AADF4 gui=NONE cterm=NONE
hi EndOfBuffer guisp=NONE guifg=NONE guibg=NONE gui=NONE cterm=NONE
hi ErrorMsg guisp=NONE guifg=#ED8796 guibg=NONE gui=bolditalic cterm=bold,italic
hi VertSplit guisp=NONE guifg=#181926 guibg=NONE gui=NONE cterm=NONE
hi Folded guisp=NONE guifg=#8AADF4 guibg=#494D64 gui=NONE cterm=NONE
hi FoldColumn guisp=NONE guifg=#6E738D guibg=#24273A gui=NONE cterm=NONE
hi SignColumn guisp=NONE guifg=#494D64 guibg=#24273A gui=NONE cterm=NONE
hi IncSearch guisp=NONE guifg=#494D64 guibg=#F5BDE6 gui=NONE cterm=NONE
hi CursorLineNR guisp=NONE guifg=#B7BDF8 guibg=NONE gui=NONE cterm=NONE
hi LineNr guisp=NONE guifg=#494D64 guibg=NONE gui=NONE cterm=NONE
hi MatchParen guisp=NONE guifg=#F5A97F guibg=NONE gui=bold cterm=bold
hi ModeMsg guisp=NONE guifg=#CAD3F5 guibg=NONE gui=bold cterm=bold
hi MoreMsg guisp=NONE guifg=#8AADF4 guibg=NONE gui=NONE cterm=NONE
hi NonText guisp=NONE guifg=#6E738D guibg=NONE gui=NONE cterm=NONE
hi Pmenu guisp=NONE guifg=#939AB7 guibg=#363A4F gui=NONE cterm=NONE
hi PmenuSel guisp=NONE guifg=#CAD3F5 guibg=#494D64 gui=bold cterm=bold
hi PmenuSbar guisp=NONE guifg=NONE guibg=#494D64 gui=NONE cterm=NONE
hi PmenuThumb guisp=NONE guifg=NONE guibg=#6E738D gui=NONE cterm=NONE
hi Question guisp=NONE guifg=#8AADF4 guibg=NONE gui=NONE cterm=NONE
hi QuickFixLine guisp=NONE guifg=NONE guibg=#494D64 gui=bold cterm=bold
hi Search guisp=NONE guifg=#F5BDE6 guibg=#494D64 gui=bold cterm=bold
hi SpecialKey guisp=NONE guifg=#A5ADCB guibg=NONE gui=NONE cterm=NONE
hi SpellBad guisp=NONE guifg=#24273A guibg=#ED8796 gui=NONE cterm=NONE
hi SpellCap guisp=NONE guifg=#24273A guibg=#EED49F gui=NONE cterm=NONE
hi SpellLocal guisp=NONE guifg=#24273A guibg=#8AADF4 gui=NONE cterm=NONE
hi SpellRare guisp=NONE guifg=#24273A guibg=#A6DA95 gui=NONE cterm=NONE
hi StatusLine guisp=NONE guifg=#CAD3F5 guibg=#1E2030 gui=NONE cterm=NONE
hi StatusLineNC guisp=NONE guifg=#494D64 guibg=#1E2030 gui=NONE cterm=NONE
hi StatusLineTerm guisp=NONE guifg=#CAD3F5 guibg=#1E2030 gui=NONE cterm=NONE
hi StatusLineTermNC guisp=NONE guifg=#494D64 guibg=#1E2030 gui=NONE cterm=NONE
hi TabLine guisp=NONE guifg=#494D64 guibg=#1E2030 gui=NONE cterm=NONE
hi TabLineFill guisp=NONE guifg=NONE guibg=#1E2030 gui=NONE cterm=NONE
hi TabLineSel guisp=NONE guifg=#A6DA95 guibg=#494D64 gui=NONE cterm=NONE
hi Title guisp=NONE guifg=#8AADF4 guibg=NONE gui=bold cterm=bold
hi VisualNOS guisp=NONE guifg=NONE guibg=#494D64 gui=bold cterm=bold
hi WarningMsg guisp=NONE guifg=#EED49F guibg=NONE gui=NONE cterm=NONE
hi WildMenu guisp=NONE guifg=NONE guibg=#6E738D gui=NONE cterm=NONE
hi Comment guisp=NONE guifg=#6E738D guibg=NONE gui=NONE cterm=NONE
hi Constant guisp=NONE guifg=#F5A97F guibg=NONE gui=NONE cterm=NONE
hi Identifier guisp=NONE guifg=#F0C6C6 guibg=NONE gui=NONE cterm=NONE
hi Statement guisp=NONE guifg=#C6A0F6 guibg=NONE gui=NONE cterm=NONE
hi PreProc guisp=NONE guifg=#F5BDE6 guibg=NONE gui=NONE cterm=NONE
hi Type guisp=NONE guifg=#8AADF4 guibg=NONE gui=NONE cterm=NONE
hi Special guisp=NONE guifg=#F5BDE6 guibg=NONE gui=NONE cterm=NONE
hi Underlined guisp=NONE guifg=#CAD3F5 guibg=#24273A gui=underline cterm=underline
hi Error guisp=NONE guifg=#ED8796 guibg=NONE gui=NONE cterm=NONE
hi Todo guisp=NONE guifg=#24273A guibg=#F0C6C6 gui=bold cterm=bold
hi String guisp=NONE guifg=#A6DA95 guibg=NONE gui=NONE cterm=NONE
hi Character guisp=NONE guifg=#8BD5CA guibg=NONE gui=NONE cterm=NONE
hi Number guisp=NONE guifg=#F5A97F guibg=NONE gui=NONE cterm=NONE
hi Boolean guisp=NONE guifg=#F5A97F guibg=NONE gui=NONE cterm=NONE
hi Float guisp=NONE guifg=#F5A97F guibg=NONE gui=NONE cterm=NONE
hi Function guisp=NONE guifg=#8AADF4 guibg=NONE gui=NONE cterm=NONE
hi Conditional guisp=NONE guifg=#ED8796 guibg=NONE gui=NONE cterm=NONE
hi Repeat guisp=NONE guifg=#ED8796 guibg=NONE gui=NONE cterm=NONE
hi Label guisp=NONE guifg=#F5A97F guibg=NONE gui=NONE cterm=NONE
hi Operator guisp=NONE guifg=#91D7E3 guibg=NONE gui=NONE cterm=NONE
hi Keyword guisp=NONE guifg=#F5BDE6 guibg=NONE gui=NONE cterm=NONE
hi Include guisp=NONE guifg=#F5BDE6 guibg=NONE gui=NONE cterm=NONE
hi StorageClass guisp=NONE guifg=#EED49F guibg=NONE gui=NONE cterm=NONE
hi Structure guisp=NONE guifg=#EED49F guibg=NONE gui=NONE cterm=NONE
hi Typedef guisp=NONE guifg=#EED49F guibg=NONE gui=NONE cterm=NONE
hi debugPC guisp=NONE guifg=NONE guibg=#181926 gui=NONE cterm=NONE
hi debugBreakpoint guisp=NONE guifg=#6E738D guibg=#24273A gui=NONE cterm=NONE
hi PmenuMatch guisp=NONE guifg=#EED49F guibg=NONE gui=bold cterm=bold
hi PmenuKind guisp=NONE guifg=#8AADF4 guibg=NONE gui=NONE cterm=NONE


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
  \ surface1, red, green, yellow, blue, pink, teal, subtext1,
  \ surface2, red, green, yellow, blue, pink, teal, subtext0
]
