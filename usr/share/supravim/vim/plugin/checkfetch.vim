vim9script

g:sp_checkfetch = true # check if the git branch is up to date

if g:sp_checkfetch == true 
	def GotOutputSupravimServer(channel: channel, msg: string)
		if msg =~ '.*\s*HEAD'
			var branch_name_lst = readfile('.git/HEAD', 'r')
			if (empty(branch_name_lst))
				return
			endif
			var branch_name = substitute(branch_name_lst[0], 'ref:\s*refs/heads/', '', '')
			var hash = system('git rev-parse ' .. branch_name)
			hash = substitute(hash, '\s*\n', '', '')
			var hash2 = substitute(msg, '\s*HEAD\s*', '', '')
			if hash2 != hash
				call g:PopUpGit(branch_name)
			endif
		endif
	enddef

	def g:PopUpGit(branch_name: string)
		call g:SupraNotification([
			"Git  ",
			"Your branch " .. branch_name .. " is out of date",
			"use `git pull` or `git fetch`",
			"to sync with recent modifications."])
	enddef

	def Fetch()
		if executable("git") == 1 
			job_start(["git", "ls-remote", "origin"], {
				out_cb: GotOutputSupravimServer,
			})
		endif
	enddef

	call Fetch()
endif
