vim9script

def HighlightComments()

	syntax match Identifier "// [?] .*$" containedin=Comment
	syntax match WarningMsg "// [!] .*$" containedin=Comment
	syntax match WarningMsg "// WARN.*$" containedin=Comment
	syntax match InfoComment "// \* .*$" containedin=Comment

	highlight InfoComment guifg=#645bb4
	highlight ErrorComment guifg=#ff0000 cterm=bold

enddef

autocmd BufReadPost,BufNewFile *.c,*.cpp,*.js,*.vala,*.ts,*.rs call HighlightComments()
