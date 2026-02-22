vim9script
# Name: catppuccin_frappe.vim

set background=dark
hi clear

if exists('syntax on')
    syntax reset
endif

g:colors_name = 'catppuccin_frappe'
set t_Co=256

const rosewater = "#F2D5CF"
const flamingo = "#EEBEBE"
const pink = "#F4B8E4"
const mauve = "#CA9EE6"
const red = "#E78284"
const maroon = "#EA999C"
const peach = "#EF9F76"
const yellow = "#E5C890"
const green = "#A6D189"
const teal = "#81C8BE"
const sky = "#99D1DB"
const sapphire = "#85C1DC"
const blue = "#8CAAEE"
const lavender = "#BABBF1"

const text = "#C6D0F5"
const subtext1 = "#B5BFE2"
const subtext0 = "#A5ADCE"
const overlay2 = "#949CBB"
const overlay1 = "#838BA7"
const overlay0 = "#737994"
const surface2 = "#626880"
const surface1 = "#51576D"
const surface0 = "#414559"

const base = "#303446"
const mantle = "#292C3C"
const crust = "#232634"

hi Normal guisp=NONE guifg=#C6D0F5 guibg=#303446 gui=NONE cterm=NONE
hi Visual guisp=NONE guifg=NONE guibg=#51576D gui=bold cterm=bold
hi Conceal guisp=NONE guifg=#838BA7 guibg=NONE gui=NONE cterm=NONE
hi ColorColumn guisp=NONE guifg=NONE guibg=#414559 gui=NONE cterm=NONE
hi Cursor guisp=NONE guifg=#303446 guibg=#F2D5CF gui=NONE cterm=NONE
hi lCursor guisp=NONE guifg=#303446 guibg=#F2D5CF gui=NONE cterm=NONE
hi CursorIM guisp=NONE guifg=#303446 guibg=#F2D5CF gui=NONE cterm=NONE
hi CursorColumn guisp=NONE guifg=NONE guibg=#292C3C gui=NONE cterm=NONE
hi CursorLine guisp=NONE guifg=NONE guibg=#414559 gui=NONE cterm=NONE
hi Directory guisp=NONE guifg=#8CAAEE guibg=NONE gui=NONE cterm=NONE
hi DiffAdd guisp=NONE guifg=#303446 guibg=#A6D189 gui=NONE cterm=NONE
hi DiffChange guisp=NONE guifg=#303446 guibg=#E5C890 gui=NONE cterm=NONE
hi DiffDelete guisp=NONE guifg=#303446 guibg=#E78284 gui=NONE cterm=NONE
hi DiffText guisp=NONE guifg=#303446 guibg=#8CAAEE gui=NONE cterm=NONE
hi EndOfBuffer guisp=NONE guifg=NONE guibg=NONE gui=NONE cterm=NONE
hi ErrorMsg guisp=NONE guifg=#E78284 guibg=NONE gui=bolditalic cterm=bold,italic
hi VertSplit guisp=NONE guifg=#232634 guibg=NONE gui=NONE cterm=NONE
hi Folded guisp=NONE guifg=#8CAAEE guibg=#51576D gui=NONE cterm=NONE
hi FoldColumn guisp=NONE guifg=#737994 guibg=#303446 gui=NONE cterm=NONE
hi SignColumn guisp=NONE guifg=#51576D guibg=#303446 gui=NONE cterm=NONE
hi IncSearch guisp=NONE guifg=#51576D guibg=#F4B8E4 gui=NONE cterm=NONE
hi CursorLineNR guisp=NONE guifg=#BABBF1 guibg=NONE gui=NONE cterm=NONE
hi LineNr guisp=NONE guifg=#51576D guibg=NONE gui=NONE cterm=NONE
hi MatchParen guisp=NONE guifg=#EF9F76 guibg=NONE gui=bold cterm=bold
hi ModeMsg guisp=NONE guifg=#C6D0F5 guibg=NONE gui=bold cterm=bold
hi MoreMsg guisp=NONE guifg=#8CAAEE guibg=NONE gui=NONE cterm=NONE
hi NonText guisp=NONE guifg=#737994 guibg=NONE gui=NONE cterm=NONE
hi Pmenu guisp=NONE guifg=#949CBB guibg=#414559 gui=NONE cterm=NONE
hi PmenuSel guisp=NONE guifg=#C6D0F5 guibg=#51576D gui=bold cterm=bold
hi PmenuSbar guisp=NONE guifg=NONE guibg=#51576D gui=NONE cterm=NONE
hi PmenuThumb guisp=NONE guifg=NONE guibg=#737994 gui=NONE cterm=NONE
hi Question guisp=NONE guifg=#8CAAEE guibg=NONE gui=NONE cterm=NONE
hi QuickFixLine guisp=NONE guifg=NONE guibg=#51576D gui=bold cterm=bold
hi Search guisp=NONE guifg=#F4B8E4 guibg=#51576D gui=bold cterm=bold
hi SpecialKey guisp=NONE guifg=#A5ADCE guibg=NONE gui=NONE cterm=NONE
hi SpellBad guisp=NONE guifg=#303446 guibg=#E78284 gui=NONE cterm=NONE
hi SpellCap guisp=NONE guifg=#303446 guibg=#E5C890 gui=NONE cterm=NONE
hi SpellLocal guisp=NONE guifg=#303446 guibg=#8CAAEE gui=NONE cterm=NONE
hi SpellRare guisp=NONE guifg=#303446 guibg=#A6D189 gui=NONE cterm=NONE
hi StatusLine guisp=NONE guifg=#C6D0F5 guibg=#292C3C gui=NONE cterm=NONE
hi StatusLineNC guisp=NONE guifg=#51576D guibg=#292C3C gui=NONE cterm=NONE
hi StatusLineTerm guisp=NONE guifg=#C6D0F5 guibg=#292C3C gui=NONE cterm=NONE
hi StatusLineTermNC guisp=NONE guifg=#51576D guibg=#292C3C gui=NONE cterm=NONE
hi TabLine guisp=NONE guifg=#51576D guibg=#292C3C gui=NONE cterm=NONE
hi TabLineFill guisp=NONE guifg=NONE guibg=#292C3C gui=NONE cterm=NONE
hi TabLineSel guisp=NONE guifg=#A6D189 guibg=#51576D gui=NONE cterm=NONE
hi Title guisp=NONE guifg=#8CAAEE guibg=NONE gui=bold cterm=bold
hi VisualNOS guisp=NONE guifg=NONE guibg=#51576D gui=bold cterm=bold
hi WarningMsg guisp=NONE guifg=#E5C890 guibg=NONE gui=NONE cterm=NONE
hi WildMenu guisp=NONE guifg=NONE guibg=#737994 gui=NONE cterm=NONE
hi Comment guisp=NONE guifg=#737994 guibg=NONE gui=NONE cterm=NONE
hi Constant guisp=NONE guifg=#EF9F76 guibg=NONE gui=NONE cterm=NONE
hi Identifier guisp=NONE guifg=#EEBEBE guibg=NONE gui=NONE cterm=NONE
hi Statement guisp=NONE guifg=#CA9EE6 guibg=NONE gui=NONE cterm=NONE
hi PreProc guisp=NONE guifg=#F4B8E4 guibg=NONE gui=NONE cterm=NONE
hi Type guisp=NONE guifg=#8CAAEE guibg=NONE gui=NONE cterm=NONE
hi Special guisp=NONE guifg=#F4B8E4 guibg=NONE gui=NONE cterm=NONE
hi Underlined guisp=NONE guifg=#C6D0F5 guibg=#303446 gui=underline cterm=underline
hi Error guisp=NONE guifg=#E78284 guibg=NONE gui=NONE cterm=NONE
hi Todo guisp=NONE guifg=#303446 guibg=#EEBEBE gui=bold cterm=bold
hi String guisp=NONE guifg=#A6D189 guibg=NONE gui=NONE cterm=NONE
hi Character guisp=NONE guifg=#81C8BE guibg=NONE gui=NONE cterm=NONE
hi Number guisp=NONE guifg=#EF9F76 guibg=NONE gui=NONE cterm=NONE
hi Boolean guisp=NONE guifg=#EF9F76 guibg=NONE gui=NONE cterm=NONE
hi Float guisp=NONE guifg=#EF9F76 guibg=NONE gui=NONE cterm=NONE
hi Function guisp=NONE guifg=#8CAAEE guibg=NONE gui=NONE cterm=NONE
hi Conditional guisp=NONE guifg=#E78284 guibg=NONE gui=NONE cterm=NONE
hi Repeat guisp=NONE guifg=#E78284 guibg=NONE gui=NONE cterm=NONE
hi Label guisp=NONE guifg=#EF9F76 guibg=NONE gui=NONE cterm=NONE
hi Operator guisp=NONE guifg=#99D1DB guibg=NONE gui=NONE cterm=NONE
hi Keyword guisp=NONE guifg=#F4B8E4 guibg=NONE gui=NONE cterm=NONE
hi Include guisp=NONE guifg=#F4B8E4 guibg=NONE gui=NONE cterm=NONE
hi StorageClass guisp=NONE guifg=#E5C890 guibg=NONE gui=NONE cterm=NONE
hi Structure guisp=NONE guifg=#E5C890 guibg=NONE gui=NONE cterm=NONE
hi Typedef guisp=NONE guifg=#E5C890 guibg=NONE gui=NONE cterm=NONE
hi debugPC guisp=NONE guifg=NONE guibg=#232634 gui=NONE cterm=NONE
hi debugBreakpoint guisp=NONE guifg=#737994 guibg=#303446 gui=NONE cterm=NONE
hi PmenuMatch guisp=NONE guifg=#E5C890 guibg=NONE gui=bold cterm=bold
hi PmenuKind guisp=NONE guifg=#8CAAEE guibg=NONE gui=NONE cterm=NONE

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
