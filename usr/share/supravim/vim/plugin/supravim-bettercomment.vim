vim9script

def HighlightComments()

	syntax match QuestionComment "// [?] .*$" containedin=Comment
	syntax match WarningSimpleComment "// [!] .*$" containedin=Comment
	syntax match WarningComment "// WARN.*$" containedin=Comment
	syntax match InfoComment "// \* .*$" containedin=Comment
	syntax match NoteComment "// NOTE.*$" containedin=Comment
	syntax match FixComment "// FIX.*$" containedin=Comment
	syntax match TodoComment "// TODO.*$" containedin=Comment

	highlight InfoComment guifg=#98c379
	highlight QuestionComment guifg=#e06c75
	highlight TodoComment guifg=#c678dd
	highlight WarningSimpleComment guifg=#e5c07b
	highlight WarningComment guifg=#e5c07b cterm=bold
	highlight NoteComment guifg=#98c379 cterm=bold
	highlight FixComment guifg=#e06c75 cterm=bold

enddef

autocmd BufReadPost,BufNewFile *.c,*.cpp,*.js,*.vala,*.ts,*.rs call HighlightComments()
