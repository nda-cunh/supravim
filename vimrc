"**** SUPRAVIM ****"
set nocompatible
filetype off

call pathogen#infect()
call pathogen#helptags()

filetype plugin indent on
"--------------- jeu de couleur ---------------"
colorscheme onedark
set background=dark
set t_Co=256
" 1: gruvbox
" 2: molokai
" 3: dracula
" 4: atom
" 5: iceberg
" 6: onedark
" 7: onehalf
" 8: onelight

"-------------- Save Undo  ------------"
if !isdirectory($HOME."/.vim")
	call mkdir($HOME."/.vim", "", 0770)
endif
if !isdirectory($HOME."/.vim/undo-dir")
	call mkdir($HOME."/.vim/undo-dir", "", 0700)
endif
set undodir=~/.vim/undo-dir
set undofile

" -------------  DBG integration  --------------"

packadd! termdebug
let g:termdebug_wide=1

"-------------- Auto Pairs ---------------------"
" let g:AutoPairsFlyMode 			= 0
" let g:AutoPairsMapCR 			= 0
" let g:AutoPairsWildClosedPair 	= ''
" let g:AutoPairsMultilineClose 	= 0
imap <silent><CR>				<CR><Plug>AutoPairsReturn
" *autopairs* let g:AutoPairs = {}

"--------------- Onglets ---------------------"
noremap <c-n>	<esc>:tabnew 
noremap <C-Right>				:tabnext<CR>
noremap <C-Left>				:tabprevious<CR>
inoremap <C-Right>				<esc>:tabnext<CR>
inoremap <C-Left>				<esc>:tabprevious<CR>
noremap <C-l>				:tabnext<CR>
noremap <C-h>				:tabprevious<CR>
inoremap <C-l>				<esc>:tabnext<CR>
inoremap <C-h>				<esc>:tabprevious<CR>

"--------------- Les racourcis ---------------"
noremap <C-Up>			<Esc>g<C-}>
noremap <C-Down>		<Esc><C-T>
inoremap <C-Up>			<Esc>g<C-}>
inoremap <C-Down>		<Esc><C-T>
noremap <C-k>			<Esc>g<C-}>
noremap <C-j>			<Esc><C-T>
inoremap <C-k>			<Esc>g<C-}>
inoremap <C-j>			<Esc><C-T>

inoremap <c-q>				<esc>:q!<CR>:NERDTreeRefreshRoot<CR>
inoremap <c-s>				<esc>:w!<CR>:NERDTreeRefreshRoot<CR>
noremap <c-q>				<esc>:q!<CR>:NERDTreeRefreshRoot<CR>
noremap <c-s>				<esc>:w!<CR>:NERDTreeRefreshRoot<CR>
map <C-F5> 					:Termdebug<CR>
map <F5> 					:call CompileRun()<CR>
imap <F5>				 	<Esc>:call CompileRun()<CR>
map <F6> 					:call CompileRun2()<CR>
imap <F6>				 	<Esc>:call CompileRun2()<CR>
noremap <C-d>				:vs 
noremap <S-d>				:split 
noremap <F3>				<Esc>:call Norminette()<CR>
noremap <S-Right>			<C-w><Right>
noremap <S-Left>			<C-w><Left>
noremap <S-Up>				<C-w><Up>
noremap <S-Down>			<C-w><Down>

noremap <S-l>				<C-w><Right>
noremap <S-h>				<C-w><Left>
noremap <S-k>				<C-w><Up>
noremap <S-j>				<C-w><Down>
inoremap <TAB>				<TAB>
imap <C-g>					<esc>:NERDTreeTabsToggle<CR>
map <C-g>					:NERDTreeTabsToggle<CR>
map <S-T> <Esc>:term ++rows=15<CR>

