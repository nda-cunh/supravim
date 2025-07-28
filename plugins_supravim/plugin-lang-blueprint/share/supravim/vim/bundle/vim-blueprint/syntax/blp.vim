 vim9script
# Vim syntax file
# Language:            Blueprint <https://gitlab.gnome.org/jwestman/blueprint-compiler>
# Homepage:            https://gitlab.com/gabmus/vim-blueprint
# Maintainer:          Gabriele Musco <gabmus@disroot.org>
# Last Change:         Jan 10, 2022

syn case match

syntax keyword blpTodos
    \ TODO
    \ XXX
    \ FIXME
    \ NOTE
    \ WARNING

syntax keyword blpKeywords
    \ using
    \ template
    \ styles
    \ item
    \ menu
    \ submenu
    \ section

syntax match blpNumber "\v<\d+>"
syntax match blpNumber "\v<\d+\.\d+>"

syntax keyword blpBooleans 
    \ true
    \ false

syntax keyword blpConstants
    \ center
    \ right
    \ left
    \ start
    \ end
    \ vertical
    \ horizontal
    \ always
    \ never
    \ natural
    \ none
    \ word
    \ char
    \ word_char

syntax match blpOperators "\v:"

syntax match blpDelimiters "\v\{"
syntax match blpDelimiters "\v\}"
syntax match blpDelimiters "\v\["
syntax match blpDelimiters "\v\]"
syntax match blpDelimiters "\v\("
syntax match blpDelimiters "\v_\("
syntax match blpDelimiters "\v\)"

# with class meaning both modules and widget names
syntax match blpClass "\v<\u\w+>"
syntax match blpClass "\v<\u\w+\.\u\w+>"
syntax match blpClass "\v\.<\u\w+>"

syntax match blpProperty "\v<\l[a-z\-]*>:"

syntax match blpChildType "\[\v<\l[a-z\-]*>\]"

syntax match blpComment "\v\/\/.*$"
    \ contains=blpTodos
syntax region blpComment start="/\*" end="\*/"
    \ contains=blpTodos

syntax region blpString start=/"/ skip=/\\\\\|\\"/ end=/"/ oneline
syntax region blpString start=/'/ skip=/\\\\\|\\'/ end=/'/ oneline

syntax match blpSignal "\v\l[a-z\-]*\s*\=\>"
syntax match blpSignal "notify::\v\l[a-z\-]*\s*\=\>"

highlight default link blpTodos Todo
highlight default link blpProperty Identifier
highlight default link blpSignal Function
highlight default link blpKeywords Keyword
highlight default link blpNumber Number
highlight default link blpBooleans Boolean
highlight default link blpClass Type
highlight default link blpChildType Structure
highlight default link blpComment Comment
highlight default link blpOperators Operator
highlight default link blpString String
highlight default link blpDelimiters Delimiter
highlight default link blpConstants Constant
