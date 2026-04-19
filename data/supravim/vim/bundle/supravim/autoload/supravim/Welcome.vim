vim9script

import autoload 'SupraNotification.vim' as Notify

export def Welcome()
	# Used for SupraWater with folder
	silent! autocmd! FileExplorer
	highlight SupraVimYellow guifg=#e4bf7d ctermfg=Yellow
	var timer = timer_start(50, (_) => {
		echohl SupraVimYellow
		echo 'Welcome to SupraVim ! Press <F12> for help or curstomize your settings.'
		echohl None
	})
enddef

export def PrintChangeLog()
	if executable('suprapack')
		job_start(["suprapack", "info", "supravim"], {
			out_io: 'buffer',
			out_msg: 0,
			out_mode: 'raw',
			close_cb: (ch: channel) => {
				const buffer = ch->ch_getbufnr('out')
				const all = getbufline(buffer, 0, '$')
				var a = stridx(all[0], 'Version')
				var b = stridx(all[0], '0m', a)
				var c = stridx(all[0], "\n", b)
				var version = all[0][b + 2 : c - 1]
				call WelcomeChangeLog(version)
				execute "bd! " .. buffer
			}
		})
	endif
enddef

def WelcomeChangeLog(version: string)
	
    var current_version = get(g:, 'supravim_version', '0.0.0')
    
    var version_file = expand('$HOME/.config/supravim/last_version.txt')
    var last_run_version = ''

    if filereadable(version_file)
        last_run_version = readfile(version_file)->get(0, '')
    endif

    if last_run_version == current_version
        return
    endif
	
	var last_version = ''

	if filereadable(version_file)
		last_version = readfile(version_file)->get(0, '')
	endif

	if last_version == version
		return
	endif

	var txt = (last_version == '' ? '' : last_version .. ' → ')

	var changelog_path = expand('$HOME/.local/share/supravim/CHANGELOG.md')
	if !filereadable(changelog_path) | return | endif # Sécurité si le fichier n'existe pas

	var changelog = readfile(changelog_path)
	var log_to_display: list<string> = ["Welcome to SupraVim " .. txt .. version]
	# just print 4 log line max or stop if the line begin by '#'
	var count = 0
	for line in changelog
		if count >= 4
			break
		endif
		if line =~ '^#' && count > 0
			break
		endif
		if line != ''
			log_to_display += [line]
			count += 1
		endif
	endfor
	log_to_display += [" __Click here to see full changelog__"]

	Notify.Notification(log_to_display, {
		icon: '󰪷',
		left_click: (wid) => {
			tabnew $HOME/.local/share/supravim/CHANGELOG.md
			popup_close(wid)
		},
	})
	writefile([version], version_file)
enddef