"---------------      Terminal        ---------------"
tnoremap <C-q> q<CR>
tnoremap <F3> clear -x ; norminette<CR>
tnoremap <F5> clear -x; if [ -f Makefile ] \|\| [ -f ../Makefile ]; then [ -f Makefile ] && make all && make run; [ -f ../Makefile ] && make all -C ../ && make run -C ../; else gcc *.c; ./a.out; fi; <CR>
"*cflags* tnoremap <F5> clear -x; if [ -f Makefile ] \|\| [ -f ../Makefile ]; then [ -f Makefile ] && make all && make run; [ -f ../Makefile ] && make all -C ../ && make run -C ../; else gcc -Wall -Wextra -Werror *.c; ./a.out; fi; <CR>
tnoremap <F6> clear -x; if [ -f Makefile ] \|\| [ -f ../Makefile ]; then [ -f Makefile ] && make all && make run2; [ -f ../Makefile ] && make all -C ../ && make run2 -C ../; else gcc *.c; ./a.out; fi; <CR>
"*cflags* tnoremap <F6> clear -x; if [ -f Makefile ] \|\| [ -f ../Makefile ]; then [ -f Makefile ] && make all && make run2; [ -f ../Makefile ] && make all -C ../ && make run2 -C ../; else gcc -Wall -Wextra -Werror *.c; ./a.out; fi; <CR>

" tnoremap <F4> <C-W>N<CR><S-UP>
tnoremap <S-Right>		<C-W>N<C-w><Right>
tnoremap <S-Left>		<C-W>N<C-w><Left>
tnoremap <S-Up>			<C-W>N<C-w><Up>
tnoremap <S-Down>		<C-W>N<C-w><Down>

tnoremap <S-l>			<C-W>N<C-w><Right>
tnoremap <S-h>			<C-W>N<C-w><Left>
tnoremap <S-k>			<C-W>N<C-w><Up>
tnoremap <S-l>			<C-W>N<C-w><Down>

tnoremap <C-l>			<C-W>N<esc>:tabnext<CR>
tnoremap <C-h>			<C-W>N<esc>:tabprevious<CR>

"--------------- utilitaires basiques ---------------"
syntax on
set mouse=a
set cursorline
set nu
set tabstop=4
set shiftwidth=4
set smartindent
set autoindent
set shiftround
set showmode
set backspace=indent,eol,start
set pumheight=50
set encoding=utf-8
set splitbelow
set splitright
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
let g:UltiSnipsExpandTrigger="<Tab>"

"---------- Qui utilise la scrollbar -----------"
set guioptions-=r
set guioptions-=R
set guioptions-=l
set guioptions-=L

"------------------ Snipets --------------------"
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<S-tab>"

"--------------- CLANG COMPLETER ---------------"
set noinfercase
set completeopt-=preview
set completeopt+=menuone,noselect
let g:clang_library_path='/usr/lib/llvm-12/lib/libclang.so.1'
let g:clang_complete_auto = 1
let g:mucomplete#enable_auto_at_startup = 1

"--------------- SYNTASTIC ---------------"
let current_compiler = "gcc"
let g:rainbow_active = 1

let g:syntastic_cpp_compiler = 'gcc'
let g:syntastic_cpp_compiler_options = ' -std=c++11 -stdlib=libc++ -Wall -Werror -Wextra'
let g:syntastic_check_on_open=1
let g:syntastic_enable_signs=1
let g:syntastic_cpp_check_header = 1
let g:syntastic_cpp_remove_include_errors = 1
let g:syntastic_c_remove_include_errors = 1
let g:syntastic_c_include_dirs = ['../../../include','../../include','../include','./include', '../libft', '../libft/include', './libft', './libft/include']

