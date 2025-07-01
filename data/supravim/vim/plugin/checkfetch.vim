vim9script

g:sp_checkfetch = false # check if the git branch is up to date

var branch_name: string

if g:sp_checkfetch == true 
	def GotOutputSupravimServer(channel: channel, msg: string)
		if msg =~ '.*\s*refs/.*/' .. branch_name
			var hash = system('git rev-parse ' .. branch_name)
			hash = substitute(hash, '\s*\n', '', '')
			var hash2 = substitute(msg, '\s*refs.*', '', '')
			if hash2 != hash
				call g:PopUpGit(branch_name)
			endif
		endif
	enddef

	def g:PopUpGit(branch: string)
		call g:SupraNotification([
			"Git  ",
			"Your branch " .. branch .. " is out of date",
			"use `git pull` or `git fetch`",
			"to sync with recent modifications."])
	enddef

	def Fetch()
		if executable("git") == 1 
			if !filereadable('.git/HEAD')
				return
			endif
			var branch_name_lst = readfile('.git/HEAD', 'r')
			branch_name = substitute(branch_name_lst[0], 'ref:\s*refs/heads/', '', '')
			if (empty(branch_name_lst))
				return
			endif
			job_start(["git", "ls-remote", "origin"], {
				out_cb: GotOutputSupravimServer,
			})
		endif
	enddef

	call Fetch()
endif
