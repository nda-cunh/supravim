set nocompatible
filetype off

call pathogen#infect()
call pathogen#helptags()

filetype plugin indent on
"--------------- Les racourcit ---------------"
inoremap <c-w>	<esc>:w!<CR>
inoremap <c-q>	<esc>:q!<CR>
inoremap <c-s>	<esc>:w!<CR>
noremap <c-w>	<esc>:w!<CR>
noremap <c-q>	<esc>:q!<CR>
noremap <c-s>	<esc>:w!<CR>
nmap <F8> :TagbarToggle<CR>
noremap <C-d>				:vs 
noremap <S-d>				:split 
noremap <S-Right>			<C-w><Right>
noremap <S-Left>			<C-w><Left>
noremap <S-Up>				<C-w><Up>
noremap <S-Down>			<C-w><Down>
inoremap <TAB>				<TAB>
noremap <C-k>				:!(make  && ./APP)<CR>
noremap <C-e>				:!(clang *.c && ./a.out)<CR>
noremap <C-b>				:r ~/main.test <CR>
imap <C-g> <esc>:NERDTreeToggle<CR>
map <C-g> :NERDTreeToggle<CR>

"--------------- utilitaire basique	---------------"
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

"--------------- jeu de couleur ---------------"
colorscheme molokai
set t_Co=256

"--------------- CLANG COMPLETER ---------------"
set noinfercase
set completeopt-=preview
set completeopt+=menuone,noselect
let g:clang_library_path='/usr/lib/llvm-10/lib/libclang-10.so.1'
let g:clang_complete_auto = 1
let g:mucomplete#enable_auto_at_startup = 1
"
" "--------------- TAGBAR ---------------"
" "let g:tagbar_ctags_bin="~/.vim/bundle/ctags/ctags"
" "autocmd VimEnter * TagbarToggle
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