"--------------- PL NERDTREE ---------------"
let g:nerdtree_tabs_open_on_console_startup=1
let NERDTreeIgnore = ['\.png$\','\.jpg$','\.o$']
let g:NERDTreeWinSize = 27
"---------------- AUTO LOAD---------------"
func! AirFresh()
	exec "AirlineRefresh"
endfunc                                        

autocmd InsertEnter * call AirFresh()
autocmd InsertLeave * call AirFresh()
autocmd TabLeave * call AirFresh()


"--------------- FONCTION ---------------"

imap <C-F5>		<esc>:Gdbs<CR>
map <C-F5>		<esc>:Gdbs<CR>

command -nargs=0 -bar Gdbs :call Gdbf()
func! Gdbf()
	if &filetype != 'c' && &filetype != 'cpp'
		echo "Tu veux débugguer quoi là ?"
	else
		set splitbelow nosplitbelow
		set splitright nosplitright
		silent call Compile()
		exec ":NERDTreeTabsClose"
		if !filereadable("Makefile")
			exec ":Termdebug ./a.out"
		else
			exec ":Termdebug"
		endif
	endif
	set splitbelow
	set splitright
endfunc               

command -nargs=+ -bar MakeHeader :call FctsToHeader( split('<args>') )

func! FctsToHeader(...)
	for files_input in a:000[0]
		let $f=files_input
		exec ":r !IFS=$'\\n'; for fct in $(cat "files_input" | grep -Eo \"^[a-z].*)$\" | grep -v \"[^*a-z\_]main(\"); do echo \"$fct;\"; done"
	endfor
endfunc                                  

func! Norminette()
	exec "w"
	silent exec "!clear -x"
	exec "!echo Norminette de % && norminette \"%\""
endfunc

func! CompileRun2()
	exec "w"
	silent exec "!clear -x"
	exec "cd" "%:p:h"
	if filereadable("Makefile")
		exec "!make -C \"%:p:h\" --no-print-directory && make -C \"%:p:h\" run2 --no-print-directory"
	elseif filereadable("../Makefile")
		exec "!make -C \"%:p:h/../\" --no-print-directory && make -C \"%:p:h/../\" run2 --no-print-directory"
	endif
endfunc

func! CompileRun()
	if &filetype == 'nerdtree' || &filetype == 'vim'
		echo "Fenetre non compilable"
		return
	endif
	exec "w"
	exec "cd" "%:p:h"
	silent exec "!clear -x"
	if &filetype == 'c' || &filetype == 'make' || &filetype == 'cpp'
		if filereadable("Makefile")
			exec "!make -C \"%:p:h\" --no-print-directory && make -C \"%:p:h\" run --no-print-directory"
		elseif filereadable("../Makefile")
			exec "!make -C \"%:p:h/../\" --no-print-directory && make -C \"%:p:h/../\" run --no-print-directory"
		else
			exec "!gcc -g \"%:p:h/\"*.c -o a.out && valgrind --leak-check=full --show-leak-kinds=all -q ./a.out"
"*cflags* 			exec "!gcc -g -Wall -Wextra -Werror \"%:p:h/\"*.c -o a.out && valgrind --leak-check=full --show-leak-kinds=all -q ./a.out"
		endif
	elseif &filetype == 'cpp'
		exec "!g++ % -o %<"
		exec "!time ./%<"
	elseif &filetype == 'java'
		exec "!javac %"
		exec "!time java %"
	elseif &filetype == 'sh'
		exec "!time bash %"
	elseif &filetype == 'python'
		exec "!time python3 %"
	elseif &filetype == 'html'
		exec "!google-chrome % &"
	elseif &filetype == 'matlab'
		exec "!time octave %"
	elseif &filetype == 'vala' || &filetype == 'vapi'
		if filereadable("Makefile")
			exec "!make -C %:p:h --no-print-directory && make -C %:p:h run --no-print-directory"
		else
			exec "!valac %:p:h/*.vala --pkg=posix -o a.out && ./a.out"
		endif
	endif
	exec "redraw!"
endfunc

func! Compile()
	exec "w"
	exec "cd" "%:p:h"
	silent exec "!clear -x"
	if &filetype == 'c' || &filetype == 'make' || &filetype == 'cpp'
		if filereadable("Makefile")
			exec "!make -C \"%:p:h\" --no-print-directory"
		elseif filereadable("../Makefile")
			exec "!make -C \"%:p:h/../\" --no-print-directory"
		else
			exec "!gcc -g \"%:p:h/\"*.c -o a.out"
"*cflags* 			exec "!gcc -g -Wall -Wextra -Werror \"%:p:h/\"*.c -o a.out"
		endif
	elseif &filetype == 'cpp'
		exec "!g++ % -o %<"
		exec "!time ./%<"
	elseif &filetype == 'java'
		exec "!javac %"
		exec "!time java %"
	elseif &filetype == 'sh'
		exec "!time bash %"
	elseif &filetype == 'python'
		exec "!time python3 %"
	elseif &filetype == 'html'
		exec "!google-chrome % &"
	elseif &filetype == 'matlab'
		exec "!time octave %"
	elseif &filetype == 'vala' || &filetype == 'vapi'
		if filereadable("Makefile")
			exec "!make -C %:p:h --no-print-directory"
		else
			exec "!valac %:p:h/*.vala --pkg=posix -o a.out"
		endif
	endif
	exec "redraw!"
endfunc


" -------------- SupraNorm ----------------"

highlight DapBreakpoint ctermfg=135

sign define NormLinter text=\ ✖ texthl=DapBreakpoint
let g:syntastic_error_symbol='\ ✖'
let g:syntastic_warning_symbol='\ ✖'

function GetErrors(filename)
	let norm_errors = system("norminette \"" .a:filename ."\"")
	let norm_errors = norm_errors->split("\n")
	let regex = 'Error: \([A-Z_]*\)\s*(line:\s*\(\d*\), col:\s*\(\d*\)):\t\(.*\)'
	let errors = []
	for s in norm_errors
		if s =~# regex
			let groups = matchlist(s, regex)
			let groups = [groups[1], groups[2], groups[3], groups[4]]
			call add(errors, groups)
		endif
	endfor
	return errors
endfunction

function HighlightNorm(filename)
	call clearmatches("NormErrors")
	let g:errors = GetErrors(a:filename)
	hi def link NormErrors Underlined
	sign unplace *
	for error in g:errors
		exe ":sign place 2 line=".error[1] " name=NormLinter file=" .a:filename
	endfor
endfunction

function DisplayErrorMsg()
	for error in g:errors
		if line(".") == error[1]
			echo error[3]
		else
			echo ""
		endif
	endfor
endfunction

autocmd CursorMoved *.c call DisplayErrorMsg()

function GetErrorDict(filename)
	let errors = GetErrors(a:filename)
	let error_dict = {}
	for error in errors
		eval error_dict->extend({error[1] : error[3]})
	endfor
	return error_dict
endfunction

function! s:empty_message(timer)
	echo ""
endfunction

command Norm call HighlightNorm(expand("%"))
autocmd BufEnter,BufWritePost *.c Norm
autocmd BufLeave *.c call clearmatches("NormErrors")

"
" -------------- COLORS FILE ----------------"
function! NERDTreeHighlightFile(extension, fg, bg)
	exec 'autocmd filetype nerdtree highlight ' . a:extension .' ctermbg='. a:bg .' ctermfg='. a:fg
	exec 'autocmd filetype nerdtree syn match ' . a:extension .' #^\s\+.*'. a:extension .'$#'
endfunction

call NERDTreeHighlightFile('.c', 'blue', 'none')
call NERDTreeHighlightFile('h', 'green', 'none')
call NERDTreeHighlightFile('vala', 'magenta', 'none')
call NERDTreeHighlightFile('Makefile', 'red', 'none')

augroup nerdtreeconcealbrackets
	autocmd!
	autocmd FileType nerdtree syntax match hideBracketsInNerdTree "\]" contained conceal containedin=ALL
	autocmd FileType nerdtree syntax match hideBracketsInNerdTree "\[" contained conceal containedin=ALL
augroup END
