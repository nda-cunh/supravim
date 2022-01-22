set nocompatible
filetype off

call pathogen#infect()
call pathogen#helptags()

filetype plugin indent on

"-------------- Ctrl-Z persistant ------------"
try
    set undodir=~/.vim/undodir
    set undofile
catch
endtry

"--------------- Les racourcis ---------------"
inoremap <c-w>	<esc>:w!<CR>
inoremap <c-q>	<esc>:q!<CR>
inoremap <c-s>	<esc>:w!<CR>
noremap <c-w>	<esc>:w!<CR>
noremap <c-q>	<esc>:q!<CR>
noremap <c-s>	<esc>:w!<CR>
map <F5> 					:call CompileRun()<CR>
imap <F5>				 	<Esc>:call CompileRun()<CR>
vmap <F5> 					<Esc>:call CompileRun()<CR>
nmap <F8>					:TagbarToggle<CR>
noremap <S-o>				:Stdheader<CR>
noremap <S-n>				:!(norminette)<CR>
noremap <S-m>				:r $HOME/main.template<CR>
noremap <C-d>				:vs 
noremap <S-d>				:split 
noremap <S-Right>			<C-w><Right>
noremap <S-Left>			<C-w><Left>
noremap <S-Up>				<C-w><Up>
noremap <S-Down>			<C-w><Down>
inoremap <TAB>				<TAB>
noremap <C-k>				:!make ; (make run)<CR>
noremap <C-e>				:!(cc *.c -lbsd && ./a.out)<CR>
noremap <C-b>				:r ~/main.test <CR>
imap <C-g>					<esc>:NERDTreeToggle<CR>
map <C-g>					:NERDTreeToggle<CR>

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
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
let g:AutoPairsFlyMode = 0

"---------- Qui utilise la scrollbar -----------"
set guioptions-=r
set guioptions-=R
set guioptions-=l
set guioptions-=L

"--------------- jeu de couleur ---------------"
colorscheme gruvbox
set t_Co=256

"--------------- CLANG COMPLETER ---------------"
set noinfercase
set completeopt-=preview
set completeopt+=menuone,noselect
let g:clang_library_path='/usr/lib/llvm-12/lib/libclang.so.1'
let g:clang_complete_auto = 1
let g:mucomplete#enable_auto_at_startup = 1
"
" "--------------- TAGBAR ---------------"
" "let g:tagbar_ctags_bin="~/.vim/bundle/ctags/ctags"
"autocmd VimEnter * TagbarToggle
"
" "--------------- SYNTASTIC ---------------"
let current_compiler = "gcc"
let g:rainbow_active = 1

let g:syntastic_cpp_compiler = 'gcc'
let g:syntastic_cpp_compiler_options = ' -std=c++11 -stdlib=libc++ -Wall-Werror -Wextra'
let g:syntastic_check_on_open=1
let g:syntastic_enable_signs=1
let g:syntastic_cpp_check_header = 1
let g:syntastic_cpp_remove_include_errors = 1
let g:syntastic_c_remove_include_errors = 1
let g:syntastic_c_include_dirs = ['../../../include','../../include','../include','./include']

"--------------- PL NERDTREE ---------------"
let sbv_open_nerdtree_to_start=1
let sbv_open_nerdtree_with_new_tab=1
autocmd BufCreate * call s:addingNewTab(sbv_open_nerdtree_with_new_tab)
autocmd VimEnter * call s:actionForOpen(sbv_open_nerdtree_to_start)
autocmd WinEnter * call s:CloseIfOnlyNerdTreeLeft()

"--------------- FONCTION ---------------"

function! s:actionForOpen(openNerdTree)
	let filename = expand('%:t')
	if !empty(a:openNerdTree)
		NERDTree
	endif
	if !empty(filename)
		wincmd l
	endif
endfunction

function! s:addingNewTab(openNerdTree)
	let filename = expand('%:t')
	if winnr('$') < 2 && exists('t:NERDTreeBufName') == 0
		if !empty(a:openNerdTree)
			NERDTree
		endif
		if !empty(filename)
			wincmd l
		endif
	endif
endfunction

function! s:CloseIfOnlyNerdTreeLeft()
	if exists("t:NERDTreeBufName")
		if bufwinnr(t:NERDTreeBufName) != -1
			if winnr("$") == 1
				q
			endif
		endif
	endif
endfunction

func! CompileRun()
exec "w"
if &filetype == 'c'
    exec "!gcc % -o %<"
    exec "!time ./%<"
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
elseif &filetype == 'go'
    exec "!go build %<"
    exec "!time go run %"
elseif &filetype == 'matlab'
    exec "!time octave %"
elseif &filetype == 'vala'
	exec "!valac %"
elseif &filetype == 'vapi'
	exec "!valac %"
endif
endfunc
