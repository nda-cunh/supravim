vim9script

def HighlightComments()

	syntax clear cTodo

	syntax match NoteComment "\v(\/*|[*]|\s*)\s*NOTE.*$" contained contained containedin=cComment,cCommentL,cMulti
	syntax match WarningComment "\v(\/*|[*]|\s*)\s*WARN.*$" contained containedin=cComment,cCommentL,cMulti
	syntax match FixComment "\v(\/*|[*]|\s*)\s*FIX.*$" contained containedin=cComment,cCommentL,cMulti
	syntax match TodoComment "\v(\/*|[*]|\s*)\s*TODO.*$" contained containedin=cComment,cCommentL,cMulti
	syntax match HackComment "\v(\/*|[*]|\s*)\s*HACK.*$" contained containedin=cComment,cCommentL,cMulti
	syntax match PerfComment "\v(\/*|[*]|\s*)\s*PERF.*$" contained containedin=cComment,cCommentL,cMulti

	highlight QuestionComment guifg=#e06c75
	highlight WarningSimpleComment guifg=#e5c07b
	
	highlight PerfComment guifg=#61afef
	highlight HackComment guifg=#ee6666
	highlight TodoComment guifg=#c678dd
	highlight WarningComment guifg=#e5c07b
	highlight NoteComment guifg=#98c379
	highlight FixComment guifg=#e06c75

	syntax match PerfCommentText "PERF" contained contained containedin=PerfComment
	highlight PerfCommentText guifg=#61afef cterm=bold
	syntax match HackCommentText "HACK\S*" contained containedin=HackComment
	highlight HackCommentText guifg=#ee6666 cterm=bold
	syntax match TodoCommentText "TODO" contained containedin=TodoComment
	highlight TodoCommentText guifg=#c678dd cterm=bold
	syntax match WarningCommentText "WARN\S*" contained containedin=WarningComment
	highlight WarningCommentText guifg=#e5c07b cterm=bold
	syntax match NoteCommentText "NOTE" contained containedin=NoteComment
	highlight NoteCommentText guifg=#98c379 cterm=bold
	syntax match FixCommentText "FIX\S*" contained containedin=FixComment
	highlight FixCommentText guifg=#e06c75 cterm=bold

enddef

autocmd BufReadPost,BufNewFile *.h,*.hpp,*.c,*.cpp,*.js,*.vala,*.ts,*.rs call HighlightComments()
