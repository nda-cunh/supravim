"**** SUPRAVIM ****"
set nocompatible
filetype off

call pathogen#infect()
call pathogen#helptags()

filetype plugin indent on
"--------------- jeu de couleur ---------------"
colorscheme gruvbox
set background=dark
set t_Co=256
" 1: gruvbox
" 2: molokai
" 3: dracula

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
let g:AutoPairsFlyMode 			= 0
let g:AutoPairsMapCR 			= 0
let g:AutoPairsWildClosedPair 	= ''
let g:AutoPairsMultilineClose 	= 0
imap <silent><CR>				<CR><Plug>AutoPairsReturn
"*autopairs* let g:AutoPairs = {}


"--------------- Onglets ---------------------"
noremap <c-n>	<esc>:tabnew 
noremap <C-Right>				:tabnext<CR>
noremap <C-Left>				:tabprevious<CR>
inoremap <C-Right>				<esc>:tabnext<CR>
inoremap <C-Left>				<esc>:tabprevious<CR>

"--------------- Les racourcis ---------------"
noremap <C-Up>			<Esc>g<C-}>
noremap <C-Down>		<Esc><C-T>
inoremap <C-Up>			<Esc>g<C-}>
inoremap <C-Down>		<Esc><C-T>

inoremap <c-w>				<esc>:w!<CR>
inoremap <c-q>				<esc>:q!<CR>
inoremap <c-s>				<esc>:w!<CR>
noremap <c-w>				<esc>:w!<CR>
noremap <c-q>				<esc>:q!<CR>
noremap <c-s>				<esc>:w!<CR>
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
inoremap <TAB>				<TAB>
imap <C-g>					<esc>:NERDTreeTabsToggle<CR>
map <C-g>					:NERDTreeTabsToggle<CR>
map <S-T> <Esc>:term ++rows=15<CR>

"---------------      Terminal        ---------------"
tnoremap <C-q> exit<CR>
tnoremap <F5> make all && make run<CR>
tnoremap <F6> make all && make run2<CR>
tnoremap <F3> norminette<CR>

" tnoremap <F4> <C-W>N<CR><S-UP>
tnoremap <S-Right>			<C-W>N<C-w><Right>
tnoremap <S-Left>			<C-W>N<C-w><Left>
tnoremap <S-Up>				<C-W>N<C-w><Up>
tnoremap <S-Down>			<C-W>N<C-w><Down>

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
let g:syntastic_c_include_dirs = ['../../../include','../../include','../include','./include']

"--------------- PL NERDTREE ---------------"
let g:nerdtree_tabs_open_on_console_startup=1
let NERDTreeIgnore = ['\.png$\','\.jpg$','\.o$']
"---------------- AUTO LOAD---------------"
autocmd VimEnter call Pause()

"--------------- FONCTION ---------------"

imap <C-F5>		<esc>:Gdbs<CR>
map <C-F5>		<esc>:Gdbs<CR>

command -nargs=0 -bar Gdbs :call Gdbf()
func! Gdbf()
	set splitbelow nosplitbelow
	set splitright nosplitright
	if &filetype == 'c'
		exec ":NERDTreeTabsClose"
		if !filereadable("Makefile")
			exec ":Termdebug ./a.out"
		else
			exec ":Termdebug"
		endif
	else
		echo "Fichier non supporter !"
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

func! Pause()                                  
	exec "!stty start undef && stty stop undef"
endfunc                                        

func! Norminette()
	exec "!echo Norminette de % && norminette %"
endfunc

func! CompileRun2()
	exec "w"
	exec "cd" "%:p:h"
	if filereadable("Makefile")
		exec "!make -C %:p:h --no-print-directory && make -C %:p:h run2 --no-print-directory"
	elseif filereadable("../Makefile")
		exec "!make -C %:p:h/../ --no-print-directory && make -C %:p:h/../ run2 --no-print-directory"
	endif
endfunc

func! CompileRun()
	exec "w"
	exec "cd" "%:p:h"
	if &filetype == 'c' || &filetype == 'make'
		if filereadable("Makefile")
			exec "!make -C %:p:h --no-print-directory && make -C %:p:h run --no-print-directory"
		elseif filereadable("../Makefile")
			exec "!make -C %:p:h/../ --no-print-directory && make -C %:p:h/../ run --no-print-directory"
		else
			exec "!gcc -g %:p:h/*.c -o a.out && ./a.out"
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
endfunc

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
