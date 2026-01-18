vim9script noclear

if exists('g:supra_menu_loaded')
	finish
endif

g:supra_menu_loaded = 1

import autoload 'SupraMenu.vim'

map <RightMouse>			<scriptcmd>SupraMenu.Open()<cr>

##########
# Format of the row
# {
#     label: string ->  Le texte affiché 
#     cmd: string -> La commande à exécuter 
#     icon: string -> L'icône à afficher
#     priority: number -> La priorité d'affichage (plus grand = plus haut)
#     type: char -> 'n' = normal, 'v' = visual, 'i' = insert, 'c' = command 'a' = all modes
# }
##########

const LspBlock = {
    priority: 900,
    rows: [
        { label: 'Show References', cmd: '<esc>:LspReferences<cr>', icon: '󰈻', type: 'n' }
    ]
}

const SystemBlock = {
    priority: 800,
    rows: [
        { label: 'Save All',  cmd: ':wall<CR>',      icon: '󰆓', type: 'n' },
        { label: 'Auto Norm', cmd: '<leader><F2>', icon: '󰉶', type: 'n' }
    ]
}

const EditionBlock = {
    priority: 700,
    rows: [
		{ label: 'Copy',       cmd: 'y',         icon: '󰆏', type: 'v' },
		{ label: 'Cut',        cmd: 'd',         icon: '󰆐', type: 'v' },
		{ label: 'Paste',      cmd: 'p',         icon: '󰅍', type: 'v' },
		{ label: 'Select All', cmd: '<esc>ggVG', icon: '󰒅', type: 'v' }, # 'a' pour Normal & Visuel
		{ label: 'Equalize',   cmd: '=',         icon: '󰉼', type: 'v' },
		{ label: 'Select All', cmd: '<esc>ggVG', icon: '󰒅', type: 'n' }, # 'a' pour Normal & Visuel
		{ label: 'Paste',      cmd: 'p',         icon: '󰅍', type: 'n' },
        { label: 'Undo',       cmd: 'u',         icon: '󰕌', type: 'n' },
        { label: 'Redo',       cmd: '<C-r>',     icon: '󰑎', type: 'n' },
    ]
}

const DebugBlock = {
    priority: 600,
    rows: [
        { label: 'Debug',                cmd: ':Gdbs<cr>', icon: '󰃤', type: 'n' },
        { label: 'Rename Symbol <F2>',   cmd: '<F2>',     icon: '󰏫', type: 'n' }
    ]
}

const FoldingBlock = {
    priority: 500,
    rows: [
        { label: 'FoldToggle',  cmd: 'za', icon: '󱊄', type: 'n' },
        { label: 'Fold All',    cmd: 'zM', icon: '󱊅', type: 'n' },
        { label: 'UnFold All',  cmd: 'zR', icon: '󱊆', type: 'n' }
    ]
}

const SettingsBlock = {
    priority: 100,
    rows: [
        { label: 'SupraVim Settings', cmd: ':call SettingsSupravim()<CR>', icon: '󰒓', type: 'n' }
    ]
}

call SupraMenu.Register((_) => {
	return LspBlock
})

call SupraMenu.Register((_) => {
	return SystemBlock
})

call SupraMenu.Register((_) => {
	return EditionBlock
})

call SupraMenu.Register((_) => {
	return DebugBlock
})

call SupraMenu.Register((_) => {
	return FoldingBlock
})

call SupraMenu.Register((_) => {
	return SettingsBlock
})
