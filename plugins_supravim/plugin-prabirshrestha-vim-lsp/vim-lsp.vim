vim9script

import autoload 'supraconfig.vim' as SupraConfig

# --- Helper pour rafraîchir le LSP lors d'un changement d'option ---
def RefreshLsp()
    silent! call lsp#disable()
    timer_start(100, (_) => {
        silent! call lsp#enable()
		if &modifiable && !&readonly
			silent! write
		endif
    })
enddef

autocmd User lsp_setup doautocmd User LspIsReady 

# --- Déclaration des Groupes ---
SupraConfig.RegisterGroup('lsp', 'Language Server Protocol: completion, diagnostics and code intelligence')
SupraConfig.RegisterGroup('lsp/diagnostics', 'Options for diagnostic messages and errors')
SupraConfig.RegisterGroup('lsp/diagnostics/echo', 'Diagnostic messages shown in the command line')
SupraConfig.RegisterGroup('lsp/diagnostics/signs', 'SignColumn icons for errors, warnings, and hints')
SupraConfig.RegisterGroup('lsp/diagnostics/virtual_text', 'Diagnostic text displayed next to the code')
SupraConfig.RegisterGroup('lsp/diagnostics/float', 'Diagnostic messages shown in floating windows')
SupraConfig.RegisterGroup('lsp/diagnostics/echo', 'Diagnostic messages shown in the command line')
SupraConfig.RegisterGroup('lsp/diagnostics/highlights', 'Highlight lines with diagnostics')
SupraConfig.RegisterGroup('lsp/semantic', 'Color the code with LSP')
SupraConfig.RegisterGroup('lsp/inlay_hints', 'Inline hints like (string: ), for types and parameters')

var is_load = false 

