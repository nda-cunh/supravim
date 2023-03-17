int	main(string []args)
{
	string path = Environment.get_variable ("PWD");
	string home = Environment.get_variable ("HOME");
	string []rules = {};
	string []av_exec;
	
	if (args[1] == null){
		rules += "all";
	}
	else{
		for (var i = 1; args[i] != null; i++){
			rules += args[i];
		}
	}
	int i = path.length - 1;
	int ret;

	while (home != path && path != "/tmp" && i > 0)
	{
		if (access(path + "/Makefile", F_OK) == 0)
		{
			int pid = fork();
			if (pid == 0)
			{
				if (rules[0] == "valanocompileabcsupra")
					return (0);
				av_exec = {"make", "-C", path, "--no-print-directory"};
				foreach(var item in rules){
					av_exec += item;
				}
				execvp("make", av_exec);
			}
			waitpid(pid, out ret, 0);
			return (ret);
		}
		else
		{
			while (path[i] != '/')
				i--;
			path.data[i] = '\0';
		}
	}
	return (42);
}
