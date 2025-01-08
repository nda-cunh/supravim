vim9script

var current_compiler = "clang"
g:rainbow_active = 1
g:syntastic_error_symbol = '\ ✖'
g:syntastic_warning_symbol = '\ ✖'
g:syntastic_cpp_compiler = 'clang++'
g:syntastic_cpp_compiler_options = ' -Wall -Wextra'
g:syntastic_check_on_open = 1
g:syntastic_enable_signs = 1
g:syntastic_cpp_check_header = 1
g:syntastic_cpp_remove_include_errors = 1
g:syntastic_c_remove_include_errors = 1
g:syntastic_c_include_dirs = ['../../../include', '../../include', '../include', './include', '../../../includes', '../../includes', '../includes', './includes', './libft', '../libft', '../../libft', '../../../libft', './libft/include', '../libft/include', '../../libft/include']

autocmd BufRead,BufNewFile *.c,*.h call Init_Syntastic()

def g:Init_Syntastic()
	g:lsp_diagnostics_enabled = 0
	g:lsp_diagnostics_signs_enabled = 0
	g:lsp_document_code_action_signs_enabled = 0
	g:lsp_diagnostics_signs_delay = 1
	g:lsp_diagnostics_signs_priority = 0
	g:lsp_diagnostics_signs_insert_mode_enabled = 0
	g:lsp_tagfunc_source_methods = []
enddef
