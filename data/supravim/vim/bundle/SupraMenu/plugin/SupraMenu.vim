vim9script noclear

if exists('g:supra_menu_loaded')
	finish
endif

g:supra_menu_loaded = 1

import autoload 'SupraMenu.vim'

noremap <RightMouse>			<scriptcmd>SupraMenu.Open()<cr>
inoremap <RightMouse>			<esc><scriptcmd>SupraMenu.Open()<cr>

def Highlights()
	hi def link SupraMenu Normal
	hi def link SupraMenuBorder Normal
	hi def link SupraMenuSeparator Comment
	hi def link SupraMenuShortcut Comment
	hi def link SupraMenuDisabled NonText
enddef

Highlights()
au ColorScheme * Highlights()

##########
# Format of a block: { priority: number, rows: list<Row> }
# priority: higher number means displayed first
#
# Format of a row
# {
#     label: string -> The label to display
#     icon: string -> The icon to display (can be empty)
#     cmd: func() | string -> The function to call, or the keys to feed
#     modes: string -> 'n', 'v' or 'nv' (default 'n', children inherit it)
#     shortcut: string -> Hint displayed on the right
#     enabled: bool -> false greys out the row (default true)
#     children: list<Row> -> Submenu
# }
# Separator: { sep: true }
##########

const LspBlock = {
	priority: 900,
	rows: [
	{
		label: 'Lsp', icon: '󰅩', children: [
			{ label: 'Show References', cmd: '<esc>:LspReferences<cr>', icon: '󰈻', shortcut: 'gr' },
			{ label: 'Rename Symbol', cmd: '<F2>',      icon: '󰏫', shortcut: 'F2' },
			{ label: 'Show Signature', cmd: '<C-space>', icon: '󰌶', shortcut: 'Ctrl+<space>' },
			{ sep: true },
			{ sep: true },
			{ label: 'Go to Definition', cmd: 'gd', icon: '󰌶', shortcut: 'gd' },
			{ label: 'Go to Declaration', cmd: 'gD', icon: '󰌶', shortcut: 'gD' },
			{ label: 'Go to Type Definition', cmd: 'gT', icon: '󰌶', shortcut: 'gT' },
			{ label: 'Go to Implementation', cmd: 'gi', icon: '󰌶', shortcut: 'gi' },
			{ sep: true },
			{ label: 'Code Actions', cmd: 'ga', icon: '󰌶', shortcut: 'ga' },
		]
	}
	]
}

const SystemBlock = {
	priority: 800,
	rows: [
		{ label: 'Save All',  cmd: ':wall<CR>',    icon: '󰆓' },
		{ label: 'Auto Norm', cmd: '<leader><F2>', icon: '󰉶' }
	]
}

const EditionBlock = {
	priority: 700,
	rows: [
		{ label: 'Copy',       cmd: 'y',         icon: '󰆏', modes: 'v' },
		{ label: 'Cut',        cmd: 'd',         icon: '󰆐', modes: 'v' },
		{ label: 'Paste',      cmd: 'p',         icon: '󰅍', modes: 'nv' },
		{ label: 'Select All', cmd: '<esc>ggVG', icon: '󰒅', modes: 'nv' },
		{ sep: true },
		{ label: 'Undo',       cmd: 'u',         icon: '󰕌', shortcut: 'u' },
		{ label: 'Redo',       cmd: '<C-r>',     icon: '󰑎', shortcut: 'C-r' },
		{ label: 'Transform', icon: '󰬴', modes: 'v', children: [
			{ label: 'Equalize',        cmd: '=',          icon: '󰉼' },
			{ label: 'Uppercase',       cmd: 'gU',         icon: '󰬶' },
			{ label: 'Lowercase',       cmd: 'gu',         icon: '󰬵' },
			{ sep: true },
			{ label: 'Sort Ascending',  cmd: ':sort<cr>',  icon: '' },
			{ label: 'Sort Descending', cmd: ':sort!<cr>', icon: '' },
		] },
	]
}

const DebugBlock = {
	priority: 600,
	rows: [
		# { label: 'Debug',         cmd: ':Gdbs<cr>', icon: '󰃤' },
		{ label: 'Folding', icon: '󱊄', children: [
			{ label: 'Toggle',     cmd: 'za', icon: '󱊄', shortcut: 'za' },
			{ label: 'Fold All',   cmd: 'zM', icon: '󱊅', shortcut: 'zM' },
			{ label: 'UnFold All', cmd: 'zR', icon: '󱊆', shortcut: 'zR' },
		] },
	]
}

const SettingsBlock = {
	priority: -1,
	rows: [
		{ label: 'SupraVim Settings', cmd: () => g:SettingsSupravim(), icon: '󰒓', shortcut: 'F12' }
	]
}

def Echo(msg: string)
	echomsg msg
enddef


SupraMenu.Register(LspBlock)
SupraMenu.Register(SystemBlock)
SupraMenu.Register(EditionBlock)
SupraMenu.Register(DebugBlock)
SupraMenu.Register(SettingsBlock)

def Loaded()
	timer_start(500, (_) => {
		silent! doautocmd User SupraMenuLoaded
	})
enddef

au VimEnter * call Loaded()