SupraConfig.RegisterMany([
    # --- GENERAL & LOGGING ---
    {
        id: 'lsp/enabled',
        type: 'bool',
        default: true,
        lore: 'Enable or disable the Language Server Protocol interface',
		spawn: false,
        handler: (v) => {
            if v
				silent! call lsp#enable()
			else
				silent! call lsp#disable()
			endif
        }
    },
    {
        id: 'lsp/debug',
        type: 'bool',
        default: false,
        lore: 'Enable verbose logging for LSP (~/.cache/supravim_lsp.log)',
        handler: (v) => {
            g:lsp_log_file = v ? expand('~/.cache/supravim_lsp.log') : ''
            g:lsp_log_verbose = v ? 1 : 0
        }
    },

    # --- DIAGNOSTICS (GENERAL) ---
    {
        id: 'lsp/diagnostics/highlights/enabled',
        type: 'bool',
        default: true,
        lore: 'Highlight lines containing errors or warnings',
        handler: (v) => {
            g:lsp_diagnostics_highlights_enabled = v ? 1 : 0
            if is_load | RefreshLsp() | endif
        }
    },
    {
        id: 'lsp/diagnostics/highlights/insert_mode',
        type: 'bool',
        default: true,
        lore: 'Keep diagnostic highlights while in insert mode',
        handler: (v) => {
            g:lsp_diagnostics_highlights_insert_mode_enabled = v ? 1 : 0
			if is_load | RefreshLsp() | endif
        }
    },

    # --- SIGNS (Gutter) ---
    {
        id: 'lsp/diagnostics/signs/enabled',
        type: 'bool',
        default: true,
        lore: 'Show error/warning signs in the gutter (SignColumn)',
        handler: (v) => {
            g:lsp_diagnostics_signs_enabled = v ? 1 : 0
			if is_load | RefreshLsp() | endif
        }
    },
    {
        id: 'lsp/diagnostics/signs/insert_mode',
        type: 'bool',
        default: false,
        lore: 'Keep diagnostic signs visible while in insert mode',
        handler: (v) => {
			g:lsp_diagnostics_signs_insert_mode_enabled = v ? 1 : 0
			if is_load | RefreshLsp() | endif
        }
    },
    {
        id: 'lsp/diagnostics/signs/error_icon',
        type: 'string',
        default: '┃',
        lore: 'Icon for error diagnostics',
        handler: (v) => {
			g:lsp_diagnostics_signs_error = {'text': v}
			if is_load | RefreshLsp() | endif
		}
    },
    {
        id: 'lsp/diagnostics/signs/warning_icon',
        type: 'string',
        default: '┃',
        lore: 'Icon for warning diagnostics',
        handler: (v) => {
			g:lsp_diagnostics_signs_warning = {'text': v}
			if is_load | RefreshLsp() | endif
		}
    },
	{
        id: 'lsp/diagnostics/signs/info_icon',
        type: 'string',
		# a sign special for info is not the same as error and warning
        default: '┃',
		lore: 'Icon for information diagnostics',
        handler: (v) => {
            g:lsp_diagnostics_signs_information = {'text': v}
			if is_load | RefreshLsp() | endif
        }
    },
    {
        id: 'lsp/diagnostics/signs/hint_icon',
        type: 'string',
        default: '┃',
        lore: 'Icon for hint and suggestion diagnostics',
        handler: (v) => {
            g:lsp_diagnostics_signs_hint = {'text': v}
			if is_load | RefreshLsp() | endif
        }
    },
	{
		id: 'lsp/diagnostics/signs/action_icon',
		type: 'string',
		default: '⚡',
		lore: 'Icon for available code actions',
		handler: (v) => {
			g:lsp_document_code_action_signs_hint = {'text': v}
			if is_load | RefreshLsp() | endif
		}
	},
	{
		id: 'lsp/diagnostics/signs/delay',
		type: 'number',
		default: 30,
		lore: 'Delay in ms before showing signs',
		handler: (v) => {
			g:lsp_diagnostics_signs_delay = v
			if is_load | RefreshLsp() | endif
		}
	},
	{
		id: 'lsp/diagnostics/signs/action_delay',
		type: 'number',
		default: 200,
		lore: 'Delay in ms before showing code action signs',
		handler: (v) => {
			g:lsp_document_code_action_signs_delay = v
			if is_load | RefreshLsp() | endif
		}
	},
	{
		id: 'lsp/diagnostics/signs/action_enabled',
		type: 'bool',
		default: true,
		lore: 'Show signs for available code actions',
		handler: (v) => {
			g:lsp_document_code_action_signs_enabled = v ? 1 : 0
			if is_load | RefreshLsp() | endif
		}
	},

    # --- VIRTUAL TEXT ---
    {
        id: 'lsp/diagnostics/virtual_text/enabled',
        type: 'bool',
        default: false,
        lore: 'Show diagnostic text at the end of the line',
        handler: (v) => {
            g:lsp_diagnostics_virtual_text_enabled = v ? 1 : 0
            if is_load | RefreshLsp() | endif
        }
    },
    {
        id: 'lsp/diagnostics/virtual_text/align',
        type: 'string',
        default: 'below',
        lore: 'Alignment of virtual text: after, right, below, above',
        handler: (v) => {
            var valid = ['after', 'right', 'below', 'above']
            g:lsp_diagnostics_virtual_text_align = index(valid, v) != -1 ? v : 'below'
			if is_load | RefreshLsp() | endif
        }
    },
    {
        id: 'lsp/diagnostics/virtual_text/delay',
        type: 'number',
        default: 50,
        lore: 'Delay in ms before showing virtual text diagnostics',
        handler: (v) => {
			g:lsp_diagnostics_virtual_text_delay = v
			if is_load | RefreshLsp() | endif
        }
    },
    {
        id: 'lsp/diagnostics/virtual_text/wrap',
        type: 'bool',
        default: true,
        lore: 'Wrap virtual text if it exceeds line length',
        handler: (v) => {
            g:lsp_diagnostics_virtual_text_wrap = v ? "wrap" : "truncate"
        }
    },
    {
        id: 'lsp/diagnostics/virtual_text/prefix',
		type: 'string',
		default: '‣ ',
		lore: 'Prefix icon for virtual text diagnostics',
		handler: (v) => {
			g:lsp_diagnostics_virtual_text_prefix = v
			if is_load | RefreshLsp() | endif
		}
	},

    # --- FLOATING WINDOWS ---
    {
        id: 'lsp/diagnostics/float/enabled',
        type: 'bool',
        default: true,
        lore: 'Show diagnostics in a floating window under cursor',
        handler: (v) => {
            g:lsp_diagnostics_float_cursor = v ? 1 : 0
			if is_load | RefreshLsp() | endif
        }
    },
    {
        id: 'lsp/diagnostics/float/delay',
        type: 'number',
        default: 50,
        lore: 'Delay in ms before showing floating diagnostics',
        handler: (v) => {
            g:lsp_diagnostics_float_delay = v
			if is_load | RefreshLsp() | endif
        }
    },
    {
        id: 'lsp/diagnostics/float/insert_mode',
        type: 'bool',
        default: false,
        lore: 'Keep floating diagnostics visible while in insert mode',
        handler: (v) => {
			g:lsp_diagnostics_float_insert_mode_enabled = v ? 1 : 0
			if is_load | RefreshLsp() | endif
        }
    },
    # --- FLOATING WINDOWS ---
    {
        id: 'lsp/diagnostics/echo/enabled',
        type: 'bool',
        default: true,
        lore: 'Show in the command line when cursor is on a line with diagnostics',
        handler: (v) => {
            g:lsp_diagnostics_echo_cursor = v ? 1 : 0
			if is_load | RefreshLsp() | endif
        }
    },
    {
        id: 'lsp/diagnostics/echo/delay',
        type: 'number',
        default: 50,
        lore: 'Delay in ms before showing echo diagnostics',
        handler: (v) => {
            g:lsp_diagnostics_echo_delay = v
			if is_load | RefreshLsp() | endif
        }
    },

    # --- SEMANTIC HIGHLIGHTING ---
    {
        id: 'lsp/semantic/enabled',
        type: 'bool',
        default: false,
        lore: 'Enable semantic token highlighting (modern syntax coloring)',
        handler: (v) => {
            g:lsp_semantic_enabled = v
            if is_load | RefreshLsp() | endif
        }
    },
    {
        id: 'lsp/semantic/delay',
        type: 'number',
        default: 0,
        lore: 'Delay in ms before applying semantic token highlights',
        handler: (v) => {
			g:lsp_semantic_delay = v
			if is_load | RefreshLsp() | endif
        }
    },

    # --- INLAY HINTS ---
    {
        id: 'lsp/inlay_hints/enabled',
        type: 'bool',
        default: false,
        lore: 'Show inline hints for types and parameters',
        handler: (v) => {
            g:lsp_inlay_hints_enabled = v
            if is_load | RefreshLsp() | endif
        }
    },
    {
        id: 'lsp/inlay_hints/delay',
		type: 'number',
		default: 50,
		lore: 'Delay in ms before showing inlay hints',
		handler: (v) => {
			g:lsp_inlay_hints_delay = v
			if is_load | RefreshLsp() | endif
		}
	},
])

is_load = true


au User SupraMenuLoaded InitMenuActionLsp()

export def InitMenuActionLsp()
	call SupraMenu#Register(MenuActionLsp)
enddef

def g:HasCodeAction(): bool
	const v = sign_getplaced(bufnr(), {'lnum': 16, 'group': 'vim_lsp_document_code_action_signs'})
	return !empty(v) && !empty(v[0].signs)
enddef

def LspMenuActionRunSupraMenu(col: number, line: number)
	# move to the position to ensure the code action menu is relevant to the
	cursor(line, col)
	silent! feedkeys(":LspCodeAction --ui=float", 'n')
	# HACK supra truc bizarre
	timer_start(200, (_) => {
		feedkeys("\<cr>", 'n')
	})
enddef

const SID = expand('<SID>')
def MenuActionLsp(ctx: dict<any>): dict<any>
    const col = ctx.col
	const line = ctx.line
	if !g:HasCodeAction()
		 return {}
	endif
    return {
        priority: 0,
        rows: [
            {
                label: 'Lsp Code Actions',
				cmd: $'<cmd>call {SID}LspMenuActionRunSupraMenu(' .. ctx.col .. ', ' .. ctx.line .. ')<cr>',
                icon: '⚡',
                type: 'n'
            }
        ]
    }
enddef
